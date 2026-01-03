# Function: onAdjustTrove(uint256,uint256,uint256,struct TroveChange)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `onAdjustTrove(uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 62003:1578:124

## Implementation

```solidity
function onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange calldata _troveChange) external {
    _requireCallerIsBorrowerOperations();
    Troves[_troveId].coll = _newColl;
    Troves[_troveId].debt = _newDebt;
    Troves[_troveId].lastDebtUpdateTime = uint64(block.timestamp);
    _movePendingTroveRewardsToActivePool(defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain);
    uint256 newStake = _updateStakeAndTotalStakes(_troveId, _newColl);
    _updateTroveRewardSnapshots(_troveId);
    emit TroveUpdated({_troveId: _troveId, _debt: _newDebt, _coll: _newColl, _stake: newStake, _annualInterestRate: Troves[_troveId].annualInterestRate, _snapshotOfTotalCollRedist: L_coll, _snapshotOfTotalDebtRedist: L_boldDebt});
    emit TroveOperation({_troveId: _troveId, _operation: Operation.adjustTrove, _annualInterestRate: Troves[_troveId].annualInterestRate, _debtIncreaseFromRedist: _troveChange.appliedRedistBoldDebtGain, _debtIncreaseFromUpfrontFee: _troveChange.upfrontFee, _debtChangeFromOperation: int256(_troveChange.debtIncrease) - int256(_troveChange.debtDecrease), _collIncreaseFromRedist: _troveChange.appliedRedistCollGain, _collChangeFromOperation: int256(_troveChange.collIncrease) - int256(_troveChange.collDecrease)});
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

## External Calls

- **IDefaultPool::decreaseBoldDebt(uint256)**
- **IDefaultPool::sendCollToActivePool(uint256)**

## State Variable Reads

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **L_coll** (`uint256`)
- **L_boldDebt** (`uint256`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **totalStakes** (`uint256`)
- **totalCollateralSnapshot** (`uint256`)
- **totalStakesSnapshot** (`uint256`)

## State Variable Writes

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **totalStakes** (`uint256`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.onAdjustTrove(uint256,uint256,uint256,struct TroveChange) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._movePendingTroveRewardsToActivePool(contract IDefaultPool,uint256,uint256) (NodeID: 2)
  │   💬 Args: [defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._updateStakeAndTotalStakes(uint256,uint256) (NodeID: 3)
  │   💬 Args: [_troveId, _newColl]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveManager._computeNewStake(uint256) (NodeID: 4)
  │     💬 Args: [_coll]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TroveManager._updateTroveRewardSnapshots(uint256) (NodeID: 5)
      💬 Args: [_troveId]
      👁️  Def: internal
```
