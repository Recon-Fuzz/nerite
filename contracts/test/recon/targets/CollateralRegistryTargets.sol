
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import "forge-std/console2.sol";

import {Properties} from "../Properties.sol";

abstract contract CollateralRegistryTargets is BaseTargetFunctions, Properties  {
    
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function collateralRegistry_redeemCollateral_clamped(uint256 _boldAmount, uint256 _maxIterationsPerCollateral, uint256 _maxFeePercentage) public {
        // Clamp inputs
        _boldAmount = _boldAmount % (boldToken.balanceOf(_getActor()) + 1);
        _maxFeePercentage = _maxFeePercentage % 1e18;
        
        // Approve
        vm.prank(_getActor());
        boldToken.approve(address(collateralRegistry), _boldAmount);
        
        // Call unclamped handler
        collateralRegistry_redeemCollateral(_boldAmount, _maxIterationsPerCollateral, _maxFeePercentage);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
    
    function collateralRegistry_redeemCollateral(uint256 _boldAmount, uint256 _maxIterationsPerCollateral, uint256 _maxFeePercentage) public updateGhosts asActor {
        collateralRegistry.redeemCollateral(_boldAmount, _maxIterationsPerCollateral, _maxFeePercentage);
        hasDoneRedemption = true;
    }
}