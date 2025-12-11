# Function: batchLiquidateTroves(uint256[])

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `batchLiquidateTroves(uint256[])`
- **Visibility**: public
- **Source Range**: 16330:2140:275

## Implementation

```solidity
function batchLiquidateTroves(uint256[] memory _troveArray) override public {
    if (_troveArray.length == 0) {
        revert EmptyData();
    }
    IActivePool activePoolCached = activePool;
    IDefaultPool defaultPoolCached = defaultPool;
    IStabilityPool stabilityPoolCached = stabilityPool;
    TroveChange memory troveChange;
    LiquidationValues memory totals;
    (uint256 price, ) = priceFeed.fetchPrice();
    uint256 boldInStabPool = stabilityPoolCached.getTotalBoldDeposits();
    _batchLiquidateTroves(defaultPoolCached, price, boldInStabPool, _troveArray, totals, troveChange);
    if (troveChange.debtDecrease == 0) {
        revert NothingToLiquidate();
    }
    activePoolCached.mintAggInterestAndAccountForTroveChange(troveChange, address(0));
    if ((totals.debtToOffset > 0) || (totals.collToSendToSP > 0)) {
        stabilityPoolCached.offset(totals.debtToOffset, totals.collToSendToSP);
    }
    _redistributeDebtAndColl(activePoolCached, defaultPoolCached, totals.debtToRedistribute, totals.collToRedistribute);
    if (totals.collSurplus > 0) {
        activePoolCached.sendColl(address(collSurplusPool), totals.collSurplus);
    }
    _updateSystemSnapshots_excludeCollRemainder(activePoolCached, totals.collGasCompensation);
    emit Liquidation(totals.debtToOffset, totals.debtToRedistribute, totals.ETHGasCompensation, totals.collGasCompensation, totals.collToSendToSP, totals.collToRedistribute, totals.collSurplus, L_coll, L_boldDebt, price);
    _sendGasCompensation(activePoolCached, msg.sender, totals.ETHGasCompensation, totals.collGasCompensation);
}
```

## Related Implementations

### _batchLiquidateTroves(contract IDefaultPool,uint256,uint256,uint256[],struct TroveManager.LiquidationValues,struct TroveChange)

- **Kind**: internal
- **Source**: 18630:1121:275
- **Link**: `src/TroveManager.sol:TroveManager:_batchLiquidateTroves(contract IDefaultPool,uint256,uint256,uint256[],struct TroveManager.LiquidationValues,struct TroveChange)`

```solidity
function _batchLiquidateTroves(IDefaultPool _defaultPool, uint256 _price, uint256 _boldInStabPool, uint256[] memory _troveArray, LiquidationValues memory totals, TroveChange memory troveChange) internal {
    uint256 remainingBoldInStabPool = _boldInStabPool;
    for (uint256 i = 0; i < _troveArray.length; i++) {
        uint256 troveId = _troveArray[i];
        if (!_isActiveOrZombie(Troves[troveId].status)) continue;
        uint256 ICR = getCurrentICR(troveId, _price);
        if (ICR < MCR) {
            LiquidationValues memory singleLiquidation;
            LatestTroveData memory trove;
            _liquidate(_defaultPool, troveId, remainingBoldInStabPool, _price, trove, singleLiquidation);
            remainingBoldInStabPool -= singleLiquidation.debtToOffset;
            _addLiquidationValuesToTotals(trove, singleLiquidation, totals, troveChange);
        }
    }
}
```

### _isActiveOrZombie(enum ITroveManager.Status)

- **Kind**: internal
- **Source**: 18476:148:275
- **Link**: `src/TroveManager.sol:TroveManager:_isActiveOrZombie(enum ITroveManager.Status)`

```solidity
function _isActiveOrZombie(Status _status) internal pure returns (bool) {
    return (_status == Status.active) || (_status == Status.zombie);
}
```

### getCurrentICR(uint256,uint256)

- **Kind**: internal
- **Source**: 41949:270:275
- **Link**: `src/TroveManager.sol:TroveManager:getCurrentICR(uint256,uint256)`

```solidity
function getCurrentICR(uint256 _troveId, uint256 _price) override public view returns (uint256) {
    LatestTroveData memory trove;
    _getLatestTroveData(_troveId, trove);
    return LiquityMath._computeCR(trove.entireColl, trove.entireDebt, _price);
}
```

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

### _liquidate(contract IDefaultPool,uint256,uint256,uint256,struct LatestTroveData,struct TroveManager.LiquidationValues)

- **Kind**: internal
- **Source**: 8777:4311:275
- **Link**: `src/TroveManager.sol:TroveManager:_liquidate(contract IDefaultPool,uint256,uint256,uint256,struct LatestTroveData,struct TroveManager.LiquidationValues)`

```solidity
function _liquidate(IDefaultPool _defaultPool, uint256 _troveId, uint256 _boldInStabPool, uint256 _price, LatestTroveData memory trove, LiquidationValues memory singleLiquidation) internal {
    address owner = troveNFT.ownerOf(_troveId);
    _getLatestTroveData(_troveId, trove);
    address batchAddress = _getBatchManager(_troveId);
    bool isTroveInBatch = batchAddress != address(0);
    LatestBatchData memory batch;
    if (isTroveInBatch) _getLatestBatchData(batchAddress, batch);
    _movePendingTroveRewardsToActivePool(_defaultPool, trove.redistBoldDebtGain, trove.redistCollGain);
    singleLiquidation.collGasCompensation = _getCollGasCompensation(trove.entireColl);
    uint256 collToLiquidate = trove.entireColl - singleLiquidation.collGasCompensation;
    (singleLiquidation.debtToOffset, singleLiquidation.collToSendToSP, singleLiquidation.debtToRedistribute, singleLiquidation.collToRedistribute, singleLiquidation.collSurplus) = _getOffsetAndRedistributionVals(trove.entireDebt, collToLiquidate, _boldInStabPool, _price);
    TroveChange memory troveChange;
    troveChange.collDecrease = trove.entireColl;
    troveChange.debtDecrease = trove.entireDebt;
    troveChange.appliedRedistCollGain = trove.redistCollGain;
    troveChange.appliedRedistBoldDebtGain = trove.redistBoldDebtGain;
    _closeTrove(_troveId, troveChange, batchAddress, batch.entireCollWithoutRedistribution, batch.entireDebtWithoutRedistribution, Status.closedByLiquidation);
    if (isTroveInBatch) {
        singleLiquidation.oldWeightedRecordedDebt = batch.weightedRecordedDebt + ((trove.entireDebt - trove.redistBoldDebtGain) * batch.annualInterestRate);
        singleLiquidation.newWeightedRecordedDebt = batch.entireDebtWithoutRedistribution * batch.annualInterestRate;
        troveChange.batchAccruedManagementFee = batch.accruedManagementFee;
        troveChange.oldWeightedRecordedBatchManagementFee = batch.weightedRecordedBatchManagementFee + ((trove.entireDebt - trove.redistBoldDebtGain) * batch.annualManagementFee);
        troveChange.newWeightedRecordedBatchManagementFee = batch.entireDebtWithoutRedistribution * batch.annualManagementFee;
        activePool.mintBatchManagementFeeAndAccountForChange(troveChange, batchAddress);
    } else {
        singleLiquidation.oldWeightedRecordedDebt = trove.weightedRecordedDebt;
    }
    if (singleLiquidation.collSurplus > 0) {
        collSurplusPool.accountSurplus(owner, singleLiquidation.collSurplus);
    }
    borrowerOperations.onLiquidateTrove(_troveId);
    emit TroveUpdated({_troveId: _troveId, _debt: 0, _coll: 0, _stake: 0, _annualInterestRate: 0, _snapshotOfTotalCollRedist: 0, _snapshotOfTotalDebtRedist: 0});
    emit TroveOperation({_troveId: _troveId, _operation: Operation.liquidate, _annualInterestRate: 0, _debtIncreaseFromRedist: trove.redistBoldDebtGain, _debtIncreaseFromUpfrontFee: 0, _debtChangeFromOperation: -int256(trove.entireDebt), _collIncreaseFromRedist: trove.redistCollGain, _collChangeFromOperation: -int256(trove.entireColl)});
    if (isTroveInBatch) {
        emit BatchUpdated({_interestBatchManager: batchAddress, _operation: BatchOperation.exitBatch, _debt: batches[batchAddress].debt, _coll: batches[batchAddress].coll, _annualInterestRate: batch.annualInterestRate, _annualManagementFee: batch.annualManagementFee, _totalDebtShares: batches[batchAddress].totalDebtShares, _debtIncreaseFromUpfrontFee: 0});
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

### _getCollGasCompensation(uint256)

- **Kind**: internal
- **Source**: 13195:198:275
- **Link**: `src/TroveManager.sol:TroveManager:_getCollGasCompensation(uint256)`

```solidity
function _getCollGasCompensation(uint256 _entireColl) internal pure returns (uint256) {
    return LiquityMath._min(_entireColl / COLL_GAS_COMPENSATION_DIVISOR, COLL_GAS_COMPENSATION_CAP);
}
```

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:215
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

### _getOffsetAndRedistributionVals(uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 13559:2089:275
- **Link**: `src/TroveManager.sol:TroveManager:_getOffsetAndRedistributionVals(uint256,uint256,uint256,uint256)`

```solidity
function _getOffsetAndRedistributionVals(uint256 _entireTroveDebt, uint256 _collToLiquidate, uint256 _boldInStabPool, uint256 _price) internal view returns (uint256 debtToOffset, uint256 collToSendToSP, uint256 debtToRedistribute, uint256 collToRedistribute, uint256 collSurplus) {
    uint256 collSPPortion;
    if (_boldInStabPool > 0) {
        debtToOffset = LiquityMath._min(_entireTroveDebt, _boldInStabPool);
        collSPPortion = (_collToLiquidate * debtToOffset) / _entireTroveDebt;
        (collToSendToSP, collSurplus) = _getCollPenaltyAndSurplus(collSPPortion, debtToOffset, LIQUIDATION_PENALTY_SP, _price);
    }
    debtToRedistribute = _entireTroveDebt - debtToOffset;
    if (debtToRedistribute > 0) {
        uint256 collRedistributionPortion = _collToLiquidate - collSPPortion;
        if (collRedistributionPortion > 0) {
            (collToRedistribute, collSurplus) = _getCollPenaltyAndSurplus(collRedistributionPortion + collSurplus, debtToRedistribute, LIQUIDATION_PENALTY_REDISTRIBUTION, _price);
        }
    }
}
```

### _getCollPenaltyAndSurplus(uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 15654:579:275
- **Link**: `src/TroveManager.sol:TroveManager:_getCollPenaltyAndSurplus(uint256,uint256,uint256,uint256)`

```solidity
function _getCollPenaltyAndSurplus(uint256 _collToLiquidate, uint256 _debtToLiquidate, uint256 _penaltyRatio, uint256 _price) internal pure returns (uint256 seizedColl, uint256 collSurplus) {
    uint256 maxSeizedColl = (_debtToLiquidate * (DECIMAL_PRECISION + _penaltyRatio)) / _price;
    if (_collToLiquidate > maxSeizedColl) {
        seizedColl = maxSeizedColl;
        collSurplus = _collToLiquidate - maxSeizedColl;
    } else {
        seizedColl = _collToLiquidate;
        collSurplus = 0;
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

### _addLiquidationValuesToTotals(struct LatestTroveData,struct TroveManager.LiquidationValues,struct TroveManager.LiquidationValues,struct TroveChange)

- **Kind**: internal
- **Source**: 19898:1159:275
- **Link**: `src/TroveManager.sol:TroveManager:_addLiquidationValuesToTotals(struct LatestTroveData,struct TroveManager.LiquidationValues,struct TroveManager.LiquidationValues,struct TroveChange)`

```solidity
function _addLiquidationValuesToTotals(LatestTroveData memory _trove, LiquidationValues memory _singleLiquidation, LiquidationValues memory totals, TroveChange memory troveChange) internal pure {
    totals.collGasCompensation += _singleLiquidation.collGasCompensation;
    totals.ETHGasCompensation += ETH_GAS_COMPENSATION;
    troveChange.debtDecrease += _trove.entireDebt;
    troveChange.collDecrease += _trove.entireColl;
    troveChange.appliedRedistBoldDebtGain += _trove.redistBoldDebtGain;
    troveChange.oldWeightedRecordedDebt += _singleLiquidation.oldWeightedRecordedDebt;
    troveChange.newWeightedRecordedDebt += _singleLiquidation.newWeightedRecordedDebt;
    totals.debtToOffset += _singleLiquidation.debtToOffset;
    totals.collToSendToSP += _singleLiquidation.collToSendToSP;
    totals.debtToRedistribute += _singleLiquidation.debtToRedistribute;
    totals.collToRedistribute += _singleLiquidation.collToRedistribute;
    totals.collSurplus += _singleLiquidation.collSurplus;
}
```

### _redistributeDebtAndColl(contract IActivePool,contract IDefaultPool,uint256,uint256)

- **Kind**: internal
- **Source**: 49377:1950:275
- **Link**: `src/TroveManager.sol:TroveManager:_redistributeDebtAndColl(contract IActivePool,contract IDefaultPool,uint256,uint256)`

```solidity
function _redistributeDebtAndColl(IActivePool _activePool, IDefaultPool _defaultPool, uint256 _debtToRedistribute, uint256 _collToRedistribute) internal {
    if (_debtToRedistribute == 0) return;
    uint256 collNumerator = (_collToRedistribute * DECIMAL_PRECISION) + lastCollError_Redistribution;
    uint256 boldDebtNumerator = (_debtToRedistribute * DECIMAL_PRECISION) + lastBoldDebtError_Redistribution;
    uint256 collRewardPerUnitStaked = collNumerator / totalStakes;
    uint256 boldDebtRewardPerUnitStaked = boldDebtNumerator / totalStakes;
    lastCollError_Redistribution = collNumerator - (collRewardPerUnitStaked * totalStakes);
    lastBoldDebtError_Redistribution = boldDebtNumerator - (boldDebtRewardPerUnitStaked * totalStakes);
    L_coll = L_coll + collRewardPerUnitStaked;
    L_boldDebt = L_boldDebt + boldDebtRewardPerUnitStaked;
    _defaultPool.increaseBoldDebt(_debtToRedistribute);
    _activePool.sendCollToDefaultPool(_collToRedistribute);
}
```

### _updateSystemSnapshots_excludeCollRemainder(contract IActivePool,uint256)

- **Kind**: internal
- **Source**: 51515:364:275
- **Link**: `src/TroveManager.sol:TroveManager:_updateSystemSnapshots_excludeCollRemainder(contract IActivePool,uint256)`

```solidity
function _updateSystemSnapshots_excludeCollRemainder(IActivePool _activePool, uint256 _collRemainder) internal {
    totalStakesSnapshot = totalStakes;
    uint256 activeColl = _activePool.getCollBalance();
    uint256 liquidatedColl = defaultPool.getCollBalance();
    totalCollateralSnapshot = (activeColl - _collRemainder) + liquidatedColl;
}
```

### _sendGasCompensation(contract IActivePool,address,uint256,uint256)

- **Kind**: internal
- **Source**: 21063:311:275
- **Link**: `src/TroveManager.sol:TroveManager:_sendGasCompensation(contract IActivePool,address,uint256,uint256)`

```solidity
function _sendGasCompensation(IActivePool _activePool, address _liquidator, uint256 _eth, uint256 _coll) internal {
    if (_eth > 0) {
        WETH.transferFrom(gasPoolAddress, _liquidator, _eth);
    }
    if (_coll > 0) {
        _activePool.sendColl(_liquidator, _coll);
    }
}
```

## External Calls

- **IPriceFeed::fetchPrice()**
- **IStabilityPool::getTotalBoldDeposits()**
- **IActivePool::mintAggInterestAndAccountForTroveChange(struct TroveChange,address)**
- **IStabilityPool::offset(uint256,uint256)**
- **IActivePool::sendColl(address,uint256)**
- **ITroveNFT::ownerOf(uint256)**
- **IActivePool::mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)**
- **ICollSurplusPool::accountSurplus(address,uint256)**
- **IBorrowerOperations::onLiquidateTrove(uint256)**
- **IDefaultPool::decreaseBoldDebt(uint256)**
- **IDefaultPool::sendCollToActivePool(uint256)**
- **ISortedTroves::removeFromBatch(uint256)**
- **ISortedTroves::remove(uint256)**
- **ITroveNFT::burn(uint256)**
- **IDefaultPool::increaseBoldDebt(uint256)**
- **IActivePool::sendCollToDefaultPool(uint256)**
- **IActivePool::getCollBalance()**
- **IDefaultPool::getCollBalance()**
- **IWETH::transferFrom(address,address,uint256)**

## State Variable Reads

- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **L_coll** (`uint256`)
- **L_boldDebt** (`uint256`)
- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **MCR** (`uint256`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)
- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **shutdownTime** (`uint256`)
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **LIQUIDATION_PENALTY_SP** (`uint256`)
- **LIQUIDATION_PENALTY_REDISTRIBUTION** (`uint256`)
- **TroveIds** (`uint256[]`)
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **lastZombieTroveId** (`uint256`)
- **totalStakes** (`uint256`)
- **lastCollError_Redistribution** (`uint256`)
- **lastBoldDebtError_Redistribution** (`uint256`)
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **gasPoolAddress** (`address`)

## State Variable Writes

- **lastZombieTroveId** (`uint256`)
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **totalStakes** (`uint256`)
- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)
- **TroveIds** (`uint256[]`)
- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **lastCollError_Redistribution** (`uint256`)
- **lastBoldDebtError_Redistribution** (`uint256`)
- **L_coll** (`uint256`)
- **L_boldDebt** (`uint256`)
- **totalStakesSnapshot** (`uint256`)
- **totalCollateralSnapshot** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.batchLiquidateTroves(uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: TroveManager._batchLiquidateTroves(contract IDefaultPool,uint256,uint256,uint256[],struct TroveManager.LiquidationValues,struct TroveChange) (NodeID: 1)
  │   💬 Args: [defaultPoolCached, price, boldInStabPool, _troveArray, totals, troveChange]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._isActiveOrZombie(enum ITroveManager.Status) (NodeID: 2)
  │ │   💬 Args: [Troves[troveId].status]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager.getCurrentICR(uint256,uint256) (NodeID: 3)
  │ │   💬 Args: [troveId, _price]
  │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: TroveManager._getLatestTroveData(uint256,struct LatestTroveData) (NodeID: 4)
  │ │ │   💬 Args: [_troveId, trove]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: TroveManager._getBatchManager(uint256) (NodeID: 5)
  │ │ │ │   💬 Args: [_troveId]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: TroveManager._getLatestBatchData(address,struct LatestBatchData) (NodeID: 6)
  │ │ │ │   💬 Args: [batchAddress, batch]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 7)
  │ │ │ │ │   💬 Args: [batch.lastDebtUpdateTime]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 8)
  │ │ │ │ │   💬 Args: [latestBatchData.weightedRecordedDebt, period]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 9)
  │ │ │ │     💬 Args: [latestBatchData.weightedRecordedBatchManagementFee, period]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: TroveManager._getLatestTroveDataFromBatch(uint256,address,struct LatestTroveData,struct LatestBatchData) (NodeID: 10)
  │ │ │ │   💬 Args: [_troveId, batchAddress, trove, batch]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 11)
  │ │ │ │     💬 Args: [_latestBatchData.lastInterestRateAdjTime, trove.lastInterestRateAdjTime]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 12)
  │ │ │ │   💬 Args: [Troves[_troveId].lastDebtUpdateTime]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 13)
  │ │ │     💬 Args: [trove.weightedRecordedDebt, period]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 14)
  │ │     💬 Args: [trove.entireColl, trove.entireDebt, _price]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._liquidate(contract IDefaultPool,uint256,uint256,uint256,struct LatestTroveData,struct TroveManager.LiquidationValues) (NodeID: 15)
  │ │   💬 Args: [_defaultPool, troveId, remainingBoldInStabPool, _price, trove, singleLiquidation]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: TroveManager._getLatestTroveData(uint256,struct LatestTroveData) (NodeID: 16)
  │ │ │   💬 Args: [_troveId, trove]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: TroveManager._getBatchManager(uint256) (NodeID: 17)
  │ │ │ │   💬 Args: [_troveId]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: TroveManager._getLatestBatchData(address,struct LatestBatchData) (NodeID: 18)
  │ │ │ │   💬 Args: [batchAddress, batch]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 19)
  │ │ │ │ │   💬 Args: [batch.lastDebtUpdateTime]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 20)
  │ │ │ │ │   💬 Args: [latestBatchData.weightedRecordedDebt, period]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 21)
  │ │ │ │     💬 Args: [latestBatchData.weightedRecordedBatchManagementFee, period]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: TroveManager._getLatestTroveDataFromBatch(uint256,address,struct LatestTroveData,struct LatestBatchData) (NodeID: 22)
  │ │ │ │   💬 Args: [_troveId, batchAddress, trove, batch]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 23)
  │ │ │ │     💬 Args: [_latestBatchData.lastInterestRateAdjTime, trove.lastInterestRateAdjTime]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 24)
  │ │ │ │   💬 Args: [Troves[_troveId].lastDebtUpdateTime]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 25)
  │ │ │     💬 Args: [trove.weightedRecordedDebt, period]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: TroveManager._getBatchManager(uint256) (NodeID: 26)
  │ │ │   💬 Args: [_troveId]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: TroveManager._getLatestBatchData(address,struct LatestBatchData) (NodeID: 27)
  │ │ │   💬 Args: [batchAddress, batch]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 28)
  │ │ │ │   💬 Args: [batch.lastDebtUpdateTime]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 29)
  │ │ │ │   💬 Args: [latestBatchData.weightedRecordedDebt, period]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 30)
  │ │ │     💬 Args: [latestBatchData.weightedRecordedBatchManagementFee, period]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: TroveManager._movePendingTroveRewardsToActivePool(contract IDefaultPool,uint256,uint256) (NodeID: 31)
  │ │ │   💬 Args: [_defaultPool, trove.redistBoldDebtGain, trove.redistCollGain]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: TroveManager._getCollGasCompensation(uint256) (NodeID: 32)
  │ │ │   💬 Args: [trove.entireColl]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 33)
  │ │ │     💬 Args: [_entireColl / COLL_GAS_COMPENSATION_DIVISOR, COLL_GAS_COMPENSATION_CAP]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: TroveManager._getOffsetAndRedistributionVals(uint256,uint256,uint256,uint256) (NodeID: 34)
  │ │ │   💬 Args: [trove.entireDebt, collToLiquidate, _boldInStabPool, _price]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 35)
  │ │ │ │   💬 Args: [_entireTroveDebt, _boldInStabPool]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: TroveManager._getCollPenaltyAndSurplus(uint256,uint256,uint256,uint256) (NodeID: 36)
  │ │ │ │   💬 Args: [collSPPortion, debtToOffset, LIQUIDATION_PENALTY_SP, _price]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: TroveManager._getCollPenaltyAndSurplus(uint256,uint256,uint256,uint256) (NodeID: 37)
  │ │ │     💬 Args: [collRedistributionPortion + collSurplus, debtToRedistribute, LIQUIDATION_PENALTY_REDISTRIBUTION, _price]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: TroveManager._closeTrove(uint256,struct TroveChange,address,uint256,uint256,enum ITroveManager.Status) (NodeID: 38)
  │ │     💬 Args: [_troveId, troveChange, batchAddress, batch.entireCollWithoutRedistribution, batch.entireDebtWithoutRedistribution, Status.closedByLiquidation]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: TroveManager._requireMoreThanOneTroveInSystem(uint256) (NodeID: 39)
  │ │   │   💬 Args: [TroveIdsArrayLength]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: TroveManager._removeTroveId(uint256,uint256) (NodeID: 40)
  │ │   │   💬 Args: [_troveId, TroveIdsArrayLength]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: TroveManager._removeTroveSharesFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256) (NodeID: 41)
  │ │       💬 Args: [_troveId, _troveChange.collDecrease, _troveChange.debtDecrease, _troveChange, _batchAddress, _newBatchColl, _newBatchDebt]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveManager._addLiquidationValuesToTotals(struct LatestTroveData,struct TroveManager.LiquidationValues,struct TroveManager.LiquidationValues,struct TroveChange) (NodeID: 42)
  │     💬 Args: [trove, singleLiquidation, totals, troveChange]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._redistributeDebtAndColl(contract IActivePool,contract IDefaultPool,uint256,uint256) (NodeID: 43)
  │   💬 Args: [activePoolCached, defaultPoolCached, totals.debtToRedistribute, totals.collToRedistribute]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._updateSystemSnapshots_excludeCollRemainder(contract IActivePool,uint256) (NodeID: 44)
  │   💬 Args: [activePoolCached, totals.collGasCompensation]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TroveManager._sendGasCompensation(contract IActivePool,address,uint256,uint256) (NodeID: 45)
      💬 Args: [activePoolCached, msg.sender, totals.ETHGasCompensation, totals.collGasCompensation]
      👁️  Def: internal
```
