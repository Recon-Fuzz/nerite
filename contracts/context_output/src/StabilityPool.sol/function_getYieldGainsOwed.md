# Function: getYieldGainsOwed()

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `getYieldGainsOwed()`
- **Visibility**: external
- **Source Range**: 11036:108:274

## Implementation

```solidity
function getYieldGainsOwed() override external view returns (uint256) {
    return yieldGainsOwed;
}
```

## State Variable Reads

- **yieldGainsOwed** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.getYieldGainsOwed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
