
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import "forge-std/console2.sol";

import {Properties} from "../Properties.sol";

abstract contract TroveManagerTargets is BaseTargetFunctions, Properties  {

    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    /// === Clamped Handlers === ///

    function troveManager_liquidate_clamped(uint256 _troveId) public {
        _troveId = setNewClampedTroveId(_troveId);
        
        troveManager_liquidate(_troveId);
    }

    function troveManager_urgentRedemption_clamped(uint256 _boldAmount, uint256[] memory _troveIds, uint256 _minCollateral) public {
        _boldAmount = _boldAmount % (boldToken.balanceOf(_getActor()) + 1);
        
        vm.prank(_getActor());
        boldToken.approve(address(troveManager), _boldAmount);
        
        troveManager_urgentRedemption(_boldAmount, _troveIds, _minCollateral);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function troveManager_batchLiquidateTroves(uint256[] memory _troveArray) public updateGhosts asActor {
        troveManager.batchLiquidateTroves(_troveArray);
    }


    function troveManager_liquidate(uint256 _troveId) public updateGhosts asActor {
        troveManager.liquidate(_troveId);
        hasDoneLiquidation = true;
    }


    function troveManager_urgentRedemption(uint256 _boldAmount, uint256[] memory _troveIds, uint256 _minCollateral) public updateGhosts asActor {
        troveManager.urgentRedemption(_boldAmount, _troveIds, _minCollateral);
    }
    

    // function troveManager_callInternalRemoveTroveId(uint256 _troveId) public updateGhosts asActor {
    //     troveManager.callInternalRemoveTroveId(_troveId);
    // }

    // function troveManager_getUnbackedPortionPriceAndRedeemability() public updateGhosts asActor {
    //     troveManager.getUnbackedPortionPriceAndRedeemability();
    // }


    // function troveManager_onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange memory _troveChange) public updateGhosts asActor {
    //     troveManager.onAdjustTrove(_troveId, _newColl, _newDebt, _troveChange);
    // }

    // function troveManager_onAdjustTroveInsideBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) public updateGhosts asActor {
    //     troveManager.onAdjustTroveInsideBatch(_troveId, _newTroveColl, _newTroveDebt, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt);
    // }

    // function troveManager_onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange memory _troveChange) public updateGhosts asActor {
    //     troveManager.onAdjustTroveInterestRate(_troveId, _newColl, _newDebt, _newAnnualInterestRate, _troveChange);
    // }

    // function troveManager_onApplyTroveInterest(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, TroveChange memory _troveChange) public updateGhosts asActor {
    //     troveManager.onApplyTroveInterest(_troveId, _newTroveColl, _newTroveDebt, _batchAddress, _newBatchColl, _newBatchDebt, _troveChange);
    // }

    // function troveManager_onCloseTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) public updateGhosts asActor {
    //     troveManager.onCloseTrove(_troveId, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt);
    // }

    // function troveManager_onLowerBatchManagerAnnualFee(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualManagementFee) public updateGhosts asActor {
    //     troveManager.onLowerBatchManagerAnnualFee(_batchAddress, _newColl, _newDebt, _newAnnualManagementFee);
    // }

    // function troveManager_onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) public updateGhosts asActor {
    //     troveManager.onOpenTrove(_owner, _troveId, _troveChange, _annualInterestRate);
    // }

    // function troveManager_onOpenTroveAndJoinBatch(address _owner, uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _batchColl, uint256 _batchDebt) public updateGhosts asActor {
    //     troveManager.onOpenTroveAndJoinBatch(_owner, _troveId, _troveChange, _batchAddress, _batchColl, _batchDebt);
    // }

    // function troveManager_onRegisterBatchManager(address _account, uint256 _annualInterestRate, uint256 _annualManagementFee) public updateGhosts asActor {
    //     troveManager.onRegisterBatchManager(_account, _annualInterestRate, _annualManagementFee);
    // }

    // function troveManager_onRemoveFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, uint256 _newAnnualInterestRate) public updateGhosts asActor {
    //     troveManager.onRemoveFromBatch(_troveId, _newTroveColl, _newTroveDebt, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt, _newAnnualInterestRate);
    // }

    // function troveManager_onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) public updateGhosts asActor {
    //     troveManager.onSetBatchManagerAnnualInterestRate(_batchAddress, _newColl, _newDebt, _newAnnualInterestRate, _upfrontFee);
    // }

    // function troveManager_onSetInterestBatchManager(ITroveManager.OnSetInterestBatchManagerParams memory _params) public updateGhosts asActor {
    //     troveManager.onSetInterestBatchManager(_params);
    // }

    // function troveManager_redeemCollateral(address _redeemer, uint256 _boldamount, uint256 _price, uint256 _redemptionRate, uint256 _maxIterations) public updateGhosts asActor {
    //     troveManager.redeemCollateral(_redeemer, _boldamount, _price, _redemptionRate, _maxIterations);
    // }

    // function troveManager_setTroveStatusToActive(uint256 _troveId) public updateGhosts asActor {
    //     troveManager.setTroveStatusToActive(_troveId);
    // }

    // function troveManager_shutdown() public updateGhosts asActor {
    //     troveManager.shutdown();
    // }

    // ===== ADDITIONAL SHORTCUT HANDLERS FOR COVERAGE ===== //

    /// Shortcut to trigger urgent redemption after shutdown
    function shortcut_urgentRedemption_afterShutdown(
        uint256 _collAmount,
        uint256 _boldAmount,
        uint256 _priceCollapse
    ) public {
        // Step 1: Open a trove with the actor
        _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
        if (_collAmount == 0) _collAmount = collToken.balanceOf(_getActor());
        
        uint256 troveId = borrowerOperations.openTrove(
            _getActor(),
            0,
            _collAmount,
            _boldAmount % 1000e18 + MIN_DEBT,
            0,
            0,
            MAX_ANNUAL_INTEREST_RATE / 2,
            type(uint256).max,
            address(0),
            address(0),
            address(0)
        );
        
        // Step 2: Trigger shutdown by collapsing price
        uint256 collapsePrice = _priceCollapse % 1000e18 + 1e18; // Low price to trigger shutdown
        priceFeed.setPrice(collapsePrice);
        
        // Step 3: Call shutdown (this should succeed if TCR < SCR)
        try borrowerOperations.shutdown() {} catch {}
        
        // Step 4: Ensure actor has Bold to redeem
        uint256 redeemAmount = (_boldAmount % 100e18) + 1e18;
        uint256 actorBoldBalance = boldToken.balanceOf(_getActor());
        if (actorBoldBalance < redeemAmount) {
            vm.prank(address(borrowerOperations));
            boldToken.mint(_getActor(), redeemAmount - actorBoldBalance);
        }
        
        // Step 5: Approve Bold for redemption
        vm.prank(_getActor());
        boldToken.approve(address(troveManager), redeemAmount);
        
        // Step 6: Call urgent redemption
        uint256[] memory troveIds = new uint256[](1);
        troveIds[0] = troveId;
        
        troveManager_urgentRedemption(redeemAmount, troveIds, 0);
    }

    /// Shortcut to create liquidatable troves and batch liquidate them
    function shortcut_batchLiquidateTroves(
        uint256 _numTroves,
        uint256 _collPerTrove,
        uint256 _priceCollapse
    ) public {
        _numTroves = (_numTroves % 5) + 1; // 1-5 troves
        uint256[] memory troveIdsToLiquidate = new uint256[](_numTroves);
        
        // Step 1: Open multiple troves
        for (uint256 i = 0; i < _numTroves; i++) {
            uint256 collAmount = (_collPerTrove % 100e18) + 10e18;
            uint256 boldAmount = (collAmount * 50) / 100; // ~50% LTV initially
            
            try borrowerOperations.openTrove(
                _getActor(),
                i,
                collAmount,
                boldAmount,
                0,
                0,
                MAX_ANNUAL_INTEREST_RATE / 2,
                type(uint256).max,
                address(0),
                address(0),
                address(0)
            ) returns (uint256 troveId) {
                troveIdsToLiquidate[i] = troveId;
            } catch {
                // If opening fails, use existing trove
                if (troveIds.length > 0) {
                    troveIdsToLiquidate[i] = troveIds[i % troveIds.length];
                }
            }
        }
        
        // Step 2: Crash the collateral price to make troves liquidatable
        uint256 crashedPrice = (_priceCollapse % 500e18) + 100e18; // 100-600 USD per ETH
        priceFeed.setPrice(crashedPrice);
        
        // Step 3: Call batch liquidate
        troveManager_batchLiquidateTroves(troveIdsToLiquidate);
    }


}