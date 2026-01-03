# Function: getYieldGainsPending()

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `getYieldGainsPending()`
- **Visibility**: external
- **Source Range**: 11150:114:123

## Implementation

```solidity
function getYieldGainsPending() override external view returns (uint256) {
    return yieldGainsPending;
}
```

## State Variable Reads

- **yieldGainsPending** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.getYieldGainsPending() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
