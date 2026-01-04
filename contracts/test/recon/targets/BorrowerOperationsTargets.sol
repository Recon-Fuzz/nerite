
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import "forge-std/console2.sol";

import {Properties} from "../Properties.sol";

import {IBorrowerOperations} from "../../../src/Interfaces/IBorrowerOperations.sol";

import {LiquityMath} from "../../../src/Dependencies/LiquityMath.sol";
import {MIN_DEBT, MAX_ANNUAL_INTEREST_RATE, MAX_ANNUAL_BATCH_MANAGEMENT_FEE, _100pct} from "../../../src/Dependencies/Constants.sol";
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
        // Use active trove instead of any trove
        _troveId = getActiveOrZombieTroveId(_troveId);
        _newAnnualInterestRate = _newAnnualInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1);
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
        _troveId = setNewClampedTroveId(_troveId);
        _newAnnualInterestRate = _newAnnualInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1);
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
        _troveId = setNewClampedTroveId(_troveId);
        _newBatchManager = setNewClampedBatchManager(uint256(uint160(_newBatchManager)));
        _upperHint = setNewClampedTroveId(_upperHint);
        _lowerHint = setNewClampedTroveId(_lowerHint);
        
        borrowerOperations_setInterestBatchManager(_troveId, _newBatchManager, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_setInterestIndividualDelegate_clamped(uint256 _troveId, address _delegate, uint128 _minInterestRate, uint128 _maxInterestRate, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee, uint256 _minInterestRateChangePeriod) public {
        _troveId = setNewClampedTroveId(_troveId);
        _minInterestRate = uint128(_minInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1));
        _maxInterestRate = uint128(_maxInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1));
        _newAnnualInterestRate = _newAnnualInterestRate % (MAX_ANNUAL_INTEREST_RATE + 1);
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
        _newBatchManager = setNewClampedBatchManager(uint256(uint160(_newBatchManager)));
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
    function shortcut_setAndRemoveIndividualDelegate(uint256 _troveId) public {
        _troveId = setNewClampedTroveId(_troveId);
        
        // First set the delegate
        borrowerOperations_setInterestIndividualDelegate_clamped(
            _troveId,
            _getActor(),
            0,
            uint128(MAX_ANNUAL_INTEREST_RATE),
            MAX_ANNUAL_INTEREST_RATE / 2,
            0,
            0,
            type(uint256).max,
            0
        );
        
        // Then remove it
        borrowerOperations_removeInterestIndividualDelegate_clamped(_troveId);
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
}