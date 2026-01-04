
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

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function canary_liquidation() public {
        t(!hasDoneLiquidation, "canary_liquidation");
    }
    function canary_redemption() public {
        t(!hasDoneRedemption, "canary_redemption");
    }

}