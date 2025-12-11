
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
    
    // Shortcut to set up and execute a liquidation
    function shortcut_liquidate(
        uint256 collateralAmount,
        uint256 borrowAmount,
        uint256 newPrice
    ) public {
        // Setup: Open a trove with current actor
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collateralAmount,
            borrowAmount,
            0,
            0,
            5e16, // 5% interest rate
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Warp time to accrue some interest
        vm.warp(block.timestamp + 30 days);
        
        // Change price to make trove liquidatable
        priceFeed_setPrice_clamped(uint88(newPrice));
        
        // Switch to different actor to perform liquidation
        switchActor(1);
        troveManager_liquidate_clamped(clampedTroveId);
    }

    // Shortcut to set up and execute a redemption
    function shortcut_redeemCollateral(
        uint256 collateralAmount,
        uint256 borrowAmount,
        uint256 redeemAmount
    ) public {
        // Setup: Open a trove to redeem from
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collateralAmount,
            borrowAmount,
            0,
            0,
            5e16, // 5% interest rate
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Warp time to accrue interest and allow redemptions
        vm.warp(block.timestamp + 30 days);
        
        // Switch to different actor and open another trove to get BOLD
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collateralAmount,
            borrowAmount,
            0,
            0,
            5e16,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Use that BOLD to redeem collateral
        collateralRegistry_redeemCollateral_clamped(
            redeemAmount,
            10, // max iterations
            1e18 // max fee 100%
        );
    }

    // Shortcut to set up stability pool with deposits and claim gains
    function shortcut_stabilityPool_claimGains(
        uint256 depositAmount,
        uint256 collateralToOffset,
        uint256 debtToOffset
    ) public {
        // Provide to stability pool
        stabilityPool_provideToSP_clamped(depositAmount, false);
        
        // Trigger an offset to generate collateral gains
        switchActor(1);
        stabilityPool_offset_clamped(debtToOffset, collateralToOffset);
        
        // Switch back and claim gains
        switchActor(0);
        stabilityPool.claimAllCollGains();
    }

    // Shortcut to set up batch manager and join trove to batch
    function shortcut_joinBatch(
        uint256 collateralAmount,
        uint256 borrowAmount
    ) public {
        // Register as batch manager
        borrowerOperations_registerBatchManager_clamped(
            1e16,  // min rate 1%
            10e16, // max rate 10%
            5e16,  // current rate 5%
            5e15,  // management fee 0.5%
            1 days // min change period
        );
        
        // Open a trove with different actor
        switchActor(1);
        uint256 troveId = borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collateralAmount,
            borrowAmount,
            0,
            0,
            5e16, // 5% interest rate
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Join the batch manager
        switchActor(0); // Switch to batch manager
        address batchManager = clampedBatchManager;
        switchActor(1); // Switch back to trove owner
        borrowerOperations_setInterestBatchManager_clamped(
            troveId,
            batchManager,
            0,
            0,
            type(uint256).max
        );
    }

    // Shortcut to set up and withdraw from stability pool
    function shortcut_stabilityPool_withdraw(
        uint256 depositAmount,
        uint256 withdrawAmount,
        uint256 boldYield
    ) public {
        // Provide to stability pool
        stabilityPool_provideToSP_clamped(depositAmount, false);
        
        // Warp time to accrue potential rewards
        vm.warp(block.timestamp + 7 days);
        
        // Trigger BOLD rewards
        stabilityPool_triggerBoldRewards_clamped(boldYield);
        
        // Withdraw from stability pool
        stabilityPool_withdrawFromSP_clamped(withdrawAmount, true);
    }

    // Shortcut to adjust trove with both collateral and debt changes
    function shortcut_adjustTrove(
        uint256 openCollAmount,
        uint256 openBoldAmount,
        uint256 adjustCollAmount,
        uint256 adjustBoldAmount,
        uint256 newInterestRate,
        bool isCollIncrease,
        bool isDebtIncrease
    ) public {
        // First open a trove
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            openCollAmount,
            openBoldAmount,
            0,
            0,
            5e16, // 5% interest rate
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Warp time
        vm.warp(block.timestamp + 1 days);
        
        // Adjust interest rate first
        borrowerOperations_adjustTroveInterestRate_clamped(
            clampedTroveId,
            newInterestRate,
            0,
            0,
            type(uint256).max
        );
        
        // Then adjust the trove collateral/debt
        borrowerOperations_adjustTrove_clamped(
            clampedTroveId,
            adjustCollAmount,
            isCollIncrease,
            adjustBoldAmount,
            isDebtIncrease,
            type(uint256).max
        );
    }

    // Shortcut to create multiple troves and batch liquidate
    function shortcut_batchLiquidate(
        uint256 collateralAmount,
        uint256 borrowAmount,
        uint256 numTroves,
        uint256 newPrice
    ) public {
        numTroves = (numTroves % 5) + 1; // Limit to 1-5 troves
        uint256[] memory troveIdsToLiquidate = new uint256[](numTroves);
        
        // Open multiple troves
        for (uint256 i = 0; i < numTroves; i++) {
            uint256 troveId = borrowerOperations_openTrove_clamped(
                _getActor(),
                i,
                collateralAmount,
                borrowAmount,
                0,
                0,
                5e16, // 5% interest rate
                type(uint256).max,
                address(0),
                address(0),
                address(0)
            );
            troveIdsToLiquidate[i] = troveId;
        }
        
        // Warp time
        vm.warp(block.timestamp + 30 days);
        
        // Change price to make troves liquidatable
        priceFeed_setPrice_clamped(uint88(newPrice));
        
        // Switch to different actor and batch liquidate
        switchActor(1);
        troveManager.batchLiquidateTroves(troveIdsToLiquidate);
    }

    // Shortcut for urgent redemption scenario
    function shortcut_urgentRedemption(
        uint256 collateralAmount,
        uint256 borrowAmount,
        uint256 redeemAmount,
        uint256 priceChange
    ) public {
        // Open a trove that will be redeemed
        uint256 troveId = borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collateralAmount,
            borrowAmount,
            0,
            0,
            5e16, // 5% interest rate
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Warp time
        vm.warp(block.timestamp + 30 days);
        
        // Change price to create urgent redemption conditions
        priceFeed_setPrice_clamped(uint88(priceChange));
        
        // Switch to different actor and open trove to get BOLD
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collateralAmount,
            borrowAmount,
            0,
            0,
            6e16,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Perform urgent redemption
        uint256[] memory troveIds = new uint256[](1);
        troveIds[0] = troveId;
        
        troveManager_urgentRedemption_clamped(
            redeemAmount,
            troveIds,
            0 // min collateral
        );
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function canary_liquidation() public {
        t(!hasDoneLiquidation, "canary_liquidation");
    }
    function canary_redemption() public {
        t(!hasDoneRedemption, "canary_redemption");
    }

}