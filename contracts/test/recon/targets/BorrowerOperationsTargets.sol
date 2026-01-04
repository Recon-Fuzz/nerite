
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import "forge-std/console2.sol";

import {Properties} from "../Properties.sol";

import {IBorrowerOperations} from "../../../src/Interfaces/IBorrowerOperations.sol";

import {LiquityMath} from "../../../src/Dependencies/LiquityMath.sol";
import {MIN_DEBT, MIN_ANNUAL_INTEREST_RATE, MAX_ANNUAL_INTEREST_RATE, MAX_ANNUAL_BATCH_MANAGEMENT_FEE, _100pct} from "../../../src/Dependencies/Constants.sol";
import {LatestTroveData} from "../../../src/Types/LatestTroveData.sol";

abstract contract BorrowerOperationsTargets is BaseTargetFunctions, Properties  {

    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    /// === Clamped Handlers === ///

    function borrowerOperations_addColl_clamped(uint256 _troveId, uint256 _collAmount) public {
        _troveId = setNewClampedTroveId(_troveId);
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        
        borrowerOperations_addColl(_troveId, _collAmount);
    }

    function borrowerOperations_adjustTrove_clamped(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) public {
        _troveId = setNewClampedTroveId(_troveId);
        _collChange = _collChange % (collToken.balanceOf(_getActor()) + 1);
        _boldChange = _boldChange % (boldToken.balanceOf(_getActor()) + 1);
        
        borrowerOperations_adjustTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _maxUpfrontFee);
    }

    function borrowerOperations_adjustTroveInterestRate_clamped(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public {
        // Use active STANDALONE trove (not in a batch) - this is a requirement for adjustTroveInterestRate
        _troveId = getActiveStandaloneTroveId(_troveId);
        
        // Ensure interest rate is in valid range
        uint256 range = MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE;
        _newAnnualInterestRate = MIN_ANNUAL_INTEREST_RATE + (_newAnnualInterestRate % (range + 1));
        
        _upperHint = setNewClampedTroveId(_upperHint);
        _lowerHint = setNewClampedTroveId(_lowerHint);
        
        borrowerOperations_adjustTroveInterestRate(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_adjustZombieTrove_clamped(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public {
        _troveId = setNewClampedTroveId(_troveId);
        _collChange = _collChange % (collToken.balanceOf(_getActor()) + 1);
        _boldChange = _boldChange % (boldToken.balanceOf(_getActor()) + 1);
        _upperHint = setNewClampedTroveId(_upperHint);
        _lowerHint = setNewClampedTroveId(_lowerHint);
        
        borrowerOperations_adjustZombieTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_applyPendingDebt_clamped(uint256 _troveId, uint256 _lowerHint, uint256 _upperHint) public {
        _troveId = setNewClampedTroveId(_troveId);
        _lowerHint = setNewClampedTroveId(_lowerHint);
        _upperHint = setNewClampedTroveId(_upperHint);
        
        borrowerOperations_applyPendingDebt(_troveId, _lowerHint, _upperHint);
    }

    function borrowerOperations_closeTrove_clamped(uint256 _troveId) public {
        // Use open trove instead of any trove
        _troveId = getOpenTroveId(_troveId);
        
        // Ensure the actor has sufficient Bold balance to close the trove
        // by minting if needed (this simulates the actor accumulating Bold)
        try troveManager.getLatestTroveData(_troveId) returns (LatestTroveData memory troveData) {
            uint256 actorBalance = boldToken.balanceOf(_getActor());
            if (actorBalance < troveData.entireDebt) {
                // Mint the difference to actor to ensure they can close
                vm.prank(address(borrowerOperations));
                boldToken.mint(_getActor(), troveData.entireDebt - actorBalance);
            }
        } catch {}
        
        borrowerOperations_closeTrove(_troveId);
    }

    function borrowerOperations_lowerBatchManagementFee_clamped(uint256 _newAnnualManagementFee) public {
        _newAnnualManagementFee = _newAnnualManagementFee % (MAX_ANNUAL_BATCH_MANAGEMENT_FEE + 1);
        
        borrowerOperations_lowerBatchManagementFee(_newAnnualManagementFee);
    }

    function borrowerOperations_onLiquidateTrove_clamped(uint256 _troveId) public {
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_onLiquidateTrove(_troveId);
    }

    function borrowerOperations_openTrove_clamped(address _owner, uint256 _ownerIndex, uint256 _collAmount, uint256 _boldAmount, uint256 _upperHint, uint256 _lowerHint, uint256 _annualInterestRate, uint256 _maxUpfrontFee, address _addManager, address _removeManager, address _receiver) public {
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        _boldAmount = _boldAmount % (MIN_DEBT + 1);
        _annualInterestRate = _annualInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1);
        _upperHint = setNewClampedTroveId(_upperHint);
        _lowerHint = setNewClampedTroveId(_lowerHint);
        
        uint256 troveId = borrowerOperations_openTrove(_owner, _ownerIndex, _collAmount, _boldAmount, _upperHint, _lowerHint, _annualInterestRate, _maxUpfrontFee, _addManager, _removeManager, _receiver);
        troveIds.push(troveId);
    }

    function borrowerOperations_registerBatchManager_clamped(uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _annualManagementFee, uint128 _minInterestRateChangePeriod) public {
        _minInterestRate = uint128(_minInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1));
        _maxInterestRate = uint128(_maxInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1));
        _currentInterestRate = uint128(_currentInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1));
        _annualManagementFee = uint128(_annualManagementFee % (MAX_ANNUAL_BATCH_MANAGEMENT_FEE + 1));
        
        borrowerOperations_registerBatchManager(_minInterestRate, _maxInterestRate, _currentInterestRate, _annualManagementFee, _minInterestRateChangePeriod);
    }

    function borrowerOperations_removeFromBatch_clamped(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public {
        // Use a trove that IS in a batch - this is required for removeFromBatch
        _troveId = getTroveInBatchId(_troveId);
        
        // Ensure interest rate is in valid range
        uint256 range = MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE;
        _newAnnualInterestRate = MIN_ANNUAL_INTEREST_RATE + (_newAnnualInterestRate % (range + 1));
        
        _upperHint = setNewClampedTroveId(_upperHint);
        _lowerHint = setNewClampedTroveId(_lowerHint);
        
        borrowerOperations_removeFromBatch(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_removeInterestIndividualDelegate_clamped(uint256 _troveId) public {
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_removeInterestIndividualDelegate(_troveId);
    }

    function borrowerOperations_repayBold_clamped(uint256 _troveId, uint256 _boldAmount) public {
        _troveId = setNewClampedTroveId(_troveId);
        _boldAmount = _boldAmount % (boldToken.balanceOf(_getActor()) + 1);
        
        borrowerOperations_repayBold(_troveId, _boldAmount);
    }

    function borrowerOperations_setAddManager_clamped(uint256 _troveId, address _manager) public {
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_setAddManager(_troveId, _manager);
    }

    function borrowerOperations_setBatchManagerAnnualInterestRate_clamped(uint128 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public {
        _newAnnualInterestRate = uint128(_newAnnualInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1));
        _upperHint = setNewClampedTroveId(_upperHint);
        _lowerHint = setNewClampedTroveId(_lowerHint);
        
        borrowerOperations_setBatchManagerAnnualInterestRate(_newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_setInterestBatchManager_clamped(uint256 _troveId, address _newBatchManager, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public {
        // Use active standalone trove (NOT in a batch) - this is required for setInterestBatchManager
        _troveId = getActiveStandaloneTroveId(_troveId);
        _newBatchManager = setNewClampedBatchManager(uint256(uint160(_newBatchManager)));
        _upperHint = setNewClampedTroveId(_upperHint);
        _lowerHint = setNewClampedTroveId(_lowerHint);
        
        borrowerOperations_setInterestBatchManager(_troveId, _newBatchManager, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_setInterestIndividualDelegate_clamped(uint256 _troveId, address _delegate, uint128 _minInterestRate, uint128 _maxInterestRate, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee, uint256 _minInterestRateChangePeriod) public {
        // Use active trove to ensure it's in the right state
        _troveId = setNewClampedTroveId(_troveId);
        
        // Ensure minInterestRate and maxInterestRate are valid and ordered
        // Clamp to valid range: MIN_ANNUAL_INTEREST_RATE to MAX_ANNUAL_INTEREST_RATE
        uint256 range = MAX_ANNUAL_INTEREST_RATE - MIN_ANNUAL_INTEREST_RATE;
        
        // First, clamp minInterestRate to the valid range
        _minInterestRate = uint128(MIN_ANNUAL_INTEREST_RATE + (_minInterestRate % (range + 1)));
        
        // Then, clamp maxInterestRate to be >= minInterestRate and <= MAX_ANNUAL_INTEREST_RATE
        // Calculate remaining range from minInterestRate to MAX
        uint256 remainingRange = MAX_ANNUAL_INTEREST_RATE - _minInterestRate;
        if (remainingRange > 0) {
            _maxInterestRate = uint128(_minInterestRate + (_maxInterestRate % (remainingRange + 1)));
        } else {
            _maxInterestRate = _minInterestRate;
        }
        
        // Ensure _newAnnualInterestRate is also in valid range
        _newAnnualInterestRate = MIN_ANNUAL_INTEREST_RATE + (_newAnnualInterestRate % (range + 1));
        _upperHint = setNewClampedTroveId(_upperHint);
        _lowerHint = setNewClampedTroveId(_lowerHint);
        
        borrowerOperations_setInterestIndividualDelegate(_troveId, _delegate, _minInterestRate, _maxInterestRate, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee, _minInterestRateChangePeriod);
    }

    function borrowerOperations_setRemoveManager_clamped(uint256 _troveId, address _manager) public {
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_setRemoveManager(_troveId, _manager);
    }

    function borrowerOperations_setRemoveManagerWithReceiver_clamped(uint256 _troveId, address _manager, address _receiver) public {
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_setRemoveManagerWithReceiver(_troveId, _manager, _receiver);
    }

    function borrowerOperations_switchBatchManager_clamped(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, address _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) public {
        _troveId = setNewClampedTroveId(_troveId);
        _removeUpperHint = setNewClampedTroveId(_removeUpperHint);
        _removeLowerHint = setNewClampedTroveId(_removeLowerHint);
        
        // Get the current batch manager for this trove to ensure we select a DIFFERENT one
        address currentBatchManager = borrowerOperations.interestBatchManagerOf(_troveId);
        if (currentBatchManager != address(0)) {
            _newBatchManager = getDifferentBatchManager(currentBatchManager, uint256(uint160(_newBatchManager)));
            if (_newBatchManager == address(0)) {
                // Fallback if no different batch manager available
                _newBatchManager = setNewClampedBatchManager(uint256(uint160(_newBatchManager)));
            }
        } else {
            _newBatchManager = setNewClampedBatchManager(uint256(uint160(_newBatchManager)));
        }
        
        _addUpperHint = setNewClampedTroveId(_addUpperHint);
        _addLowerHint = setNewClampedTroveId(_addLowerHint);
        
        borrowerOperations_switchBatchManager(_troveId, _removeUpperHint, _removeLowerHint, _newBatchManager, _addUpperHint, _addLowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_withdrawBold_clamped(uint256 _troveId, uint256 _boldAmount, uint256 _maxUpfrontFee) public {
        // Use active trove
        _troveId = getActiveOrZombieTroveId(_troveId);
        
        // Clamp to available debt capacity under the debt limit
        uint256 debtLimit = troveManager.getDebtLimit();
        uint256 currentSystemDebt = troveManager.getEntireSystemDebt();
        
        if (debtLimit > currentSystemDebt) {
            uint256 availableDebt = debtLimit - currentSystemDebt;
            if (availableDebt > 0) {
                _boldAmount = (_boldAmount % availableDebt) + 1; // ensure > 0
            } else {
                _boldAmount = 1; // minimal amount
            }
        } else {
            _boldAmount = 1; // minimal amount if at limit
        }
        
        borrowerOperations_withdrawBold(_troveId, _boldAmount, _maxUpfrontFee);
    }

    function borrowerOperations_withdrawColl_clamped(uint256 _troveId, uint256 _collWithdrawal) public {
        // Use active trove
        _troveId = getActiveOrZombieTroveId(_troveId);
        
        // Clamp withdrawal to a portion of the trove's collateral (to ensure it remains collateralized)
        try troveManager.getLatestTroveData(_troveId) returns (LatestTroveData memory troveData) {
            if (troveData.entireColl > 0) {
                // Withdraw at most 30% of collateral to help maintain collateralization
                uint256 maxWithdrawal = (troveData.entireColl * 30) / 100;
                if (maxWithdrawal > 0) {
                    _collWithdrawal = (_collWithdrawal % maxWithdrawal) + 1;
                } else {
                    _collWithdrawal = 1;
                }
            }
        } catch {
            _collWithdrawal = 1e18; // Default small amount
        }
        
        borrowerOperations_withdrawColl(_troveId, _collWithdrawal);
    }

    /// === Handlers === ///


    function borrowerOperations_addColl(uint256 _troveId, uint256 _collAmount) public updateGhosts asActor {
        borrowerOperations.addColl(_troveId, _collAmount);
    }

    function borrowerOperations_adjustTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) public updateGhosts asActor {
        borrowerOperations.adjustTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _maxUpfrontFee);
    }

    function borrowerOperations_adjustTroveInterestRate(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public updateGhosts asActor {
        borrowerOperations.adjustTroveInterestRate(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_adjustZombieTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public updateGhosts asActor {
        borrowerOperations.adjustZombieTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _upperHint, _lowerHint, _maxUpfrontFee);
    }


    function borrowerOperations_applyPendingDebt(uint256 _troveId, uint256 _lowerHint, uint256 _upperHint) public updateGhosts asActor {
        borrowerOperations.applyPendingDebt(_troveId, _lowerHint, _upperHint);
    }


    function borrowerOperations_applyPendingDebt(uint256 _troveId) public updateGhosts asActor {
        borrowerOperations.applyPendingDebt(_troveId);
    }


    function borrowerOperations_closeTrove(uint256 _troveId) public updateGhosts asActor {
        borrowerOperations.closeTrove(_troveId);
    }


    function borrowerOperations_lowerBatchManagementFee(uint256 _newAnnualManagementFee) public updateGhosts asActor {
        borrowerOperations.lowerBatchManagementFee(_newAnnualManagementFee);
    }

    function borrowerOperations_onLiquidateTrove(uint256 _troveId) public updateGhosts asActor {
        borrowerOperations.onLiquidateTrove(_troveId);
    }

    function borrowerOperations_openTrove(address _owner, uint256 _ownerIndex, uint256 _collAmount, uint256 _boldAmount, uint256 _upperHint, uint256 _lowerHint, uint256 _annualInterestRate, uint256 _maxUpfrontFee, address _addManager, address _removeManager, address _receiver) public updateGhosts asActor returns (uint256) {
        uint256 troveId = borrowerOperations.openTrove(_owner, _ownerIndex, _collAmount, _boldAmount, _upperHint, _lowerHint, _annualInterestRate, _maxUpfrontFee, _addManager, _removeManager, _receiver);
        clampedTroveId = troveId;
        return troveId;
    }

    function borrowerOperations_openTroveAndJoinInterestBatchManager(IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory _params) public updateGhosts asActor {
        borrowerOperations.openTroveAndJoinInterestBatchManager(_params);
    }

    function borrowerOperations_registerBatchManager(uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _annualManagementFee, uint128 _minInterestRateChangePeriod) public updateGhosts asActor {
        borrowerOperations.registerBatchManager(_minInterestRate, _maxInterestRate, _currentInterestRate, _annualManagementFee, _minInterestRateChangePeriod);
        // Track registered batch manager
        registeredBatchManagers.push(_getActor());
    }

    function borrowerOperations_removeFromBatch(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public updateGhosts asActor {
        borrowerOperations.removeFromBatch(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_removeInterestIndividualDelegate(uint256 _troveId) public updateGhosts asActor {
        borrowerOperations.removeInterestIndividualDelegate(_troveId);
    }


    function borrowerOperations_repayBold(uint256 _troveId, uint256 _boldAmount) public updateGhosts asActor {
        borrowerOperations.repayBold(_troveId, _boldAmount);
    }

    function borrowerOperations_setAddManager(uint256 _troveId, address _manager) public updateGhosts asActor {
        borrowerOperations.setAddManager(_troveId, _manager);
    }

    function borrowerOperations_setBatchManagerAnnualInterestRate(uint128 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public updateGhosts asActor {
        borrowerOperations.setBatchManagerAnnualInterestRate(_newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_setInterestBatchManager(uint256 _troveId, address _newBatchManager, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public updateGhosts asActor {
        borrowerOperations.setInterestBatchManager(_troveId, _newBatchManager, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_setInterestIndividualDelegate(uint256 _troveId, address _delegate, uint128 _minInterestRate, uint128 _maxInterestRate, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee, uint256 _minInterestRateChangePeriod) public updateGhosts asActor {
        borrowerOperations.setInterestIndividualDelegate(_troveId, _delegate, _minInterestRate, _maxInterestRate, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee, _minInterestRateChangePeriod);
    }

    function borrowerOperations_setRemoveManager(uint256 _troveId, address _manager) public updateGhosts asActor {
        borrowerOperations.setRemoveManager(_troveId, _manager);
    }

    function borrowerOperations_setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) public updateGhosts asActor {
        borrowerOperations.setRemoveManagerWithReceiver(_troveId, _manager, _receiver);
    }

    function borrowerOperations_shutdown() public updateGhosts asActor {
        borrowerOperations.shutdown();
    }

    function borrowerOperations_shutdownFromOracleFailure() public updateGhosts asActor {
        borrowerOperations.shutdownFromOracleFailure();
    }

    // === Switch Batch Manager === //

    function borrowerOperations_switchBatchManager(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, address _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) public updateGhosts asActor {
        borrowerOperations.switchBatchManager(_troveId, _removeUpperHint, _removeLowerHint, _newBatchManager, _addUpperHint, _addLowerHint, _maxUpfrontFee);
    }


    // === Withdraw Bold === //
    function borrowerOperations_withdrawBold(uint256 _troveId, uint256 _boldAmount, uint256 _maxUpfrontFee) public updateGhosts asActor {
        borrowerOperations.withdrawBold(_troveId, _boldAmount, _maxUpfrontFee);
    }

    // === Withdraw Coll === //
    function borrowerOperations_withdrawColl(uint256 _troveId, uint256 _collWithdrawal) public updateGhosts asActor {
        borrowerOperations.withdrawColl(_troveId, _collWithdrawal);
    }

    // ===== ADDITIONAL IMPROVED HANDLERS FOR COVERAGE ===== //

    /// Handler to open a trove and join a batch manager in one call
    function borrowerOperations_openTroveAndJoinInterestBatchManager_clamped(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint256 _annualInterestRate,
        address _interestBatchManager,
        uint256 _maxUpfrontFee
    ) public {
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        if (_collAmount == 0) _collAmount = 1;
        
        _boldAmount = (_boldAmount % (MIN_DEBT * 10)) + MIN_DEBT; // Ensure valid debt amount
        _interestBatchManager = setNewClampedBatchManager(uint256(uint160(_interestBatchManager)));
        
        IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory params = 
            IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({
                owner: _getActor(),
                ownerIndex: 0,
                collAmount: _collAmount,
                boldAmount: _boldAmount,
                upperHint: 0,
                lowerHint: 0,
                interestBatchManager: _interestBatchManager,
                maxUpfrontFee: _maxUpfrontFee,
                addManager: address(0),
                removeManager: address(0),
                receiver: address(0)
            });
        
        borrowerOperations_openTroveAndJoinInterestBatchManager(params);
    }

    /// Shortcut to ensure a trove has individual delegate set before removing it
    function shortcut_setAndRemoveIndividualDelegate(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint256 _annualInterestRate,
        address _delegate
    ) public {
        // Step 1: Open a fresh trove owned by current actor
        borrowerOperations_openTrove_clamped(
            address(0),
            0,
            _collAmount,
            _boldAmount,
            0,
            0,
            _annualInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1),
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        uint256 freshTroveId = clampedTroveId;
        
        // Step 2: Set individual delegate on this trove
        borrowerOperations_setInterestIndividualDelegate_clamped(
            freshTroveId,
            _delegate,
            0,
            uint128(MAX_ANNUAL_INTEREST_RATE),
            MAX_ANNUAL_INTEREST_RATE / 2,
            0,
            0,
            type(uint256).max,
            1 hours
        );
        
        // Step 3: Now remove the delegate (this should cover line 834)
        borrowerOperations_removeInterestIndividualDelegate(freshTroveId);
    }
    
    /// Enhanced shortcut to test removeInterestIndividualDelegate with proper setup
    function shortcut_removeIndividualDelegate_comprehensive(
        uint256 _collAmount,
        uint256 _boldAmount
    ) public {
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        if (_collAmount < 10e18) _collAmount = 10e18;
        _boldAmount = (_boldAmount % (MIN_DEBT * 10)) + MIN_DEBT;
        
        // Open trove, set delegate, then remove it
        uint256 troveId = borrowerOperations.openTrove(
            _getActor(),
            0,
            _collAmount,
            _boldAmount,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Set delegate with valid parameters
        try borrowerOperations.setInterestIndividualDelegate(
            troveId,
            _getActor(), // Use same actor as delegate
            0,
            uint128(MAX_ANNUAL_INTEREST_RATE),
            MAX_ANNUAL_INTEREST_RATE / 2,
            0,
            0,
            type(uint256).max,
            0
        ) {} catch {}
        
        // Now remove it
        try borrowerOperations.removeInterestIndividualDelegate(troveId) {} catch {}
    }

    /// Improved handler to ensure batch managers are registered before use
    function borrowerOperations_registerAndUseBatchManager(
        uint128 _annualInterestRate,
        uint128 _annualManagementFee
    ) public {
        _annualInterestRate = uint128(_annualInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1));
        _annualManagementFee = uint128(_annualManagementFee % (MAX_ANNUAL_BATCH_MANAGEMENT_FEE + 1));
        
        // Register the current actor as a batch manager
        borrowerOperations_registerBatchManager_clamped(
            0,
            uint128(MAX_ANNUAL_INTEREST_RATE),
            _annualInterestRate,
            _annualManagementFee,
            0
        );
        
        // Now set this registered batch manager for use
        clampedBatchManager = _getActor();
    }

    /// Shortcut to close a trove with proper setup
    function shortcut_closeTrove_withSetup(uint256 _collAmount, uint256 _boldAmount) public {
        // Open a trove
        borrowerOperations_openTrove_clamped(
            address(0),
            0,
            _collAmount,
            _boldAmount,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Warp time forward to accrue some interest
        vm.warp(block.timestamp + 365 days);
        
        // Close the trove with clamped handler that ensures sufficient Bold
        borrowerOperations_closeTrove_clamped(clampedTroveId);
    }

    /// Shortcut for applyPendingDebt on a batch trove
    function shortcut_applyPendingDebtOnBatchTrove(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint256 _batchManagerSeed
    ) public {
        // First register a batch manager
        borrowerOperations_registerAndUseBatchManager(
            uint128(MAX_ANNUAL_INTEREST_RATE / 2),
            uint128(MAX_ANNUAL_BATCH_MANAGEMENT_FEE / 2)
        );
        
        // Open trove and join batch
        borrowerOperations_openTroveAndJoinInterestBatchManager_clamped(
            _collAmount,
            _boldAmount,
            MAX_ANNUAL_INTEREST_RATE / 2,
            clampedBatchManager,
            type(uint256).max
        );
        
        // Warp time to accumulate pending debt
        vm.warp(block.timestamp + 365 days);
        
        // Apply pending debt
        borrowerOperations_applyPendingDebt_clamped(clampedTroveId, 0, 0);
    }

    /// Shortcut for setBatchManagerAnnualInterestRate - ensures batch manager has troves
    function shortcut_setBatchManagerAnnualInterestRate_withBatch(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint128 _newAnnualInterestRate
    ) public {
        // Save current actor to restore later
        address currentActorAddress = _getActor();
        
        // Step 1: Register a batch manager
        borrowerOperations_registerAndUseBatchManager(
            uint128(MAX_ANNUAL_INTEREST_RATE / 2),
            uint128(MAX_ANNUAL_BATCH_MANAGEMENT_FEE / 2)
        );
        address batchManagerAddr = clampedBatchManager;
        
        // Step 2: Switch to a different actor to open the trove (borrowers can't be batch managers)
        address[] memory actors = _getActors();
        if (actors.length > 1) {
            // Find an actor that's not the batch manager
            for (uint256 i = 0; i < actors.length; i++) {
                if (actors[i] != batchManagerAddr) {
                    _enableActor(actors[i]);
                    break;
                }
            }
        }
        
        // Step 3: Open trove and join the batch
        borrowerOperations_openTroveAndJoinInterestBatchManager_clamped(
            _collAmount,
            _boldAmount,
            _newAnnualInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1),
            batchManagerAddr,
            type(uint256).max
        );
        
        // Step 4: Warp time to ensure cooldown period has passed
        vm.warp(block.timestamp + 8 days); // INTEREST_RATE_ADJ_COOLDOWN is 7 days
        
        // Step 5: Switch back to the batch manager to call setBatchManagerAnnualInterestRate
        _enableActor(batchManagerAddr);
        
        // Step 6: Call setBatchManagerAnnualInterestRate as the batch manager
        uint128 adjustedRate = uint128((_newAnnualInterestRate + 1) % (MAX_ANNUAL_INTEREST_RATE + 1));
        borrowerOperations_setBatchManagerAnnualInterestRate_clamped(
            adjustedRate,
            0,
            0,
            type(uint256).max
        );
    }

    /// Shortcut to trigger the upfront fee path in setBatchManagerAnnualInterestRate (within cooldown)
    function shortcut_setBatchManagerAnnualInterestRate_withinCooldown(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint128 _initialRate,
        uint128 _newRate
    ) public {
        address currentActorAddress = _getActor();
        
        // Step 1: Register a batch manager with initial rate
        _initialRate = uint128(_initialRate % (MAX_ANNUAL_INTEREST_RATE + 1));
        borrowerOperations_registerBatchManager_clamped(
            0,
            uint128(MAX_ANNUAL_INTEREST_RATE),
            _initialRate,
            uint128(MAX_ANNUAL_BATCH_MANAGEMENT_FEE / 2),
            0
        );
        address batchManagerAddr = _getActor();
        registeredBatchManagers.push(batchManagerAddr);
        
        // Step 2: Switch to different actor to open trove and join batch
        address[] memory actors = _getActors();
        if (actors.length > 1) {
            for (uint256 i = 0; i < actors.length; i++) {
                if (actors[i] != batchManagerAddr) {
                    _enableActor(actors[i]);
                    break;
                }
            }
        }
        
        // Step 3: Open trove and join batch
        borrowerOperations_openTroveAndJoinInterestBatchManager_clamped(
            _collAmount,
            _boldAmount,
            _initialRate,
            batchManagerAddr,
            type(uint256).max
        );
        
        // Step 4: Warp SMALL amount of time (within cooldown) - only 1 day instead of 8
        vm.warp(block.timestamp + 1 days); // Well within 7-day cooldown
        
        // Step 5: Switch to batch manager and change rate (should trigger upfront fee path)
        _enableActor(batchManagerAddr);
        _newRate = uint128(_newRate % (MAX_ANNUAL_INTEREST_RATE + 1));
        if (_newRate == _initialRate) {
            _newRate = uint128((_initialRate + 1) % (MAX_ANNUAL_INTEREST_RATE + 1));
        }
        
        borrowerOperations_setBatchManagerAnnualInterestRate_clamped(
            _newRate,
            0,
            0,
            type(uint256).max
        );
    }

    /// Shortcut for setInterestIndividualDelegate - ensures caller owns the trove
    function shortcut_setInterestIndividualDelegate_ownedTrove(
        uint256 _collAmount,
        uint256 _boldAmount
    ) public {
        // Step 1: Open a trove (actor automatically becomes the owner)
        borrowerOperations_openTrove_clamped(
            address(0),
            0,
            _collAmount,
            _boldAmount,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 2: The clampedTroveId now contains the trove owned by current actor
        // Call setInterestIndividualDelegate on this owned trove
        borrowerOperations_setInterestIndividualDelegate_clamped(
            clampedTroveId,
            _getActor(),
            0,
            uint128(MAX_ANNUAL_INTEREST_RATE),
            MAX_ANNUAL_INTEREST_RATE / 2,
            0,
            0,
            type(uint256).max,
            0
        );
    }

    /// Shortcut for adjustTroveInterestRate - ensures trove is active
    function shortcut_adjustTroveInterestRate_activeTrove(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint128 _newAnnualInterestRate
    ) public {
        // Step 1: Open a trove (will be active)
        borrowerOperations_openTrove_clamped(
            address(0),
            0,
            _collAmount,
            _boldAmount,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 2: Warp time to ensure cooldown has passed
        vm.warp(block.timestamp + 8 days);
        
        // Step 3: Adjust the interest rate on this active trove
        borrowerOperations_adjustTroveInterestRate_clamped(
            clampedTroveId,
            _newAnnualInterestRate,
            0,
            0,
            type(uint256).max
        );
    }

    /// Shortcut for removeFromBatch - ensures trove is in a batch
    function shortcut_removeFromBatch_inBatch(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint128 _newAnnualInterestRate
    ) public {
        // Step 1: Register a batch manager
        borrowerOperations_registerAndUseBatchManager(
            uint128(MAX_ANNUAL_INTEREST_RATE / 2),
            uint128(MAX_ANNUAL_BATCH_MANAGEMENT_FEE / 2)
        );
        
        // Step 2: Open trove and join batch
        borrowerOperations_openTroveAndJoinInterestBatchManager_clamped(
            _collAmount,
            _boldAmount,
            MAX_ANNUAL_INTEREST_RATE / 2,
            clampedBatchManager,
            type(uint256).max
        );
        
        // Step 3: Warp time to ensure cooldown has passed
        vm.warp(block.timestamp + 8 days);
        
        // Step 4: Remove from batch
        borrowerOperations_removeFromBatch_clamped(
            clampedTroveId,
            _newAnnualInterestRate,
            0,
            0,
            type(uint256).max
        );
    }

    /// Shortcut for setInterestBatchManager - ensures trove is NOT in a batch and batch manager exists
    function shortcut_setInterestBatchManager_standalone(
        uint256 _collAmount,
        uint256 _boldAmount
    ) public {
        // Step 1: Open a standalone trove (NOT in a batch)
        borrowerOperations_openTrove_clamped(
            address(0),
            0,
            _collAmount,
            _boldAmount,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 2: Register a batch manager (using a different actor to avoid conflicts)
        borrowerOperations_registerAndUseBatchManager(
            uint128(MAX_ANNUAL_INTEREST_RATE / 2),
            uint128(MAX_ANNUAL_BATCH_MANAGEMENT_FEE / 2)
        );
        
        // Step 3: Set the batch manager for the standalone trove
        borrowerOperations_setInterestBatchManager_clamped(
            clampedTroveId,
            clampedBatchManager,
            0,
            0,
            type(uint256).max
        );
    }

    /// Shortcut for switchBatchManager - ensures trove is in a batch and another batch exists
    function shortcut_switchBatchManager_twoBatches(
        uint256 _collAmount,
        uint256 _boldAmount
    ) public {
        address currentActorAddress = _getActor();
        
        // Step 1: Register first batch manager using first actor
        borrowerOperations_registerAndUseBatchManager(
            uint128(MAX_ANNUAL_INTEREST_RATE / 2),
            uint128(MAX_ANNUAL_BATCH_MANAGEMENT_FEE / 2)
        );
        address firstBatchManager = clampedBatchManager;
        
        // Step 2: Switch to different actor to open trove
        address[] memory actors = _getActors();
        if (actors.length > 1) {
            for (uint256 i = 0; i < actors.length; i++) {
                if (actors[i] != firstBatchManager) {
                    _enableActor(actors[i]);
                    break;
                }
            }
        }
        
        // Step 3: Open trove and join first batch
        borrowerOperations_openTroveAndJoinInterestBatchManager_clamped(
            _collAmount,
            _boldAmount,
            MAX_ANNUAL_INTEREST_RATE / 2,
            firstBatchManager,
            type(uint256).max
        );
        uint256 troveInBatch = clampedTroveId;
        address troveOwner = _getActor();
        
        // Step 4: Register second batch manager (using original actor)
        _enableActor(currentActorAddress);
        borrowerOperations_registerAndUseBatchManager(
            uint128(MAX_ANNUAL_INTEREST_RATE / 3),
            uint128(MAX_ANNUAL_BATCH_MANAGEMENT_FEE / 3)
        );
        address secondBatchManager = clampedBatchManager;
        
        // Ensure second batch is different from first
        if (secondBatchManager == firstBatchManager) {
            return; // Can't switch to same batch
        }
        
        // Step 5: Warp time to ensure cooldown has passed
        vm.warp(block.timestamp + 8 days);
        
        // Step 6: Switch back to trove owner to call switchBatchManager
        _enableActor(troveOwner);
        
        // Step 7: Switch from first batch to second batch
        borrowerOperations_switchBatchManager_clamped(
            troveInBatch,
            0,
            0,
            secondBatchManager,
            0,
            0,
            type(uint256).max
        );
    }
    
    /// Shortcut to create and adjust a zombie trove
    function shortcut_createAndAdjustZombieTrove(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint256 _priceCollapse
    ) public {
        // Step 1: Open a trove with minimal debt (below MIN_DEBT threshold after liquidation)
        _collAmount = (_collAmount % 10e18) + 1e18; // Small collateral
        _boldAmount = (_boldAmount % MIN_DEBT) + (MIN_DEBT / 2); // Debt below MIN_DEBT
        
        uint256 zombieTroveId = borrowerOperations.openTrove(
            _getActor(),
            0,
            _collAmount,
            _boldAmount,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 2: Create another larger trove for redistribution
        address[] memory actors = _getActors();
        if (actors.length > 1) {
            _enableActor(actors[1]);
        }
        
        uint256 largeTroveId = borrowerOperations.openTrove(
            _getActor(),
            0,
            100e18,
            MIN_DEBT * 10,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 3: Crash price to make first trove liquidatable
        uint256 crashedPrice = (_priceCollapse % 500e18) + 100e18;
        priceFeed.setPrice(crashedPrice);
        
        // Step 4: Liquidate the small trove (should become zombie due to debt < MIN_DEBT)
        try troveManager.liquidate(zombieTroveId) {} catch {}
        
        // Step 5: Now try to adjust the zombie trove
        borrowerOperations_adjustZombieTrove_clamped(
            zombieTroveId,
            1e18,
            true,
            MIN_DEBT,
            true,
            0,
            0,
            type(uint256).max
        );
    }
    
    /// Shortcut to create zombie trove and apply pending debt to make it active
    function shortcut_zombieToActiveViaPendingDebt(
        uint256 _collAmount
    ) public {
        // Step 1: Create a zombie trove (similar to above)
        _collAmount = (_collAmount % 10e18) + 1e18;
        
        uint256 zombieTroveId = borrowerOperations.openTrove(
            _getActor(),
            0,
            _collAmount,
            MIN_DEBT / 2,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 2: Create another trove for liquidation/redistribution
        address[] memory actors = _getActors();
        if (actors.length > 1) {
            _enableActor(actors[1]);
        }
        
        borrowerOperations.openTrove(
            _getActor(),
            0,
            100e18,
            MIN_DEBT * 10,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 3: Crash price and liquidate to create zombie
        priceFeed.setPrice(500e18);
        try troveManager.liquidate(zombieTroveId) {} catch {}
        
        // Step 4: Trigger redistribution by liquidating another trove
        // This will add pending debt to the zombie trove
        try troveManager.liquidate(zombieTroveId + 1) {} catch {}
        
        // Step 5: Warp time to accumulate more debt
        vm.warp(block.timestamp + 365 days);
        
        // Step 6: Apply pending debt to potentially make zombie active
        borrowerOperations_applyPendingDebt_clamped(zombieTroveId, 0, 0);
    }
    
    /// ===== PHASE 4 COVERAGE IMPROVEMENTS ===== ///
    
    /// Shortcut for closeTrove - ensures trove is open and actor has sufficient Bold
    function shortcut_closeTrove_fullyFunded(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint256 _annualInterestRate
    ) public {
        // Step 1: Open a trove
        borrowerOperations_openTrove_clamped(
            address(0),
            0,
            _collAmount,
            _boldAmount,
            0,
            0,
            _annualInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1),
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        uint256 troveToClose = clampedTroveId;
        
        // Step 2: Warp time to accumulate some interest
        vm.warp(block.timestamp + 30 days);
        
        // Step 3: Get the trove's debt and ensure actor has enough Bold
        try troveManager.getLatestTroveData(troveToClose) returns (LatestTroveData memory troveData) {
            uint256 actorBalance = boldToken.balanceOf(_getActor());
            if (actorBalance < troveData.entireDebt) {
                // Mint additional Bold to actor
                vm.prank(address(borrowerOperations));
                boldToken.mint(_getActor(), troveData.entireDebt - actorBalance + 1e18);
            }
        } catch {}
        
        // Step 4: Close the trove
        borrowerOperations_closeTrove(troveToClose);
    }
    
    /// Shortcut to create a batch with troves and then call setBatchManagerAnnualInterestRate within cooldown
    function shortcut_setBatchAnnualRate_prematureAdjustment(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint128 _initialRate,
        uint128 _newRate
    ) public {
        // Ensure rates are different
        _initialRate = uint128((_initialRate % (MAX_ANNUAL_INTEREST_RATE - 1)) + 1);
        _newRate = uint128((_newRate % (MAX_ANNUAL_INTEREST_RATE - 1)) + 1);
        if (_initialRate == _newRate) {
            _newRate = uint128((_initialRate % MAX_ANNUAL_INTEREST_RATE) + 1);
        }
        
        address originalActor = _getActor();
        
        // Step 1: Register a batch manager with _initialRate
        borrowerOperations_registerBatchManager_clamped(
            0,
            uint128(MAX_ANNUAL_INTEREST_RATE),
            _initialRate,
            uint128(MAX_ANNUAL_BATCH_MANAGEMENT_FEE / 2),
            1 hours // Short cooldown period
        );
        address batchManagerAddr = _getActor();
        
        // Step 2: Switch to different actor and open trove joining the batch
        address[] memory actors = _getActors();
        if (actors.length > 1) {
            for (uint256 i = 0; i < actors.length; i++) {
                if (actors[i] != batchManagerAddr) {
                    _enableActor(actors[i]);
                    break;
                }
            }
        }
        
        borrowerOperations_openTroveAndJoinInterestBatchManager_clamped(
            _collAmount,
            _boldAmount,
            _initialRate,
            batchManagerAddr,
            type(uint256).max
        );
        
        // Step 3: Warp SMALL amount of time (within cooldown) - this triggers the upfront fee path
        vm.warp(block.timestamp + 30 minutes); // Within 1 hour cooldown
        
        // Step 4: Switch to batch manager and change rate (should trigger lines 928-944)
        _enableActor(batchManagerAddr);
        
        borrowerOperations_setBatchManagerAnnualInterestRate_clamped(
            _newRate,
            0,
            0,
            type(uint256).max
        );
    }
    
    /// Shortcut for batchLiquidateTroves to generate collateral surplus
    function shortcut_batchLiquidate_withSurplus(
        uint256 _numTroves,
        uint256 _collAmount,
        uint256 _boldAmount
    ) public {
        // Create multiple over-collateralized troves
        _numTroves = (_numTroves % 3) + 1; // 1-3 troves
        uint256[] memory troveIdsToLiquidate = new uint256[](_numTroves);
        
        for (uint256 i = 0; i < _numTroves; i++) {
            // Create heavily over-collateralized troves (400% collateral ratio)
            uint256 collateral = (_collAmount % 100e18) + 50e18;
            uint256 debt = (_boldAmount % MIN_DEBT) + MIN_DEBT;
            
            uint256 tid = borrowerOperations.openTrove(
                _getActor(),
                i,
                collateral,
                debt,
                0,
                0,
                MAX_ANNUAL_INTEREST_RATE / 2,
                type(uint256).max,
                address(0),
                address(0),
                address(0)
            );
            troveIdsToLiquidate[i] = tid;
        }
        
        // Provide to stability pool to enable liquidations
        address[] memory actors = _getActors();
        if (actors.length > 1) {
            _enableActor(actors[1]);
        }
        uint256 spAmount = MIN_DEBT * _numTroves * 2;
        
        // First open a trove to get Bold
        borrowerOperations_openTrove_clamped(
            address(0),
            0,
            100e18,
            spAmount,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Provide to SP
        try stabilityPool.provideToSP(spAmount, false) {} catch {}
        
        // Crash price moderately (not too much, to ensure surplus)
        priceFeed.setPrice(1500e18);
        
        // Batch liquidate
        try troveManager.batchLiquidateTroves(troveIdsToLiquidate) {} catch {}
    }
    
    /// Shortcut for withdrawColl - ensures withdrawal maintains collateralization
    function shortcut_withdrawColl_maintainCollateral(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint256 _withdrawalPct
    ) public {
        // Step 1: Open a well-collateralized trove
        _collAmount = (_collAmount % 100e18) + 50e18; // Large collateral
        _boldAmount = (_boldAmount % MIN_DEBT) + MIN_DEBT;
        
        borrowerOperations_openTrove_clamped(
            address(0),
            0,
            _collAmount,
            _boldAmount,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 2: Withdraw a small percentage (10-20%) to maintain collateralization
        _withdrawalPct = (_withdrawalPct % 11) + 10; // 10-20%
        uint256 withdrawAmount = (_collAmount * _withdrawalPct) / 100;
        
        // Step 3: Call withdrawColl
        borrowerOperations_withdrawColl(clampedTroveId, withdrawAmount);
    }
    
    /// ===== PHASE 3 ADDITIONAL HANDLERS ===== ///
    
    /// Shortcut for closeTrove with batch - ensures trove in batch is properly closed
    function shortcut_closeTrove_inBatch(
        uint256 _collAmount,
        uint256 _boldAmount
    ) public {
        address originalActor = _getActor();
        
        // Step 1: Register a batch manager
        borrowerOperations_registerAndUseBatchManager(
            uint128(MAX_ANNUAL_INTEREST_RATE / 2),
            uint128(MAX_ANNUAL_BATCH_MANAGEMENT_FEE / 2)
        );
        address batchManagerAddr = clampedBatchManager;
        
        // Step 2: Switch to different actor and open trove in batch
        address[] memory actors = _getActors();
        if (actors.length > 1) {
            for (uint256 i = 0; i < actors.length; i++) {
                if (actors[i] != batchManagerAddr) {
                    _enableActor(actors[i]);
                    break;
                }
            }
        }
        
        borrowerOperations_openTroveAndJoinInterestBatchManager_clamped(
            _collAmount,
            _boldAmount,
            MAX_ANNUAL_INTEREST_RATE / 2,
            batchManagerAddr,
            type(uint256).max
        );
        uint256 troveInBatch = clampedTroveId;
        
        // Step 3: Warp time to accumulate some interest
        vm.warp(block.timestamp + 30 days);
        
        // Step 4: Ensure actor has sufficient Bold to close
        try troveManager.getLatestTroveData(troveInBatch) returns (LatestTroveData memory troveData) {
            uint256 actorBalance = boldToken.balanceOf(_getActor());
            if (actorBalance < troveData.entireDebt) {
                vm.prank(address(borrowerOperations));
                boldToken.mint(_getActor(), troveData.entireDebt - actorBalance + 1e18);
            }
        } catch {}
        
        // Step 5: Close the trove
        borrowerOperations_closeTrove(troveInBatch);
    }
    
    /// Shortcut to test setAddManager coverage
    function shortcut_setAddManager_validTrove(
        uint256 _collAmount,
        uint256 _boldAmount,
        address _manager
    ) public {
        // Step 1: Open a trove owned by current actor
        borrowerOperations_openTrove_clamped(
            address(0),
            0,
            _collAmount,
            _boldAmount,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 2: Set the add manager
        borrowerOperations_setAddManager(clampedTroveId, _manager);
    }
    
    /// Comprehensive shortcut to create zombie trove and test full lifecycle
    function shortcut_zombieTrove_fullLifecycle(
        uint256 _collAmount
    ) public {
        _collAmount = (_collAmount % 20e18) + 5e18;
        
        // Step 1: Open trove with debt just below MIN_DEBT
        uint256 zombieDebt = (MIN_DEBT * 95) / 100; // 95% of MIN_DEBT
        
        uint256 zombieTroveId = borrowerOperations.openTrove(
            _getActor(),
            0,
            _collAmount,
            zombieDebt,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 2: Create another trove for redistribution source
        address[] memory actors = _getActors();
        if (actors.length > 1) {
            _enableActor(actors[1]);
        }
        
        uint256 largeTroveId = borrowerOperations.openTrove(
            _getActor(),
            0,
            100e18,
            MIN_DEBT * 20,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 3: Setup stability pool for liquidation
        vm.prank(address(borrowerOperations));
        boldToken.mint(_getActor(), MIN_DEBT * 50);
        
        vm.prank(_getActor());
        boldToken.approve(address(stabilityPool), MIN_DEBT * 50);
        
        vm.prank(_getActor());
        try stabilityPool.provideToSP(MIN_DEBT * 50, false) {} catch {}
        
        // Step 4: Crash price to trigger liquidation
        uint256 crashPrice = priceFeed.getPrice() * 50 / 100;
        priceFeed.setPrice(crashPrice);
        
        // Step 5: Liquidate the small trove (should become zombie)
        try troveManager.liquidate(zombieTroveId) {} catch {}
        
        // Step 6: Try adjusting the zombie trove
        _enableActor(actors[0]);
        try borrowerOperations.adjustZombieTrove(
            zombieTroveId,
            1e18,
            true,
            MIN_DEBT,
            true,
            0,
            0,
            type(uint256).max
        ) {} catch {}
        
        // Step 7: Apply pending debt
        vm.warp(block.timestamp + 365 days);
        try borrowerOperations.applyPendingDebt(zombieTroveId, 0, 0) {} catch {}
    }
}