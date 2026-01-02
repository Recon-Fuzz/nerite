
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import "forge-std/console2.sol";

import {ActivePoolTargets} from "./targets/ActivePoolTargets.sol";
import {BoldTokenTargets} from "./targets/BoldTokenTargets.sol";
import {BorrowerOperationsTargets} from "./targets/BorrowerOperationsTargets.sol";
import {CollateralRegistryTargets} from "./targets/CollateralRegistryTargets.sol";
import {CollTokenTargets} from "./targets/CollTokenTargets.sol";
import {ManagersTargets} from "./targets/ManagersTargets.sol";
import {PriceFeedTargets} from "./targets/PriceFeedTargets.sol";
import {StabilityPoolTargets} from "./targets/StabilityPoolTargets.sol";
import {TroveManagerTargets} from "./targets/TroveManagerTargets.sol";

abstract contract TargetFunctions is 
    ActivePoolTargets,
    BoldTokenTargets,
    BorrowerOperationsTargets,
    CollateralRegistryTargets,
    CollTokenTargets,
    ManagersTargets,
    PriceFeedTargets,
    StabilityPoolTargets,
    TroveManagerTargets

 {

    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // SHORTCUT HANDLERS - Phase 2
    
    // collToken_transfer shortcuts
    // PATH 0: _balanceOf[msg.sender] >= amount
    function shortcut_collToken_transfer_withBalance(
        uint256 amount,
        address to
    ) public {
        // Transfer requires sufficient balance
        // Clamp amount to actor's balance
        amount = amount % (collToken.balanceOf(_getActor()) + 1);
        
        collToken_transfer(to, amount);
    }

    // collToken_transferFrom shortcuts
    // PATH 0: allowed != ~0 (allowance is not unlimited)
    function shortcut_collToken_transferFrom_withLimitedAllowance(
        address from,
        address to,
        uint256 amount,
        uint256 allowanceAmount
    ) public {
        // Set limited allowance
        vm.prank(from);
        collToken.approve(_getActor(), allowanceAmount);
        
        // Clamp amount to allowance
        amount = amount % (allowanceAmount + 1);
        
        collToken_transferFrom(from, to, amount);
    }

    // PATH 1: allowed == ~0 (unlimited allowance)
    function shortcut_collToken_transferFrom_withUnlimitedAllowance(
        address from,
        address to,
        uint256 amount
    ) public {
        // Set unlimited allowance
        vm.prank(from);
        collToken.approve(_getActor(), type(uint256).max);
        
        collToken_transferFrom(from, to, amount);
    }

    // stabilityPool_triggerBoldRewards shortcuts
    // PATH 0: accumulatedYieldGains != 0 && totalBoldDepositsCached < DECIMAL_PRECISION
    function shortcut_triggerBoldRewards_withYieldGains_lowDeposits(
        uint256 depositAmount
    ) public {
        // Provide to SP with small amount to ensure totalBoldDepositsCached < DECIMAL_PRECISION
        depositAmount = depositAmount % (1e18 + 1); // Keep below DECIMAL_PRECISION
        
        stabilityPool_provideToSP_clamped(depositAmount, true);
        
        // Trigger rewards (must be called from activePool)
        vm.prank(address(activePool));
        stabilityPool_triggerBoldRewards(0);
    }

    // PATH 1: accumulatedYieldGains == 0
    function shortcut_triggerBoldRewards_noYieldGains() public {
        // Just trigger rewards with no accumulated gains
        vm.prank(address(activePool));
        stabilityPool_triggerBoldRewards(0);
    }

    // PATH 2: accumulatedYieldGains != 0 && totalBoldDepositsCached >= DECIMAL_PRECISION
    function shortcut_triggerBoldRewards_withYieldGains_highDeposits(
        uint256 depositAmount
    ) public {
        // Provide to SP with large amount
        depositAmount = 1e18 + (depositAmount % (collToken.balanceOf(_getActor()) + 1));
        
        stabilityPool_provideToSP_clamped(depositAmount, true);
        
        // Trigger rewards
        vm.prank(address(activePool));
        stabilityPool_triggerBoldRewards(0);
    }

    // stabilityPool_claimAllCollGains shortcuts
    // PATH 0: collToSend == 0
    function shortcut_claimAllCollGains_noGains() public {
        // Claim when there are no gains
        stabilityPool_claimAllCollGains();
    }

    // PATH 1: collToSend != 0
    function shortcut_claimAllCollGains_withGains(
        uint256 depositAmount,
        uint256 debtToOffset,
        uint256 collToAdd
    ) public {
        // 1. Provide to SP
        stabilityPool_provideToSP_clamped(depositAmount, true);
        
        // 2. Offset to generate collateral gains
        vm.prank(address(troveManager));
        stabilityPool_offset(debtToOffset, collToAdd);
        
        // 3. Claim gains
        stabilityPool_claimAllCollGains();
    }

    // borrowerOperations_setRemoveManagerWithReceiver shortcuts
    // PATH 0: msg.sender == troveNFT.ownerOf(_troveId) && (_manager != 0) && (_receiver != 0)
    function shortcut_setRemoveManagerWithReceiver_asOwner(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 interestRate,
        address manager,
        address receiver
    ) public {
        // 1. Open trove to become owner
        borrowerOperations_openTrove_clamped(
            _getActor(), 
            0, 
            collAmount, 
            boldAmount, 
            0, 
            0, 
            interestRate, 
            type(uint256).max, 
            address(0), 
            address(0), 
            address(0)
        );
        
        // 2. Set manager with receiver (ensuring non-zero addresses)
        address actualManager = manager != address(0) ? manager : address(0x1);
        address actualReceiver = receiver != address(0) ? receiver : address(0x2);
        
        // Use the entropy from troveIds array to select the trove we just created
        borrowerOperations_setRemoveManagerWithReceiver_clamped(actualManager, actualReceiver, troveIds.length - 1);
    }

    // borrowerOperations_setRemoveManager shortcuts
    // PATH 0: msg.sender == troveNFT.ownerOf(_troveId) && (_manager != 0)
    function shortcut_setRemoveManager_asOwner(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 interestRate,
        address manager
    ) public {
        // 1. Open trove to become owner
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            interestRate,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // 2. Set manager (ensuring non-zero address)
        address actualManager = manager != address(0) ? manager : address(0x1);
        
        // Use the entropy from troveIds array
        borrowerOperations_setRemoveManager_clamped(actualManager, troveIds.length - 1);
    }

    // borrowerOperations_setAddManager shortcuts
    // PATH 0: msg.sender == troveNFT.ownerOf(_troveId)
    function shortcut_setAddManager_asOwner(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 interestRate,
        address manager
    ) public {
        // 1. Open trove to become owner
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            interestRate,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // 2. Set add manager
        borrowerOperations_setAddManager_clamped(manager, troveIds.length - 1);
    }

    // borrowerOperations_removeInterestIndividualDelegate shortcuts
    // PATH 0: msg.sender == troveNFT.ownerOf(_troveId)
    function shortcut_removeInterestIndividualDelegate_asOwner(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 interestRate
    ) public {
        // 1. Open trove
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            interestRate,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // 2. Set individual delegate first
        borrowerOperations_setInterestIndividualDelegate_clamped(
            address(0x123),
            0,
            type(uint128).max,
            interestRate,
            0,
            0,
            type(uint256).max,
            0,
            troveIds.length - 1
        );
        
        // 3. Remove delegate
        borrowerOperations_removeInterestIndividualDelegate_clamped(troveIds.length - 1);
    }

    // borrowerOperations_onLiquidateTrove shortcuts
    // PATH 0: msg.sender == troveManager
    function shortcut_onLiquidateTrove_fromTroveManager(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 interestRate
    ) public {
        // 1. Open trove
        borrowerOperations_openTrove_clamped(
            _getActor(),
            0,
            collAmount,
            boldAmount,
            0,
            0,
            interestRate,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // 2. Call from troveManager
        uint256 troveId = troveIds[troveIds.length - 1];
        vm.prank(address(troveManager));
        borrowerOperations_onLiquidateTrove(troveId);
    }

    // borrowerOperations_registerBatchManager shortcuts
    // PATH 0: Basic registration
    function shortcut_registerBatchManager_basic(
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod
    ) public {
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate,
            maxInterestRate,
            currentInterestRate,
            annualManagementFee,
            minInterestRateChangePeriod
        );
    }

    // borrowerOperations_lowerBatchManagementFee shortcuts
    // PATH 0: Lower fee after registering
    function shortcut_lowerBatchManagementFee_afterRegister(
        uint128 initialFee,
        uint128 newFee
    ) public {
        // 1. Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            0,
            type(uint128).max,
            1e17,
            initialFee,
            0
        );
        
        // 2. Lower the fee (ensure newFee < initialFee by clamping)
        newFee = newFee % (initialFee + 1);
        
        borrowerOperations_lowerBatchManagementFee_clamped(newFee);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function canary_liquidation() public {
        t(!hasDoneLiquidation, "canary_liquidation");
    }
    function canary_redemption() public {
        t(!hasDoneRedemption, "canary_redemption");
    }

}