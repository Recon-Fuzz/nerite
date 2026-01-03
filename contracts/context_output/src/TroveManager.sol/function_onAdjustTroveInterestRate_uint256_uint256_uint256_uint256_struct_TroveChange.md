# Function: onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 60406:1591:124

## Implementation

```solidity
function onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange calldata _troveChange) external {
    _requireCallerIsBorrowerOperations();
    Troves[_troveId].coll = _newColl;
    Troves[_troveId].debt = _newDebt;
    Troves[_troveId].annualInterestRate = _newAnnualInterestRate;
    Troves[_troveId].lastDebtUpdateTime = uint64(block.timestamp);
    Troves[_troveId].lastInterestRateAdjTime = uint64(block.timestamp);
    _movePendingTroveRewardsToActivePool(defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain);
    _updateTroveRewardSnapshots(_troveId);
    emit TroveUpdated({_troveId: _troveId, _debt: _newDebt, _coll: _newColl, _stake: Troves[_troveId].stake, _annualInterestRate: _newAnnualInterestRate, _snapshotOfTotalCollRedist: L_coll, _snapshotOfTotalDebtRedist: L_boldDebt});
    emit TroveOperation({_troveId: _troveId, _operation: Operation.adjustTroveInterestRate, _annualInterestRate: _newAnnualInterestRate, _debtIncreaseFromRedist: _troveChange.appliedRedistBoldDebtGain, _debtIncreaseFromUpfrontFee: _troveChange.upfrontFee, _debtChangeFromOperation: 0, _collIncreaseFromRedist: _troveChange.appliedRedistCollGain, _collChangeFromOperation: 0});
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

## State Variable Writes

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._movePendingTroveRewardsToActivePool(contract IDefaultPool,uint256,uint256) (NodeID: 2)
  │   💬 Args: [defaultPool, _troveChange.appliedRedistBoldDebtGain, _troveChange.appliedRedistCollGain]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TroveManager._updateTroveRewardSnapshots(uint256) (NodeID: 3)
      💬 Args: [_troveId]
      👁️  Def: internal
```
