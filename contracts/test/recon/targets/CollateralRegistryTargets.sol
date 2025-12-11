
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

    // Handler to test getTroveManager with various indices
    // Since we only have 1 collateral in setup, we clamp to valid range
    function collateralRegistry_getTroveManager_clamped(uint256 _index) public {
        // Get total number of collaterals from the registry
        uint256 totalCollaterals = collateralRegistry.totalCollaterals();
        if (totalCollaterals == 0) return;
        
        // Clamp index to valid range [0, totalCollaterals)
        _index = _index % totalCollaterals;
        
        // Call getTroveManager - this will cover different branches based on index
        collateralRegistry.getTroveManager(_index);
    }

    // Handler to test the redeemCollateral fallback path (lines 140-142)
    // This path is taken when totals.unbacked == 0, which happens when:
    // - All redeemable branches have unbackedPortion = 0 
    // - This occurs when SP size >= total system debt for all collaterals
    // In this rare case, the code uses getEntireSystemDebt() instead as fallback
    // 
    // Note: This is a very rare edge case that's difficult to trigger,
    // as it requires the SP to be "over-collateralized" relative to system debt
    // The fuzzer should eventually hit this state naturally through random operations

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
    
    function collateralRegistry_redeemCollateral(uint256 _boldAmount, uint256 _maxIterationsPerCollateral, uint256 _maxFeePercentage) public updateGhosts asActor {
        collateralRegistry.redeemCollateral(_boldAmount, _maxIterationsPerCollateral, _maxFeePercentage);
        hasDoneRedemption = true;
    }
}