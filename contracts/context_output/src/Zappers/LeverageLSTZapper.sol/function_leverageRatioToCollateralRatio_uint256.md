# Function: leverageRatioToCollateralRatio(uint256)

**Contract**: [src/Zappers/LeverageLSTZapper.sol/contract_LeverageLSTZapper.md]

## Metadata

- **Contract**: LeverageLSTZapper
- **Signature**: `leverageRatioToCollateralRatio(uint256)`
- **Visibility**: external
- **Source Range**: 8478:184:140

## Implementation

```solidity
function leverageRatioToCollateralRatio(uint256 _inputRatio) external pure returns (uint256) {
    return (_inputRatio * DECIMAL_PRECISION) / (_inputRatio - DECIMAL_PRECISION);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LeverageLSTZapper.leverageRatioToCollateralRatio(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
