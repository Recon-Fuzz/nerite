# Function: offset(uint256,uint256)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `offset(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 19209:414:123

## Implementation

```solidity
function offset(uint256 _debtToOffset, uint256 _collToAdd) override external {
    _requireCallerIsTroveManager();
    uint256 totalBold = totalBoldDeposits;
    if ((totalBold == 0) || (_debtToOffset == 0)) return;
    _updateCollRewardSumAndProduct(_collToAdd, _debtToOffset, totalBold);
    _moveOffsetCollAndDebt(_collToAdd, _debtToOffset);
}
```

## Related Implementations

### _requireCallerIsTroveManager()

- **Kind**: internal
- **Source**: 36800:160:123
- **Link**: `src/StabilityPool.sol:StabilityPool:_requireCallerIsTroveManager()`

```solidity
function _requireCallerIsTroveManager() internal view {
    require(msg.sender == address(troveManager), "StabilityPool: Caller is not TroveManager");
}
```

### _updateCollRewardSumAndProduct(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 21791:4020:123
- **Link**: `src/StabilityPool.sol:StabilityPool:_updateCollRewardSumAndProduct(uint256,uint256,uint256)`

```solidity
function _updateCollRewardSumAndProduct(uint256 _collToAdd, uint256 _debtToOffset, uint256 _totalBoldDeposits) internal {
    (uint256 collGainPerUnitStaked, uint256 boldLossPerUnitStaked, uint256 newLastBoldLossErrorOffset) = _computeCollRewardsPerUnitStaked(_collToAdd, _debtToOffset, _totalBoldDeposits);
    uint256 currentP = P;
    uint256 newP;
    assert(boldLossPerUnitStaked <= DECIMAL_PRECISION);
    uint256 newProductFactor = uint256(DECIMAL_PRECISION) - boldLossPerUnitStaked;
    uint128 currentScaleCached = currentScale;
    uint128 currentEpochCached = currentEpoch;
    uint256 currentS = epochToScaleToS[currentEpochCached][currentScaleCached];
    uint256 marginalCollGain = collGainPerUnitStaked * (currentP - 1);
    uint256 newS = currentS + marginalCollGain;
    epochToScaleToS[currentEpochCached][currentScaleCached] = newS;
    emit S_Updated(newS, currentEpochCached, currentScaleCached);
    if (newProductFactor == 0) {
        currentEpoch = currentEpochCached + 1;
        emit EpochUpdated(currentEpoch);
        currentScale = 0;
        emit ScaleUpdated(currentScale);
        newP = DECIMAL_PRECISION;
    } else {
        uint256 lastBoldLossErrorByP_Offset_Cached = lastBoldLossErrorByP_Offset;
        uint256 lastBoldLossError_TotalDeposits_Cached = lastBoldLossError_TotalDeposits;
        newP = _getNewPByScale(currentP, newProductFactor, lastBoldLossErrorByP_Offset_Cached, lastBoldLossError_TotalDeposits_Cached, 1);
        if (newP < SCALE_FACTOR) {
            newP = _getNewPByScale(currentP, newProductFactor, lastBoldLossErrorByP_Offset_Cached, lastBoldLossError_TotalDeposits_Cached, SCALE_FACTOR);
            currentScale = currentScaleCached + 1;
            if (newP < SCALE_FACTOR) {
                newP = _getNewPByScale(currentP, newProductFactor, lastBoldLossErrorByP_Offset_Cached, lastBoldLossError_TotalDeposits_Cached, SCALE_FACTOR * SCALE_FACTOR);
                currentScale = currentScaleCached + 2;
            }
        }
        emit ScaleUpdated(currentScale);
    }
    lastBoldLossErrorByP_Offset = currentP * newLastBoldLossErrorOffset;
    lastBoldLossError_TotalDeposits = _totalBoldDeposits;
    assert(newP > 0);
    P = newP;
    emit P_Updated(newP);
}
```

### _computeCollRewardsPerUnitStaked(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 19669:2056:123
- **Link**: `src/StabilityPool.sol:StabilityPool:_computeCollRewardsPerUnitStaked(uint256,uint256,uint256)`

```solidity
function _computeCollRewardsPerUnitStaked(uint256 _collToAdd, uint256 _debtToOffset, uint256 _totalBoldDeposits) internal returns (uint256 collGainPerUnitStaked, uint256 boldLossPerUnitStaked, uint256 newLastBoldLossErrorOffset) {
    uint256 collNumerator = (_collToAdd * DECIMAL_PRECISION) + lastCollError_Offset;
    assert(_debtToOffset <= _totalBoldDeposits);
    if (_debtToOffset == _totalBoldDeposits) {
        boldLossPerUnitStaked = DECIMAL_PRECISION;
        newLastBoldLossErrorOffset = 0;
    } else {
        uint256 boldLossNumerator = _debtToOffset * DECIMAL_PRECISION;
        boldLossPerUnitStaked = (boldLossNumerator / _totalBoldDeposits) + 1;
        newLastBoldLossErrorOffset = (boldLossPerUnitStaked * _totalBoldDeposits) - boldLossNumerator;
    }
    collGainPerUnitStaked = collNumerator / _totalBoldDeposits;
    lastCollError_Offset = collNumerator - (collGainPerUnitStaked * _totalBoldDeposits);
    return (collGainPerUnitStaked, boldLossPerUnitStaked, newLastBoldLossErrorOffset);
}
```

### _getNewPByScale(uint256,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 25817:586:123
- **Link**: `src/StabilityPool.sol:StabilityPool:_getNewPByScale(uint256,uint256,uint256,uint256,uint256)`

```solidity
function _getNewPByScale(uint256 _currentP, uint256 _newProductFactor, uint256 _lastBoldLossErrorByP_Offset, uint256 _lastBoldLossError_TotalDeposits, uint256 _scale) internal pure returns (uint256) {
    uint256 errorFactor;
    if (_lastBoldLossErrorByP_Offset > 0) {
        errorFactor = (((_lastBoldLossErrorByP_Offset * _newProductFactor) * _scale) / _lastBoldLossError_TotalDeposits) / DECIMAL_PRECISION;
    }
    return (((_currentP * _newProductFactor) * _scale) + errorFactor) / DECIMAL_PRECISION;
}
```

### _moveOffsetCollAndDebt(uint256,uint256)

- **Kind**: internal
- **Source**: 26409:635:123
- **Link**: `src/StabilityPool.sol:StabilityPool:_moveOffsetCollAndDebt(uint256,uint256)`

```solidity
function _moveOffsetCollAndDebt(uint256 _collToAdd, uint256 _debtToOffset) internal {
    _updateTotalBoldDeposits(0, _debtToOffset);
    boldToken.burn(address(this), _debtToOffset);
    uint256 newCollBalance = collBalance + _collToAdd;
    collBalance = newCollBalance;
    activePool.sendColl(address(this), _collToAdd);
    emit StabilityPoolCollBalanceUpdated(newCollBalance);
}
```

### _updateTotalBoldDeposits(uint256,uint256)

- **Kind**: internal
- **Source**: 27050:384:123
- **Link**: `src/StabilityPool.sol:StabilityPool:_updateTotalBoldDeposits(uint256,uint256)`

```solidity
function _updateTotalBoldDeposits(uint256 _depositIncrease, uint256 _depositDecrease) internal {
    if ((_depositIncrease == 0) && (_depositDecrease == 0)) return;
    uint256 newTotalBoldDeposits = (totalBoldDeposits + _depositIncrease) - _depositDecrease;
    totalBoldDeposits = newTotalBoldDeposits;
    emit StabilityPoolBoldBalanceUpdated(newTotalBoldDeposits);
}
```

## External Calls

- **IBoldToken::burn(address,uint256)**
- **IActivePool::sendColl(address,uint256)**

## State Variable Reads

- **totalBoldDeposits** (`uint256`)
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **P** (`uint256`)
- **currentScale** (`uint128`)
- **currentEpoch** (`uint128`)
- **epochToScaleToS** (`mapping(uint128 => mapping(uint128 => uint256))`)
- **lastBoldLossErrorByP_Offset** (`uint256`)
- **lastBoldLossError_TotalDeposits** (`uint256`)
- **SCALE_FACTOR** (`uint256`)
- **lastCollError_Offset** (`uint256`)
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **collBalance** (`uint256`)

## State Variable Writes

- **epochToScaleToS** (`mapping(uint128 => mapping(uint128 => uint256))`)
- **currentEpoch** (`uint128`)
- **currentScale** (`uint128`)
- **lastBoldLossErrorByP_Offset** (`uint256`)
- **lastBoldLossError_TotalDeposits** (`uint256`)
- **P** (`uint256`)
- **lastCollError_Offset** (`uint256`)
- **collBalance** (`uint256`)
- **totalBoldDeposits** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.offset(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StabilityPool._requireCallerIsTroveManager() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._updateCollRewardSumAndProduct(uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [_collToAdd, _debtToOffset, totalBold]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StabilityPool._computeCollRewardsPerUnitStaked(uint256,uint256,uint256) (NodeID: 3)
  │ │   💬 Args: [_collToAdd, _debtToOffset, _totalBoldDeposits]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StabilityPool._getNewPByScale(uint256,uint256,uint256,uint256,uint256) (NodeID: 4)
  │ │   💬 Args: [currentP, newProductFactor, lastBoldLossErrorByP_Offset_Cached, lastBoldLossError_TotalDeposits_Cached, 1]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StabilityPool._getNewPByScale(uint256,uint256,uint256,uint256,uint256) (NodeID: 5)
  │ │   💬 Args: [currentP, newProductFactor, lastBoldLossErrorByP_Offset_Cached, lastBoldLossError_TotalDeposits_Cached, SCALE_FACTOR]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StabilityPool._getNewPByScale(uint256,uint256,uint256,uint256,uint256) (NodeID: 6)
  │     💬 Args: [currentP, newProductFactor, lastBoldLossErrorByP_Offset_Cached, lastBoldLossError_TotalDeposits_Cached, SCALE_FACTOR * SCALE_FACTOR]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StabilityPool._moveOffsetCollAndDebt(uint256,uint256) (NodeID: 7)
      💬 Args: [_collToAdd, _debtToOffset]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StabilityPool._updateTotalBoldDeposits(uint256,uint256) (NodeID: 8)
        💬 Args: [0, _debtToOffset]
        👁️  Def: internal
```
