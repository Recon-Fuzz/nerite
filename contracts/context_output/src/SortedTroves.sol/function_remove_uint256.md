# Function: remove(uint256)

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `remove(uint256)`
- **Visibility**: external
- **Source Range**: 6185:347:273

## Implementation

```solidity
function remove(uint256 _id) override external {
    _requireCallerIsBOorTM();
    require(contains(_id), "SortedTroves: List does not contain the id");
    require(!isBatchedNode(_id), "SortedTroves: Must use removeFromBatch() to remove batched node");
    _removeSlice(_id, _id);
    delete nodes[_id];
    --size;
}
```

## Related Implementations

### _requireCallerIsBOorTM()

- **Kind**: internal
- **Source**: 21802:253:273
- **Link**: `src/SortedTroves.sol:SortedTroves:_requireCallerIsBOorTM()`

```solidity
function _requireCallerIsBOorTM() internal view {
    require((msg.sender == borrowerOperationsAddress) || (msg.sender == address(troveManager)), "SortedTroves: Caller is not BorrowerOperations nor TroveManager");
}
```

### contains(uint256)

- **Kind**: internal
- **Source**: 11484:108:273
- **Link**: `src/SortedTroves.sol:SortedTroves:contains(uint256)`

```solidity
function contains(uint256 _id) override public view returns (bool) {
    return nodes[_id].exists;
}
```

### isBatchedNode(uint256)

- **Kind**: internal
- **Source**: 11668:126:273
- **Link**: `src/SortedTroves.sol:SortedTroves:isBatchedNode(uint256)`

```solidity
function isBatchedNode(uint256 _id) override public view returns (bool) {
    return nodes[_id].batchId.isNotZero();
}
```

### isNotZero(BatchId)

- **Kind**: free-function
- **Source**: 447:77:277
- **Link**: `src/Types/BatchId.sol:isNotZero(BatchId)`

```solidity
function isNotZero(BatchId x) pure returns (bool) {
    return !x.isZero();
}
```

### isZero(BatchId)

- **Kind**: free-function
- **Source**: 364:81:277
- **Link**: `src/Types/BatchId.sol:isZero(BatchId)`

```solidity
function isZero(BatchId x) pure returns (bool) {
    return x == BATCH_ID_ZERO;
}
```

### _removeSlice(uint256,uint256)

- **Kind**: internal
- **Source**: 5854:228:273
- **Link**: `src/SortedTroves.sol:SortedTroves:_removeSlice(uint256,uint256)`

```solidity
function _removeSlice(uint256 _sliceHead, uint256 _sliceTail) internal {
    nodes[nodes[_sliceHead].prevId].nextId = nodes[_sliceTail].nextId;
    nodes[nodes[_sliceTail].nextId].prevId = nodes[_sliceHead].prevId;
}
```

## State Variable Reads

- **borrowerOperationsAddress** (`address`)
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)

## State Variable Writes

- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)
- **size** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.remove(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SortedTroves._requireCallerIsBOorTM() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SortedTroves.contains(uint256) (NodeID: 2)
  │   💬 Args: [_id]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SortedTroves.isBatchedNode(uint256) (NodeID: 3)
  │   💬 Args: [_id]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 4)
  │     💬 Args: [nodes[_id].batchId]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 5)
  │       💬 Args: [x]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SortedTroves._removeSlice(uint256,uint256) (NodeID: 6)
      💬 Args: [_id, _id]
      👁️  Def: internal
```
