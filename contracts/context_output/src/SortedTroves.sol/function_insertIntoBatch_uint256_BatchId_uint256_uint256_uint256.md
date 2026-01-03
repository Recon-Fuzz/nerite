# Function: insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 8582:1162:122

## Implementation

```solidity
function insertIntoBatch(uint256 _troveId, BatchId _batchId, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) override external {
    _requireCallerIsBorrowerOperations();
    require(!contains(_troveId), "SortedTroves: List already contains the node");
    require(_troveId != ROOT_NODE_ID, "SortedTroves: _troveId cannot be the root node's ID");
    require(_batchId.isNotZero(), "SortedTroves: _batchId cannot be zero");
    uint256 batchTail = batches[_batchId].tail;
    if (batchTail == UNINITIALIZED_ID) {
        _insertSlice(troveManager, _troveId, _troveId, _annualInterestRate, _prevId, _nextId);
        batches[_batchId].head = _troveId;
    } else {
        _insertSliceIntoVerifiedPosition(_troveId, _troveId, batchTail, nodes[batchTail].nextId);
    }
    batches[_batchId].tail = _troveId;
    nodes[_troveId].batchId = _batchId;
    nodes[_troveId].exists = true;
    ++size;
}
```

## Related Implementations

### _requireCallerIsBorrowerOperations()

- **Kind**: internal
- **Source**: 22061:175:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_requireCallerIsBorrowerOperations()`

```solidity
function _requireCallerIsBorrowerOperations() internal view {
    require(msg.sender == borrowerOperationsAddress, "SortedTroves: Caller is not BorrowerOperations");
}
```

### contains(uint256)

- **Kind**: internal
- **Source**: 11484:108:122
- **Link**: `src/SortedTroves.sol:SortedTroves:contains(uint256)`

```solidity
function contains(uint256 _id) override public view returns (bool) {
    return nodes[_id].exists;
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

### _insertSlice(contract ITroveManager,uint256,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 4121:644:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_insertSlice(contract ITroveManager,uint256,uint256,uint256,uint256,uint256)`

```solidity
function _insertSlice(ITroveManager _troveManager, uint256 _sliceHead, uint256 _sliceTail, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) internal {
    if (!_validInsertPosition(_troveManager, _annualInterestRate, _prevId, _nextId)) {
        (_prevId, _nextId) = _findInsertPosition(_troveManager, _annualInterestRate, _prevId, _nextId);
    }
    _insertSliceIntoVerifiedPosition(_sliceHead, _sliceTail, _prevId, _nextId);
}
```

### _validInsertPosition(contract ITroveManager,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 13791:913:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_validInsertPosition(contract ITroveManager,uint256,uint256,uint256)`

```solidity
function _validInsertPosition(ITroveManager _troveManager, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) internal view returns (bool) {
    BatchId prevBatchId = nodes[_prevId].batchId;
    return (((((nodes[_prevId].nextId == _nextId) && (nodes[_nextId].prevId == _prevId)) && ((prevBatchId != nodes[_nextId].batchId) || prevBatchId.isZero())) && ((_prevId == ROOT_NODE_ID) || (_troveManager.getTroveAnnualInterestRate(_prevId) >= _annualInterestRate))) && ((_nextId == ROOT_NODE_ID) || (_annualInterestRate > _troveManager.getTroveAnnualInterestRate(_nextId))));
}
```

### _findInsertPosition(contract ITroveManager,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 19166:2594:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_findInsertPosition(contract ITroveManager,uint256,uint256,uint256)`

```solidity
function _findInsertPosition(ITroveManager _troveManager, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) internal view returns (uint256, uint256) {
    if (_prevId == ROOT_NODE_ID) {
        return _descendList(_troveManager, _annualInterestRate, ROOT_NODE_ID);
    } else {
        if ((!contains(_prevId)) || (_troveManager.getTroveAnnualInterestRate(_prevId) < _annualInterestRate)) {
            _prevId = BAD_HINT;
        }
    }
    if (_nextId == ROOT_NODE_ID) {
        return _ascendList(_troveManager, _annualInterestRate, ROOT_NODE_ID);
    } else {
        if ((!contains(_nextId)) || (_annualInterestRate <= _troveManager.getTroveAnnualInterestRate(_nextId))) {
            _nextId = BAD_HINT;
        }
    }
    if ((_prevId == BAD_HINT) && (_nextId == BAD_HINT)) {
        return _descendList(_troveManager, _annualInterestRate, ROOT_NODE_ID);
    } else if (_prevId == BAD_HINT) {
        return _ascendList(_troveManager, _annualInterestRate, _skipToBatchHead(_nextId));
    } else if (_nextId == BAD_HINT) {
        return _descendList(_troveManager, _annualInterestRate, _skipToBatchTail(_prevId));
    } else {
        return _descendAndAscendList(_troveManager, _annualInterestRate, _skipToBatchTail(_prevId), _skipToBatchHead(_nextId));
    }
}
```

### _descendList(contract ITroveManager,uint256,uint256)

- **Kind**: internal
- **Source**: 16386:363:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_descendList(contract ITroveManager,uint256,uint256)`

```solidity
function _descendList(ITroveManager _troveManager, uint256 _annualInterestRate, uint256 _startId) internal view returns (uint256, uint256) {
    Position memory pos = Position(_startId, nodes[_startId].nextId);
    while (!_descendOne(_troveManager, _annualInterestRate, pos)) {}
    return (pos.prevId, pos.nextId);
}
```

### _descendOne(contract ITroveManager,uint256,struct SortedTroves.Position)

- **Kind**: internal
- **Source**: 15102:464:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_descendOne(contract ITroveManager,uint256,struct SortedTroves.Position)`

```solidity
function _descendOne(ITroveManager _troveManager, uint256 _annualInterestRate, Position memory _pos) internal view returns (bool found) {
    if ((_pos.nextId == ROOT_NODE_ID) || (_annualInterestRate > _troveManager.getTroveAnnualInterestRate(_pos.nextId))) {
        found = true;
    } else {
        _pos.prevId = _skipToBatchTail(_pos.nextId);
        _pos.nextId = nodes[_pos.prevId].nextId;
    }
}
```

### _skipToBatchTail(uint256)

- **Kind**: internal
- **Source**: 14710:190:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_skipToBatchTail(uint256)`

```solidity
function _skipToBatchTail(uint256 _id) internal view returns (uint256) {
    BatchId batchId = nodes[_id].batchId;
    return batchId.isNotZero() ? batches[batchId].tail : _id;
}
```

### _ascendList(contract ITroveManager,uint256,uint256)

- **Kind**: internal
- **Source**: 17097:361:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_ascendList(contract ITroveManager,uint256,uint256)`

```solidity
function _ascendList(ITroveManager _troveManager, uint256 _annualInterestRate, uint256 _startId) internal view returns (uint256, uint256) {
    Position memory pos = Position(nodes[_startId].prevId, _startId);
    while (!_ascendOne(_troveManager, _annualInterestRate, pos)) {}
    return (pos.prevId, pos.nextId);
}
```

### _ascendOne(contract ITroveManager,uint256,struct SortedTroves.Position)

- **Kind**: internal
- **Source**: 15572:464:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_ascendOne(contract ITroveManager,uint256,struct SortedTroves.Position)`

```solidity
function _ascendOne(ITroveManager _troveManager, uint256 _annualInterestRate, Position memory _pos) internal view returns (bool found) {
    if ((_pos.prevId == ROOT_NODE_ID) || (_troveManager.getTroveAnnualInterestRate(_pos.prevId) >= _annualInterestRate)) {
        found = true;
    } else {
        _pos.nextId = _skipToBatchHead(_pos.prevId);
        _pos.prevId = nodes[_pos.nextId].prevId;
    }
}
```

### _skipToBatchHead(uint256)

- **Kind**: internal
- **Source**: 14906:190:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_skipToBatchHead(uint256)`

```solidity
function _skipToBatchHead(uint256 _id) internal view returns (uint256) {
    BatchId batchId = nodes[_id].batchId;
    return batchId.isNotZero() ? batches[batchId].head : _id;
}
```

### _descendAndAscendList(contract ITroveManager,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 17464:808:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_descendAndAscendList(contract ITroveManager,uint256,uint256,uint256)`

```solidity
function _descendAndAscendList(ITroveManager _troveManager, uint256 _annualInterestRate, uint256 _descentStartId, uint256 _ascentStartId) internal view returns (uint256 prevId, uint256 nextId) {
    Position memory descentPos = Position(_descentStartId, nodes[_descentStartId].nextId);
    Position memory ascentPos = Position(nodes[_ascentStartId].prevId, _ascentStartId);
    for (; ; ) {
        if (_descendOne(_troveManager, _annualInterestRate, descentPos)) {
            return (descentPos.prevId, descentPos.nextId);
        }
        if (_ascendOne(_troveManager, _annualInterestRate, ascentPos)) {
            return (ascentPos.prevId, ascentPos.nextId);
        }
    }
    assert(false);
}
```

### _insertSliceIntoVerifiedPosition(uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 3795:320:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_insertSliceIntoVerifiedPosition(uint256,uint256,uint256,uint256)`

```solidity
function _insertSliceIntoVerifiedPosition(uint256 _sliceHead, uint256 _sliceTail, uint256 _prevId, uint256 _nextId) internal {
    nodes[_prevId].nextId = _sliceHead;
    nodes[_sliceHead].prevId = _prevId;
    nodes[_sliceTail].nextId = _nextId;
    nodes[_nextId].prevId = _sliceTail;
}
```

## External Calls

- **ITroveManager::getTroveAnnualInterestRate(uint256)**

## State Variable Reads

- **batches** (`mapping(BatchId => struct SortedTroves.Batch)`)
- **UNINITIALIZED_ID** (`uint256`)
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)
- **borrowerOperationsAddress** (`address`)
- **BAD_HINT** (`uint256`)

## State Variable Writes

- **batches** (`mapping(BatchId => struct SortedTroves.Batch)`)
- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)
- **size** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.insertIntoBatch(uint256,BatchId,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SortedTroves._requireCallerIsBorrowerOperations() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SortedTroves.contains(uint256) (NodeID: 2)
  │   💬 Args: [_troveId]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 3)
  │   💬 Args: [_batchId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 4)
  │     💬 Args: [x]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SortedTroves._insertSlice(contract ITroveManager,uint256,uint256,uint256,uint256,uint256) (NodeID: 5)
  │   💬 Args: [troveManager, _troveId, _troveId, _annualInterestRate, _prevId, _nextId]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SortedTroves._validInsertPosition(contract ITroveManager,uint256,uint256,uint256) (NodeID: 6)
  │ │   💬 Args: [_troveManager, _annualInterestRate, _prevId, _nextId]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 7)
  │ │     💬 Args: [prevBatchId]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SortedTroves._findInsertPosition(contract ITroveManager,uint256,uint256,uint256) (NodeID: 8)
  │ │   💬 Args: [_troveManager, _annualInterestRate, _prevId, _nextId]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SortedTroves._descendList(contract ITroveManager,uint256,uint256) (NodeID: 9)
  │ │ │   💬 Args: [_troveManager, _annualInterestRate, ROOT_NODE_ID]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SortedTroves._descendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 10)
  │ │ │     💬 Args: [_troveManager, _annualInterestRate, pos]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 11)
  │ │ │       💬 Args: [_pos.nextId]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 12)
  │ │ │         💬 Args: [batchId]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 13)
  │ │ │           💬 Args: [x]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SortedTroves.contains(uint256) (NodeID: 14)
  │ │ │   💬 Args: [_prevId]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: SortedTroves._ascendList(contract ITroveManager,uint256,uint256) (NodeID: 15)
  │ │ │   💬 Args: [_troveManager, _annualInterestRate, ROOT_NODE_ID]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SortedTroves._ascendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 16)
  │ │ │     💬 Args: [_troveManager, _annualInterestRate, pos]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SortedTroves._skipToBatchHead(uint256) (NodeID: 17)
  │ │ │       💬 Args: [_pos.prevId]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 18)
  │ │ │         💬 Args: [batchId]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 19)
  │ │ │           💬 Args: [x]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SortedTroves.contains(uint256) (NodeID: 20)
  │ │ │   💬 Args: [_nextId]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: SortedTroves._descendList(contract ITroveManager,uint256,uint256) (NodeID: 21)
  │ │ │   💬 Args: [_troveManager, _annualInterestRate, ROOT_NODE_ID]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SortedTroves._descendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 22)
  │ │ │     💬 Args: [_troveManager, _annualInterestRate, pos]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 23)
  │ │ │       💬 Args: [_pos.nextId]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 24)
  │ │ │         💬 Args: [batchId]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 25)
  │ │ │           💬 Args: [x]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SortedTroves._ascendList(contract ITroveManager,uint256,uint256) (NodeID: 26)
  │ │ │   💬 Args: [_troveManager, _annualInterestRate, _skipToBatchHead(_nextId)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SortedTroves._skipToBatchHead(uint256) (NodeID: 31)
  │ │ │ │   💬 Args: [_nextId]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 32)
  │ │ │ │     💬 Args: [batchId]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 33)
  │ │ │ │       💬 Args: [x]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SortedTroves._ascendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 27)
  │ │ │     💬 Args: [_troveManager, _annualInterestRate, pos]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SortedTroves._skipToBatchHead(uint256) (NodeID: 28)
  │ │ │       💬 Args: [_pos.prevId]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 29)
  │ │ │         💬 Args: [batchId]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 30)
  │ │ │           💬 Args: [x]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SortedTroves._descendList(contract ITroveManager,uint256,uint256) (NodeID: 34)
  │ │ │   💬 Args: [_troveManager, _annualInterestRate, _skipToBatchTail(_prevId)]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 39)
  │ │ │ │   💬 Args: [_prevId]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 40)
  │ │ │ │     💬 Args: [batchId]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 41)
  │ │ │ │       💬 Args: [x]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SortedTroves._descendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 35)
  │ │ │     💬 Args: [_troveManager, _annualInterestRate, pos]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 36)
  │ │ │       💬 Args: [_pos.nextId]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 37)
  │ │ │         💬 Args: [batchId]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 38)
  │ │ │           💬 Args: [x]
  │ │ │           👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SortedTroves._descendAndAscendList(contract ITroveManager,uint256,uint256,uint256) (NodeID: 42)
  │ │     💬 Args: [_troveManager, _annualInterestRate, _skipToBatchTail(_prevId), _skipToBatchHead(_nextId)]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 51)
  │ │   │   💬 Args: [_prevId]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 52)
  │ │   │     💬 Args: [batchId]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 53)
  │ │   │       💬 Args: [x]
  │ │   │       👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SortedTroves._skipToBatchHead(uint256) (NodeID: 54)
  │ │   │   💬 Args: [_nextId]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 55)
  │ │   │     💬 Args: [batchId]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 56)
  │ │   │       💬 Args: [x]
  │ │   │       👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SortedTroves._descendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 43)
  │ │   │   💬 Args: [_troveManager, _annualInterestRate, descentPos]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 44)
  │ │   │     💬 Args: [_pos.nextId]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 45)
  │ │   │       💬 Args: [batchId]
  │ │   │       👁️  Def: internal
  │ │   │     └─ [7] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 46)
  │ │   │         💬 Args: [x]
  │ │   │         👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: SortedTroves._ascendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 47)
  │ │       💬 Args: [_troveManager, _annualInterestRate, ascentPos]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SortedTroves._skipToBatchHead(uint256) (NodeID: 48)
  │ │         💬 Args: [_pos.prevId]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 49)
  │ │           💬 Args: [batchId]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 50)
  │ │             💬 Args: [x]
  │ │             👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SortedTroves._insertSliceIntoVerifiedPosition(uint256,uint256,uint256,uint256) (NodeID: 57)
  │     💬 Args: [_sliceHead, _sliceTail, _prevId, _nextId]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SortedTroves._insertSliceIntoVerifiedPosition(uint256,uint256,uint256,uint256) (NodeID: 58)
      💬 Args: [_troveId, _troveId, batchTail, nodes[batchTail].nextId]
      👁️  Def: internal
```
