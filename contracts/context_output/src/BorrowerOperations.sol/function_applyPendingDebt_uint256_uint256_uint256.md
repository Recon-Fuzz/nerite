# Function: applyPendingDebt(uint256,uint256,uint256)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `applyPendingDebt(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 29143:2339:54

## Implementation

```solidity
function applyPendingDebt(uint256 _troveId, uint256 _lowerHint, uint256 _upperHint) public {
    _requireIsNotShutDown();
    ITroveManager troveManagerCached = troveManager;
    _requireTroveIsOpen(troveManagerCached, _troveId);
    LatestTroveData memory trove = troveManagerCached.getLatestTroveData(_troveId);
    _requireNonZeroDebt(trove.entireDebt);
    TroveChange memory change;
    change.appliedRedistBoldDebtGain = trove.redistBoldDebtGain;
    change.appliedRedistCollGain = trove.redistCollGain;
    address batchManager = interestBatchManagerOf[_troveId];
    LatestBatchData memory batch;
    if (batchManager == address(0)) {
        change.oldWeightedRecordedDebt = trove.weightedRecordedDebt;
        change.newWeightedRecordedDebt = trove.entireDebt * trove.annualInterestRate;
    } else {
        batch = troveManagerCached.getLatestBatchData(batchManager);
        change.batchAccruedManagementFee = batch.accruedManagementFee;
        change.oldWeightedRecordedDebt = batch.weightedRecordedDebt;
        change.newWeightedRecordedDebt = (batch.entireDebtWithoutRedistribution + trove.redistBoldDebtGain) * batch.annualInterestRate;
        change.oldWeightedRecordedBatchManagementFee = batch.weightedRecordedBatchManagementFee;
        change.newWeightedRecordedBatchManagementFee = (batch.entireDebtWithoutRedistribution + trove.redistBoldDebtGain) * batch.annualManagementFee;
    }
    troveManagerCached.onApplyTroveInterest(_troveId, trove.entireColl, trove.entireDebt, batchManager, batch.entireCollWithoutRedistribution, batch.entireDebtWithoutRedistribution, change);
    activePool.mintAggInterestAndAccountForTroveChange(change, batchManager);
    if (_checkTroveIsZombie(troveManagerCached, _troveId) && (trove.entireDebt >= MIN_DEBT)) {
        troveManagerCached.setTroveStatusToActive(_troveId);
        _reInsertIntoSortedTroves(_troveId, trove.annualInterestRate, _upperHint, _lowerHint, batchManager, batch.annualInterestRate);
    }
}
```

## Related Implementations

### _requireIsNotShutDown()

- **Kind**: internal
- **Source**: 51954:128:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireIsNotShutDown()`

```solidity
function _requireIsNotShutDown() internal view {
    if (hasBeenShutDown) {
        revert IsShutDown();
    }
}
```

### _requireTroveIsOpen(contract ITroveManager,uint256)

- **Kind**: internal
- **Source**: 54280:314:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireTroveIsOpen(contract ITroveManager,uint256)`

```solidity
function _requireTroveIsOpen(ITroveManager _troveManager, uint256 _troveId) internal view {
    ITroveManager.Status status = _troveManager.getTroveStatus(_troveId);
    if ((status != ITroveManager.Status.active) && (status != ITroveManager.Status.zombie)) {
        revert TroveNotOpen();
    }
}
```

### _requireNonZeroDebt(uint256)

- **Kind**: internal
- **Source**: 55346:151:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireNonZeroDebt(uint256)`

```solidity
function _requireNonZeroDebt(uint256 _troveDebt) internal pure {
    if (_troveDebt == 0) {
        revert TroveWithZeroDebt();
    }
}
```

### _checkTroveIsZombie(contract ITroveManager,uint256)

- **Kind**: internal
- **Source**: 55096:244:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_checkTroveIsZombie(contract ITroveManager,uint256)`

```solidity
function _checkTroveIsZombie(ITroveManager _troveManager, uint256 _troveId) internal view returns (bool) {
    ITroveManager.Status status = _troveManager.getTroveStatus(_troveId);
    return status == ITroveManager.Status.zombie;
}
```

### _reInsertIntoSortedTroves(uint256,uint256,uint256,uint256,address,uint256)

- **Kind**: internal
- **Source**: 49545:667:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_reInsertIntoSortedTroves(uint256,uint256,uint256,uint256,address,uint256)`

```solidity
function _reInsertIntoSortedTroves(uint256 _troveId, uint256 _troveAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, address _batchManager, uint256 _batchAnnualInterestRate) internal {
    if (_batchManager == address(0)) {
        sortedTroves.insert(_troveId, _troveAnnualInterestRate, _upperHint, _lowerHint);
    } else {
        sortedTroves.insertIntoBatch(_troveId, BatchId.wrap(_batchManager), _batchAnnualInterestRate, _upperHint, _lowerHint);
    }
}
```

## External Calls

- **ITroveManager::getLatestTroveData(uint256)**
- **ITroveManager::getLatestBatchData(address)**
- **ITroveManager::onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)**
- **IActivePool::mintAggInterestAndAccountForTroveChange(struct TroveChange,address)**
- **ITroveManager::setTroveStatusToActive(uint256)**
- **ITroveManager::getTroveStatus(uint256)**
- **ISortedTroves::insert(uint256,uint256,uint256,uint256)**
- **ISortedTroves::insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **hasBeenShutDown** (`bool`)
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.applyPendingDebt(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsOpen(contract ITroveManager,uint256) (NodeID: 2)
  │   💬 Args: [troveManagerCached, _troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireNonZeroDebt(uint256) (NodeID: 3)
  │   💬 Args: [trove.entireDebt]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._checkTroveIsZombie(contract ITroveManager,uint256) (NodeID: 4)
  │   💬 Args: [troveManagerCached, _troveId]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._reInsertIntoSortedTroves(uint256,uint256,uint256,uint256,address,uint256) (NodeID: 5)
      💬 Args: [_troveId, trove.annualInterestRate, _upperHint, _lowerHint, batchManager, batch.annualInterestRate]
      👁️  Def: internal
```
