
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import "forge-std/console2.sol";

import {Properties} from "../Properties.sol";
import {MIN_DEBT, MAX_ANNUAL_INTEREST_RATE} from "../../../src/Dependencies/Constants.sol";

abstract contract TroveManagerTargets is BaseTargetFunctions, Properties  {

    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    /// === Clamped Handlers === ///

    function troveManager_liquidate_clamped(uint256 _troveId) public {
        _troveId = setNewClampedTroveId(_troveId);
        
        troveManager_liquidate(_troveId);
    }

    function troveManager_urgentRedemption_clamped(uint256 _boldAmount, uint256[] memory _troveIds, uint256 _minCollateral) public {
        // Ensure _boldAmount > 0 by using modulo with actor's balance
        uint256 actorBalance = boldToken.balanceOf(_getActor());
        if (actorBalance == 0) return; // Skip if actor has no Bold
        
        _boldAmount = (_boldAmount % actorBalance) + 1; // CRITICAL: +1 ensures > 0
        
        // Clamp troveIds array to valid active troves
        if (_troveIds.length > 0 && troveIds.length > 0) {
            _troveIds[0] = setNewClampedTroveId(_troveIds[0]);
        }
        
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
        // Step 1: Open multiple troves to build up system debt
        uint256[] memory troveIdsForRedemption = new uint256[](3);
        
        for (uint256 i = 0; i < 3; i++) {
            _collAmount = _collAmount % (collToken.balanceOf(_getActor()) + 1);
            if (_collAmount == 0 || _collAmount < 10e18) _collAmount = 50e18;
            
            uint256 troveDebt = (_boldAmount % (MIN_DEBT * 10)) + MIN_DEBT;
            
            uint256 troveId = borrowerOperations.openTrove(
                _getActor(),
                i,
                _collAmount,
                troveDebt,
                0,
                0,
                MAX_ANNUAL_INTEREST_RATE / 2,
                type(uint256).max,
                address(0),
                address(0),
                address(0)
            );
            
            troveIdsForRedemption[i] = troveId;
        }
        
        // Step 2: Trigger shutdown by severely collapsing price
        // SCR is typically 130%, so we need TCR < 130%
        // If troves have 150% collateral ratio, drop price by ~20% to get TCR ~120%
        uint256 currentPrice = priceFeed.getPrice();
        uint256 collapsePrice = currentPrice * 70 / 100; // 30% price drop should trigger shutdown
        priceFeed.setPrice(collapsePrice);
        
        // Step 3: Call shutdown - should succeed now with TCR < SCR
        try borrowerOperations.shutdown() {
            // Shutdown succeeded
        } catch {
            // If shutdown failed, try even lower price
            priceFeed.setPrice(currentPrice * 50 / 100);
            try borrowerOperations.shutdown() {} catch {}
        }
        
        // Step 4: Verify shutdown happened by checking if we can call urgentRedemption
        // (urgentRedemption requires shutdownTime != 0)
        
        // Step 5: Ensure actor has Bold to redeem
        uint256 redeemAmount = (_boldAmount % (MIN_DEBT * 5)) + MIN_DEBT;
        uint256 actorBoldBalance = boldToken.balanceOf(_getActor());
        if (actorBoldBalance < redeemAmount) {
            vm.prank(address(borrowerOperations));
            boldToken.mint(_getActor(), redeemAmount - actorBoldBalance);
        }
        
        // Step 6: Approve Bold for redemption
        vm.prank(_getActor());
        boldToken.approve(address(troveManager), redeemAmount);
        
        // Step 7: Call urgent redemption with the troves we created
        troveManager_urgentRedemption(redeemAmount, troveIdsForRedemption, 0);
    }

    /// Shortcut to create liquidatable troves and batch liquidate them
    function shortcut_batchLiquidateTroves(
        uint256 _numTroves,
        uint256 _collPerTrove,
        uint256 _priceCollapse
    ) public {
        _numTroves = (_numTroves % 5) + 1; // 1-5 troves
        uint256[] memory troveIdsToLiquidate = new uint256[](_numTroves);
        
        // Step 1: Ensure stability pool has deposits to absorb liquidations
        // Switch to a different actor to provide stability pool deposits
        address liquidator = _getActor();
        address[] memory actors = _getActors();
        if (actors.length > 1) {
            _enableActor(actors[1]);
        }
        
        // Deposit to stability pool
        uint256 spDeposit = MIN_DEBT * 100;
        vm.prank(address(borrowerOperations));
        boldToken.mint(_getActor(), spDeposit);
        
        vm.prank(_getActor());
        boldToken.approve(address(stabilityPool), spDeposit);
        
        vm.prank(_getActor());
        stabilityPool.provideToSP(spDeposit, false);
        
        // Switch back to original actor
        _enableActor(liquidator);
        
        // Step 2: Open multiple troves with high debt-to-collateral ratio
        for (uint256 i = 0; i < _numTroves; i++) {
            uint256 collAmount = (_collPerTrove % 50e18) + 10e18;
            // Create troves with higher debt ratio to make them easier to liquidate
            uint256 boldAmount = (collAmount * 80) / 100; // ~80% LTV initially
            
            try borrowerOperations.openTrove(
                _getActor(),
                i + 100, // Use different ownerIndex to avoid conflicts
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
        
        // Step 3: Crash the collateral price significantly to make troves liquidatable
        // MCR is typically 110%, so crash price to make CR < 110%
        uint256 currentPrice = priceFeed.getPrice();
        uint256 crashedPrice = currentPrice * 60 / 100; // 40% crash should make 80% LTV troves liquidatable
        priceFeed.setPrice(crashedPrice);
        
        // Step 4: Call batch liquidate
        troveManager_batchLiquidateTroves(troveIdsToLiquidate);
    }
    
    /// Shortcut to create over-collateralized troves that generate surplus on liquidation
    function shortcut_batchLiquidateTroves_withSurplus(
        uint256 _numTroves,
        uint256 _collPerTrove
    ) public {
        _numTroves = (_numTroves % 3) + 1; // 1-3 troves
        uint256[] memory troveIdsToLiquidate = new uint256[](_numTroves);
        
        // Step 1: Ensure stability pool has deposits
        address liquidator = _getActor();
        address[] memory actors = _getActors();
        if (actors.length > 1) {
            _enableActor(actors[1]);
        }
        
        uint256 spDeposit = MIN_DEBT * 100;
        vm.prank(address(borrowerOperations));
        boldToken.mint(_getActor(), spDeposit);
        
        vm.prank(_getActor());
        boldToken.approve(address(stabilityPool), spDeposit);
        
        vm.prank(_getActor());
        stabilityPool.provideToSP(spDeposit, false);
        
        _enableActor(liquidator);
        
        // Step 2: Open troves with VERY HIGH collateralization (to ensure surplus after liquidation)
        for (uint256 i = 0; i < _numTroves; i++) {
            uint256 collAmount = (_collPerTrove % 100e18) + 50e18; // Large collateral
            // Low debt relative to collateral - only 30% LTV
            uint256 boldAmount = (collAmount * 30) / 100;
            
            try borrowerOperations.openTrove(
                _getActor(),
                i + 200, // Different ownerIndex
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
                if (troveIds.length > 0) {
                    troveIdsToLiquidate[i] = troveIds[i % troveIds.length];
                }
            }
        }
        
        // Step 3: Small price drop - just enough to make liquidatable but still have surplus
        // With 30% LTV and MCR of 110%, even after ~15% price drop they'll have surplus
        uint256 currentPrice = priceFeed.getPrice();
        uint256 crashedPrice = currentPrice * 85 / 100; // 15% crash
        priceFeed.setPrice(crashedPrice);
        
        // Step 4: Batch liquidate - should generate collateral surplus
        troveManager_batchLiquidateTroves(troveIdsToLiquidate);
    }


}