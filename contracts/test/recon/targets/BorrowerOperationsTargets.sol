
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import "forge-std/console2.sol";

import {Properties} from "../Properties.sol";

import {IBorrowerOperations} from "../../../src/Interfaces/IBorrowerOperations.sol";

import {LiquityMath} from "../../../src/Dependencies/LiquityMath.sol";

abstract contract BorrowerOperationsTargets is BaseTargetFunctions, Properties  {

    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    /// === Clamped Handlers === ///

    function borrowerOperations_addColl_clamped(uint256 _troveId, uint256 _collAmount) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        
        // Approve
        vm.prank(_getActor());
        collToken.approve(address(borrowerOperations), _collAmount);
        
        // Call unclamped handler
        borrowerOperations_addColl(clampedTroveId, _collAmount);
    }

    function borrowerOperations_adjustTrove_clamped(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        _collChange = _collChange % (collToken.balanceOf(_getActor()) + 1);
        
        // Approve
        vm.prank(_getActor());
        collToken.approve(address(borrowerOperations), _collChange);
        
        // Call unclamped handler
        borrowerOperations_adjustTrove(clampedTroveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _maxUpfrontFee);
    }

    function borrowerOperations_adjustTroveInterestRate_clamped(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        _newAnnualInterestRate = _newAnnualInterestRate % 250e16;
        uint256 clampedUpperHint = setNewClampedTroveId(_upperHint);
        uint256 clampedLowerHint = setNewClampedTroveId(_lowerHint);
        
        // Call unclamped handler
        borrowerOperations_adjustTroveInterestRate(clampedTroveId, _newAnnualInterestRate, clampedUpperHint, clampedLowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_adjustZombieTrove_clamped(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        _collChange = _collChange % (collToken.balanceOf(_getActor()) + 1);
        uint256 clampedUpperHint = setNewClampedTroveId(_upperHint);
        uint256 clampedLowerHint = setNewClampedTroveId(_lowerHint);
        
        // Approve
        vm.prank(_getActor());
        collToken.approve(address(borrowerOperations), _collChange);
        
        // Call unclamped handler
        borrowerOperations_adjustZombieTrove(clampedTroveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, clampedUpperHint, clampedLowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_applyPendingDebt_clamped(uint256 _troveId, uint256 _lowerHint, uint256 _upperHint) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        uint256 clampedUpperHint = setNewClampedTroveId(_upperHint);
        uint256 clampedLowerHint = setNewClampedTroveId(_lowerHint);
        
        // Call unclamped handler
        borrowerOperations_applyPendingDebt(clampedTroveId, clampedLowerHint, clampedUpperHint);
    }

    function borrowerOperations_closeTrove_clamped(uint256 _troveId) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        
        // Call unclamped handler
        borrowerOperations_closeTrove(clampedTroveId);
    }

    function borrowerOperations_lowerBatchManagementFee_clamped(uint256 _newAnnualManagementFee) public {
        // Clamp inputs
        _newAnnualManagementFee = _newAnnualManagementFee % 1e17;
        
        // Call unclamped handler
        borrowerOperations_lowerBatchManagementFee(_newAnnualManagementFee);
    }

    function borrowerOperations_onLiquidateTrove_clamped(uint256 _troveId) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        
        // Call unclamped handler
        borrowerOperations_onLiquidateTrove(clampedTroveId);
    }

    function borrowerOperations_openTrove_clamped(address _owner, uint256 _ownerIndex, uint256 _collAmount, uint256 _boldAmount, uint256 _upperHint, uint256 _lowerHint, uint256 _annualInterestRate, uint256 _maxUpfrontFee, address _addManager, address _removeManager, address _receiver) public {
        // Clamp inputs
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        _boldAmount = _boldAmount % 2000e18;
        _annualInterestRate = _annualInterestRate % 250e16;
        uint256 clampedUpperHint = troveIds.length > 0 ? setNewClampedTroveId(_upperHint) : 0;
        uint256 clampedLowerHint = troveIds.length > 0 ? setNewClampedTroveId(_lowerHint) : 0;
        
        // Approve
        vm.prank(_getActor());
        collToken.approve(address(borrowerOperations), _collAmount);
        
        // Call unclamped handler
        uint256 newTroveId = borrowerOperations_openTrove(_owner, _ownerIndex, _collAmount, _boldAmount, clampedUpperHint, clampedLowerHint, _annualInterestRate, _maxUpfrontFee, _addManager, _removeManager, _receiver);
        
        // Track the new trove
        troveIds.push(newTroveId);
    }

    function borrowerOperations_registerBatchManager_clamped(uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _annualManagementFee, uint128 _minInterestRateChangePeriod) public {
        // Clamp inputs
        _minInterestRate = uint128(_minInterestRate % 250e16);
        _maxInterestRate = uint128(_maxInterestRate % 250e16);
        _currentInterestRate = uint128(_currentInterestRate % 250e16);
        _annualManagementFee = uint128(_annualManagementFee % 1e17);
        _minInterestRateChangePeriod = uint128(_minInterestRateChangePeriod % 7 days);
        
        // Call unclamped handler
        borrowerOperations_registerBatchManager(_minInterestRate, _maxInterestRate, _currentInterestRate, _annualManagementFee, _minInterestRateChangePeriod);
    }

    function borrowerOperations_removeFromBatch_clamped(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        _newAnnualInterestRate = _newAnnualInterestRate % 250e16;
        uint256 clampedUpperHint = setNewClampedTroveId(_upperHint);
        uint256 clampedLowerHint = setNewClampedTroveId(_lowerHint);
        
        // Call unclamped handler
        borrowerOperations_removeFromBatch(clampedTroveId, _newAnnualInterestRate, clampedUpperHint, clampedLowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_removeInterestIndividualDelegate_clamped(uint256 _troveId) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        
        // Call unclamped handler
        borrowerOperations_removeInterestIndividualDelegate(clampedTroveId);
    }

    function borrowerOperations_repayBold_clamped(uint256 _troveId, uint256 _boldAmount) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        _boldAmount = _boldAmount % (boldToken.balanceOf(_getActor()) + 1);
        
        // Approve
        vm.prank(_getActor());
        boldToken.approve(address(borrowerOperations), _boldAmount);
        
        // Call unclamped handler
        borrowerOperations_repayBold(clampedTroveId, _boldAmount);
    }

    function borrowerOperations_setAddManager_clamped(uint256 _troveId, address _manager) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        
        // Call unclamped handler
        borrowerOperations_setAddManager(clampedTroveId, _manager);
    }

    function borrowerOperations_setBatchManagerAnnualInterestRate_clamped(uint128 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        _newAnnualInterestRate = uint128(_newAnnualInterestRate % 250e16);
        uint256 clampedUpperHint = setNewClampedTroveId(_upperHint);
        uint256 clampedLowerHint = setNewClampedTroveId(_lowerHint);
        
        // Call unclamped handler
        borrowerOperations_setBatchManagerAnnualInterestRate(_newAnnualInterestRate, clampedUpperHint, clampedLowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_setInterestBatchManager_clamped(uint256 _troveId, uint256 _newBatchManager, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        address clampedBatchMgr = setNewClampedBatchManager(_newBatchManager);
        uint256 clampedUpperHint = setNewClampedTroveId(_upperHint);
        uint256 clampedLowerHint = setNewClampedTroveId(_lowerHint);
        
        // Call unclamped handler
        borrowerOperations_setInterestBatchManager(clampedTroveId, clampedBatchMgr, clampedUpperHint, clampedLowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_setInterestIndividualDelegate_clamped(uint256 _troveId, address _delegate, uint128 _minInterestRate, uint128 _maxInterestRate, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee, uint256 _minInterestRateChangePeriod) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        _minInterestRate = uint128(_minInterestRate % 250e16);
        _maxInterestRate = uint128(_maxInterestRate % 250e16);
        _newAnnualInterestRate = _newAnnualInterestRate % 250e16;
        _minInterestRateChangePeriod = _minInterestRateChangePeriod % 7 days;
        uint256 clampedUpperHint = setNewClampedTroveId(_upperHint);
        uint256 clampedLowerHint = setNewClampedTroveId(_lowerHint);
        
        // Call unclamped handler
        borrowerOperations_setInterestIndividualDelegate(clampedTroveId, _delegate, _minInterestRate, _maxInterestRate, _newAnnualInterestRate, clampedUpperHint, clampedLowerHint, _maxUpfrontFee, _minInterestRateChangePeriod);
    }

    function borrowerOperations_setRemoveManager_clamped(uint256 _troveId, address _manager) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        
        // Call unclamped handler
        borrowerOperations_setRemoveManager(clampedTroveId, _manager);
    }

    function borrowerOperations_setRemoveManagerWithReceiver_clamped(uint256 _troveId, address _manager, address _receiver) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        
        // Call unclamped handler
        borrowerOperations_setRemoveManagerWithReceiver(clampedTroveId, _manager, _receiver);
    }

    function borrowerOperations_switchBatchManager_clamped(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, uint256 _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        uint256 clampedRemoveUpperHint = setNewClampedTroveId(_removeUpperHint);
        uint256 clampedRemoveLowerHint = setNewClampedTroveId(_removeLowerHint);
        address clampedBatchMgr = setNewClampedBatchManager(_newBatchManager);
        uint256 clampedAddUpperHint = setNewClampedTroveId(_addUpperHint);
        uint256 clampedAddLowerHint = setNewClampedTroveId(_addLowerHint);
        
        // Call unclamped handler
        borrowerOperations_switchBatchManager(clampedTroveId, clampedRemoveUpperHint, clampedRemoveLowerHint, clampedBatchMgr, clampedAddUpperHint, clampedAddLowerHint, _maxUpfrontFee);
    }

    function borrowerOperations_withdrawBold_clamped(uint256 _troveId, uint256 _boldAmount, uint256 _maxUpfrontFee) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        
        // Call unclamped handler
        borrowerOperations_withdrawBold(clampedTroveId, _boldAmount, _maxUpfrontFee);
    }

    function borrowerOperations_withdrawColl_clamped(uint256 _troveId, uint256 _collWithdrawal) public {
        // Clamp inputs
        if (troveIds.length == 0) return;
        clampedTroveId = setNewClampedTroveId(_troveId);
        
        // Call unclamped handler
        borrowerOperations_withdrawColl(clampedTroveId, _collWithdrawal);
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
}