# Function: getRedemptionRateWithDecay()

**Contract**: [src/CollateralRegistry.sol/contract_CollateralRegistry.md]

## Metadata

- **Contract**: CollateralRegistry
- **Signature**: `getRedemptionRateWithDecay()`
- **Visibility**: public
- **Source Range**: 10994:144:56

## Implementation

```solidity
function getRedemptionRateWithDecay() override public view returns (uint256) {
    return _calcRedemptionRate(_calcDecayedBaseRate());
}
```

## Related Implementations

### _calcRedemptionRate(uint256)

- **Kind**: internal
- **Source**: 10355:235:56
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_calcRedemptionRate(uint256)`

```solidity
function _calcRedemptionRate(uint256 _baseRate) internal pure returns (uint256) {
    return LiquityMath._min(REDEMPTION_FEE_FLOOR + _baseRate, DECIMAL_PRECISION);
}
```

### _calcDecayedBaseRate()

- **Kind**: internal
- **Source**: 10056:293:56
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
- **Source**: 8382:149:56
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_minutesPassedSinceLastFeeOp()`

```solidity
function _minutesPassedSinceLastFeeOp() internal view returns (uint256) {
    return (block.timestamp - lastFeeOperationTime) / ONE_MINUTE;
}
```

### _decPow(uint256,uint256)

- **Kind**: internal
- **Source**: 1800:686:64
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
- **Source**: 752:192:64
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:decMul(uint256,uint256)`

```solidity
function decMul(uint256 x, uint256 y) internal pure returns (uint256 decProd) {
    uint256 prod_xy = x * y;
    decProd = (prod_xy + (DECIMAL_PRECISION / 2)) / DECIMAL_PRECISION;
}
```

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:64
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

## State Variable Reads

- **baseRate** (`uint256`)
- **lastFeeOperationTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollateralRegistry.getRedemptionRateWithDecay() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: CollateralRegistry._calcRedemptionRate(uint256) (NodeID: 1)
      💬 Args: [_calcDecayedBaseRate()]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: CollateralRegistry._calcDecayedBaseRate() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: CollateralRegistry._minutesPassedSinceLastFeeOp() (NodeID: 4)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: LiquityMath._decPow(uint256,uint256) (NodeID: 5)
    │     💬 Args: [REDEMPTION_MINUTE_DECAY_FACTOR, minutesPassed]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 6)
    │   │   💬 Args: [x, x]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 7)
    │   │   💬 Args: [x, y]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 8)
    │   │   💬 Args: [x, x]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: LiquityMath.decMul(uint256,uint256) (NodeID: 9)
    │       💬 Args: [x, y]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 2)
        💬 Args: [REDEMPTION_FEE_FLOOR + _baseRate, DECIMAL_PRECISION]
        👁️  Def: internal
```
