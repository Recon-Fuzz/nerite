
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import "forge-std/console2.sol";

import {Properties} from "../Properties.sol";

abstract contract StabilityPoolTargets is BaseTargetFunctions, Properties  {

    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Clamped handler for provideToSP
    function stabilityPool_provideToSP_clamped(uint256 _topUp, bool _doClaim) public {
        _topUp = _topUp % (boldToken.balanceOf(_getActor()) + 1);
        stabilityPool_provideToSP(_topUp, _doClaim);
    }

    // Clamped handler for withdrawFromSP
    function stabilityPool_withdrawFromSP_clamped(uint256 _amount, bool _doClaim) public {
        _amount = _amount % (stabilityPool.getCompoundedBoldDeposit(_getActor()) + 1);
        stabilityPool_withdrawFromSP(_amount, _doClaim);
    }

    // Clamped handler for offset
    function stabilityPool_offset_clamped(uint256 _debtToOffset, uint256 _collToAdd) public {
        _debtToOffset = _debtToOffset % (stabilityPool.getTotalBoldDeposits() + 1);
        _collToAdd = _collToAdd % (collToken.balanceOf(_getActor()) + 1);
        
        collToken.approve(address(stabilityPool), _collToAdd);
        stabilityPool_offset(_debtToOffset, _collToAdd);
    }

    // Clamped handler for triggerBoldRewards
    function stabilityPool_triggerBoldRewards_clamped(uint256 _boldYield) public {
        _boldYield = _boldYield % 10001e18;
        stabilityPool_triggerBoldRewards(_boldYield);
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