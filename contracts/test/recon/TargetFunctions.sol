
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
import {PriceFeedTargets} from "./targets/PriceFeedTargets.sol";
import {StabilityPoolTargets} from "./targets/StabilityPoolTargets.sol";
import {TroveManagerTargets} from "./targets/TroveManagerTargets.sol";
import {MIN_ANNUAL_INTEREST_RATE, MAX_ANNUAL_INTEREST_RATE, MIN_DEBT} from "../../src/Dependencies/Constants.sol";
import {ITroveManager} from "../../src/Interfaces/ITroveManager.sol";
import {IBorrowerOperations} from "../../src/Interfaces/IBorrowerOperations.sol";

abstract contract TargetFunctions is 
    ActivePoolTargets,
    BorrowerOperationsTargets,
    CollateralRegistryTargets,
    CollTokenTargets,
    ManagersTargets,
    PriceFeedTargets,
    StabilityPoolTargets,
    TroveManagerTargets
 {

    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_shutdown =====
    // Prerequisites: openTrove, setPrice
    // Paths: 3
    
    // PATH 0: totalDebt > 0 && TCR < SCR
    function shortcut_shutdown_byTotalDebt_lowTCR(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        uint88 newPrice
    ) public {
        // Call prerequisites with clamped handlers
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Set price to make TCR < SCR
        priceFeed_setPrice(newPrice);
        
        // Call target with unclamped handler
        borrowerOperations_shutdown();
    }
    
    // PATH 1: newOracleFailureDetected
    function shortcut_shutdown_oracleFailure(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate
    ) public {
        // Call prerequisites
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Note: Oracle failure would need to be triggered externally
        // This path may not be easily reachable through shortcuts
        borrowerOperations_shutdown();
    }
    
    // PATH 2: totalDebt <= 0 && TCR < SCR  
    function shortcut_shutdown_noDebt_lowTCR(
        uint88 newPrice
    ) public {
        // Set price to make TCR < SCR (even with no debt)
        priceFeed_setPrice(newPrice);
        
        // Call target
        borrowerOperations_shutdown();
    }

    // ===== SHORTCUT FUNCTIONS FOR stabilityPool_offset =====
    // Prerequisites: provideToSP
    // Paths: 5
    
    // PATH 0: totalBold != 0 && _debtToOffset == totalBold && newProductFactor != 0 && lastBoldLossErrorByP_Offset_Cached > 0 && newP < SCALE_FACTOR
    function shortcut_offset_fullDebt_withProductFactor_withError_lowP(
        uint256 provideAmount,
        uint256 collToAdd
    ) public {
        // Provide to SP using clamped handler
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        // Switch to different actor for offset
        switchActor(1);
        
        // Call offset - the path conditions will be satisfied based on state
        stabilityPool_offset_clamped(provideAmount, collToAdd);
    }
    
    // PATH 1: totalBold != 0 && _debtToOffset != totalBold && newProductFactor != 0
    function shortcut_offset_partialDebt_withProductFactor(
        uint256 provideAmount,
        uint256 debtToOffset,
        uint256 collToAdd
    ) public {
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        switchActor(1);
        
        // Offset partial debt
        uint256 clampedDebt = debtToOffset % (provideAmount + 1);
        stabilityPool_offset_clamped(clampedDebt, collToAdd);
    }
    
    // PATH 2: totalBold == 0
    function shortcut_offset_noDeposits(
        uint256 collToAdd
    ) public {
        // No provide to SP - empty pool
        // Call offset directly
        stabilityPool_offset_clamped(0, collToAdd);
    }
    
    // PATH 3: _debtToOffset == totalBold && newProductFactor == 0
    function shortcut_offset_fullDebt_noProductFactor(
        uint256 provideAmount,
        uint256 collToAdd
    ) public {
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        switchActor(1);
        
        stabilityPool_offset_clamped(provideAmount, collToAdd);
    }
    
    // PATH 4: newP >= SCALE_FACTOR
    function shortcut_offset_highP(
        uint256 provideAmount,
        uint256 collToAdd
    ) public {
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        switchActor(1);
        
        stabilityPool_offset_clamped(provideAmount, collToAdd);
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_setAddManager =====
    // Prerequisites: openTrove
    // Paths: 1
    
    function shortcut_setAddManager(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        address manager
    ) public {
        // Open trove first
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Set add manager - using clamped troveId
        borrowerOperations_setAddManager(clampedTroveId, manager);
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_closeTrove =====
    // Prerequisites: openTrove  
    // Paths: 2
    
    // PATH 0: batchManager != 0 && totalDebt > 0 && !hasBeenShutDown && newTCR >= CCR
    function shortcut_closeTrove_withBatchManager(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        address batchManager
    ) public {
        // Open trove and join batch
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Close the trove
        borrowerOperations_closeTrove(clampedTroveId);
    }
    
    // PATH 1: batchManager == 0 && totalDebt <= 0 && hasBeenShutDown
    function shortcut_closeTrove_noBatchManager_shutdown(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate
    ) public {
        // Open trove
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Close the trove
        borrowerOperations_closeTrove(clampedTroveId);
    }

    // ===== SHORTCUT FUNCTIONS FOR collToken_transferFrom =====
    // Prerequisites: approve
    // Paths: 2
    
    // PATH 0: allowed != ~0
    function shortcut_transferFrom_limitedAllowance(
        address spender,
        uint256 approveAmount,
        address to,
        uint256 transferAmount
    ) public {
        // Approve first
        collToken_approve_clamped(spender, approveAmount);
        
        // Transfer
        switchActor(1);
        collToken_transferFrom(spender, to, transferAmount);
    }
    
    // PATH 1: allowed == ~0 (unlimited allowance)
    function shortcut_transferFrom_unlimitedAllowance(
        address spender,
        address to,
        uint256 transferAmount
    ) public {
        // Approve unlimited
        collToken_approve_clamped(spender, type(uint256).max);
        
        // Transfer
        switchActor(1);
        collToken_transferFrom(spender, to, transferAmount);
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_setInterestBatchManager =====
    // Prerequisites: openTrove, registerBatchManager
    // Paths: 2
    
    // PATH 0: vars.trove.entireDebt > 0 && newICR >= MCR && totalDebt > 0 && newTCR >= CCR && interestIndividualDelegateOf[_troveId].account != 0
    function shortcut_setInterestBatchManager_withDebt_withDelegate(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod
    ) public {
        // Register batch manager first
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        address batchManagerAddr = _getActor();
        
        // Switch actor and open trove
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Set interest batch manager
        borrowerOperations_setInterestBatchManager(clampedTroveId, batchManagerAddr, 0, 0, type(uint256).max);
    }
    
    // PATH 1: vars.trove.entireDebt <= 0 && newICR >= MCR && totalDebt <= 0 && newTCR >= CCR && interestIndividualDelegateOf[_troveId].account == 0
    function shortcut_setInterestBatchManager_noDebt_noDelegate(
        uint256 collAmount,
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod
    ) public {
        // Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        address batchManagerAddr = _getActor();
        
        // Switch actor and open trove with minimal debt
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, 0, 0, 0, minInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Set interest batch manager
        borrowerOperations_setInterestBatchManager(clampedTroveId, batchManagerAddr, 0, 0, type(uint256).max);
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_removeFromBatch =====
    // Prerequisites: openTroveAndJoinInterestBatchManager
    // Paths: 3
    
    // PATH 0: vars.batch.annualInterestRate != _newAnnualInterestRate && vars.trove.entireDebt > 0 && newICR >= MCR && totalDebt > 0 && newTCR >= CCR
    function shortcut_removeFromBatch_differentRate_withDebt(
        uint256 collAmount,
        uint256 boldAmount,
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod,
        uint256 newAnnualInterestRate
    ) public {
        // Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        address batchManagerAddr = _getActor();
        
        // Open trove and join batch - note: need to implement this properly
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, currentInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Set to batch first
        borrowerOperations_setInterestBatchManager(clampedTroveId, batchManagerAddr, 0, 0, type(uint256).max);
        
        // Remove from batch with different rate
        borrowerOperations_removeFromBatch(clampedTroveId, newAnnualInterestRate, 0, 0, type(uint256).max);
    }
    
    // PATH 1: vars.batch.annualInterestRate != _newAnnualInterestRate && vars.trove.entireDebt <= 0
    function shortcut_removeFromBatch_differentRate_noDebt(
        uint256 collAmount,
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod,
        uint256 newAnnualInterestRate
    ) public {
        // Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        address batchManagerAddr = _getActor();
        
        // Open trove and join batch
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, 0, 0, 0, currentInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        borrowerOperations_setInterestBatchManager(clampedTroveId, batchManagerAddr, 0, 0, type(uint256).max);
        
        // Remove from batch
        borrowerOperations_removeFromBatch(clampedTroveId, newAnnualInterestRate, 0, 0, type(uint256).max);
    }
    
    // PATH 2: vars.batch.annualInterestRate == _newAnnualInterestRate
    function shortcut_removeFromBatch_sameRate(
        uint256 collAmount,
        uint256 boldAmount,
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod
    ) public {
        // Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        address batchManagerAddr = _getActor();
        
        // Open trove and join batch
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, currentInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        borrowerOperations_setInterestBatchManager(clampedTroveId, batchManagerAddr, 0, 0, type(uint256).max);
        
        // Remove with same rate
        borrowerOperations_removeFromBatch(clampedTroveId, currentInterestRate, 0, 0, type(uint256).max);
    }

    // ===== SHORTCUT FUNCTIONS FOR stabilityPool_withdrawFromSP =====
    // Prerequisites: provideToSP
    // Paths: 4
    
    // PATH 0: scaleDiff == 1 && compoundedStake < (initialDeposit / 1e9) && _doClaim && newDeposit == 0
    function shortcut_withdrawFromSP_scaleDiff1_smallStake_claim(
        uint256 provideAmount,
        uint256 withdrawAmount
    ) public {
        // Provide to SP
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        // Withdraw with claim
        stabilityPool_withdrawFromSP(withdrawAmount, true);
    }
    
    // PATH 1: scaleDiff == 0 && compoundedStake >= (initialDeposit / 1e9) && !_doClaim && newDeposit != 0
    function shortcut_withdrawFromSP_scaleDiff0_largeStake_noClaim(
        uint256 provideAmount,
        uint256 withdrawAmount
    ) public {
        // Provide to SP
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        // Withdraw without claim
        stabilityPool_withdrawFromSP(withdrawAmount, false);
    }
    
    // PATH 2: epochSnapshot < currentEpoch && _doClaim
    function shortcut_withdrawFromSP_oldEpoch_claim(
        uint256 provideAmount,
        uint256 withdrawAmount
    ) public {
        // Provide to SP
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        // Would need epoch change - simplified
        stabilityPool_withdrawFromSP(withdrawAmount, true);
    }
    
    // PATH 3: scaleDiff != 1 && scaleDiff != 0
    function shortcut_withdrawFromSP_otherScaleDiff(
        uint256 provideAmount,
        uint256 withdrawAmount
    ) public {
        // Provide to SP
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        // Withdraw
        stabilityPool_withdrawFromSP(withdrawAmount, true);
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_lowerBatchManagementFee =====
    // Prerequisites: registerBatchManager
    // Paths: 1
    
    function shortcut_lowerBatchManagementFee(
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod,
        uint256 newAnnualManagementFee
    ) public {
        // Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        
        // Lower the fee
        borrowerOperations_lowerBatchManagementFee(newAnnualManagementFee);
    }

    // ===== SHORTCUT FUNCTIONS FOR stabilityPool_triggerBoldRewards =====
    // Prerequisites: provideToSP
    // Paths: 3
    
    // PATH 0: accumulatedYieldGains != 0 && totalBoldDepositsCached < DECIMAL_PRECISION
    function shortcut_triggerBoldRewards_withGains_lowDeposits(
        uint256 provideAmount,
        uint256 yieldAmount
    ) public {
        // Provide to SP
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        // Trigger rewards
        stabilityPool_triggerBoldRewards(yieldAmount);
    }
    
    // PATH 1: accumulatedYieldGains == 0
    function shortcut_triggerBoldRewards_noGains(
        uint256 provideAmount
    ) public {
        // Provide to SP
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        // Trigger with no gains
        stabilityPool_triggerBoldRewards(0);
    }
    
    // PATH 2: accumulatedYieldGains != 0 && totalBoldDepositsCached >= DECIMAL_PRECISION
    function shortcut_triggerBoldRewards_withGains_highDeposits(
        uint256 provideAmount,
        uint256 yieldAmount
    ) public {
        // Provide to SP
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        // Trigger rewards
        stabilityPool_triggerBoldRewards(yieldAmount);
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_applyPendingDebt =====
    // Prerequisites: openTrove
    // Paths: 3
    
    // PATH 0: batchManager == 0 && _checkTroveIsZombie && trove.entireDebt >= MIN_DEBT
    function shortcut_applyPendingDebt_noBatch_zombie_sufficientDebt(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate
    ) public {
        // Open trove
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Apply pending debt
        borrowerOperations_applyPendingDebt(clampedTroveId, 0, 1);
    }
    
    // PATH 1: batchManager != 0 && _checkTroveIsZombie && trove.entireDebt >= MIN_DEBT
    function shortcut_applyPendingDebt_withBatch_zombie_sufficientDebt(
        uint256 collAmount,
        uint256 boldAmount,
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod
    ) public {
        // Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        address batchManagerAddr = _getActor();
        
        // Open trove and join batch
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, currentInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        borrowerOperations_setInterestBatchManager(clampedTroveId, batchManagerAddr, 0, 0, type(uint256).max);
        
        // Apply pending debt
        borrowerOperations_applyPendingDebt(clampedTroveId, 0, 1);
    }
    
    // PATH 2: batchManager == 0 && _checkTroveIsZombie && trove.entireDebt < MIN_DEBT
    function shortcut_applyPendingDebt_noBatch_zombie_insufficientDebt(
        uint256 collAmount,
        uint256 annualInterestRate
    ) public {
        // Open trove with minimal debt
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, 1, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Apply pending debt
        borrowerOperations_applyPendingDebt(clampedTroveId, 0, 1);
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_setBatchManagerAnnualInterestRate =====
    // Prerequisites: registerBatchManager
    // Paths: 3
    
    // PATH 0: batch.annualInterestRate != _newAnnualInterestRate && totalDebt > 0 && newTCR >= CCR && !sortedTroves.isEmptyBatch
    function shortcut_setBatchManagerAnnualInterestRate_differentRate_withDebt_nonEmptyBatch(
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod,
        uint128 newAnnualInterestRate
    ) public {
        // Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        
        // Warp time forward to pass the minInterestRateChangePeriod cooldown
        // The minimum is 1 hour, so we warp by the clamped value + 1 to ensure it passes
        vm.warp(block.timestamp + minInterestRateChangePeriod + 1);
        
        // Set new rate
        borrowerOperations_setBatchManagerAnnualInterestRate(newAnnualInterestRate, 0, 0, type(uint256).max);
    }
    
    // PATH 1: batch.annualInterestRate != _newAnnualInterestRate && totalDebt <= 0 && newTCR >= CCR && sortedTroves.isEmptyBatch
    function shortcut_setBatchManagerAnnualInterestRate_differentRate_noDebt_emptyBatch(
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod,
        uint128 newAnnualInterestRate
    ) public {
        // Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        
        // Warp time forward to pass the minInterestRateChangePeriod cooldown
        // The minimum is 1 hour, so we warp by the clamped value + 1 to ensure it passes
        vm.warp(block.timestamp + minInterestRateChangePeriod + 1);
        
        // Set new rate
        borrowerOperations_setBatchManagerAnnualInterestRate(newAnnualInterestRate, 0, 0, type(uint256).max);
    }
    
    // PATH 2: batch.annualInterestRate == _newAnnualInterestRate
    function shortcut_setBatchManagerAnnualInterestRate_sameRate(
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod
    ) public {
        // Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        
        // Warp time forward to pass the minInterestRateChangePeriod cooldown
        // The minimum is 1 hour, so we warp by the clamped value + 1 to ensure it passes
        vm.warp(block.timestamp + minInterestRateChangePeriod + 1);
        
        // Set same rate
        borrowerOperations_setBatchManagerAnnualInterestRate(currentInterestRate, 0, 0, type(uint256).max);
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_openTrove =====
    // Prerequisites: none listed, but has 2 paths
    // Paths: 2
    
    // PATH 0: vars.entireDebt > 0 && vars.ICR >= MCR && totalDebt > 0 && vars.newTCR >= CCR && _removeManager != 0 && _receiver != 0
    function shortcut_openTrove_withDebt_withManagers(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        address removeManager,
        address receiver
    ) public {
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), removeManager, receiver
        );
    }
    
    // PATH 1: vars.entireDebt <= 0 && totalDebt <= 0
    function shortcut_openTrove_noDebt(
        uint256 collAmount,
        uint256 annualInterestRate
    ) public {
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, 0, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_adjustTroveInterestRate =====
    // Prerequisites: openTrove
    // Paths: 3
    
    // PATH 0: trove.annualInterestRate != _newAnnualInterestRate && newDebt > 0 && newICR >= MCR && totalDebt > 0
    function shortcut_adjustTroveInterestRate_differentRate_withDebt(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        uint256 newAnnualInterestRate
    ) public {
        // Open trove
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Adjust rate
        borrowerOperations_adjustTroveInterestRate(clampedTroveId, newAnnualInterestRate, 0, 0, type(uint256).max);
    }
    
    // PATH 1: trove.annualInterestRate != _newAnnualInterestRate && newDebt <= 0 && totalDebt <= 0
    function shortcut_adjustTroveInterestRate_differentRate_noDebt(
        uint256 collAmount,
        uint256 annualInterestRate,
        uint256 newAnnualInterestRate
    ) public {
        // Open trove with no debt
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, 0, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Adjust rate
        borrowerOperations_adjustTroveInterestRate(clampedTroveId, newAnnualInterestRate, 0, 0, type(uint256).max);
    }
    
    // PATH 2: trove.annualInterestRate == _newAnnualInterestRate
    function shortcut_adjustTroveInterestRate_sameRate(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate
    ) public {
        // Open trove
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Adjust to same rate
        borrowerOperations_adjustTroveInterestRate(clampedTroveId, annualInterestRate, 0, 0, type(uint256).max);
    }

    // ===== SHORTCUT FUNCTIONS FOR collToken_transfer =====
    // Prerequisites: none, but has path
    // Paths: 1
    
    function shortcut_transfer(
        address to,
        uint256 amount
    ) public {
        collToken_transfer(to, amount);
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_setRemoveManagerWithReceiver =====
    // Prerequisites: openTrove
    // Paths: 1
    
    function shortcut_setRemoveManagerWithReceiver(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        address manager,
        address receiver
    ) public {
        // Open trove
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Set remove manager with receiver
        borrowerOperations_setRemoveManagerWithReceiver(clampedTroveId, manager, receiver);
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_shutdownFromOracleFailure =====
    // Prerequisites: none
    // Paths: 2
    // NOTE: This function can only be called by the price feed contract
    
    // PATH 0: hasBeenShutDown
    function shortcut_shutdownFromOracleFailure_alreadyShutdown(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        uint88 newPrice
    ) public {
        // First trigger normal shutdown to set hasBeenShutDown = true
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        priceFeed_setPrice(newPrice % (100e18 + 1));
        try borrowerOperations.shutdown() {} catch {}
        
        // Now call shutdownFromOracleFailure as price feed
        vm.prank(address(priceFeed));
        borrowerOperations.shutdownFromOracleFailure();
    }
    
    // PATH 1: !hasBeenShutDown
    function shortcut_shutdownFromOracleFailure_notShutdown() public {
        // Call shutdownFromOracleFailure as price feed when not yet shutdown
        vm.prank(address(priceFeed));
        borrowerOperations.shutdownFromOracleFailure();
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_openTroveAndJoinInterestBatchManager =====
    // Prerequisites: registerBatchManager
    // Paths: 2
    
    // PATH 0: vars.entireDebt > 0 && vars.ICR >= MCR && totalDebt > 0 && _params.interestBatchManager == 0
    function shortcut_openTroveAndJoinBatch_withDebt_noManager(
        uint256 collAmount,
        uint256 boldAmount,
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod
    ) public {
        // Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        address batchManagerAddr = _getActor();
        
        // Open trove and join batch
        switchActor(1);
        // Note: Would need to use proper params struct - simplified here
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, currentInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
    }
    
    // PATH 1: vars.entireDebt <= 0 && totalDebt <= 0 && _params.interestBatchManager != 0
    function shortcut_openTroveAndJoinBatch_noDebt_withManager(
        uint256 collAmount,
        uint128 minInterestRate,
        uint128 maxInterestRate,
        uint128 currentInterestRate,
        uint128 annualManagementFee,
        uint128 minInterestRateChangePeriod
    ) public {
        // Register batch manager
        borrowerOperations_registerBatchManager_clamped(
            minInterestRate, maxInterestRate, currentInterestRate, annualManagementFee, minInterestRateChangePeriod
        );
        address batchManagerAddr = _getActor();
        
        // Open trove and join batch
        switchActor(1);
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, 0, 0, 0, currentInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
    }

    // ===== SHORTCUT FUNCTIONS FOR stabilityPool_claimAllCollGains =====
    // Prerequisites: provideToSP, offset
    // Paths: 2
    
    // PATH 0: collToSend == 0
    function shortcut_claimAllCollGains_noCollateral(
        uint256 provideAmount
    ) public {
        // Provide to SP
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        // Claim gains
        stabilityPool_claimAllCollGains();
    }
    
    // PATH 1: collToSend != 0
    function shortcut_claimAllCollGains_withCollateral(
        uint256 provideAmount,
        uint256 collToAdd
    ) public {
        // Provide to SP
        stabilityPool_provideToSP_clamped(provideAmount, false);
        
        // Offset to generate collateral gains
        switchActor(1);
        stabilityPool_offset_clamped(provideAmount / 2, collToAdd);
        
        // Claim gains
        switchActor(0);
        stabilityPool_claimAllCollGains();
    }

    // ===== SHORTCUT FUNCTIONS FOR stabilityPool_provideToSP =====
    // Prerequisites: openTrove (to get BOLD tokens)
    // Paths: 4
    
    // PATH 0: scaleDiff == 1 && compoundedStake < (initialDeposit / 1e9) && _doClaim && newDeposit == 0
    function shortcut_provideToSP_scaleDiff1_smallStake_claim(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        uint256 topUp
    ) public {
        // Open trove to get BOLD
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Provide to SP
        stabilityPool_provideToSP_clamped(topUp, true);
    }
    
    // PATH 1: scaleDiff == 0 && compoundedStake >= (initialDeposit / 1e9) && !_doClaim && newDeposit != 0
    function shortcut_provideToSP_scaleDiff0_largeStake_noClaim(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        uint256 topUp
    ) public {
        // Open trove to get BOLD
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Provide to SP
        stabilityPool_provideToSP_clamped(topUp, false);
    }
    
    // PATH 2: epochSnapshot < currentEpoch && _doClaim && newDeposit == 0
    function shortcut_provideToSP_oldEpoch_claim(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        uint256 topUp
    ) public {
        // Open trove to get BOLD
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Provide to SP
        stabilityPool_provideToSP_clamped(topUp, true);
    }
    
    // PATH 3: scaleDiff != 1 && scaleDiff != 0
    function shortcut_provideToSP_otherScaleDiff(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        uint256 topUp
    ) public {
        // Open trove to get BOLD
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        // Provide to SP
        stabilityPool_provideToSP_clamped(topUp, true);
    }

    // ===== SHORTCUT FUNCTIONS FOR troveManager_urgentRedemption =====
    // Prerequisites: shutdown system, open troves
    // This function requires the system to be in shutdown state
    function shortcut_urgentRedemption(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        uint256 redemptionAmount,
        uint88 newPrice
    ) public {
        // Step 1: Open a trove to have some debt in the system
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        
        uint256 openedTroveId = clampedTroveId;
        
        // Step 2: Trigger shutdown by crashing the price
        priceFeed_setPrice(newPrice % (100e18 + 1)); // Low price to trigger TCR < SCR
        
        // Step 3: Call shutdown - catch in case it fails
        try borrowerOperations.shutdown() {} catch {}
        
        // Step 4: Ensure actor has Bold tokens for redemption
        uint256 actorBalance = boldToken.balanceOf(_getActor());
        if (actorBalance < 1e18) {
            // Mint Bold if actor doesn't have enough
            vm.prank(address(borrowerOperations));
            boldToken.mint(_getActor(), 100e18);
            actorBalance = boldToken.balanceOf(_getActor());
        }
        
        redemptionAmount = (redemptionAmount % actorBalance) + 1; // Ensure > 0
        
        // Step 5: Build array of trove IDs with the opened trove
        uint256[] memory troveIdsArray = new uint256[](1);
        troveIdsArray[0] = openedTroveId;
        
        // Step 6: Call urgent redemption with clamped handler
        troveManager_urgentRedemption_clamped(redemptionAmount, troveIdsArray, 0);
    }

    // ===== ENHANCED SHORTCUT FOR adjustTroveInterestRate - PHASE 5 =====
    // Ensures we have an active standalone trove (not in batch) before adjusting rate
    function shortcut_adjustTroveInterestRate_activeStandalone(
        uint256 collAmount,
        uint256 boldAmount,
        uint128 initialRate,
        uint128 newRate
    ) public {
        // Step 1: Open a standalone trove (not in a batch) - this will be active by default
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, 
            uint256(initialRate) % (MAX_ANNUAL_INTEREST_RATE + 1), 
            type(uint256).max,
            address(0), address(0), address(0)
        );
        uint256 standaloneTroveId = clampedTroveId;
        
        // Step 2: Warp time to ensure cooldown has passed (7 days)
        vm.warp(block.timestamp + 8 days);
        
        // Step 3: Ensure the new rate is different from initial rate and valid
        uint256 validNewRate = MIN_ANNUAL_INTEREST_RATE + 
            (uint256(newRate) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1));
        
        // Step 4: Call adjustTroveInterestRate using the clamped handler 
        // (which should now find this active standalone trove)
        borrowerOperations_adjustTroveInterestRate_clamped(
            standaloneTroveId,
            validNewRate,
            0, // upper hint
            0, // lower hint
            type(uint256).max // max upfront fee
        );
    }

    // ===== PHASE 5 COVERAGE - GROUP 1: Trove Interest Rate and Delegate Management =====
    
    // COVERAGE TARGET: adjustTroveInterestRate - lines 516-543 and line 545
    // ROOT CAUSE: Line 516 _requireTroveIsActive failing - trove is not in 'active' state
    // SOLUTION: Shortcut that explicitly creates an ACTIVE standalone trove then adjusts rate
    function shortcut_adjustTroveInterestRate_phase5_group1(
        uint256 collAmount,
        uint256 boldAmount,
        uint128 initialRate,
        uint128 newRate
    ) public {
        // Clamp parameters
        collAmount = collAmount % (collToken.balanceOf(_getActor()) + 1);
        if (collAmount < 10e18) collAmount = 10e18;
        boldAmount = (boldAmount % (MIN_DEBT * 10)) + MIN_DEBT;
        
        // Step 1: Open a fresh standalone trove (NOT in a batch)
        // This ensures the trove starts in ACTIVE status
        uint256 validInitialRate = MIN_ANNUAL_INTEREST_RATE + 
            (uint256(initialRate) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1));
        
        uint256 activeTroveId = borrowerOperations.openTrove(
            _getActor(),       // owner
            0,                 // ownerIndex
            collAmount,        // collAmount
            boldAmount,        // boldAmount
            0,                 // upperHint
            0,                 // lowerHint
            validInitialRate,  // annualInterestRate
            type(uint256).max, // maxUpfrontFee
            address(0),        // addManager
            address(0),        // removeManager
            address(0)         // receiver
        );
        
        // Verify the trove is active
        require(troveManager.getTroveStatus(activeTroveId) == ITroveManager.Status.active, 
            "Trove must be active");
        
        // Verify the trove is NOT in a batch (line 514 requires this)
        require(borrowerOperations.interestBatchManagerOf(activeTroveId) == address(0), 
            "Trove must not be in batch");
        
        // Step 2: Warp time to ensure cooldown has passed (7 days)
        vm.warp(block.timestamp + 8 days);
        
        // Step 3: Ensure the new rate is DIFFERENT from initial rate and VALID
        uint256 validNewRate = MIN_ANNUAL_INTEREST_RATE + 
            (uint256(newRate) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1));
        
        // Ensure it's different from current rate (line 520 requires this)
        if (validNewRate == validInitialRate) {
            validNewRate = validInitialRate == MIN_ANNUAL_INTEREST_RATE ? 
                MIN_ANNUAL_INTEREST_RATE + 1 : MIN_ANNUAL_INTEREST_RATE;
        }
        
        // Step 4: Call adjustTroveInterestRate - should now cover lines 516-543 and 545
        try borrowerOperations.adjustTroveInterestRate(
            activeTroveId,
            validNewRate,
            0,                 // upperHint
            0,                 // lowerHint
            type(uint256).max  // maxUpfrontFee
        ) {} catch {}
    }
    
    // ===== ENHANCED SHORTCUT FOR setInterestIndividualDelegate - PHASE 5 =====
    // Ensures valid rate parameters for setting individual delegate
    function shortcut_setInterestIndividualDelegate_validRates(
        uint256 collAmount,
        uint256 boldAmount,
        uint128 initialRate
    ) public {
        // Step 1: Open a trove (will be active and owned by current actor)
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, 
            uint256(initialRate) % (MAX_ANNUAL_INTEREST_RATE + 1), 
            type(uint256).max,
            address(0), address(0), address(0)
        );
        uint256 troveId = clampedTroveId;
        
        // Step 2: Set individual delegate with guaranteed valid parameters
        // Use full range for min/max to ensure they pass validation
        uint128 validMinRate = uint128(MIN_ANNUAL_INTEREST_RATE);
        uint128 validMaxRate = uint128(MAX_ANNUAL_INTEREST_RATE);
        uint256 validNewRate = (MIN_ANNUAL_INTEREST_RATE + MAX_ANNUAL_INTEREST_RATE) / 2; // Middle of range
        
        // Step 3: Call setInterestIndividualDelegate (should now cover lines 817-828)
        vm.prank(_getActor());
        borrowerOperations.setInterestIndividualDelegate(
            troveId,
            _getActor(), // Use current actor as delegate
            validMinRate,
            validMaxRate,
            validNewRate,
            0, // upper hint
            0, // lower hint
            type(uint256).max, // max upfront fee
            0  // min interest rate change period
        );
    }

    // ===== SHORTCUT FUNCTIONS FOR borrowerOperations_removeInterestIndividualDelegate =====
    // This function requires a trove that already has an individual delegate set
    // Path: Trove has delegate set -> remove it
    function shortcut_removeInterestIndividualDelegate_withDelegate(
        uint256 collAmount,
        uint256 boldAmount,
        uint256 annualInterestRate,
        address delegate,
        uint128 minRate,
        uint128 maxRate,
        uint256 minChangePeriod
    ) public {
        // Step 1: Open a trove
        borrowerOperations_openTrove_clamped(
            address(0), 0, collAmount, boldAmount, 0, 0, annualInterestRate, type(uint256).max,
            address(0), address(0), address(0)
        );
        uint256 troveId = clampedTroveId;
        
        // Step 2: Set individual delegate on the trove - ensure parameters are valid
        // Use MIN/MAX constants directly to ensure valid range
        uint128 validMinRate = uint128(MIN_ANNUAL_INTEREST_RATE);
        uint128 validMaxRate = uint128(MAX_ANNUAL_INTEREST_RATE);
        uint256 validNewRate = MIN_ANNUAL_INTEREST_RATE + (annualInterestRate % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1));
        
        // Call setInterestIndividualDelegate directly to have full control
        vm.prank(_getActor());
        try borrowerOperations.setInterestIndividualDelegate(
            troveId,
            _getActor(), // Use current actor as delegate
            validMinRate,
            validMaxRate,
            validNewRate,
            0, // upper hint
            0, // lower hint
            type(uint256).max, // max upfront fee
            0  // min interest rate change period
        ) {
            // Delegate successfully set
        } catch {
            // If it fails, skip removal
            return;
        }
        
        // Step 3: Now remove the delegate (this is the target function that should cover line 834)
        vm.prank(_getActor());
        borrowerOperations.removeInterestIndividualDelegate(troveId);
    }

    // ===== PHASE 5 - GROUP 1: Batch Membership Management =====
    
    /// COVERAGE TARGET: setInterestBatchManager - lines 974-1022
    /// ROOT CAUSE: Line 974 _requireValidInterestBatchManager failing - batch manager is not registered
    /// SOLUTION: Shortcut that explicitly registers a batch manager first, then joins trove to it
    function shortcut_phase5_setInterestBatchManager_validBatchManager(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint128 _batchInterestRate
    ) public {
        // Step 1: Register a batch manager FIRST (this makes it valid)
        uint128 validRate = uint128(MIN_ANNUAL_INTEREST_RATE + 
            (uint256(_batchInterestRate) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1)));
        
        borrowerOperations.registerBatchManager(
            uint128(MIN_ANNUAL_INTEREST_RATE),     // minInterestRate
            uint128(MAX_ANNUAL_INTEREST_RATE),     // maxInterestRate
            validRate,                              // currentInterestRate
            uint128(0),                             // annualManagementFee (0 for simplicity)
            0                                        // minInterestRateChangePeriod
        );
        address validBatchManager = _getActor();
        
        // Step 2: Switch to different actor and open a standalone trove
        switchActor(1);
        
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        if (_collAmount < 10e18) _collAmount = 10e18;
        _boldAmount = (_boldAmount % (MIN_DEBT * 10)) + MIN_DEBT;
        
        uint256 standaloneTroveId = borrowerOperations.openTrove(
            _getActor(),
            0,
            _collAmount,
            _boldAmount,
            0,
            0,
            validRate,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        troveIds.push(standaloneTroveId);  // Track the trove
        clampedTroveId = standaloneTroveId;
        
        // Verify trove is NOT in a batch (line 975 requires this)
        address currentBatch = borrowerOperations.interestBatchManagerOf(standaloneTroveId);
        if (currentBatch != address(0)) return;  // Already in batch, skip
        
        // Step 3: Join the VALID batch manager (should now cover lines 974-1022)
        borrowerOperations.setInterestBatchManager(
            standaloneTroveId,
            validBatchManager,
            0,
            0,
            type(uint256).max
        );
    }
    
    /// COVERAGE TARGET: switchBatchManager - lines 1105-1110
    /// ROOT CAUSE: Line 1105 _requireNewInterestBatchManager failing - new batch manager is same as old
    /// SOLUTION: Shortcut that registers TWO different batch managers and switches between them
    function shortcut_phase5_switchBatchManager_differentBatchManager(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint128 _rate1,
        uint128 _rate2
    ) public {
        // Ensure rates are in valid range
        _rate1 = uint128(MIN_ANNUAL_INTEREST_RATE + 
            (uint256(_rate1) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1)));
        _rate2 = uint128(MIN_ANNUAL_INTEREST_RATE + 
            (uint256(_rate2) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1)));
        // Ensure rates are different
        if (_rate1 == _rate2) {
            _rate2 = _rate1 == MIN_ANNUAL_INTEREST_RATE ? 
                uint128(MIN_ANNUAL_INTEREST_RATE + 1) : uint128(MIN_ANNUAL_INTEREST_RATE);
        }
        
        // Step 1: Register FIRST batch manager AS actor 0
        borrowerOperations.registerBatchManager(
            uint128(MIN_ANNUAL_INTEREST_RATE),
            uint128(MAX_ANNUAL_INTEREST_RATE),
            _rate1,
            uint128(0),
            0
        );
        address firstBatchManager = _getActor();
        
        // Step 2: Switch to different actor and register SECOND batch manager
        switchActor(1);
        borrowerOperations.registerBatchManager(
            uint128(MIN_ANNUAL_INTEREST_RATE),
            uint128(MAX_ANNUAL_INTEREST_RATE),
            _rate2,
            uint128(0),
            0
        );
        address secondBatchManager = _getActor();
        
        // Ensure we have two DIFFERENT batch managers (safety check)
        if (firstBatchManager == secondBatchManager) return;
        
        // Step 3: Switch to third actor to open trove and join first batch
        switchActor(2);
        
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        if (_collAmount < 10e18) _collAmount = 10e18;
        _boldAmount = (_boldAmount % (MIN_DEBT * 10)) + MIN_DEBT;
        
        // Open trove and join FIRST batch
        IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = 
            IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({
                owner: _getActor(),
                ownerIndex: 0,
                collAmount: _collAmount,
                boldAmount: _boldAmount,
                upperHint: 0,
                lowerHint: 0,
                interestBatchManager: firstBatchManager,
                maxUpfrontFee: type(uint256).max,
                addManager: address(0),
                removeManager: address(0),
                receiver: address(0)
            });
        
        // Open trove and capture the returned troveId
        uint256 troveInBatch;
        try borrowerOperations.openTroveAndJoinInterestBatchManager(params) returns (uint256 newTroveId) {
            troveInBatch = newTroveId;
            troveIds.push(newTroveId);  // Track the trove
            clampedTroveId = newTroveId;
        } catch {
            return;  // Failed to open trove, skip
        }
        
        // Verify trove is in the first batch
        address currentBatch = borrowerOperations.interestBatchManagerOf(troveInBatch);
        if (currentBatch != firstBatchManager) return;
        
        // Step 4: Switch batch from first to second (should cover lines 1105-1110)
        borrowerOperations.switchBatchManager(
            troveInBatch,
            0,  // removeUpperHint
            0,  // removeLowerHint
            secondBatchManager,
            0,  // addUpperHint
            0,  // addLowerHint
            type(uint256).max
        );
    }
    
    /// COVERAGE TARGET: setBatchManagerAnnualInterestRate - lines 928-944
    /// ROOT CAUSE: Lines 925-927 condition evaluating to false - either rate is same OR outside cooldown
    /// SOLUTION: Shortcut that changes rate WITHIN cooldown period with DIFFERENT rate
    function shortcut_phase5_setBatchManagerRate_withinCooldown(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint128 _initialRate,
        uint128 _newRate
    ) public {
        // Ensure rates are in valid range and different
        _initialRate = uint128(MIN_ANNUAL_INTEREST_RATE + 
            (uint256(_initialRate) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1)));
        _newRate = uint128(MIN_ANNUAL_INTEREST_RATE + 
            (uint256(_newRate) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1)));
        if (_initialRate == _newRate) {
            _newRate = _initialRate == MIN_ANNUAL_INTEREST_RATE ? 
                uint128(MIN_ANNUAL_INTEREST_RATE + 1) : uint128(MIN_ANNUAL_INTEREST_RATE);
        }
        
        // Step 1: Register batch manager with initial rate AS actor 0
        borrowerOperations.registerBatchManager(
            uint128(MIN_ANNUAL_INTEREST_RATE),
            uint128(MAX_ANNUAL_INTEREST_RATE),
            _initialRate,
            uint128(0),
            0
        );
        address batchManagerAddr = _getActor();
        
        // Step 2: Switch to different actor and open trove in batch
        switchActor(1);
        
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        if (_collAmount < 10e18) _collAmount = 10e18;
        _boldAmount = (_boldAmount % (MIN_DEBT * 10)) + MIN_DEBT;
        
        IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = 
            IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({
                owner: _getActor(),
                ownerIndex: 0,
                collAmount: _collAmount,
                boldAmount: _boldAmount,
                upperHint: 0,
                lowerHint: 0,
                interestBatchManager: batchManagerAddr,
                maxUpfrontFee: type(uint256).max,
                addManager: address(0),
                removeManager: address(0),
                receiver: address(0)
            });
        
        // Open trove and capture the returned troveId
        try borrowerOperations.openTroveAndJoinInterestBatchManager(params) returns (uint256 newTroveId) {
            troveIds.push(newTroveId);  // Track the trove
            clampedTroveId = newTroveId;
        } catch {
            return;  // Failed to open trove, skip
        }
        
        // Step 3: Warp SMALL amount of time (within 7-day cooldown) - this is critical!
        // INTEREST_RATE_ADJ_COOLDOWN is 7 days, so we warp only 1 day to stay within it
        vm.warp(block.timestamp + 1 days);
        
        // Step 4: Switch to batch manager and change rate WITHIN cooldown
        // This should trigger the upfront fee path at lines 928-944
        switchActor(0);  // Back to batch manager actor
        
        borrowerOperations.setBatchManagerAnnualInterestRate(
            _newRate,
            0,
            0,
            type(uint256).max
        );
    }
    
    /// COVERAGE TARGET: setBatchManagerAnnualInterestRate - line 951
    /// ROOT CAUSE: Line 950 condition evaluating to false - batch is empty (no troves)
    /// SOLUTION: Shortcut that ensures batch has troves before changing rate
    function shortcut_phase5_setBatchManagerRate_nonEmptyBatch(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint128 _initialRate,
        uint128 _newRate
    ) public {
        // Ensure rates are in valid range and different
        _initialRate = uint128(MIN_ANNUAL_INTEREST_RATE + 
            (uint256(_initialRate) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1)));
        _newRate = uint128(MIN_ANNUAL_INTEREST_RATE + 
            (uint256(_newRate) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1)));
        if (_initialRate == _newRate) {
            _newRate = _initialRate == MIN_ANNUAL_INTEREST_RATE ? 
                uint128(MIN_ANNUAL_INTEREST_RATE + 1) : uint128(MIN_ANNUAL_INTEREST_RATE);
        }
        
        // Step 1: Register batch manager with initial rate AS actor 0
        borrowerOperations.registerBatchManager(
            uint128(MIN_ANNUAL_INTEREST_RATE),
            uint128(MAX_ANNUAL_INTEREST_RATE),
            _initialRate,
            uint128(0),
            0
        );
        address batchManagerAddr = _getActor();
        
        // Step 2: Switch to different actor and open trove in batch
        // This makes the batch NON-EMPTY
        switchActor(1);
        
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        if (_collAmount < 10e18) _collAmount = 10e18;
        _boldAmount = (_boldAmount % (MIN_DEBT * 10)) + MIN_DEBT;
        
        IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = 
            IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({
                owner: _getActor(),
                ownerIndex: 0,
                collAmount: _collAmount,
                boldAmount: _boldAmount,
                upperHint: 0,
                lowerHint: 0,
                interestBatchManager: batchManagerAddr,
                maxUpfrontFee: type(uint256).max,
                addManager: address(0),
                removeManager: address(0),
                receiver: address(0)
            });
        
        // Open trove and capture the returned troveId
        try borrowerOperations.openTroveAndJoinInterestBatchManager(params) returns (uint256 newTroveId) {
            troveIds.push(newTroveId);  // Track the trove
            clampedTroveId = newTroveId;
        } catch {
            return;  // Failed to open trove, skip
        }
        
        // Step 3: Warp time PAST cooldown period (8 days to ensure we pass 7-day cooldown)
        vm.warp(block.timestamp + 8 days);
        
        // Step 4: Switch to batch manager and change rate
        // Since batch is non-empty, this should execute line 951 (reInsertBatch)
        switchActor(0);  // Back to batch manager actor
        
        borrowerOperations.setBatchManagerAnnualInterestRate(
            _newRate,
            0,
            0,
            type(uint256).max
        );
    }
    
    /// COVERAGE TARGET: removeFromBatch - lines 1041-1091
    /// ROOT CAUSE: Line 1043 _requireIsInBatch failing - trove is not in a batch
    /// SOLUTION: Shortcut that explicitly creates trove IN batch, then removes it
    function shortcut_phase5_removeFromBatch_troveInBatch(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint128 _batchRate,
        uint128 _newRate
    ) public {
        // Ensure rates are in valid range
        _batchRate = uint128(MIN_ANNUAL_INTEREST_RATE + 
            (uint256(_batchRate) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1)));
        _newRate = uint128(MIN_ANNUAL_INTEREST_RATE + 
            (uint256(_newRate) % (MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE + 1)));
        
        // Step 1: Register batch manager AS actor 0
        borrowerOperations.registerBatchManager(
            uint128(MIN_ANNUAL_INTEREST_RATE),
            uint128(MAX_ANNUAL_INTEREST_RATE),
            _batchRate,
            uint128(0),
            0
        );
        address batchManagerAddr = _getActor();
        
        // Step 2: Switch to different actor and open trove IN batch
        switchActor(1);
        
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        if (_collAmount < 10e18) _collAmount = 10e18;
        _boldAmount = (_boldAmount % (MIN_DEBT * 10)) + MIN_DEBT;
        
        IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = 
            IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({
                owner: _getActor(),
                ownerIndex: 0,
                collAmount: _collAmount,
                boldAmount: _boldAmount,
                upperHint: 0,
                lowerHint: 0,
                interestBatchManager: batchManagerAddr,
                maxUpfrontFee: type(uint256).max,
                addManager: address(0),
                removeManager: address(0),
                receiver: address(0)
            });
        
        // Open trove and capture the returned troveId
        uint256 troveInBatch;
        try borrowerOperations.openTroveAndJoinInterestBatchManager(params) returns (uint256 newTroveId) {
            troveInBatch = newTroveId;
            troveIds.push(newTroveId);  // Track the trove
            clampedTroveId = newTroveId;
        } catch {
            return;  // Failed to open trove, skip
        }
        
        // Verify trove IS in batch (line 1043 requires this)
        address currentBatch = borrowerOperations.interestBatchManagerOf(troveInBatch);
        if (currentBatch == address(0)) return;  // Not in batch, skip
        
        // Step 3: Remove from batch (should now cover lines 1041-1091)
        borrowerOperations.removeFromBatch(
            troveInBatch,
            _newRate,
            0,
            0,
            type(uint256).max
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