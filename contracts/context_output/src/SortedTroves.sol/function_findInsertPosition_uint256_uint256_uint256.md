# Function: findInsertPosition(uint256,uint256,uint256)

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `findInsertPosition(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 18564:273:273

## Implementation

```solidity
function findInsertPosition(uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) override external view returns (uint256, uint256) {
    return _findInsertPosition(troveManager, _annualInterestRate, _prevId, _nextId);
}
```

## Related Implementations

### _findInsertPosition(contract ITroveManager,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 19166:2594:273
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
- **Source**: 16386:363:273
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
- **Source**: 15102:464:273
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
- **Source**: 14710:190:273
- **Link**: `src/SortedTroves.sol:SortedTroves:_skipToBatchTail(uint256)`

```solidity
function _skipToBatchTail(uint256 _id) internal view returns (uint256) {
    BatchId batchId = nodes[_id].batchId;
    return batchId.isNotZero() ? batches[batchId].tail : _id;
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

### contains(uint256)

- **Kind**: internal
- **Source**: 11484:108:273
- **Link**: `src/SortedTroves.sol:SortedTroves:contains(uint256)`

```solidity
function contains(uint256 _id) override public view returns (bool) {
    return nodes[_id].exists;
}
```

### _ascendList(contract ITroveManager,uint256,uint256)

- **Kind**: internal
- **Source**: 17097:361:273
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
- **Source**: 15572:464:273
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
- **Source**: 14906:190:273
- **Link**: `src/SortedTroves.sol:SortedTroves:_skipToBatchHead(uint256)`

```solidity
function _skipToBatchHead(uint256 _id) internal view returns (uint256) {
    BatchId batchId = nodes[_id].batchId;
    return batchId.isNotZero() ? batches[batchId].head : _id;
}
```

### _descendAndAscendList(contract ITroveManager,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 17464:808:273
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

## External Calls

- **ITroveManager::getTroveAnnualInterestRate(uint256)**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **BAD_HINT** (`uint256`)
- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)
- **batches** (`mapping(BatchId => struct SortedTroves.Batch)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.findInsertPosition(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SortedTroves._findInsertPosition(contract ITroveManager,uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [troveManager, _annualInterestRate, _prevId, _nextId]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTroves._descendList(contract ITroveManager,uint256,uint256) (NodeID: 2)
    │   💬 Args: [_troveManager, _annualInterestRate, ROOT_NODE_ID]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SortedTroves._descendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 3)
    │     💬 Args: [_troveManager, _annualInterestRate, pos]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 4)
    │       💬 Args: [_pos.nextId]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 5)
    │         💬 Args: [batchId]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 6)
    │           💬 Args: [x]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTroves.contains(uint256) (NodeID: 7)
    │   💬 Args: [_prevId]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: SortedTroves._ascendList(contract ITroveManager,uint256,uint256) (NodeID: 8)
    │   💬 Args: [_troveManager, _annualInterestRate, ROOT_NODE_ID]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SortedTroves._ascendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 9)
    │     💬 Args: [_troveManager, _annualInterestRate, pos]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SortedTroves._skipToBatchHead(uint256) (NodeID: 10)
    │       💬 Args: [_pos.prevId]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 11)
    │         💬 Args: [batchId]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 12)
    │           💬 Args: [x]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTroves.contains(uint256) (NodeID: 13)
    │   💬 Args: [_nextId]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: SortedTroves._descendList(contract ITroveManager,uint256,uint256) (NodeID: 14)
    │   💬 Args: [_troveManager, _annualInterestRate, ROOT_NODE_ID]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SortedTroves._descendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 15)
    │     💬 Args: [_troveManager, _annualInterestRate, pos]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 16)
    │       💬 Args: [_pos.nextId]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 17)
    │         💬 Args: [batchId]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 18)
    │           💬 Args: [x]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTroves._ascendList(contract ITroveManager,uint256,uint256) (NodeID: 19)
    │   💬 Args: [_troveManager, _annualInterestRate, _skipToBatchHead(_nextId)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SortedTroves._skipToBatchHead(uint256) (NodeID: 24)
    │ │   💬 Args: [_nextId]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 25)
    │ │     💬 Args: [batchId]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 26)
    │ │       💬 Args: [x]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SortedTroves._ascendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 20)
    │     💬 Args: [_troveManager, _annualInterestRate, pos]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SortedTroves._skipToBatchHead(uint256) (NodeID: 21)
    │       💬 Args: [_pos.prevId]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 22)
    │         💬 Args: [batchId]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 23)
    │           💬 Args: [x]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SortedTroves._descendList(contract ITroveManager,uint256,uint256) (NodeID: 27)
    │   💬 Args: [_troveManager, _annualInterestRate, _skipToBatchTail(_prevId)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 32)
    │ │   💬 Args: [_prevId]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 33)
    │ │     💬 Args: [batchId]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 34)
    │ │       💬 Args: [x]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SortedTroves._descendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 28)
    │     💬 Args: [_troveManager, _annualInterestRate, pos]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 29)
    │       💬 Args: [_pos.nextId]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 30)
    │         💬 Args: [batchId]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 31)
    │           💬 Args: [x]
    │           👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SortedTroves._descendAndAscendList(contract ITroveManager,uint256,uint256,uint256) (NodeID: 35)
        💬 Args: [_troveManager, _annualInterestRate, _skipToBatchTail(_prevId), _skipToBatchHead(_nextId)]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 44)
      │   💬 Args: [_prevId]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 45)
      │     💬 Args: [batchId]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 46)
      │       💬 Args: [x]
      │       👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SortedTroves._skipToBatchHead(uint256) (NodeID: 47)
      │   💬 Args: [_nextId]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 48)
      │     💬 Args: [batchId]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 49)
      │       💬 Args: [x]
      │       👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SortedTroves._descendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 36)
      │   💬 Args: [_troveManager, _annualInterestRate, descentPos]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: SortedTroves._skipToBatchTail(uint256) (NodeID: 37)
      │     💬 Args: [_pos.nextId]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 38)
      │       💬 Args: [batchId]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 39)
      │         💬 Args: [x]
      │         👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: SortedTroves._ascendOne(contract ITroveManager,uint256,struct SortedTroves.Position) (NodeID: 40)
          💬 Args: [_troveManager, _annualInterestRate, ascentPos]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: SortedTroves._skipToBatchHead(uint256) (NodeID: 41)
            💬 Args: [_pos.prevId]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: Unknown.isNotZero(BatchId) (NodeID: 42)
              💬 Args: [batchId]
              👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 43)
                💬 Args: [x]
                👁️  Def: internal
```
