# Function: getSize()

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `getSize()`
- **Visibility**: external
- **Source Range**: 12155:88:122

## Implementation

```solidity
function getSize() override external view returns (uint256) {
    return size;
}
```

## State Variable Reads

- **size** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.getSize() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
