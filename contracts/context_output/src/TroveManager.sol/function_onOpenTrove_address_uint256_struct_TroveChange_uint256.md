# Function: onOpenTrove(address,uint256,struct TroveChange,uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `onOpenTrove(address,uint256,struct TroveChange,uint256)`
- **Visibility**: external
- **Source Range**: 55340:1943:124

## Implementation

```solidity
function onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) external {
    _requireCallerIsBorrowerOperations();
    uint256 newStake = _computeNewStake(_troveChange.collIncrease);
    Troves[_troveId].debt = _troveChange.debtIncrease + _troveChange.upfrontFee;
    Troves[_troveId].coll = _troveChange.collIncrease;
    Troves[_troveId].stake = newStake;
    Troves[_troveId].status = Status.active;
    Troves[_troveId].arrayIndex = uint64(TroveIds.length);
    Troves[_troveId].lastDebtUpdateTime = uint64(block.timestamp);
    Troves[_troveId].lastInterestRateAdjTime = uint64(block.timestamp);
    Troves[_troveId].annualInterestRate = _annualInterestRate;
    TroveIds.push(_troveId);
    uint256 newTotalStakes = totalStakes + newStake;
    totalStakes = newTotalStakes;
    troveNFT.mint(_owner, _troveId);
    _updateTroveRewardSnapshots(_troveId);
    emit TroveUpdated({_troveId: _troveId, _debt: _troveChange.debtIncrease + _troveChange.upfrontFee, _coll: _troveChange.collIncrease, _stake: newStake, _annualInterestRate: _annualInterestRate, _snapshotOfTotalCollRedist: L_coll, _snapshotOfTotalDebtRedist: L_boldDebt});
    emit TroveOperation({_troveId: _troveId, _operation: Operation.openTrove, _annualInterestRate: _annualInterestRate, _debtIncreaseFromRedist: 0, _debtIncreaseFromUpfrontFee: _troveChange.upfrontFee, _debtChangeFromOperation: int256(_troveChange.debtIncrease), _collIncreaseFromRedist: 0, _collChangeFromOperation: int256(_troveChange.collIncrease)});
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

- **ITroveNFT::mint(address,uint256)**

## State Variable Reads

- **TroveIds** (`uint256[]`)
- **totalStakes** (`uint256`)
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]
- **L_coll** (`uint256`)
- **L_boldDebt** (`uint256`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **totalCollateralSnapshot** (`uint256`)
- **totalStakesSnapshot** (`uint256`)

## State Variable Writes

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **TroveIds** (`uint256[]`)
- **totalStakes** (`uint256`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.onOpenTrove(address,uint256,struct TroveChange,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._computeNewStake(uint256) (NodeID: 2)
  │   💬 Args: [_troveChange.collIncrease]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TroveManager._updateTroveRewardSnapshots(uint256) (NodeID: 3)
      💬 Args: [_troveId]
      👁️  Def: internal
```
