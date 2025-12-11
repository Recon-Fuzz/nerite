# Function: triggerBoldRewards(uint256)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `triggerBoldRewards(uint256)`
- **Visibility**: external
- **Source Range**: 16745:212:274

## Implementation

```solidity
function triggerBoldRewards(uint256 _boldYield) external {
    _requireCallerIsActivePool();
    assert(_boldYield > 0);
    _updateYieldRewardsSum(_boldYield);
}
```

## Related Implementations

### _requireCallerIsActivePool()

- **Kind**: internal
- **Source**: 36640:154:274
- **Link**: `src/StabilityPool.sol:StabilityPool:_requireCallerIsActivePool()`

```solidity
function _requireCallerIsActivePool() internal view {
    require(msg.sender == address(activePool), "StabilityPool: Caller is not ActivePool");
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

## State Variable Reads

- **yieldGainsPending** (`uint256`)
- **totalBoldDeposits** (`uint256`)
- **lastYieldError** (`uint256`)
- **P** (`uint256`)
- **currentEpoch** (`uint128`)
- **currentScale** (`uint128`)
- **epochToScaleToB** (`mapping(uint128 => mapping(uint128 => uint256))`)

## State Variable Writes

- **yieldGainsPending** (`uint256`)
- **yieldGainsOwed** (`uint256`)
- **lastYieldError** (`uint256`)
- **epochToScaleToB** (`mapping(uint128 => mapping(uint128 => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.triggerBoldRewards(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StabilityPool._requireCallerIsActivePool() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StabilityPool._updateYieldRewardsSum(uint256) (NodeID: 2)
      💬 Args: [_boldYield]
      👁️  Def: internal
```
