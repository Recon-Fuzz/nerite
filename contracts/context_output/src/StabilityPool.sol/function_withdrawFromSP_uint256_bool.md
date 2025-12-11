# Function: withdrawFromSP(uint256,bool)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `withdrawFromSP(uint256,bool)`
- **Visibility**: external
- **Source Range**: 13936:1708:274

## Implementation

```solidity
function withdrawFromSP(uint256 _amount, bool _doClaim) override external {
    uint256 initialDeposit = deposits[msg.sender].initialValue;
    _requireUserHasDeposit(initialDeposit);
    activePool.mintAggInterest();
    uint256 currentCollGain = getDepositorCollGain(msg.sender);
    uint256 currentYieldGain = getDepositorYieldGain(msg.sender);
    uint256 compoundedBoldDeposit = getCompoundedBoldDeposit(msg.sender);
    uint256 boldToWithdraw = LiquityMath._min(_amount, compoundedBoldDeposit);
    (uint256 keptYieldGain, uint256 yieldGainToSend) = _getYieldToKeepOrSend(currentYieldGain, _doClaim);
    uint256 newDeposit = (compoundedBoldDeposit - boldToWithdraw) + keptYieldGain;
    (uint256 newStashedColl, uint256 collToSend) = _getNewStashedCollAndCollToSend(msg.sender, currentCollGain, _doClaim);
    emit DepositOperation(msg.sender, Operation.withdrawFromSP, initialDeposit - compoundedBoldDeposit, -int256(boldToWithdraw), currentYieldGain, yieldGainToSend, currentCollGain, collToSend);
    _updateDepositAndSnapshots(msg.sender, newDeposit, newStashedColl);
    _decreaseYieldGainsOwed(currentYieldGain);
    _updateTotalBoldDeposits(keptYieldGain, boldToWithdraw);
    _sendBoldtoDepositor(msg.sender, boldToWithdraw + yieldGainToSend);
    _sendCollGainToDepositor(collToSend);
    _updateYieldRewardsSum(0);
}
```

## Related Implementations

### _requireUserHasDeposit(uint256)

- **Kind**: internal
- **Source**: 36966:168:274
- **Link**: `src/StabilityPool.sol:StabilityPool:_requireUserHasDeposit(uint256)`

```solidity
function _requireUserHasDeposit(uint256 _initialDeposit) internal pure {
    require(_initialDeposit > 0, "StabilityPool: User must have a non-zero deposit");
}
```

### getDepositorCollGain(address)

- **Kind**: internal
- **Source**: 28005:1111:274
- **Link**: `src/StabilityPool.sol:StabilityPool:getDepositorCollGain(address)`

```solidity
function getDepositorCollGain(address _depositor) override public view returns (uint256) {
    uint256 initialDeposit = deposits[_depositor].initialValue;
    if (initialDeposit == 0) return 0;
    Snapshots memory snapshots = depositSnapshots[_depositor];
    uint128 epochSnapshot = snapshots.epoch;
    uint128 scaleSnapshot = snapshots.scale;
    uint256 S_Snapshot = snapshots.S;
    uint256 P_Snapshot = snapshots.P;
    uint256 firstPortion = epochToScaleToS[epochSnapshot][scaleSnapshot] - S_Snapshot;
    uint256 secondPortion = epochToScaleToS[epochSnapshot][scaleSnapshot + 1] / SCALE_FACTOR;
    uint256 collGain = ((initialDeposit * (firstPortion + secondPortion)) / P_Snapshot) / DECIMAL_PRECISION;
    return LiquityMath._min(collGain, collBalance);
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

### getDepositorYieldGain(address)

- **Kind**: internal
- **Source**: 29122:1117:274
- **Link**: `src/StabilityPool.sol:StabilityPool:getDepositorYieldGain(address)`

```solidity
function getDepositorYieldGain(address _depositor) override public view returns (uint256) {
    uint256 initialDeposit = deposits[_depositor].initialValue;
    if (initialDeposit == 0) return 0;
    Snapshots memory snapshots = depositSnapshots[_depositor];
    uint128 epochSnapshot = snapshots.epoch;
    uint128 scaleSnapshot = snapshots.scale;
    uint256 B_Snapshot = snapshots.B;
    uint256 P_Snapshot = snapshots.P;
    uint256 firstPortion = epochToScaleToB[epochSnapshot][scaleSnapshot] - B_Snapshot;
    uint256 secondPortion = epochToScaleToB[epochSnapshot][scaleSnapshot + 1] / SCALE_FACTOR;
    uint256 yieldGain = ((initialDeposit * (firstPortion + secondPortion)) / P_Snapshot) / DECIMAL_PRECISION;
    return LiquityMath._min(yieldGain, yieldGainsOwed);
}
```

### getCompoundedBoldDeposit(address)

- **Kind**: internal
- **Source**: 32042:411:274
- **Link**: `src/StabilityPool.sol:StabilityPool:getCompoundedBoldDeposit(address)`

```solidity
function getCompoundedBoldDeposit(address _depositor) override public view returns (uint256) {
    uint256 initialDeposit = deposits[_depositor].initialValue;
    if (initialDeposit == 0) return 0;
    Snapshots memory snapshots = depositSnapshots[_depositor];
    uint256 compoundedDeposit = _getCompoundedStakeFromSnapshots(initialDeposit, snapshots);
    return compoundedDeposit;
}
```

### _getCompoundedStakeFromSnapshots(uint256,struct StabilityPool.Snapshots)

- **Kind**: internal
- **Source**: 32557:1927:274
- **Link**: `src/StabilityPool.sol:StabilityPool:_getCompoundedStakeFromSnapshots(uint256,struct StabilityPool.Snapshots)`

```solidity
function _getCompoundedStakeFromSnapshots(uint256 initialStake, Snapshots memory snapshots) internal view returns (uint256) {
    uint256 snapshot_P = snapshots.P;
    uint128 scaleSnapshot = snapshots.scale;
    uint128 epochSnapshot = snapshots.epoch;
    if (epochSnapshot < currentEpoch) return 0;
    uint256 compoundedStake;
    uint128 scaleDiff = currentScale - scaleSnapshot;
    uint256 cachedP = P;
    uint256 currentPToUse = (cachedP != snapshot_P) ? (cachedP - 1) : cachedP;
    if (scaleDiff == 0) {
        compoundedStake = (initialStake * currentPToUse) / snapshot_P;
    } else if (scaleDiff == 1) {
        compoundedStake = ((initialStake * currentPToUse) / snapshot_P) / SCALE_FACTOR;
    } else {
        compoundedStake = 0;
    }
    if (compoundedStake < (initialStake / 1e9)) return 0;
    return compoundedStake;
}
```

### _getYieldToKeepOrSend(uint256,bool)

- **Kind**: internal
- **Source**: 13153:423:274
- **Link**: `src/StabilityPool.sol:StabilityPool:_getYieldToKeepOrSend(uint256,bool)`

```solidity
function _getYieldToKeepOrSend(uint256 _currentYieldGain, bool _doClaim) internal pure returns (uint256, uint256) {
    uint256 yieldToKeep;
    uint256 yieldToSend;
    if (_doClaim) {
        yieldToKeep = 0;
        yieldToSend = _currentYieldGain;
    } else {
        yieldToKeep = _currentYieldGain;
        yieldToSend = 0;
    }
    return (yieldToKeep, yieldToSend);
}
```

### _getNewStashedCollAndCollToSend(address,uint256,bool)

- **Kind**: internal
- **Source**: 15650:457:274
- **Link**: `src/StabilityPool.sol:StabilityPool:_getNewStashedCollAndCollToSend(address,uint256,bool)`

```solidity
function _getNewStashedCollAndCollToSend(address _depositor, uint256 _currentCollGain, bool _doClaim) internal view returns (uint256 newStashedColl, uint256 collToSend) {
    if (_doClaim) {
        newStashedColl = 0;
        collToSend = stashedColl[_depositor] + _currentCollGain;
    } else {
        newStashedColl = stashedColl[_depositor] + _currentCollGain;
        collToSend = 0;
    }
}
```

### _updateDepositAndSnapshots(address,uint256,uint256)

- **Kind**: internal
- **Source**: 35197:1401:274
- **Link**: `src/StabilityPool.sol:StabilityPool:_updateDepositAndSnapshots(address,uint256,uint256)`

```solidity
function _updateDepositAndSnapshots(address _depositor, uint256 _newDeposit, uint256 _newStashedColl) internal {
    deposits[_depositor].initialValue = _newDeposit;
    stashedColl[_depositor] = _newStashedColl;
    if (_newDeposit == 0) {
        delete depositSnapshots[_depositor];
        emit DepositUpdated(_depositor, 0, _newStashedColl, 0, 0, 0, 0, 0);
        return;
    }
    uint128 currentScaleCached = currentScale;
    uint128 currentEpochCached = currentEpoch;
    uint256 currentP = P;
    uint256 currentS = epochToScaleToS[currentEpochCached][currentScaleCached];
    uint256 currentB = epochToScaleToB[currentEpochCached][currentScaleCached];
    depositSnapshots[_depositor].P = currentP;
    depositSnapshots[_depositor].S = currentS;
    depositSnapshots[_depositor].B = currentB;
    depositSnapshots[_depositor].scale = currentScaleCached;
    depositSnapshots[_depositor].epoch = currentEpochCached;
    emit DepositUpdated(_depositor, _newDeposit, _newStashedColl, currentP, currentS, currentB, currentScaleCached, currentEpochCached);
}
```

### _decreaseYieldGainsOwed(uint256)

- **Kind**: internal
- **Source**: 27440:206:274
- **Link**: `src/StabilityPool.sol:StabilityPool:_decreaseYieldGainsOwed(uint256)`

```solidity
function _decreaseYieldGainsOwed(uint256 _amount) internal {
    if (_amount == 0) return;
    uint256 newYieldGainsOwed = yieldGainsOwed - _amount;
    yieldGainsOwed = newYieldGainsOwed;
}
```

### _updateTotalBoldDeposits(uint256,uint256)

- **Kind**: internal
- **Source**: 27050:384:274
- **Link**: `src/StabilityPool.sol:StabilityPool:_updateTotalBoldDeposits(uint256,uint256)`

```solidity
function _updateTotalBoldDeposits(uint256 _depositIncrease, uint256 _depositDecrease) internal {
    if ((_depositIncrease == 0) && (_depositDecrease == 0)) return;
    uint256 newTotalBoldDeposits = (totalBoldDeposits + _depositIncrease) - _depositDecrease;
    totalBoldDeposits = newTotalBoldDeposits;
    emit StabilityPoolBoldBalanceUpdated(newTotalBoldDeposits);
}
```

### _sendBoldtoDepositor(address,uint256)

- **Kind**: internal
- **Source**: 34939:199:274
- **Link**: `src/StabilityPool.sol:StabilityPool:_sendBoldtoDepositor(address,uint256)`

```solidity
function _sendBoldtoDepositor(address _depositor, uint256 _boldToSend) internal {
    if (_boldToSend == 0) return;
    boldToken.returnFromPool(address(this), _depositor, _boldToSend);
}
```

### _sendCollGainToDepositor(uint256)

- **Kind**: internal
- **Source**: 34555:327:274
- **Link**: `src/StabilityPool.sol:StabilityPool:_sendCollGainToDepositor(uint256)`

```solidity
function _sendCollGainToDepositor(uint256 _collAmount) internal {
    if (_collAmount == 0) return;
    uint256 newCollBalance = collBalance - _collAmount;
    collBalance = newCollBalance;
    emit StabilityPoolCollBalanceUpdated(newCollBalance);
    collToken.safeTransfer(msg.sender, _collAmount);
}
```

### _updateYieldRewardsSum(uint256)

- **Kind**: internal
- **Source**: 16963:1935:274
- **Link**: `src/StabilityPool.sol:StabilityPool:_updateYieldRewardsSum(uint256)`

```solidity
function _updateYieldRewardsSum(uint256 _newYield) internal {
    uint256 accumulatedYieldGains = yieldGainsPending + _newYield;
    if (accumulatedYieldGains == 0) return;
    uint256 totalBoldDepositsCached = totalBoldDeposits;
    if (totalBoldDepositsCached < DECIMAL_PRECISION) {
        yieldGainsPending = accumulatedYieldGains;
        return;
    }
    yieldGainsOwed += accumulatedYieldGains;
    yieldGainsPending = 0;
    uint256 yieldNumerator = (accumulatedYieldGains * DECIMAL_PRECISION) + lastYieldError;
    uint256 yieldPerUnitStaked = yieldNumerator / totalBoldDepositsCached;
    lastYieldError = yieldNumerator - (yieldPerUnitStaked * totalBoldDepositsCached);
    uint256 marginalYieldGain = yieldPerUnitStaked * (P - 1);
    epochToScaleToB[currentEpoch][currentScale] = epochToScaleToB[currentEpoch][currentScale] + marginalYieldGain;
    emit B_Updated(epochToScaleToB[currentEpoch][currentScale], currentEpoch, currentScale);
}
```

## External Calls

- **IActivePool::mintAggInterest()**
- **IBoldToken::returnFromPool(address,address,uint256)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **depositSnapshots** (`mapping(address => struct StabilityPool.Snapshots)`)
- **epochToScaleToS** (`mapping(uint128 => mapping(uint128 => uint256))`)
- **SCALE_FACTOR** (`uint256`)
- **collBalance** (`uint256`)
- **epochToScaleToB** (`mapping(uint128 => mapping(uint128 => uint256))`)
- **yieldGainsOwed** (`uint256`)
- **currentEpoch** (`uint128`)
- **currentScale** (`uint128`)
- **P** (`uint256`)
- **stashedColl** (`mapping(address => uint256)`)
- **totalBoldDeposits** (`uint256`)
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **yieldGainsPending** (`uint256`)
- **lastYieldError** (`uint256`)

## State Variable Writes

- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **stashedColl** (`mapping(address => uint256)`)
- **depositSnapshots** (`mapping(address => struct StabilityPool.Snapshots)`)
- **yieldGainsOwed** (`uint256`)
- **totalBoldDeposits** (`uint256`)
- **collBalance** (`uint256`)
- **yieldGainsPending** (`uint256`)
- **lastYieldError** (`uint256`)
- **epochToScaleToB** (`mapping(uint128 => mapping(uint128 => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.withdrawFromSP(uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StabilityPool._requireUserHasDeposit(uint256) (NodeID: 1)
  │   💬 Args: [initialDeposit]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool.getDepositorCollGain(address) (NodeID: 2)
  │   💬 Args: [msg.sender]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 3)
  │     💬 Args: [collGain, collBalance]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool.getDepositorYieldGain(address) (NodeID: 4)
  │   💬 Args: [msg.sender]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 5)
  │     💬 Args: [yieldGain, yieldGainsOwed]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool.getCompoundedBoldDeposit(address) (NodeID: 6)
  │   💬 Args: [msg.sender]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StabilityPool._getCompoundedStakeFromSnapshots(uint256,struct StabilityPool.Snapshots) (NodeID: 7)
  │     💬 Args: [initialDeposit, snapshots]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 8)
  │   💬 Args: [_amount, compoundedBoldDeposit]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._getYieldToKeepOrSend(uint256,bool) (NodeID: 9)
  │   💬 Args: [currentYieldGain, _doClaim]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._getNewStashedCollAndCollToSend(address,uint256,bool) (NodeID: 10)
  │   💬 Args: [msg.sender, currentCollGain, _doClaim]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._updateDepositAndSnapshots(address,uint256,uint256) (NodeID: 11)
  │   💬 Args: [msg.sender, newDeposit, newStashedColl]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._decreaseYieldGainsOwed(uint256) (NodeID: 12)
  │   💬 Args: [currentYieldGain]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._updateTotalBoldDeposits(uint256,uint256) (NodeID: 13)
  │   💬 Args: [keptYieldGain, boldToWithdraw]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._sendBoldtoDepositor(address,uint256) (NodeID: 14)
  │   💬 Args: [msg.sender, boldToWithdraw + yieldGainToSend]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StabilityPool._sendCollGainToDepositor(uint256) (NodeID: 15)
  │   💬 Args: [collToSend]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StabilityPool._updateYieldRewardsSum(uint256) (NodeID: 16)
      💬 Args: [0]
      👁️  Def: internal
```
