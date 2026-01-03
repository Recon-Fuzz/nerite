# Function: onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 83848:2770:124

## Implementation

```solidity
function onRemoveFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, uint256 _newAnnualInterestRate) external {
    _requireCallerIsBorrowerOperations();
    _removeTroveSharesFromBatch(_troveId, _newTroveColl, _newTroveDebt, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt);
    Troves[_troveId].debt = _newTroveDebt;
    Troves[_troveId].coll = _newTroveColl;
    Troves[_troveId].lastDebtUpdateTime = uint64(block.timestamp);
    Troves[_troveId].annualInterestRate = _newAnnualInterestRate;
    Troves[_troveId].lastInterestRateAdjTime = uint64(block.timestamp);
    _updateTroveRewardSnapshots(_troveId);
    _movePendingTroveRewardsToActivePool(defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain);
    emit TroveUpdated({_troveId: _troveId, _debt: _newTroveDebt, _coll: _newTroveColl, _stake: Troves[_troveId].stake, _annualInterestRate: _newAnnualInterestRate, _snapshotOfTotalCollRedist: L_coll, _snapshotOfTotalDebtRedist: L_boldDebt});
    emit TroveOperation({_troveId: _troveId, _operation: Operation.removeFromBatch, _annualInterestRate: _newAnnualInterestRate, _debtIncreaseFromRedist: _troveChange.appliedRedistBoldDebtGain, _debtIncreaseFromUpfrontFee: _troveChange.upfrontFee, _debtChangeFromOperation: 0, _collIncreaseFromRedist: _troveChange.appliedRedistCollGain, _collChangeFromOperation: 0});
    emit BatchUpdated({_interestBatchManager: _batchAddress, _operation: BatchOperation.exitBatch, _debt: batches[_batchAddress].debt, _coll: batches[_batchAddress].coll, _annualInterestRate: batches[_batchAddress].annualInterestRate, _annualManagementFee: batches[_batchAddress].annualManagementFee, _totalDebtShares: batches[_batchAddress].totalDebtShares, _debtIncreaseFromUpfrontFee: 0});
}
```

## Related Implementations

### _requireCallerIsBorrowerOperations()

- **Kind**: internal
- **Source**: 53483:184:124
- **Link**: `src/TroveManager.sol:TroveManager:_requireCallerIsBorrowerOperations()`

```solidity
function _requireCallerIsBorrowerOperations() internal view {
    if (msg.sender != address(borrowerOperations)) {
        revert CallerNotBorrowerOperations();
    }
}
```

### _removeTroveSharesFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)

- **Kind**: internal
- **Source**: 86624:1454:124
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

### _updateTroveRewardSnapshots(uint256)

- **Kind**: internal
- **Source**: 42225:177:124
- **Link**: `src/TroveManager.sol:TroveManager:_updateTroveRewardSnapshots(uint256)`

```solidity
function _updateTroveRewardSnapshots(uint256 _troveId) internal {
    rewardSnapshots[_troveId].coll = L_coll;
    rewardSnapshots[_troveId].boldDebt = L_boldDebt;
}
```

### _movePendingTroveRewardsToActivePool(contract IDefaultPool,uint256,uint256)

- **Kind**: internal
- **Source**: 21499:294:124
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

- **IDefaultPool::decreaseBoldDebt(uint256)**
- **IDefaultPool::sendCollToActivePool(uint256)**

## State Variable Reads

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **L_coll** (`uint256`)
- **L_boldDebt** (`uint256`)
- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## State Variable Writes

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._removeTroveSharesFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256) (NodeID: 2)
  │   💬 Args: [_troveId, _newTroveColl, _newTroveDebt, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._updateTroveRewardSnapshots(uint256) (NodeID: 3)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TroveManager._movePendingTroveRewardsToActivePool(contract IDefaultPool,uint256,uint256) (NodeID: 4)
      💬 Args: [defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain]
      👁️  Def: internal
```
