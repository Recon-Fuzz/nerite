
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import "forge-std/console2.sol";

import {ActivePoolTargets} from "./targets/ActivePoolTargets.sol";
import {BorrowerOperationsTargets} from "./targets/BorrowerOperationsTargets.sol";
import {CollateralRegistryTargets} from "./targets/CollateralRegistryTargets.sol";
import {CollTokenTargets} from "./targets/CollTokenTargets.sol";
import {ManagersTargets} from "./targets/ManagersTargets.sol";
import {OptimizationTargets} from "./targets/OptimizationTargets.sol";
import {PriceFeedTargets} from "./targets/PriceFeedTargets.sol";
import {StabilityPoolTargets} from "./targets/StabilityPoolTargets.sol";
import {TroveManagerTargets} from "./targets/TroveManagerTargets.sol";

abstract contract TargetFunctions is 
    ActivePoolTargets,
    BorrowerOperationsTargets,
    CollateralRegistryTargets,
    CollTokenTargets,
    ManagersTargets,
    OptimizationTargets,
    PriceFeedTargets,
    StabilityPoolTargets,
    TroveManagerTargets

 {

    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    /// === Shortcut Functions === ///
    
    /// @dev Shortcut to enable liquidation: open trove, drop price, liquidate
    function shortcut_liquidate(uint256 collAmount, uint256 boldAmount, uint256 priceDropPercent) public {
        // Open a trove with actor 0 (default)
        borrowerOperations_openTrove_clamped(
            _getActor(), 
            0, 
            collAmount, 
            boldAmount, 
            0, 
            0, 
            5e16, // 5% interest rate
            type(uint256).max, 
            address(0), 
            address(0), 
            _getActor()
        );
        
        // Switch to different actor to provide stability pool funds
        switchActor(1);
        
        // Open another trove to get BOLD
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Deposit to stability pool for liquidation rewards
        stabilityPool_provideToSP_clamped(boldAmount, false);
        
        // Drop the price to make first trove liquidatable
        uint256 currentPrice = priceFeed.getPrice();
        uint256 newPrice = currentPrice * (100 - (priceDropPercent % 50)) / 100; // Max 50% drop
        priceFeed_setPrice(uint88(newPrice));
        
        // Time warp to accrue some interest
        vm.warp(block.timestamp + 30 days);
        
        // Liquidate the first trove
        if (troveIds.length > 0) {
            troveManager_liquidate_clamped(troveIds[0]);
        }
        
        // Switch back to original actor
        switchActor(0);
    }
    
    /// @dev Shortcut to test urgent redemption: open multiple troves with varying interest rates, then redeem
    function shortcut_urgentRedemption(uint256 collAmount, uint256 boldAmount, uint256 redemptionAmount) public {
        // Open trove with low interest rate (more likely to be redeemed)
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            1e16, // 1% interest rate
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Switch actor and open another trove
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            3e16, // 3% interest rate
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Switch actor and open high interest rate trove
        switchActor(2);
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            10e16, // 10% interest rate
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Time warp to accrue interest
        vm.warp(block.timestamp + 90 days);
        
        // Attempt urgent redemption
        troveManager_urgentRedemption_clamped(redemptionAmount, troveIds, 0);
        
        // Switch back to original actor
        switchActor(0);
    }
    
    /// @dev Shortcut to test batch manager functionality: register batch manager, open troves, join batch
    function shortcut_batchManagerOperations(uint256 collAmount, uint256 boldAmount, uint256 managementFee) public {
        // Register as batch manager
        borrowerOperations_registerBatchManager_clamped(
            1e16,  // min 1%
            20e16, // max 20%
            5e16,  // current 5%
            uint128(managementFee % 1e17), // management fee
            1 days // min change period
        );
        
        // Open a trove independently
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Switch to different actor
        switchActor(1);
        
        // Open another trove
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Join the batch manager (if we have troves)
        if (troveIds.length > 0) {
            borrowerOperations_setInterestBatchManager_clamped(
                troveIds[troveIds.length - 1],
                0, // entropy for batch manager selection
                0, // upper hint
                0, // lower hint
                type(uint256).max
            );
        }
        
        // Switch back
        switchActor(0);
        
        // Adjust batch manager interest rate
        borrowerOperations_setBatchManagerAnnualInterestRate_clamped(
            7e16, // 7% new rate
            0,
            0,
            type(uint256).max
        );
        
        // Time warp
        vm.warp(block.timestamp + 30 days);
    }
    
    /// @dev Shortcut for delegate operations: open trove, set delegate, delegate adjusts interest
    function shortcut_delegateInterestManagement(uint256 collAmount, uint256 boldAmount, address delegate) public {
        // Open a trove
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Set an interest rate delegate for the trove
        if (troveIds.length > 0) {
            borrowerOperations_setInterestIndividualDelegate_clamped(
                troveIds[troveIds.length - 1],
                delegate,
                1e16,  // min 1%
                15e16, // max 15%
                5e16,  // current 5%
                0,     // upper hint
                0,     // lower hint
                type(uint256).max,
                1 days
            );
        }
        
        // Time warp
        vm.warp(block.timestamp + 7 days);
        
        // Adjust the interest rate through delegate
        if (troveIds.length > 0) {
            borrowerOperations_adjustTroveInterestRate_clamped(
                troveIds[troveIds.length - 1],
                8e16, // new 8% rate
                0,
                0,
                type(uint256).max
            );
        }
    }
    
    /// @dev Shortcut for stability pool with offset: provide to SP, create liquidatable trove, offset
    function shortcut_stabilityPoolOffset(uint256 spAmount, uint256 collAmount, uint256 boldAmount, uint256 offsetDebt) public {
        // Open trove to get BOLD
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Provide to stability pool
        stabilityPool_provideToSP_clamped(spAmount, false);
        
        // Switch actor and create another trove
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Time warp
        vm.warp(block.timestamp + 60 days);
        
        // Manually trigger offset
        stabilityPool_offset_clamped(offsetDebt, collAmount);
        
        // Switch back
        switchActor(0);
    }
    
    /// @dev Shortcut for complex trove adjustment: open trove, add collateral, withdraw BOLD, adjust interest
    function shortcut_complexTroveAdjustment(uint256 initialColl, uint256 initialBold, uint256 addColl, uint256 withdrawBold) public {
        // Open initial trove
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            initialColl,
            initialBold,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Time warp to accrue interest
        vm.warp(block.timestamp + 15 days);
        
        // Add collateral to the trove
        if (troveIds.length > 0) {
            borrowerOperations_addColl_clamped(troveIds[troveIds.length - 1], addColl);
        }
        
        // Withdraw BOLD
        if (troveIds.length > 0) {
            borrowerOperations_withdrawBold_clamped(
                troveIds[troveIds.length - 1],
                withdrawBold,
                type(uint256).max
            );
        }
        
        // Adjust interest rate
        if (troveIds.length > 0) {
            borrowerOperations_adjustTroveInterestRate_clamped(
                troveIds[troveIds.length - 1],
                7e16, // 7% new rate
                0,
                0,
                type(uint256).max
            );
        }
        
        // Time warp again
        vm.warp(block.timestamp + 30 days);
    }
    
    /// @dev Shortcut for batch liquidations: create multiple undercollateralized troves, batch liquidate
    function shortcut_batchLiquidations(uint256 collAmount, uint256 boldAmount, uint256 priceDropPercent) public {
        // Provide to stability pool first (different actor)
        switchActor(2);
        
        // Open trove to get BOLD for SP
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount * 2,
            boldAmount * 3,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        stabilityPool_provideToSP_clamped(boldAmount * 2, false);
        
        // Create multiple troves with actor 0
        switchActor(0);
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Create another trove with actor 1
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Drop price to make troves liquidatable
        uint256 currentPrice = priceFeed.getPrice();
        uint256 newPrice = currentPrice * (100 - (priceDropPercent % 50)) / 100;
        priceFeed_setPrice(uint88(newPrice));
        
        // Time warp
        vm.warp(block.timestamp + 45 days);
        
        // Batch liquidate
        if (troveIds.length > 1) {
            troveManager_batchLiquidateTroves_clamped(troveIds);
        }
        
        // Switch back
        switchActor(0);
    }
    
    /// @dev Shortcut for zombie trove recovery: create zombie, adjust zombie trove
    function shortcut_zombieTroveRecovery(uint256 collAmount, uint256 boldAmount) public {
        // Open initial trove
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        // Switch to another actor for stability pool
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount * 2,
            boldAmount * 2,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            _getActor()
        );
        
        stabilityPool_provideToSP_clamped(boldAmount, false);
        
        // Drop price to create zombie state
        uint256 currentPrice = priceFeed.getPrice();
        priceFeed_setPrice(uint88(currentPrice * 80 / 100)); // 20% drop
        
        // Partially liquidate to create zombie
        if (troveIds.length > 0) {
            troveManager_liquidate_clamped(troveIds[0]);
        }
        
        // Restore price
        priceFeed_setPrice(uint88(currentPrice));
        
        // Switch back and adjust zombie trove
        switchActor(0);
        if (troveIds.length > 0) {
            borrowerOperations_adjustZombieTrove_clamped(
                troveIds[0],
                collAmount / 2,
                true,  // increase collateral
                0,
                false,
                0,
                0,
                type(uint256).max
            );
        }
    }

    
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function canary_liquidation() public {
        t(!hasDoneLiquidation, "canary_liquidation");
    }
    function canary_redemption() public {
        t(!hasDoneRedemption, "canary_redemption");
    }

}