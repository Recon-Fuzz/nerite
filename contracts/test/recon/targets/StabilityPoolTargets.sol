
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