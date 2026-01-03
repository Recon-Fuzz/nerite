# Function: getBoldDebt()

**Contract**: [src/DefaultPool.sol/contract_DefaultPool.md]

## Metadata

- **Contract**: DefaultPool
- **Signature**: `getBoldDebt()`
- **Visibility**: external
- **Source Range**: 2270:96:57

## Implementation

```solidity
function getBoldDebt() override external view returns (uint256) {
    return BoldDebt;
}
```

## State Variable Reads

- **BoldDebt** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DefaultPool.getBoldDebt() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
