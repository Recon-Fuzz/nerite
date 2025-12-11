# Function: onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 63587:2085:275

## Implementation

```solidity
function onCloseTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) override external {
    _requireCallerIsBorrowerOperations();
    _closeTrove(_troveId, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt, Status.closedByOwner);
    _movePendingTroveRewardsToActivePool(defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain);
    emit TroveUpdated({_troveId: _troveId, _debt: 0, _coll: 0, _stake: 0, _annualInterestRate: 0, _snapshotOfTotalCollRedist: 0, _snapshotOfTotalDebtRedist: 0});
    emit TroveOperation({_troveId: _troveId, _operation: Operation.closeTrove, _annualInterestRate: 0, _debtIncreaseFromRedist: _troveChange.appliedRedistBoldDebtGain, _debtIncreaseFromUpfrontFee: _troveChange.upfrontFee, _debtChangeFromOperation: int256(_troveChange.debtIncrease) - int256(_troveChange.debtDecrease), _collIncreaseFromRedist: _troveChange.appliedRedistCollGain, _collChangeFromOperation: int256(_troveChange.collIncrease) - int256(_troveChange.collDecrease)});
    if (_batchAddress != address(0)) {
        emit BatchUpdated({_interestBatchManager: _batchAddress, _operation: BatchOperation.exitBatch, _debt: batches[_batchAddress].debt, _coll: batches[_batchAddress].coll, _annualInterestRate: batches[_batchAddress].annualInterestRate, _annualManagementFee: batches[_batchAddress].annualManagementFee, _totalDebtShares: batches[_batchAddress].totalDebtShares, _debtIncreaseFromUpfrontFee: 0});
    }
}
```

## Related Implementations

### _requireCallerIsBorrowerOperations()

- **Kind**: internal
- **Source**: 53483:184:275
- **Link**: `src/TroveManager.sol:TroveManager:_requireCallerIsBorrowerOperations()`

```solidity
function _requireCallerIsBorrowerOperations() internal view {
    if (msg.sender != address(borrowerOperations)) {
        revert CallerNotBorrowerOperations();
    }
}
```

### _closeTrove(uint256,struct TroveChange,address,uint256,uint256,enum ITroveManager.Status)

- **Kind**: internal
- **Source**: 65678:1915:275
- **Link**: `src/TroveManager.sol:TroveManager:_closeTrove(uint256,struct TroveChange,address,uint256,uint256,enum ITroveManager.Status)`

```solidity
function _closeTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, Status closedStatus) internal {
    uint256 TroveIdsArrayLength = TroveIds.length;
    _requireMoreThanOneTroveInSystem(TroveIdsArrayLength);
    _removeTroveId(_troveId, TroveIdsArrayLength);
    Trove memory trove = Troves[_troveId];
    if (_batchAddress != address(0)) {
        if (trove.status == Status.active) {
            sortedTroves.removeFromBatch(_troveId);
        } else if ((trove.status == Status.zombie) && (lastZombieTroveId == _troveId)) {
            lastZombieTroveId = 0;
        }
        _removeTroveSharesFromBatch(_troveId, _troveChange.collDecrease, _troveChange.debtDecrease, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt);
    } else {
        if (trove.status == Status.active) {
            sortedTroves.remove(_troveId);
        } else if ((trove.status == Status.zombie) && (lastZombieTroveId == _troveId)) {
            lastZombieTroveId = 0;
        }
    }
    uint256 newTotalStakes = totalStakes - trove.stake;
    totalStakes = newTotalStakes;
    delete Troves[_troveId];
    Troves[_troveId].status = closedStatus;
    delete rewardSnapshots[_troveId];
    troveNFT.burn(_troveId);
}
```

### _requireMoreThanOneTroveInSystem(uint256)

- **Kind**: internal
- **Source**: 53863:181:275
- **Link**: `src/TroveManager.sol:TroveManager:_requireMoreThanOneTroveInSystem(uint256)`

```solidity
function _requireMoreThanOneTroveInSystem(uint256 TroveIdsArrayLength) internal pure {
    if (TroveIdsArrayLength == 1) {
        revert OnlyOneTroveLeft();
    }
}
```

### _removeTroveId(uint256,uint256)

- **Kind**: internal
- **Source**: 52112:382:275
- **Link**: `src/TroveManager.sol:TroveManager:_removeTroveId(uint256,uint256)`

```solidity
function _removeTroveId(uint256 _troveId, uint256 TroveIdsArrayLength) internal {
    uint64 index = Troves[_troveId].arrayIndex;
    uint256 idxLast = TroveIdsArrayLength - 1;
    uint256 idToMove = TroveIds[idxLast];
    TroveIds[index] = idToMove;
    Troves[idToMove].arrayIndex = index;
    TroveIds.pop();
}
```

### _removeTroveSharesFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)

- **Kind**: internal
- **Source**: 86624:1454:275
- **Link**: `src/TroveManager.sol:TroveManager:_removeTroveSharesFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)`

```solidity
function _removeTroveSharesFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) internal {
    Trove memory trove = Troves[_troveId];
    uint256 batchDebtDecrease = (_newTroveDebt - _troveChange.upfrontFee) - _troveChange.appliedRedistBoldDebtGain;
    uint256 batchCollDecrease = _newTroveColl - _troveChange.appliedRedistCollGain;
    batches[_batchAddress].totalDebtShares -= trove.batchDebtShares;
    batches[_batchAddress].debt = _newBatchDebt - batchDebtDecrease;
    batches[_batchAddress].coll = _newBatchColl - batchCollDecrease;
    batches[_batchAddress].lastDebtUpdateTime = uint64(block.timestamp);
    Troves[_troveId].interestBatchManager = address(0);
    Troves[_troveId].batchDebtShares = 0;
}
```

### _movePendingTroveRewardsToActivePool(contract IDefaultPool,uint256,uint256)

- **Kind**: internal
- **Source**: 21499:294:275
- **Link**: `src/TroveManager.sol:TroveManager:_movePendingTroveRewardsToActivePool(contract IDefaultPool,uint256,uint256)`

```solidity
function _movePendingTroveRewardsToActivePool(IDefaultPool _defaultPool, uint256 _bold, uint256 _coll) internal {
    if (_bold > 0) {
        _defaultPool.decreaseBoldDebt(_bold);
    }
    if (_coll > 0) {
        _defaultPool.sendCollToActivePool(_coll);
    }
}
```

## External Calls

- **ISortedTroves::removeFromBatch(uint256)**
- **ISortedTroves::remove(uint256)**
- **ITroveNFT::burn(uint256)**
- **IDefaultPool::decreaseBoldDebt(uint256)**
- **IDefaultPool::sendCollToActivePool(uint256)**

## State Variable Reads

- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **TroveIds** (`uint256[]`)
- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **lastZombieTroveId** (`uint256`)
- **totalStakes** (`uint256`)
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## State Variable Writes

- **lastZombieTroveId** (`uint256`)
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **totalStakes** (`uint256`)
- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)
- **TroveIds** (`uint256[]`)
- **batches** (`mapping(address => struct TroveManager.Batch)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.onCloseTrove(uint256,struct TroveChange,address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._closeTrove(uint256,struct TroveChange,address,uint256,uint256,enum ITroveManager.Status) (NodeID: 2)
  │   💬 Args: [_troveId, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt, Status.closedByOwner]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._requireMoreThanOneTroveInSystem(uint256) (NodeID: 3)
  │ │   💬 Args: [TroveIdsArrayLength]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._removeTroveId(uint256,uint256) (NodeID: 4)
  │ │   💬 Args: [_troveId, TroveIdsArrayLength]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveManager._removeTroveSharesFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256) (NodeID: 5)
  │     💬 Args: [_troveId, _troveChange.collDecrease, _troveChange.debtDecrease, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TroveManager._movePendingTroveRewardsToActivePool(contract IDefaultPool,uint256,uint256) (NodeID: 6)
      💬 Args: [defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain]
      👁️  Def: internal
```
