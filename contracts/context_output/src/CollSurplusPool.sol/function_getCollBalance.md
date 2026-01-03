# Function: getCollBalance()

**Contract**: [src/CollSurplusPool.sol/contract_CollSurplusPool.md]

## Metadata

- **Contract**: CollSurplusPool
- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 1554:102:55

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
┌─ [0] ⚙️ FUNCTION: CollSurplusPool.getCollBalance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
