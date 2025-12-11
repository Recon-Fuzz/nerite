# Function: isEmptyBatch(BatchId)

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `isEmptyBatch(BatchId)`
- **Visibility**: external
- **Source Range**: 11800:134:273

## Implementation

```solidity
function isEmptyBatch(BatchId _id) override external view returns (bool) {
    return batches[_id].head == UNINITIALIZED_ID;
}
```

## State Variable Reads

- **batches** (`mapping(BatchId => struct SortedTroves.Batch)`)
- **UNINITIALIZED_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.isEmptyBatch(BatchId) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
