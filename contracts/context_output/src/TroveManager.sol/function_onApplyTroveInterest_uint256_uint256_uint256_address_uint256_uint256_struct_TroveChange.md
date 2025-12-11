# Function: onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 70337:2483:275

## Implementation

```solidity
function onApplyTroveInterest(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, TroveChange calldata _troveChange) external {
    _requireCallerIsBorrowerOperations();
    Troves[_troveId].coll = _newTroveColl;
    if (_batchAddress != address(0)) {
        assert(_newTroveDebt > 0);
        _updateBatchShares(_troveId, _batchAddress, _troveChange, _newTroveDebt, _newBatchColl, _newBatchDebt, true);
        emit BatchUpdated({_interestBatchManager: _batchAddress, _operation: BatchOperation.applyBatchInterestAndFee, _debt: _newBatchDebt, _coll: _newBatchColl, _annualInterestRate: batches[_batchAddress].annualInterestRate, _annualManagementFee: batches[_batchAddress].annualManagementFee, _totalDebtShares: batches[_batchAddress].totalDebtShares, _debtIncreaseFromUpfrontFee: 0});
    } else {
        Troves[_troveId].debt = _newTroveDebt;
        Troves[_troveId].lastDebtUpdateTime = uint64(block.timestamp);
    }
    _movePendingTroveRewardsToActivePool(defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain);
    _updateTroveRewardSnapshots(_troveId);
    emit TroveUpdated({_troveId: _troveId, _debt: _newTroveDebt, _coll: _newTroveColl, _stake: Troves[_troveId].stake, _annualInterestRate: Troves[_troveId].annualInterestRate, _snapshotOfTotalCollRedist: L_coll, _snapshotOfTotalDebtRedist: L_boldDebt});
    emit TroveOperation({_troveId: _troveId, _operation: Operation.applyPendingDebt, _annualInterestRate: Troves[_troveId].annualInterestRate, _debtIncreaseFromRedist: _troveChange.appliedRedistBoldDebtGain, _debtIncreaseFromUpfrontFee: _troveChange.upfrontFee, _debtChangeFromOperation: int256(_troveChange.debtIncrease) - int256(_troveChange.debtDecrease), _collIncreaseFromRedist: _troveChange.appliedRedistCollGain, _collChangeFromOperation: int256(_troveChange.collIncrease) - int256(_troveChange.collDecrease)});
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

### _updateBatchShares(uint256,address,struct TroveChange,uint256,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 78969:4032:275
- **Link**: `src/TroveManager.sol:TroveManager:_updateBatchShares(uint256,address,struct TroveChange,uint256,uint256,uint256,bool)`

```solidity
function _updateBatchShares(uint256 _troveId, address _batchAddress, TroveChange memory _troveChange, uint256 _newTroveDebt, uint256 _batchColl, uint256 _batchDebt, bool _checkBatchSharesRatio) internal {
    uint256 currentBatchDebtShares = batches[_batchAddress].totalDebtShares;
    uint256 batchDebtSharesDelta;
    uint256 debtIncrease = (_troveChange.debtIncrease + _troveChange.upfrontFee) + _troveChange.appliedRedistBoldDebtGain;
    uint256 debtDecrease;
    if (debtIncrease > _troveChange.debtDecrease) {
        debtIncrease -= _troveChange.debtDecrease;
    } else {
        debtDecrease = _troveChange.debtDecrease - debtIncrease;
        debtIncrease = 0;
    }
    if ((debtIncrease == 0) && (debtDecrease == 0)) {
        batches[_batchAddress].debt = _batchDebt;
    } else {
        if (debtIncrease > 0) {
            if (_batchDebt == 0) {
                batchDebtSharesDelta = debtIncrease;
            } else {
                _requireBelowMaxSharesRatio(currentBatchDebtShares, _batchDebt, _checkBatchSharesRatio);
                batchDebtSharesDelta = (currentBatchDebtShares * debtIncrease) / _batchDebt;
            }
            Troves[_troveId].batchDebtShares += batchDebtSharesDelta;
            batches[_batchAddress].debt = _batchDebt + debtIncrease;
            batches[_batchAddress].totalDebtShares = currentBatchDebtShares + batchDebtSharesDelta;
        } else if (debtDecrease > 0) {
            if (_newTroveDebt == 0) {
                batches[_batchAddress].debt = _batchDebt - debtDecrease;
                batches[_batchAddress].totalDebtShares = currentBatchDebtShares - Troves[_troveId].batchDebtShares;
                Troves[_troveId].batchDebtShares = 0;
            } else {
                batchDebtSharesDelta = (currentBatchDebtShares * debtDecrease) / _batchDebt;
                Troves[_troveId].batchDebtShares -= batchDebtSharesDelta;
                batches[_batchAddress].debt = _batchDebt - debtDecrease;
                batches[_batchAddress].totalDebtShares = currentBatchDebtShares - batchDebtSharesDelta;
            }
        }
    }
    batches[_batchAddress].lastDebtUpdateTime = uint64(block.timestamp);
    uint256 collIncrease = _troveChange.collIncrease + _troveChange.appliedRedistCollGain;
    uint256 collDecrease;
    if (collIncrease > _troveChange.collDecrease) {
        collIncrease -= _troveChange.collDecrease;
    } else {
        collDecrease = _troveChange.collDecrease - collIncrease;
        collIncrease = 0;
    }
    if ((collIncrease == 0) && (collDecrease == 0)) {
        batches[_batchAddress].coll = _batchColl;
    } else {
        if (collIncrease > 0) {
            batches[_batchAddress].coll = _batchColl + collIncrease;
        } else if (collDecrease > 0) {
            batches[_batchAddress].coll = _batchColl - collDecrease;
        }
    }
}
```

### _requireBelowMaxSharesRatio(uint256,uint256,bool)

- **Kind**: internal
- **Source**: 83449:393:275
- **Link**: `src/TroveManager.sol:TroveManager:_requireBelowMaxSharesRatio(uint256,uint256,bool)`

```solidity
function _requireBelowMaxSharesRatio(uint256 _currentBatchDebtShares, uint256 _batchDebt, bool _checkBatchSharesRatio) internal pure {
    if (((_currentBatchDebtShares * MAX_BATCH_SHARES_RATIO) < _batchDebt) && _checkBatchSharesRatio) {
        revert BatchSharesRatioTooHigh();
    }
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

### _updateTroveRewardSnapshots(uint256)

- **Kind**: internal
- **Source**: 42225:177:275
- **Link**: `src/TroveManager.sol:TroveManager:_updateTroveRewardSnapshots(uint256)`

```solidity
function _updateTroveRewardSnapshots(uint256 _troveId) internal {
    rewardSnapshots[_troveId].coll = L_coll;
    rewardSnapshots[_troveId].boldDebt = L_boldDebt;
}
```

## External Calls

- **IDefaultPool::decreaseBoldDebt(uint256)**
- **IDefaultPool::sendCollToActivePool(uint256)**

## State Variable Reads

- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **L_coll** (`uint256`)
- **L_boldDebt** (`uint256`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## State Variable Writes

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._updateBatchShares(uint256,address,struct TroveChange,uint256,uint256,uint256,bool) (NodeID: 2)
  │   💬 Args: [_troveId, _batchAddress, _troveChange, _newTroveDebt, _newBatchColl, _newBatchDebt, true]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveManager._requireBelowMaxSharesRatio(uint256,uint256,bool) (NodeID: 3)
  │     💬 Args: [currentBatchDebtShares, _batchDebt, _checkBatchSharesRatio]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._movePendingTroveRewardsToActivePool(contract IDefaultPool,uint256,uint256) (NodeID: 4)
  │   💬 Args: [defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TroveManager._updateTroveRewardSnapshots(uint256) (NodeID: 5)
      💬 Args: [_troveId]
      👁️  Def: internal
```
