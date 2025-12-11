# Function: getCurrentICR(uint256,uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `getCurrentICR(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 41949:270:275

## Implementation

```solidity
function getCurrentICR(uint256 _troveId, uint256 _price) override public view returns (uint256) {
    LatestTroveData memory trove;
    _getLatestTroveData(_troveId, trove);
    return LiquityMath._computeCR(trove.entireColl, trove.entireDebt, _price);
}
```

## Related Implementations

### _getLatestTroveData(uint256,struct LatestTroveData)

- **Kind**: internal
- **Source**: 42508:1397:275
- **Link**: `src/TroveManager.sol:TroveManager:_getLatestTroveData(uint256,struct LatestTroveData)`

```solidity
function _getLatestTroveData(uint256 _troveId, LatestTroveData memory trove) internal view {
    address batchAddress = _getBatchManager(_troveId);
    if (batchAddress != address(0)) {
        LatestBatchData memory batch;
        _getLatestBatchData(batchAddress, batch);
        _getLatestTroveDataFromBatch(_troveId, batchAddress, trove, batch);
        return;
    }
    uint256 stake = Troves[_troveId].stake;
    trove.redistBoldDebtGain = (stake * (L_boldDebt - rewardSnapshots[_troveId].boldDebt)) / DECIMAL_PRECISION;
    trove.redistCollGain = (stake * (L_coll - rewardSnapshots[_troveId].coll)) / DECIMAL_PRECISION;
    trove.recordedDebt = Troves[_troveId].debt;
    trove.annualInterestRate = Troves[_troveId].annualInterestRate;
    trove.weightedRecordedDebt = trove.recordedDebt * trove.annualInterestRate;
    uint256 period = _getInterestPeriod(Troves[_troveId].lastDebtUpdateTime);
    trove.accruedInterest = _calcInterest(trove.weightedRecordedDebt, period);
    trove.entireDebt = (trove.recordedDebt + trove.redistBoldDebtGain) + trove.accruedInterest;
    trove.entireColl = Troves[_troveId].coll + trove.redistCollGain;
    trove.lastInterestRateAdjTime = Troves[_troveId].lastInterestRateAdjTime;
}
```

### _getBatchManager(uint256)

- **Kind**: internal
- **Source**: 46292:137:275
- **Link**: `src/TroveManager.sol:TroveManager:_getBatchManager(uint256)`

```solidity
function _getBatchManager(uint256 _troveId) internal view returns (address) {
    return Troves[_troveId].interestBatchManager;
}
```

### _getLatestBatchData(address,struct LatestBatchData)

- **Kind**: internal
- **Source**: 46668:1309:275
- **Link**: `src/TroveManager.sol:TroveManager:_getLatestBatchData(address,struct LatestBatchData)`

```solidity
function _getLatestBatchData(address _batchAddress, LatestBatchData memory latestBatchData) internal view {
    Batch memory batch = batches[_batchAddress];
    latestBatchData.recordedDebt = batch.debt;
    latestBatchData.annualInterestRate = batch.annualInterestRate;
    latestBatchData.weightedRecordedDebt = latestBatchData.recordedDebt * latestBatchData.annualInterestRate;
    uint256 period = _getInterestPeriod(batch.lastDebtUpdateTime);
    latestBatchData.accruedInterest = _calcInterest(latestBatchData.weightedRecordedDebt, period);
    latestBatchData.annualManagementFee = batch.annualManagementFee;
    latestBatchData.weightedRecordedBatchManagementFee = latestBatchData.recordedDebt * latestBatchData.annualManagementFee;
    latestBatchData.accruedManagementFee = _calcInterest(latestBatchData.weightedRecordedBatchManagementFee, period);
    latestBatchData.entireDebtWithoutRedistribution = (latestBatchData.recordedDebt + latestBatchData.accruedInterest) + latestBatchData.accruedManagementFee;
    latestBatchData.entireCollWithoutRedistribution = batch.coll;
    latestBatchData.lastDebtUpdateTime = batch.lastDebtUpdateTime;
    latestBatchData.lastInterestRateAdjTime = batch.lastInterestRateAdjTime;
}
```

### _getInterestPeriod(uint256)

- **Kind**: internal
- **Source**: 52678:755:275
- **Link**: `src/TroveManager.sol:TroveManager:_getInterestPeriod(uint256)`

```solidity
function _getInterestPeriod(uint256 _lastDebtUpdateTime) internal view returns (uint256) {
    if (shutdownTime == 0) {
        return block.timestamp - _lastDebtUpdateTime;
    } else if ((shutdownTime > 0) && (_lastDebtUpdateTime < shutdownTime)) {
        return shutdownTime - _lastDebtUpdateTime;
    } else {
        return 0;
    }
}
```

### _calcInterest(uint256,uint256)

- **Kind**: internal
- **Source**: 2244:173:214
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:_calcInterest(uint256,uint256)`

```solidity
function _calcInterest(uint256 _weightedDebt, uint256 _period) internal pure returns (uint256) {
    return ((_weightedDebt * _period) / ONE_YEAR) / DECIMAL_PRECISION;
}
```

### _getLatestTroveDataFromBatch(uint256,address,struct LatestTroveData,struct LatestBatchData)

- **Kind**: internal
- **Source**: 43911:1861:275
- **Link**: `src/TroveManager.sol:TroveManager:_getLatestTroveDataFromBatch(uint256,address,struct LatestTroveData,struct LatestBatchData)`

```solidity
function _getLatestTroveDataFromBatch(uint256 _troveId, address _batchAddress, LatestTroveData memory _latestTroveData, LatestBatchData memory _latestBatchData) internal view {
    Trove memory trove = Troves[_troveId];
    uint256 batchDebtShares = trove.batchDebtShares;
    uint256 totalDebtShares = batches[_batchAddress].totalDebtShares;
    uint256 stake = trove.stake;
    _latestTroveData.redistBoldDebtGain = (stake * (L_boldDebt - rewardSnapshots[_troveId].boldDebt)) / DECIMAL_PRECISION;
    _latestTroveData.redistCollGain = (stake * (L_coll - rewardSnapshots[_troveId].coll)) / DECIMAL_PRECISION;
    if (totalDebtShares > 0) {
        _latestTroveData.recordedDebt = (_latestBatchData.recordedDebt * batchDebtShares) / totalDebtShares;
        _latestTroveData.weightedRecordedDebt = _latestTroveData.recordedDebt * _latestBatchData.annualInterestRate;
        _latestTroveData.accruedInterest = (_latestBatchData.accruedInterest * batchDebtShares) / totalDebtShares;
        _latestTroveData.accruedBatchManagementFee = (_latestBatchData.accruedManagementFee * batchDebtShares) / totalDebtShares;
    }
    _latestTroveData.annualInterestRate = _latestBatchData.annualInterestRate;
    _latestTroveData.entireDebt = ((_latestTroveData.recordedDebt + _latestTroveData.redistBoldDebtGain) + _latestTroveData.accruedInterest) + _latestTroveData.accruedBatchManagementFee;
    _latestTroveData.entireColl = trove.coll + _latestTroveData.redistCollGain;
    _latestTroveData.lastInterestRateAdjTime = LiquityMath._max(_latestBatchData.lastInterestRateAdjTime, trove.lastInterestRateAdjTime);
}
```

### _max(uint256,uint256)

- **Kind**: internal
- **Source**: 255:114:215
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_max(uint256,uint256)`

```solidity
function _max(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a >= _b) ? _a : _b;
}
```

### _computeCR(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2640:414:215
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_computeCR(uint256,uint256,uint256)`

```solidity
function _computeCR(uint256 _coll, uint256 _debt, uint256 _price) internal pure returns (uint256) {
    if (_debt > 0) {
        uint256 newCollRatio = (_coll * _price) / _debt;
        return newCollRatio;
    } else {
        return (2 ** 256) - 1;
    }
}
```

## State Variable Reads

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **L_boldDebt** (`uint256`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)
- **L_coll** (`uint256`)
- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **shutdownTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.getCurrentICR(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TroveManager._getLatestTroveData(uint256,struct LatestTroveData) (NodeID: 1)
  │   💬 Args: [_troveId, trove]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._getBatchManager(uint256) (NodeID: 2)
  │ │   💬 Args: [_troveId]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._getLatestBatchData(address,struct LatestBatchData) (NodeID: 3)
  │ │   💬 Args: [batchAddress, batch]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 4)
  │ │ │   💬 Args: [batch.lastDebtUpdateTime]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 5)
  │ │ │   💬 Args: [latestBatchData.weightedRecordedDebt, period]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 6)
  │ │     💬 Args: [latestBatchData.weightedRecordedBatchManagementFee, period]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._getLatestTroveDataFromBatch(uint256,address,struct LatestTroveData,struct LatestBatchData) (NodeID: 7)
  │ │   💬 Args: [_troveId, batchAddress, trove, batch]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 8)
  │ │     💬 Args: [_latestBatchData.lastInterestRateAdjTime, trove.lastInterestRateAdjTime]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 9)
  │ │   💬 Args: [Troves[_troveId].lastDebtUpdateTime]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 10)
  │     💬 Args: [trove.weightedRecordedDebt, period]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 11)
      💬 Args: [trove.entireColl, trove.entireDebt, _price]
      👁️  Def: internal
```
