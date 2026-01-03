# Function: removeFromBatch(uint256)

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `removeFromBatch(uint256)`
- **Visibility**: external
- **Source Range**: 9843:768:122

## Implementation

```solidity
function removeFromBatch(uint256 _id) override external {
    _requireCallerIsBOorTM();
    BatchId batchId = nodes[_id].batchId;
    require(batchId.isNotZero(), "SortedTroves: Must use remove() to remove non-batched node");
    Batch memory batch = batches[batchId];
    if ((batch.head == _id) && (batch.tail == _id)) {
        delete batches[batchId];
    } else if (batch.head == _id) {
        batches[batchId].head = nodes[_id].nextId;
    } else if (batch.tail == _id) {
        batches[batchId].tail = nodes[_id].prevId;
    }
    _removeSlice(_id, _id);
    delete nodes[_id];
    --size;
}
```

## Related Implementations

### _requireCallerIsBOorTM()

- **Kind**: internal
- **Source**: 21802:253:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_requireCallerIsBOorTM()`

```solidity
function _requireCallerIsBOorTM() internal view {
    require((msg.sender == borrowerOperationsAddress) || (msg.sender == address(troveManager)), "SortedTroves: Caller is not BorrowerOperations nor TroveManager");
}
```

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

### _removeSlice(uint256,uint256)

- **Kind**: internal
- **Source**: 5854:228:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_removeSlice(uint256,uint256)`

```solidity
function _removeSlice(uint256 _sliceHead, uint256 _sliceTail) internal {
    nodes[nodes[_sliceHead].prevId].nextId = nodes[_sliceTail].nextId;
    nodes[nodes[_sliceTail].nextId].prevId = nodes[_sliceHead].prevId;
}
```

## State Variable Reads

- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)
- **batches** (`mapping(BatchId => struct SortedTroves.Batch)`)
- **borrowerOperationsAddress** (`address`)
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

## State Variable Writes

- **batches** (`mapping(BatchId => struct SortedTroves.Batch)`)
- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)
- **size** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.removeFromBatch(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SortedTroves._requireCallerIsBOorTM() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 2)
  │   💬 Args: [batchId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 3)
  │     💬 Args: [x]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SortedTroves._removeSlice(uint256,uint256) (NodeID: 4)
      💬 Args: [_id, _id]
      👁️  Def: internal
```
