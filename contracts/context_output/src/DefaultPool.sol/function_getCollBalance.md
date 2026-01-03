# Function: getCollBalance()

**Contract**: [src/DefaultPool.sol/contract_DefaultPool.md]

## Metadata

- **Contract**: DefaultPool
- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 2162:102:57

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
┌─ [0] ⚙️ FUNCTION: DefaultPool.getCollBalance() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
