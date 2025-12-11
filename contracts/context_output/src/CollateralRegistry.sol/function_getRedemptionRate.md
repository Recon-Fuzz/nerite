# Function: getRedemptionRate()

**Contract**: [src/CollateralRegistry.sol/contract_CollateralRegistry.md]

## Metadata

- **Contract**: CollateralRegistry
- **Signature**: `getRedemptionRate()`
- **Visibility**: external
- **Source Range**: 10865:123:207

## Implementation

```solidity
function getRedemptionRate() override external view returns (uint256) {
    return _calcRedemptionRate(baseRate);
}
```

## Related Implementations

### _calcRedemptionRate(uint256)

- **Kind**: internal
- **Source**: 10355:235:207
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:_calcRedemptionRate(uint256)`

```solidity
function _calcRedemptionRate(uint256 _baseRate) internal pure returns (uint256) {
    return LiquityMath._min(REDEMPTION_FEE_FLOOR + _baseRate, DECIMAL_PRECISION);
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

## State Variable Reads

- **baseRate** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollateralRegistry.getRedemptionRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: CollateralRegistry._calcRedemptionRate(uint256) (NodeID: 1)
      💬 Args: [baseRate]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 2)
        💬 Args: [REDEMPTION_FEE_FLOOR + _baseRate, DECIMAL_PRECISION]
        👁️  Def: internal
```
