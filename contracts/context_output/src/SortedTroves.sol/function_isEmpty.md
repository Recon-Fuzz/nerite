# Function: isEmpty()

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `isEmpty()`
- **Visibility**: external
- **Source Range**: 11995:90:273

## Implementation

```solidity
function isEmpty() override external view returns (bool) {
    return size == 0;
}
```

## State Variable Reads

- **size** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.isEmpty() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
