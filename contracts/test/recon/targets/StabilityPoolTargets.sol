
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import "forge-std/console2.sol";

import {Properties} from "../Properties.sol";

abstract contract StabilityPoolTargets is BaseTargetFunctions, Properties  {

    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function stabilityPool_provideToSP_clamped(uint256 _topUp, bool _doClaim) public {
        // Clamp inputs
        _topUp = _topUp % (boldToken.balanceOf(_getActor()) + 1);
        
        // Approve
        vm.prank(_getActor());
        boldToken.approve(address(stabilityPool), _topUp);
        
        // Call unclamped handler
        stabilityPool_provideToSP(_topUp, _doClaim);
    }

    function stabilityPool_withdrawFromSP_clamped(uint256 _amount, bool _doClaim) public {
        // Clamp inputs
        _amount = _amount % (stabilityPool.getCompoundedBoldDeposit(_getActor()) + 1);
        
        // Call unclamped handler
        stabilityPool_withdrawFromSP(_amount, _doClaim);
    }

    function stabilityPool_offset_clamped(uint256 _debtToOffset, uint256 _collToAdd) public {
        // Clamp inputs
        _debtToOffset = _debtToOffset % (stabilityPool.getTotalBoldDeposits() + 1);
        _collToAdd = _collToAdd % (collToken.balanceOf(_getActor()) + 1);
        
        // Approve
        vm.prank(_getActor());
        collToken.approve(address(stabilityPool), _collToAdd);
        
        // Call unclamped handler
        stabilityPool_offset(_debtToOffset, _collToAdd);
    }

    function stabilityPool_triggerBoldRewards_clamped(uint256 _boldYield) public {
        // Clamp inputs
        _boldYield = _boldYield % (boldToken.balanceOf(_getActor()) + 1);
        
        // Approve
        vm.prank(_getActor());
        boldToken.approve(address(stabilityPool), _boldYield);
        
        // Call unclamped handler
        stabilityPool_triggerBoldRewards(_boldYield);
    }

    // Handler to do partial offset (not depleting the entire pool)
    // This helps cover the else branch in _computeCollRewardsPerUnitStaked (lines 454-461)
    function stabilityPool_offset_partial(uint256 _debtToOffset, uint256 _collToAdd) public {
        uint256 totalDeposits = stabilityPool.getTotalBoldDeposits();
        if (totalDeposits == 0) return;
        
        // Clamp debt to offset to be at most 50% of total deposits
        // This ensures we don't deplete the entire pool
        _debtToOffset = _debtToOffset % (totalDeposits / 2 + 1);
        _collToAdd = _collToAdd % (collToken.balanceOf(_getActor()) + 1);
        
        // Approve
        vm.prank(_getActor());
        collToken.approve(address(stabilityPool), _collToAdd);
        
        // Call unclamped handler
        stabilityPool_offset(_debtToOffset, _collToAdd);
    }

    // Handler to create scenario for claimAllCollGains
    // User withdraws entire deposit but should have stashed collateral
    function stabilityPool_withdrawAll_and_claimLater(bool _doClaim) public {
        uint256 deposit = stabilityPool.getCompoundedBoldDeposit(_getActor());
        if (deposit == 0) return;
        
        // Withdraw entire deposit WITHOUT claiming gains (_doClaim = false)
        // This should leave stashed collateral for the user
        stabilityPool_withdrawFromSP(deposit, false);
        
        // Now try to claim all collateral gains (should hit lines 360, 362-363)
        stabilityPool_claimAllCollGains();
    }

    // Enhanced handler to ensure stashed collateral exists before claimAllCollGains
    // This creates the exact scenario needed to cover lines 360, 362-363
    function stabilityPool_setup_stashed_coll_and_claim(uint256 _depositAmount, uint256 _debtToOffset, uint256 _collToAdd) public {
        // Step 1: User deposits to SP
        _depositAmount = _depositAmount % (boldToken.balanceOf(_getActor()) + 1);
        if (_depositAmount == 0) return;
        
        vm.prank(_getActor());
        boldToken.approve(address(stabilityPool), _depositAmount);
        stabilityPool_provideToSP(_depositAmount, false);
        
        // Step 2: Create an offset event so user gains collateral
        _debtToOffset = _debtToOffset % (stabilityPool.getTotalBoldDeposits() / 2 + 1); // Don't deplete pool
        _collToAdd = _collToAdd % (collToken.balanceOf(_getActor()) + 1);
        if (_collToAdd > 0 && _debtToOffset > 0) {
            vm.prank(_getActor());
            collToken.approve(address(stabilityPool), _collToAdd);
            stabilityPool_offset(_debtToOffset, _collToAdd);
        }
        
        // Step 3: Withdraw entire deposit WITHOUT claiming (_doClaim = false)
        // This creates stashed collateral
        uint256 deposit = stabilityPool.getCompoundedBoldDeposit(_getActor());
        if (deposit > 0) {
            stabilityPool_withdrawFromSP(deposit, false);
            
            // Step 4: Now claim all collateral gains
            // This should execute lines 360, 362-363 in claimAllCollGains
            uint256 stashedColl = stabilityPool.stashedColl(_getActor());
            if (stashedColl > 0) {
                stabilityPool_claimAllCollGains();
            }
        }
    }

    // Handler to do very large offset to trigger scale changes
    // This helps cover scale-related branches in _updateCollRewardSumAndProduct and _getCompoundedStakeFromSnapshots
    function stabilityPool_offset_large(uint256 _debtToOffset, uint256 _collToAdd) public {
        uint256 totalDeposits = stabilityPool.getTotalBoldDeposits();
        if (totalDeposits == 0) return;
        
        // Clamp debt to offset to be between 80-100% of total deposits
        // This increases likelihood of triggering scale changes
        uint256 minOffset = (totalDeposits * 80) / 100;
        _debtToOffset = minOffset + (_debtToOffset % (totalDeposits - minOffset + 1));
        _collToAdd = _collToAdd % (collToken.balanceOf(_getActor()) + 1);
        
        // Approve
        vm.prank(_getActor());
        collToken.approve(address(stabilityPool), _collToAdd);
        
        // Call unclamped handler
        stabilityPool_offset(_debtToOffset, _collToAdd);
    }

    // Handler to trigger multiple consecutive large offsets to force scale changes
    // Scale changes occur when P < SCALE_FACTOR (1e9)
    // This requires multiple large offsets in succession
    function stabilityPool_offset_massive_sequential(uint256 _debtToOffset1, uint256 _collToAdd1, uint256 _debtToOffset2, uint256 _collToAdd2) public {
        uint256 totalDeposits = stabilityPool.getTotalBoldDeposits();
        if (totalDeposits == 0) return;
        
        // First offset: 90-99% of total deposits
        uint256 minOffset1 = (totalDeposits * 90) / 100;
        _debtToOffset1 = minOffset1 + (_debtToOffset1 % (totalDeposits - minOffset1 + 1));
        _collToAdd1 = _collToAdd1 % (collToken.balanceOf(_getActor()) + 1);
        
        vm.prank(_getActor());
        collToken.approve(address(stabilityPool), _collToAdd1);
        stabilityPool_offset(_debtToOffset1, _collToAdd1);
        
        // Second offset: another large offset on remaining deposits
        totalDeposits = stabilityPool.getTotalBoldDeposits();
        if (totalDeposits > 0) {
            uint256 minOffset2 = (totalDeposits * 90) / 100;
            _debtToOffset2 = minOffset2 + (_debtToOffset2 % (totalDeposits - minOffset2 + 1));
            _collToAdd2 = _collToAdd2 % (collToken.balanceOf(_getActor()) + 1);
            
            vm.prank(_getActor());
            collToken.approve(address(stabilityPool), _collToAdd2);
            stabilityPool_offset(_debtToOffset2, _collToAdd2);
        }
    }

    // Handler specifically designed to trigger scaleDiff == 1 in _getCompoundedStakeFromSnapshots
    // This requires:
    // 1. User makes a deposit (creates snapshot with current scale)
    // 2. Large offset occurs that changes the scale
    // 3. User withdraws (computes compounded stake with scaleDiff == 1)
    function stabilityPool_deposit_offset_withdraw_sequence(uint256 _depositAmount, uint256 _debtToOffset, uint256 _collToAdd) public {
        // Step 1: User makes a deposit
        _depositAmount = _depositAmount % (boldToken.balanceOf(_getActor()) + 1);
        if (_depositAmount == 0) return;
        
        vm.prank(_getActor());
        boldToken.approve(address(stabilityPool), _depositAmount);
        stabilityPool_provideToSP(_depositAmount, false);
        
        // Step 2: Perform massive offset to trigger scale change
        uint256 totalDeposits = stabilityPool.getTotalBoldDeposits();
        if (totalDeposits > 0) {
            // Offset 95-99% of deposits to maximize chance of scale change
            uint256 minOffset = (totalDeposits * 95) / 100;
            _debtToOffset = minOffset + (_debtToOffset % (totalDeposits - minOffset + 1));
            _collToAdd = _collToAdd % (collToken.balanceOf(_getActor()) + 1);
            
            vm.prank(_getActor());
            collToken.approve(address(stabilityPool), _collToAdd);
            stabilityPool_offset(_debtToOffset, _collToAdd);
        }
        
        // Step 3: Withdraw (this triggers _getCompoundedStakeFromSnapshots with potentially different scale)
        uint256 compoundedDeposit = stabilityPool.getCompoundedBoldDeposit(_getActor());
        if (compoundedDeposit > 0) {
            stabilityPool_withdrawFromSP(compoundedDeposit, true);
        }
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function stabilityPool_claimAllCollGains() public updateGhosts asActor {
        stabilityPool.claimAllCollGains();
    }


    function stabilityPool_provideToSP(uint256 _topUp, bool _doClaim) public updateGhosts asActor {
        stabilityPool.provideToSP(_topUp, _doClaim);
    }

    function stabilityPool_withdrawFromSP(uint256 _amount, bool _doClaim) public updateGhosts asActor {
        stabilityPool.withdrawFromSP(_amount, _doClaim);
    }

    function stabilityPool_offset(uint256 _debtToOffset, uint256 _collToAdd) public updateGhosts asActor {
        stabilityPool.offset(_debtToOffset, _collToAdd);
    }

    function stabilityPool_triggerBoldRewards(uint256 _boldYield) public updateGhosts asActor {
        stabilityPool.triggerBoldRewards(_boldYield);
    }

}