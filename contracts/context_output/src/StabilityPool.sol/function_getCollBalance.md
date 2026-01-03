# Function: getCollBalance()

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 10808:102:123

## Implementation

```solidity
function getCollBalance() override external view returns (uint256) {
    return collBalance;
}
```

## State Variable Reads

- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.getCollBalance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
