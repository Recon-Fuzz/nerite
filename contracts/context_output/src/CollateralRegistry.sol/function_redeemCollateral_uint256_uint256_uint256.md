# Function: redeemCollateral(uint256,uint256,uint256)

**Contract**: [src/CollateralRegistry.sol/contract_CollateralRegistry.md]

## Metadata

- **Contract**: CollateralRegistry
- **Signature**: `redeemCollateral(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4093:3847:207

## Implementation

```solidity
function redeemCollateral(uint256 _boldAmount, uint256 _maxIterationsPerCollateral, uint256 _maxFeePercentage) external {
    _requireValidMaxFeePercentage(_maxFeePercentage);
    _requireAmountGreaterThanZero(_boldAmount);
    RedemptionTotals memory totals;
    totals.numCollaterals = totalCollaterals;
    uint256[] memory unbackedPortions = new uint256[](totals.numCollaterals);
    uint256[] memory prices = new uint256[](totals.numCollaterals);
    totals.boldSupplyAtStart = boldToken.totalSupply();
    uint256 redemptionRate = _calcRedemptionRate(_getUpdatedBaseRateFromRedemption(_boldAmount, totals.boldSupplyAtStart));
    require(redemptionRate <= _maxFeePercentage, "CR: Fee exceeded provided maximum");
    for (uint256 index = 0; index < totals.numCollaterals; index++) {
        ITroveManager troveManager = getTroveManager(index);
        (uint256 unbackedPortion, uint256 price, bool redeemable) = troveManager.getUnbackedPortionPriceAndRedeemability();
        prices[index] = price;
        if (redeemable) {
            totals.unbacked += unbackedPortion;
            unbackedPortions[index] = unbackedPortion;
        }
    }
    if (totals.unbacked == 0) {
        unbackedPortions = new uint256[](totals.numCollaterals);
        for (uint256 index = 0; index < totals.numCollaterals; index++) {
            ITroveManager troveManager = getTroveManager(index);
            (, , bool redeemable) = troveManager.getUnbackedPortionPriceAndRedeemability();
            if (redeemable) {
                uint256 unbackedPortion = troveManager.getEntireSystemDebt();
                totals.unbacked += unbackedPortion;
                unbackedPortions[index] = unbackedPortion;
            }
        }
    }
    for (uint256 index = 0; index < totals.numCollaterals; index++) {
        if (unbackedPortions[index] > 0) {
            uint256 redeemAmount = (_boldAmount * unbackedPortions[index]) / totals.unbacked;
            if (redeemAmount > 0) {
                ITroveManager troveManager = getTroveManager(index);
                uint256 redeemedAmount = troveManager.redeemCollateral(msg.sender, redeemAmount, prices[index], redemptionRate, _maxIterationsPerCollateral);
                totals.redeemedAmount += redeemedAmount;
            }
        }
    }
    _updateBaseRateAndGetRedemptionRate(totals.redeemedAmount, totals.boldSupplyAtStart);
    if (totals.redeemedAmount > 0) {
        boldToken.burn(msg.sender, totals.redeemedAmount);
    }
}
```

## Related Implementations

### _requireValidMaxFeePercentage(uint256)

- **Kind**: internal
- **Source**: 13257:275:207
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_requireValidMaxFeePercentage(uint256)`

```solidity
function _requireValidMaxFeePercentage(uint256 _maxFeePercentage) internal pure {
    require((_maxFeePercentage >= REDEMPTION_FEE_FLOOR) && (_maxFeePercentage <= DECIMAL_PRECISION), "Max fee percentage must be between 0.5% and 100%");
}
```

### _requireAmountGreaterThanZero(uint256)

- **Kind**: internal
- **Source**: 13538:163:207
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_requireAmountGreaterThanZero(uint256)`

```solidity
function _requireAmountGreaterThanZero(uint256 _amount) internal pure {
    require(_amount > 0, "CollateralRegistry: Amount must be greater than zero");
}
```

### _calcRedemptionRate(uint256)

- **Kind**: internal
- **Source**: 10355:235:207
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_calcRedemptionRate(uint256)`

```solidity
function _calcRedemptionRate(uint256 _baseRate) internal pure returns (uint256) {
    return LiquityMath._min(REDEMPTION_FEE_FLOOR + _baseRate, DECIMAL_PRECISION);
}
```

### _getUpdatedBaseRateFromRedemption(uint256,uint256)

- **Kind**: internal
- **Source**: 9419:631:207
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_getUpdatedBaseRateFromRedemption(uint256,uint256)`

```solidity
function _getUpdatedBaseRateFromRedemption(uint256 _redeemAmount, uint256 _totalBoldSupply) internal view returns (uint256) {
    uint256 decayedBaseRate = _calcDecayedBaseRate();
    uint256 redeemedBoldFraction = (_redeemAmount * DECIMAL_PRECISION) / _totalBoldSupply;
    uint256 newBaseRate = decayedBaseRate + (redeemedBoldFraction / REDEMPTION_BETA);
    newBaseRate = LiquityMath._min(newBaseRate, DECIMAL_PRECISION);
    return newBaseRate;
}
```

### _calcDecayedBaseRate()

- **Kind**: internal
- **Source**: 10056:293:207
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_calcDecayedBaseRate()`

```solidity
function _calcDecayedBaseRate() internal view returns (uint256) {
    uint256 minutesPassed = _minutesPassedSinceLastFeeOp();
    uint256 decayFactor = LiquityMath._decPow(REDEMPTION_MINUTE_DECAY_FACTOR, minutesPassed);
    return (baseRate * decayFactor) / DECIMAL_PRECISION;
}
```

### _minutesPassedSinceLastFeeOp()

- **Kind**: internal
- **Source**: 8382:149:207
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_minutesPassedSinceLastFeeOp()`

```solidity
function _minutesPassedSinceLastFeeOp() internal view returns (uint256) {
    return (block.timestamp - lastFeeOperationTime) / ONE_MINUTE;
}
```

### _decPow(uint256,uint256)

- **Kind**: internal
- **Source**: 1800:686:215
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_decPow(uint256,uint256)`

```solidity
function _decPow(uint256 _base, uint256 _minutes) internal pure returns (uint256) {
    if (_minutes > 525600000) _minutes = 525600000;
    if (_minutes == 0) return DECIMAL_PRECISION;
    uint256 y = DECIMAL_PRECISION;
    uint256 x = _base;
    uint256 n = _minutes;
    while (n > 1) {
        if ((n % 2) == 0) {
            x = decMul(x, x);
            n = n / 2;
        } else {
            y = decMul(x, y);
            x = decMul(x, x);
            n = (n - 1) / 2;
        }
    }
    return decMul(x, y);
}
```

### decMul(uint256,uint256)

- **Kind**: internal
- **Source**: 752:192:215
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:decMul(uint256,uint256)`

```solidity
function decMul(uint256 x, uint256 y) internal pure returns (uint256 decProd) {
    uint256 prod_xy = x * y;
    decProd = (prod_xy + (DECIMAL_PRECISION / 2)) / DECIMAL_PRECISION;
}
```

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:215
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

### getTroveManager(uint256)

- **Kind**: internal
- **Source**: 12588:637:207
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:getTroveManager(uint256)`

```solidity
function getTroveManager(uint256 _index) public view returns (ITroveManager) {
    if (_index == 0) return troveManager0; else if (_index == 1) return troveManager1; else if (_index == 2) return troveManager2; else if (_index == 3) return troveManager3; else if (_index == 4) return troveManager4; else if (_index == 5) return troveManager5; else if (_index == 6) return troveManager6; else if (_index == 7) return troveManager7; else if (_index == 8) return troveManager8; else if (_index == 9) return troveManager9; else revert("Invalid index");
}
```

### _updateBaseRateAndGetRedemptionRate(uint256,uint256)

- **Kind**: internal
- **Source**: 8624:493:207
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_updateBaseRateAndGetRedemptionRate(uint256,uint256)`

```solidity
function _updateBaseRateAndGetRedemptionRate(uint256 _boldAmount, uint256 _totalBoldSupplyAtStart) internal {
    uint256 newBaseRate = _getUpdatedBaseRateFromRedemption(_boldAmount, _totalBoldSupplyAtStart);
    baseRate = newBaseRate;
    emit BaseRateUpdated(newBaseRate);
    _updateLastFeeOpTime();
}
```

### _updateLastFeeOpTime()

- **Kind**: internal
- **Source**: 8100:276:207
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_updateLastFeeOpTime()`

```solidity
function _updateLastFeeOpTime() internal {
    uint256 timePassed = block.timestamp - lastFeeOperationTime;
    if (timePassed >= ONE_MINUTE) {
        lastFeeOperationTime = block.timestamp;
        emit LastFeeOpTimeUpdated(block.timestamp);
    }
}
```

## External Calls

- **IBoldToken::totalSupply()**
- **ITroveManager::getUnbackedPortionPriceAndRedeemability()**
- **ITroveManager::getEntireSystemDebt()**
- **ITroveManager::redeemCollateral(address,uint256,uint256,uint256,uint256)**
- **IBoldToken::burn(address,uint256)**

## State Variable Reads

- **totalCollaterals** (`uint256`)
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **baseRate** (`uint256`)
- **lastFeeOperationTime** (`uint256`)
- **troveManager0** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager1** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager2** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager3** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager4** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager5** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager6** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager7** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager8** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager9** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

## State Variable Writes

- **baseRate** (`uint256`)
- **lastFeeOperationTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollateralRegistry.redeemCollateral(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: CollateralRegistry._requireValidMaxFeePercentage(uint256) (NodeID: 1)
  │   💬 Args: [_maxFeePercentage]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CollateralRegistry._requireAmountGreaterThanZero(uint256) (NodeID: 2)
  │   💬 Args: [_boldAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CollateralRegistry._calcRedemptionRate(uint256) (NodeID: 3)
  │   💬 Args: [_getUpdatedBaseRateFromRedemption(_boldAmount, totals.boldSupplyAtStart)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CollateralRegistry._getUpdatedBaseRateFromRedemption(uint256,uint256) (NodeID: 5)
  │ │   💬 Args: [_boldAmount, totals.boldSupplyAtStart]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: CollateralRegistry._calcDecayedBaseRate() (NodeID: 6)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: CollateralRegistry._minutesPassedSinceLastFeeOp() (NodeID: 7)
  │ │ │ │   💬 Args: [no args]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: LiquityMath._decPow(uint256,uint256) (NodeID: 8)
  │ │ │     💬 Args: [REDEMPTION_MINUTE_DECAY_FACTOR, minutesPassed]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 9)
  │ │ │   │   💬 Args: [x, x]
  │ │ │   │   👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 10)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 11)
  │ │ │   │   💬 Args: [x, x]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 12)
  │ │ │       💬 Args: [x, y]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 13)
  │ │     💬 Args: [newBaseRate, DECIMAL_PRECISION]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 4)
  │     💬 Args: [REDEMPTION_FEE_FLOOR + _baseRate, DECIMAL_PRECISION]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CollateralRegistry.getTroveManager(uint256) (NodeID: 14)
  │   💬 Args: [index]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: CollateralRegistry.getTroveManager(uint256) (NodeID: 15)
  │   💬 Args: [index]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: CollateralRegistry.getTroveManager(uint256) (NodeID: 16)
  │   💬 Args: [index]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: CollateralRegistry._updateBaseRateAndGetRedemptionRate(uint256,uint256) (NodeID: 17)
      💬 Args: [totals.redeemedAmount, totals.boldSupplyAtStart]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: CollateralRegistry._getUpdatedBaseRateFromRedemption(uint256,uint256) (NodeID: 18)
    │   💬 Args: [_boldAmount, _totalBoldSupplyAtStart]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: CollateralRegistry._calcDecayedBaseRate() (NodeID: 19)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: CollateralRegistry._minutesPassedSinceLastFeeOp() (NodeID: 20)
    │ │ │   💬 Args: [no args]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: LiquityMath._decPow(uint256,uint256) (NodeID: 21)
    │ │     💬 Args: [REDEMPTION_MINUTE_DECAY_FACTOR, minutesPassed]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 22)
    │ │   │   💬 Args: [x, x]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 23)
    │ │   │   💬 Args: [x, y]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 24)
    │ │   │   💬 Args: [x, x]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 25)
    │ │       💬 Args: [x, y]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 26)
    │     💬 Args: [newBaseRate, DECIMAL_PRECISION]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: CollateralRegistry._updateLastFeeOpTime() (NodeID: 27)
        💬 Args: [no args]
        👁️  Def: internal
```
