
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

    // Clamped handler for addColl
    function borrowerOperations_addColl_clamped(uint256 _troveId, uint256 _collAmount) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        
        collToken.approve(address(borrowerOperations), _collAmount);
        borrowerOperations_addColl(_troveId, _collAmount);
    }

    // Clamped handler for adjustTrove
    function borrowerOperations_adjustTrove_clamped(
        uint256 _troveId, 
        uint256 _collChange, 
        bool _isCollIncrease, 
        uint256 _boldChange, 
        bool _isDebtIncrease, 
        uint256 _maxUpfrontFee
    ) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        _collChange = _collChange % (collToken.balanceOf(_getActor()) + 1);
        _boldChange = _boldChange % (boldToken.balanceOf(_getActor()) + 1);
        _maxUpfrontFee = _maxUpfrontFee % 1001e18;
        
        if (_isCollIncrease) {
            collToken.approve(address(borrowerOperations), _collChange);
        }
        borrowerOperations_adjustTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _maxUpfrontFee);
    }

    // Clamped handler for adjustTroveInterestRate
    function borrowerOperations_adjustTroveInterestRate_clamped(
        uint256 _troveId, 
        uint256 _newAnnualInterestRate, 
        uint256 _upperHint, 
        uint256 _lowerHint, 
        uint256 _maxUpfrontFee
    ) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        _newAnnualInterestRate = _newAnnualInterestRate % 250e16;
        _maxUpfrontFee = _maxUpfrontFee % 1001e18;
        
        borrowerOperations_adjustTroveInterestRate(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for adjustZombieTrove
    function borrowerOperations_adjustZombieTrove_clamped(
        uint256 _troveId, 
        uint256 _collChange, 
        bool _isCollIncrease, 
        uint256 _boldChange, 
        bool _isDebtIncrease, 
        uint256 _upperHint, 
        uint256 _lowerHint, 
        uint256 _maxUpfrontFee
    ) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        _collChange = _collChange % (collToken.balanceOf(_getActor()) + 1);
        _boldChange = _boldChange % (boldToken.balanceOf(_getActor()) + 1);
        
        if (_isCollIncrease) {
            collToken.approve(address(borrowerOperations), _collChange);
        }
        borrowerOperations_adjustZombieTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for applyPendingDebt
    function borrowerOperations_applyPendingDebt_clamped(uint256 _troveId, uint256 _lowerHint, uint256 _upperHint) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_applyPendingDebt(_troveId, _lowerHint, _upperHint);
    }

    // Clamped handler for closeTrove
    function borrowerOperations_closeTrove_clamped(uint256 _troveId) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_closeTrove(_troveId);
    }

    // Clamped handler for lowerBatchManagementFee
    function borrowerOperations_lowerBatchManagementFee_clamped(uint256 _newAnnualManagementFee) public {
        _newAnnualManagementFee = _newAnnualManagementFee % (1e17 + 1);
        
        borrowerOperations_lowerBatchManagementFee(_newAnnualManagementFee);
    }

    // Clamped handler for onLiquidateTrove
    function borrowerOperations_onLiquidateTrove_clamped(uint256 _troveId) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_onLiquidateTrove(_troveId);
    }

    // Clamped handler for openTrove
    function borrowerOperations_openTrove_clamped(
        address _owner, 
        uint256 _ownerIndex, 
        uint256 _collAmount, 
        uint256 _boldAmount, 
        uint256 _upperHint, 
        uint256 _lowerHint, 
        uint256 _annualInterestRate, 
        uint256 _maxUpfrontFee, 
        address _addManager, 
        address _removeManager, 
        address _receiver
    ) public returns (uint256) {
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        _boldAmount = _boldAmount % 100001e18;
        _annualInterestRate = _annualInterestRate % 250e16;
        _maxUpfrontFee = _maxUpfrontFee % 1001e18;
        
        collToken.approve(address(borrowerOperations), _collAmount);
        uint256 troveId = borrowerOperations_openTrove(_owner, _ownerIndex, _collAmount, _boldAmount, _upperHint, _lowerHint, _annualInterestRate, _maxUpfrontFee, _addManager, _removeManager, _receiver);
        troveIds.push(troveId);
        return troveId;
    }

    // Clamped handler for registerBatchManager
    function borrowerOperations_registerBatchManager_clamped(
        uint128 _minInterestRate, 
        uint128 _maxInterestRate, 
        uint128 _currentInterestRate, 
        uint128 _annualManagementFee, 
        uint128 _minInterestRateChangePeriod
    ) public {
        _minInterestRate = uint128(_minInterestRate % 5e15);
        _maxInterestRate = uint128(_maxInterestRate % 250e16);
        _currentInterestRate = uint128(_currentInterestRate % 250e16);
        _annualManagementFee = uint128(_annualManagementFee % (1e17 + 1));
        _minInterestRateChangePeriod = uint128(_minInterestRateChangePeriod % (7 days + 1));
        
        borrowerOperations_registerBatchManager(_minInterestRate, _maxInterestRate, _currentInterestRate, _annualManagementFee, _minInterestRateChangePeriod);
        clampedBatchManager = _getActor(); // The caller becomes a batch manager
    }

    // Clamped handler for removeFromBatch
    function borrowerOperations_removeFromBatch_clamped(
        uint256 _troveId, 
        uint256 _newAnnualInterestRate, 
        uint256 _upperHint, 
        uint256 _lowerHint, 
        uint256 _maxUpfrontFee
    ) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        _newAnnualInterestRate = _newAnnualInterestRate % 250e16;
        _maxUpfrontFee = _maxUpfrontFee % 1001e18;
        
        borrowerOperations_removeFromBatch(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for removeInterestIndividualDelegate
    function borrowerOperations_removeInterestIndividualDelegate_clamped(uint256 _troveId) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_removeInterestIndividualDelegate(_troveId);
    }

    // Clamped handler for repayBold
    function borrowerOperations_repayBold_clamped(uint256 _troveId, uint256 _boldAmount) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        _boldAmount = _boldAmount % (boldToken.balanceOf(_getActor()) + 1);
        
        borrowerOperations_repayBold(_troveId, _boldAmount);
    }

    // Clamped handler for setAddManager
    function borrowerOperations_setAddManager_clamped(uint256 _troveId, address _manager) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_setAddManager(_troveId, _manager);
    }

    // Clamped handler for setBatchManagerAnnualInterestRate
    function borrowerOperations_setBatchManagerAnnualInterestRate_clamped(
        uint128 _newAnnualInterestRate, 
        uint256 _upperHint, 
        uint256 _lowerHint, 
        uint256 _maxUpfrontFee
    ) public {
        _newAnnualInterestRate = uint128(_newAnnualInterestRate % 250e16);
        _maxUpfrontFee = _maxUpfrontFee % 1001e18;
        
        borrowerOperations_setBatchManagerAnnualInterestRate(_newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for setInterestBatchManager
    function borrowerOperations_setInterestBatchManager_clamped(
        uint256 _troveId, 
        address _newBatchManager, 
        uint256 _upperHint, 
        uint256 _lowerHint, 
        uint256 _maxUpfrontFee
    ) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        _newBatchManager = setNewClampedBatchManager(uint256(uint160(_newBatchManager)));
        _maxUpfrontFee = _maxUpfrontFee % 1001e18;
        
        borrowerOperations_setInterestBatchManager(_troveId, _newBatchManager, _upperHint, _lowerHint, _maxUpfrontFee);
    }

    // Clamped handler for setInterestIndividualDelegate
    function borrowerOperations_setInterestIndividualDelegate_clamped(
        uint256 _troveId, 
        address _delegate, 
        uint128 _minInterestRate, 
        uint128 _maxInterestRate, 
        uint256 _newAnnualInterestRate, 
        uint256 _upperHint, 
        uint256 _lowerHint, 
        uint256 _maxUpfrontFee, 
        uint256 _minInterestRateChangePeriod
    ) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        _minInterestRate = uint128(_minInterestRate % 5e15);
        _maxInterestRate = uint128(_maxInterestRate % 250e16);
        _newAnnualInterestRate = _newAnnualInterestRate % 250e16;
        _maxUpfrontFee = _maxUpfrontFee % 1001e18;
        _minInterestRateChangePeriod = _minInterestRateChangePeriod % (7 days + 1);
        
        borrowerOperations_setInterestIndividualDelegate(_troveId, _delegate, _minInterestRate, _maxInterestRate, _newAnnualInterestRate, _upperHint, _lowerHint, _maxUpfrontFee, _minInterestRateChangePeriod);
    }

    // Clamped handler for setRemoveManager
    function borrowerOperations_setRemoveManager_clamped(uint256 _troveId, address _manager) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_setRemoveManager(_troveId, _manager);
    }

    // Clamped handler for setRemoveManagerWithReceiver
    function borrowerOperations_setRemoveManagerWithReceiver_clamped(uint256 _troveId, address _manager, address _receiver) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        
        borrowerOperations_setRemoveManagerWithReceiver(_troveId, _manager, _receiver);
    }

    // Clamped handler for switchBatchManager
    function borrowerOperations_switchBatchManager_clamped(
        uint256 _troveId, 
        uint256 _removeUpperHint, 
        uint256 _removeLowerHint, 
        address _newBatchManager, 
        uint256 _addUpperHint, 
        uint256 _addLowerHint, 
        uint256 _maxUpfrontFee
    ) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        _newBatchManager = setNewClampedBatchManager(uint256(uint160(_newBatchManager)));
        _maxUpfrontFee = _maxUpfrontFee % 1001e18;
        
        borrowerOperations_switchBatchManager(_troveId, _removeUpperHint, _removeLowerHint, _newBatchManager, _addUpperHint, _addLowerHint, _maxUpfrontFee);
    }

    // Clamped handler for withdrawBold
    function borrowerOperations_withdrawBold_clamped(
        uint256 _troveId, 
        uint256 _boldAmount, 
        uint256 _maxUpfrontFee
    ) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        _boldAmount = _boldAmount % 100001e18;
        _maxUpfrontFee = _maxUpfrontFee % 1001e18;
        
        borrowerOperations_withdrawBold(_troveId, _boldAmount, _maxUpfrontFee);
    }

    // Clamped handler for withdrawColl
    function borrowerOperations_withdrawColl_clamped(uint256 _troveId, uint256 _collWithdrawal) public {
        if (troveIds.length == 0) return;
        _troveId = setNewClampedTroveId(_troveId);
        uint256 maxColl = troveManager.getTroveEntireColl(_troveId);
        _collWithdrawal = _collWithdrawal % (maxColl + 1);
        
        borrowerOperations_withdrawColl(_troveId, _collWithdrawal);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    /// === Inlined Test === ///
    function borrowerOperations_claimCollateral() public updateGhosts {
        uint256 currentSurplus = collSurplusPool.getCollateral(_getActor());

        uint256 balB4 = collToken.balanceOf(_getActor());

        vm.prank(_getActor());
        try borrowerOperations.claimCollateral() {

        } catch {
            eq(currentSurplus, 0, "An owner with collateral surplus can always claim");
        }

        uint256 balAfter = collToken.balanceOf(_getActor());

        eq(balAfter - balB4, currentSurplus, "An owner that claims collateral surplus always receives the exact amount they are owed");
    }

     function inlined_test_adding_to_a_batch() public {
        uint256 debtB4 = troveManager.getTroveEntireDebt(clampedTroveId);
        borrowerOperations_setInterestBatchManager(clampedTroveId, clampedBatchManager, 0, 0, type(uint256).max);

        uint256 debtAfter = troveManager.getTroveEntireDebt(clampedTroveId);

        gte(debtAfter, debtB4, "BT-03: Adding a trove to a Batch should never decrease the Trove debt");

        revert("Stateless"); // Reverting here means the function has no impact on ghost variables
    }

    function inlined_test_removing_from_a_batch() public {
        uint256 debtB4 = troveManager.getTroveEntireDebt(clampedTroveId);
        // Get current borrow rate so we don't trigger adjustment
        // Get current batch rate
        uint256 annualRate = troveManager.getTroveAnnualInterestRate(clampedTroveId);
        borrowerOperations_removeFromBatch(clampedTroveId, annualRate, 0, 0, type(uint256).max);

        uint256 debtAfter = troveManager.getTroveEntireDebt(clampedTroveId);

        gte(debtAfter, debtB4, "BT-04: Removing a trove from a Batch should never decrease the Trove debt");

        revert("Stateless"); // Reverting here means the function has no impact on ghost variables
    }

    /// NOTE: Inlined test to check that the trove can never set itself to insolvent
    function inlined_property_check_not_insolvent(uint256 troveId) internal {
        uint256 price = priceFeed.getPrice();
        uint256 mcr = borrowerOperations.MCR();

        // Get Current Coll
        uint256 currentColl = troveManager.getTroveEntireColl(troveId);
        // Get current debt
        uint256 currentDebt = troveManager.getTroveEntireDebt(troveId);

        uint256 cr = LiquityMath._computeCR(currentColl, currentDebt, price);
        gte(cr, mcr, "Can never self liquidate");
    }



    /// === Handlers === ///


    function borrowerOperations_addColl(uint256 _troveId, uint256 _collAmount) public updateGhosts asActor {
        borrowerOperations.addColl(_troveId, _collAmount);
        inlined_property_check_not_insolvent(_troveId);
    }

    function borrowerOperations_adjustTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) public updateGhosts asActor {
        borrowerOperations.adjustTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _maxUpfrontFee);
        inlined_property_check_not_insolvent(_troveId);
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
        inlined_property_check_not_insolvent(troveId);
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
        inlined_property_check_not_insolvent(_troveId);
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
        inlined_property_check_not_insolvent(_troveId);
    }

    // === Withdraw Coll === //
    function borrowerOperations_withdrawColl(uint256 _troveId, uint256 _collWithdrawal) public updateGhosts asActor {
        borrowerOperations.withdrawColl(_troveId, _collWithdrawal);
        inlined_property_check_not_insolvent(_troveId);
    }
}