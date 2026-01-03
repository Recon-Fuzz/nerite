# Function: isBatchedNode(uint256)

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `isBatchedNode(uint256)`
- **Visibility**: public
- **Source Range**: 11668:126:122

## Implementation

```solidity
function isBatchedNode(uint256 _id) override public view returns (bool) {
    return nodes[_id].batchId.isNotZero();
}
```

## Related Implementations

### isNotZero(BatchId)

- **Kind**: free-function
- **Source**: 447:77:126
- **Link**: `src/Types/BatchId.sol:isNotZero(BatchId)`

```solidity
function isNotZero(BatchId x) pure returns (bool) {
    return !x.isZero();
}
```

### isZero(BatchId)

- **Kind**: free-function
- **Source**: 364:81:126
- **Link**: `src/Types/BatchId.sol:isZero(BatchId)`

```solidity
function isZero(BatchId x) pure returns (bool) {
    return x == BATCH_ID_ZERO;
}
```

## State Variable Reads

- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.isBatchedNode(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 1)
      💬 Args: [nodes[_id].batchId]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 2)
        💬 Args: [x]
        👁️  Def: internal
```
