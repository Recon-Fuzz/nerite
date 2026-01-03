# Function: getCollBalance()

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 4395:102:51

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
┌─ [0] ⚙️ FUNCTION: ActivePool.getCollBalance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
