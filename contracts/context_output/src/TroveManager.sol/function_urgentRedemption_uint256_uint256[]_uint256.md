# Function: urgentRedemption(uint256,uint256[],uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `urgentRedemption(uint256,uint256[],uint256)`
- **Visibility**: external
- **Source Range**: 38431:3165:275

## Implementation

```solidity
function urgentRedemption(uint256 _boldAmount, uint256[] calldata _troveIds, uint256 _minCollateral) external {
    _requireIsShutDown();
    _requireAmountGreaterThanZero(_boldAmount);
    _requireBoldBalanceCoversRedemption(boldToken, msg.sender, _boldAmount);
    IActivePool activePoolCached = activePool;
    TroveChange memory totalsTroveChange;
    (uint256 price, ) = priceFeed.fetchPrice();
    uint256 remainingBold = _boldAmount;
    for (uint256 i = 0; i < _troveIds.length; i++) {
        if (remainingBold == 0) break;
        SingleRedemptionValues memory singleRedemption;
        singleRedemption.troveId = _troveIds[i];
        _getLatestTroveData(singleRedemption.troveId, singleRedemption.trove);
        if ((!_isActiveOrZombie(Troves[singleRedemption.troveId].status)) || (singleRedemption.trove.entireDebt == 0)) {
            continue;
        }
        singleRedemption.batchAddress = _getBatchManager(singleRedemption.troveId);
        if (singleRedemption.batchAddress != address(0)) {
            _updateBatchInterestPriorToRedemption(activePoolCached, singleRedemption.batchAddress);
        }
        _urgentRedeemCollateralFromTrove(defaultPool, remainingBold, price, singleRedemption);
        totalsTroveChange.collDecrease += singleRedemption.collLot;
        totalsTroveChange.debtDecrease += singleRedemption.boldLot;
        totalsTroveChange.appliedRedistBoldDebtGain += singleRedemption.appliedRedistBoldDebtGain;
        totalsTroveChange.newWeightedRecordedDebt += singleRedemption.newWeightedRecordedDebt;
        totalsTroveChange.oldWeightedRecordedDebt += singleRedemption.oldWeightedRecordedDebt;
        remainingBold -= singleRedemption.boldLot;
    }
    if (totalsTroveChange.collDecrease < _minCollateral) {
        revert MinCollNotReached(totalsTroveChange.collDecrease);
    }
    emit Redemption(_boldAmount, totalsTroveChange.debtDecrease, totalsTroveChange.collDecrease, 0, price);
    activePoolCached.mintAggInterestAndAccountForTroveChange(totalsTroveChange, address(0));
    activePoolCached.sendColl(msg.sender, totalsTroveChange.collDecrease);
    boldToken.burn(msg.sender, totalsTroveChange.debtDecrease);
}
```

## Related Implementations

### _requireIsShutDown()

- **Kind**: internal
- **Source**: 54050:128:275
- **Link**: `src/TroveManager.sol:TroveManager:_requireIsShutDown()`

```solidity
function _requireIsShutDown() internal view {
    if (shutdownTime == 0) {
        revert NotShutDown();
    }
}
```

### _requireAmountGreaterThanZero(uint256)

- **Kind**: internal
- **Source**: 54184:148:275
- **Link**: `src/TroveManager.sol:TroveManager:_requireAmountGreaterThanZero(uint256)`

```solidity
function _requireAmountGreaterThanZero(uint256 _amount) internal pure {
    if (_amount == 0) {
        revert ZeroAmount();
    }
}
```

### _requireBoldBalanceCoversRedemption(contract IBoldToken,address,uint256)

- **Kind**: internal
- **Source**: 54338:298:275
- **Link**: `src/TroveManager.sol:TroveManager:_requireBoldBalanceCoversRedemption(contract IBoldToken,address,uint256)`

```solidity
function _requireBoldBalanceCoversRedemption(IBoldToken _boldToken, address _redeemer, uint256 _amount) internal view {
    uint256 boldBalance = _boldToken.balanceOf(_redeemer);
    if (boldBalance < _amount) {
        revert NotEnoughBoldBalance();
    }
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

### _isActiveOrZombie(enum ITroveManager.Status)

- **Kind**: internal
- **Source**: 18476:148:275
- **Link**: `src/TroveManager.sol:TroveManager:_isActiveOrZombie(enum ITroveManager.Status)`

```solidity
function _isActiveOrZombie(Status _status) internal pure returns (bool) {
    return (_status == Status.active) || (_status == Status.zombie);
}
```

### _updateBatchInterestPriorToRedemption(contract IActivePool,address)

- **Kind**: internal
- **Source**: 30247:1105:275
- **Link**: `src/TroveManager.sol:TroveManager:_updateBatchInterestPriorToRedemption(contract IActivePool,address)`

```solidity
function _updateBatchInterestPriorToRedemption(IActivePool _activePool, address _batchAddress) internal {
    LatestBatchData memory batch;
    _getLatestBatchData(_batchAddress, batch);
    batches[_batchAddress].debt = batch.entireDebtWithoutRedistribution;
    batches[_batchAddress].lastDebtUpdateTime = uint64(block.timestamp);
    TroveChange memory batchTroveChange;
    batchTroveChange.oldWeightedRecordedDebt = batch.weightedRecordedDebt;
    batchTroveChange.newWeightedRecordedDebt = batch.entireDebtWithoutRedistribution * batch.annualInterestRate;
    batchTroveChange.batchAccruedManagementFee = batch.accruedManagementFee;
    batchTroveChange.oldWeightedRecordedBatchManagementFee = batch.weightedRecordedBatchManagementFee;
    batchTroveChange.newWeightedRecordedBatchManagementFee = batch.entireDebtWithoutRedistribution * batch.annualManagementFee;
    _activePool.mintAggInterestAndAccountForTroveChange(batchTroveChange, _batchAddress);
}
```

### _urgentRedeemCollateralFromTrove(contract IDefaultPool,uint256,uint256,struct TroveManager.SingleRedemptionValues)

- **Kind**: internal
- **Source**: 36946:1479:275
- **Link**: `src/TroveManager.sol:TroveManager:_urgentRedeemCollateralFromTrove(contract IDefaultPool,uint256,uint256,struct TroveManager.SingleRedemptionValues)`

```solidity
function _urgentRedeemCollateralFromTrove(IDefaultPool _defaultPool, uint256 _maxBoldamount, uint256 _price, SingleRedemptionValues memory _singleRedemption) internal {
    _singleRedemption.boldLot = LiquityMath._min(_maxBoldamount, _singleRedemption.trove.entireDebt);
    _singleRedemption.collLot = (_singleRedemption.boldLot * (DECIMAL_PRECISION + URGENT_REDEMPTION_BONUS)) / _price;
    if (_singleRedemption.collLot > _singleRedemption.trove.entireColl) {
        _singleRedemption.collLot = _singleRedemption.trove.entireColl;
        _singleRedemption.boldLot = (_singleRedemption.trove.entireColl * _price) / (DECIMAL_PRECISION + URGENT_REDEMPTION_BONUS);
    }
    bool isTroveInBatch = _singleRedemption.batchAddress != address(0);
    _applySingleRedemption(_defaultPool, _singleRedemption, isTroveInBatch);
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

### _applySingleRedemption(contract IDefaultPool,struct TroveManager.SingleRedemptionValues,bool)

- **Kind**: internal
- **Source**: 21836:5812:275
- **Link**: `src/TroveManager.sol:TroveManager:_applySingleRedemption(contract IDefaultPool,struct TroveManager.SingleRedemptionValues,bool)`

```solidity
function _applySingleRedemption(IDefaultPool _defaultPool, SingleRedemptionValues memory _singleRedemption, bool _isTroveInBatch) internal returns (uint256) {
    uint256 newDebt = _singleRedemption.trove.entireDebt - _singleRedemption.boldLot;
    uint256 newColl = _singleRedemption.trove.entireColl - _singleRedemption.collLot;
    _singleRedemption.appliedRedistBoldDebtGain = _singleRedemption.trove.redistBoldDebtGain;
    if (_isTroveInBatch) {
        _getLatestBatchData(_singleRedemption.batchAddress, _singleRedemption.batch);
        uint256 newAmountForWeightedDebt = (_singleRedemption.batch.entireDebtWithoutRedistribution + _singleRedemption.trove.redistBoldDebtGain) - _singleRedemption.boldLot;
        _singleRedemption.oldWeightedRecordedDebt = _singleRedemption.batch.weightedRecordedDebt;
        _singleRedemption.newWeightedRecordedDebt = newAmountForWeightedDebt * _singleRedemption.batch.annualInterestRate;
        TroveChange memory troveChange;
        troveChange.debtDecrease = _singleRedemption.boldLot;
        troveChange.collDecrease = _singleRedemption.collLot;
        troveChange.appliedRedistBoldDebtGain = _singleRedemption.trove.redistBoldDebtGain;
        troveChange.appliedRedistCollGain = _singleRedemption.trove.redistCollGain;
        troveChange.oldWeightedRecordedBatchManagementFee = _singleRedemption.batch.weightedRecordedBatchManagementFee;
        troveChange.newWeightedRecordedBatchManagementFee = newAmountForWeightedDebt * _singleRedemption.batch.annualManagementFee;
        activePool.mintBatchManagementFeeAndAccountForChange(troveChange, _singleRedemption.batchAddress);
        Troves[_singleRedemption.troveId].coll = newColl;
        _updateBatchShares(_singleRedemption.troveId, _singleRedemption.batchAddress, troveChange, newDebt, _singleRedemption.batch.entireCollWithoutRedistribution, _singleRedemption.batch.entireDebtWithoutRedistribution, false);
    } else {
        _singleRedemption.oldWeightedRecordedDebt = _singleRedemption.trove.weightedRecordedDebt;
        _singleRedemption.newWeightedRecordedDebt = newDebt * _singleRedemption.trove.annualInterestRate;
        Troves[_singleRedemption.troveId].debt = newDebt;
        Troves[_singleRedemption.troveId].coll = newColl;
        Troves[_singleRedemption.troveId].lastDebtUpdateTime = uint64(block.timestamp);
    }
    _singleRedemption.newStake = _updateStakeAndTotalStakes(_singleRedemption.troveId, newColl);
    _movePendingTroveRewardsToActivePool(_defaultPool, _singleRedemption.trove.redistBoldDebtGain, _singleRedemption.trove.redistCollGain);
    _updateTroveRewardSnapshots(_singleRedemption.troveId);
    if (_isTroveInBatch) {
        emit BatchedTroveUpdated({_troveId: _singleRedemption.troveId, _interestBatchManager: _singleRedemption.batchAddress, _batchDebtShares: Troves[_singleRedemption.troveId].batchDebtShares, _coll: newColl, _stake: _singleRedemption.newStake, _snapshotOfTotalCollRedist: L_coll, _snapshotOfTotalDebtRedist: L_boldDebt});
    } else {
        emit TroveUpdated({_troveId: _singleRedemption.troveId, _debt: newDebt, _coll: newColl, _stake: _singleRedemption.newStake, _annualInterestRate: _singleRedemption.trove.annualInterestRate, _snapshotOfTotalCollRedist: L_coll, _snapshotOfTotalDebtRedist: L_boldDebt});
    }
    emit TroveOperation({_troveId: _singleRedemption.troveId, _operation: Operation.redeemCollateral, _annualInterestRate: _singleRedemption.trove.annualInterestRate, _debtIncreaseFromRedist: _singleRedemption.trove.redistBoldDebtGain, _debtIncreaseFromUpfrontFee: 0, _debtChangeFromOperation: -int256(_singleRedemption.boldLot), _collIncreaseFromRedist: _singleRedemption.trove.redistCollGain, _collChangeFromOperation: -int256(_singleRedemption.collLot)});
    if (_isTroveInBatch) {
        emit BatchUpdated({_interestBatchManager: _singleRedemption.batchAddress, _operation: BatchOperation.troveChange, _debt: batches[_singleRedemption.batchAddress].debt, _coll: batches[_singleRedemption.batchAddress].coll, _annualInterestRate: _singleRedemption.batch.annualInterestRate, _annualManagementFee: _singleRedemption.batch.annualManagementFee, _totalDebtShares: batches[_singleRedemption.batchAddress].totalDebtShares, _debtIncreaseFromUpfrontFee: 0});
    }
    emit RedemptionFeePaidToTrove(_singleRedemption.troveId, _singleRedemption.collFee);
    return newDebt;
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

### _updateStakeAndTotalStakes(uint256,uint256)

- **Kind**: internal
- **Source**: 48221:308:275
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
- **Source**: 48656:715:275
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

- **IPriceFeed::fetchPrice()**
- **IActivePool::mintAggInterestAndAccountForTroveChange(struct TroveChange,address)**
- **IActivePool::sendColl(address,uint256)**
- **IBoldToken::burn(address,uint256)**
- **IBoldToken::balanceOf(address)**
- **IActivePool::mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)**
- **IDefaultPool::decreaseBoldDebt(uint256)**
- **IDefaultPool::sendCollToActivePool(uint256)**

## State Variable Reads

- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **shutdownTime** (`uint256`)
- **L_boldDebt** (`uint256`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)
- **L_coll** (`uint256`)
- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **totalStakes** (`uint256`)
- **totalCollateralSnapshot** (`uint256`)
- **totalStakesSnapshot** (`uint256`)

## State Variable Writes

- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **totalStakes** (`uint256`)
- **rewardSnapshots** (`mapping(uint256 => struct TroveManager.RewardSnapshot)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.urgentRedemption(uint256,uint256[],uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveManager._requireIsShutDown() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._requireAmountGreaterThanZero(uint256) (NodeID: 2)
  │   💬 Args: [_boldAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._requireBoldBalanceCoversRedemption(contract IBoldToken,address,uint256) (NodeID: 3)
  │   💬 Args: [boldToken, msg.sender, _boldAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._getLatestTroveData(uint256,struct LatestTroveData) (NodeID: 4)
  │   💬 Args: [singleRedemption.troveId, singleRedemption.trove]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._getBatchManager(uint256) (NodeID: 5)
  │ │   💬 Args: [_troveId]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._getLatestBatchData(address,struct LatestBatchData) (NodeID: 6)
  │ │   💬 Args: [batchAddress, batch]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 7)
  │ │ │   💬 Args: [batch.lastDebtUpdateTime]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 8)
  │ │ │   💬 Args: [latestBatchData.weightedRecordedDebt, period]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 9)
  │ │     💬 Args: [latestBatchData.weightedRecordedBatchManagementFee, period]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._getLatestTroveDataFromBatch(uint256,address,struct LatestTroveData,struct LatestBatchData) (NodeID: 10)
  │ │   💬 Args: [_troveId, batchAddress, trove, batch]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 11)
  │ │     💬 Args: [_latestBatchData.lastInterestRateAdjTime, trove.lastInterestRateAdjTime]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 12)
  │ │   💬 Args: [Troves[_troveId].lastDebtUpdateTime]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 13)
  │     💬 Args: [trove.weightedRecordedDebt, period]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._isActiveOrZombie(enum ITroveManager.Status) (NodeID: 14)
  │   💬 Args: [Troves[singleRedemption.troveId].status]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._getBatchManager(uint256) (NodeID: 15)
  │   💬 Args: [singleRedemption.troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TroveManager._updateBatchInterestPriorToRedemption(contract IActivePool,address) (NodeID: 16)
  │   💬 Args: [activePoolCached, singleRedemption.batchAddress]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TroveManager._getLatestBatchData(address,struct LatestBatchData) (NodeID: 17)
  │     💬 Args: [_batchAddress, batch]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 18)
  │   │   💬 Args: [batch.lastDebtUpdateTime]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 19)
  │   │   💬 Args: [latestBatchData.weightedRecordedDebt, period]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 20)
  │       💬 Args: [latestBatchData.weightedRecordedBatchManagementFee, period]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TroveManager._urgentRedeemCollateralFromTrove(contract IDefaultPool,uint256,uint256,struct TroveManager.SingleRedemptionValues) (NodeID: 21)
      💬 Args: [defaultPool, remainingBold, price, singleRedemption]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 22)
    │   💬 Args: [_maxBoldamount, _singleRedemption.trove.entireDebt]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: TroveManager._applySingleRedemption(contract IDefaultPool,struct TroveManager.SingleRedemptionValues,bool) (NodeID: 23)
        💬 Args: [_defaultPool, _singleRedemption, isTroveInBatch]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: TroveManager._getLatestBatchData(address,struct LatestBatchData) (NodeID: 24)
      │   💬 Args: [_singleRedemption.batchAddress, _singleRedemption.batch]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 25)
      │ │   💬 Args: [batch.lastDebtUpdateTime]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 26)
      │ │   💬 Args: [latestBatchData.weightedRecordedDebt, period]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 27)
      │     💬 Args: [latestBatchData.weightedRecordedBatchManagementFee, period]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: TroveManager._updateBatchShares(uint256,address,struct TroveChange,uint256,uint256,uint256,bool) (NodeID: 28)
      │   💬 Args: [_singleRedemption.troveId, _singleRedemption.batchAddress, troveChange, newDebt, _singleRedemption.batch.entireCollWithoutRedistribution, _singleRedemption.batch.entireDebtWithoutRedistribution, false]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: TroveManager._requireBelowMaxSharesRatio(uint256,uint256,bool) (NodeID: 29)
      │     💬 Args: [currentBatchDebtShares, _batchDebt, _checkBatchSharesRatio]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: TroveManager._updateStakeAndTotalStakes(uint256,uint256) (NodeID: 30)
      │   💬 Args: [_singleRedemption.troveId, newColl]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: TroveManager._computeNewStake(uint256) (NodeID: 31)
      │     💬 Args: [_coll]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: TroveManager._movePendingTroveRewardsToActivePool(contract IDefaultPool,uint256,uint256) (NodeID: 32)
      │   💬 Args: [_defaultPool, _singleRedemption.trove.redistBoldDebtGain, _singleRedemption.trove.redistCollGain]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: TroveManager._updateTroveRewardSnapshots(uint256) (NodeID: 33)
          💬 Args: [_singleRedemption.troveId]
          👁️  Def: internal
```
