# Function: onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 67599:2732:124

## Implementation

```solidity
function onAdjustTroveInsideBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) external {
    _requireCallerIsBorrowerOperations();
    Troves[_troveId].coll = _newTroveColl;
    _updateTroveRewardSnapshots(_troveId);
    uint256 newStake = _updateStakeAndTotalStakes(_troveId, _newTroveColl);
    assert(_newTroveDebt > 0);
    _updateBatchShares(_troveId, _batchAddress, _troveChange, _newTroveDebt, _newBatchColl, _newBatchDebt, true);
    _movePendingTroveRewardsToActivePool(defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain);
    emit BatchedTroveUpdated({_troveId: _troveId, _interestBatchManager: _batchAddress, _batchDebtShares: Troves[_troveId].batchDebtShares, _coll: _newTroveColl, _stake: newStake, _snapshotOfTotalCollRedist: L_coll, _snapshotOfTotalDebtRedist: L_boldDebt});
    emit TroveOperation({_troveId: _troveId, _operation: Operation.adjustTrove, _annualInterestRate: batches[_batchAddress].annualInterestRate, _debtIncreaseFromRedist: _troveChange.appliedRedistBoldDebtGain, _debtIncreaseFromUpfrontFee: _troveChange.upfrontFee, _debtChangeFromOperation: int256(_troveChange.debtIncrease) - int256(_troveChange.debtDecrease), _collIncreaseFromRedist: _troveChange.appliedRedistCollGain, _collChangeFromOperation: int256(_troveChange.collIncrease) - int256(_troveChange.collDecrease)});
    emit BatchUpdated({_interestBatchManager: _batchAddress, _operation: BatchOperation.troveChange, _debt: batches[_batchAddress].debt, _coll: batches[_batchAddress].coll, _annualInterestRate: batches[_batchAddress].annualInterestRate, _annualManagementFee: batches[_batchAddress].annualManagementFee, _totalDebtShares: batches[_batchAddress].totalDebtShares, _debtIncreaseFromUpfrontFee: 0});
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

### _updateStakeAndTotalStakes(uint256,uint256)

- **Kind**: internal
- **Source**: 48221:308:124
- **Link**: `src/TroveManager.sol:TroveManager:_updateStakeAndTotalStakes(uint256,uint256)`

```solidity
function _updateStakeAndTotalStakes(uint256 _troveId, uint256 _coll) internal returns (uint256 newStake) {
    newStake = _computeNewStake(_coll);
    uint256 oldStake = Troves[_troveId].stake;
    Troves[_troveId].stake = newStake;
    totalStakes = (totalStakes - oldStake) + newStake;
}
```

### _computeNewStake(uint256)

- **Kind**: internal
- **Source**: 48656:715:124
- **Link**: `src/TroveManager.sol:TroveManager:_computeNewStake(uint256)`

```solidity
function _computeNewStake(uint256 _coll) internal view returns (uint256) {
    uint256 stake;
    if (totalCollateralSnapshot == 0) {
        stake = _coll;
    } else {
        stake = (_coll * totalStakesSnapshot) / totalCollateralSnapshot;
    }
    return stake;
}
```

### _updateBatchShares(uint256,address,struct TroveChange,uint256,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 78969:4032:124
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
- **Source**: 83449:393:124
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
- **totalStakes** (`uint256`)
- **totalCollateralSnapshot** (`uint256`)
- **totalStakesSnapshot** (`uint256`)

## State Variable Writes

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)
- **totalStakes** (`uint256`)
- **batches** (`mapping(address => struct TroveManager.Batch)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._updateTroveRewardSnapshots(uint256) (NodeID: 2)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._updateStakeAndTotalStakes(uint256,uint256) (NodeID: 3)
  │   💬 Args: [_troveId, _newTroveColl]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveManager._computeNewStake(uint256) (NodeID: 4)
  │     💬 Args: [_coll]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._updateBatchShares(uint256,address,struct TroveChange,uint256,uint256,uint256,bool) (NodeID: 5)
  │   💬 Args: [_troveId, _batchAddress, _troveChange, _newTroveDebt, _newBatchColl, _newBatchDebt, true]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveManager._requireBelowMaxSharesRatio(uint256,uint256,bool) (NodeID: 6)
  │     💬 Args: [currentBatchDebtShares, _batchDebt, _checkBatchSharesRatio]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TroveManager._movePendingTroveRewardsToActivePool(contract IDefaultPool,uint256,uint256) (NodeID: 7)
      💬 Args: [defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain]
      👁️  Def: internal
```
