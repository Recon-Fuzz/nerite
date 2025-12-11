# Function: getDepositorYieldGainWithPending(address)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `getDepositorYieldGainWithPending(address)`
- **Visibility**: external
- **Source Range**: 30245:1552:274

## Implementation

```solidity
function getDepositorYieldGainWithPending(address _depositor) override external view returns (uint256) {
    uint256 initialDeposit = deposits[_depositor].initialValue;
    if (initialDeposit == 0) return 0;
    Snapshots memory snapshots = depositSnapshots[_depositor];
    uint256 pendingSPYield = activePool.calcPendingSPYield() + yieldGainsPending;
    uint256 newYieldGainsOwed = yieldGainsOwed + ((totalBoldDeposits >= DECIMAL_PRECISION) ? pendingSPYield : 0);
    uint256 firstPortionPending;
    uint256 secondPortionPending;
    if (((pendingSPYield > 0) && (snapshots.epoch == currentEpoch)) && (totalBoldDeposits >= DECIMAL_PRECISION)) {
        uint256 yieldNumerator = (pendingSPYield * DECIMAL_PRECISION) + lastYieldError;
        uint256 yieldPerUnitStaked = yieldNumerator / totalBoldDeposits;
        uint256 marginalYieldGain = yieldPerUnitStaked * (P - 1);
        if (currentScale == snapshots.scale) firstPortionPending = marginalYieldGain; else if (currentScale == (snapshots.scale + 1)) secondPortionPending = marginalYieldGain;
    }
    uint256 firstPortion = (epochToScaleToB[snapshots.epoch][snapshots.scale] + firstPortionPending) - snapshots.B;
    uint256 secondPortion = (epochToScaleToB[snapshots.epoch][snapshots.scale + 1] + secondPortionPending) / SCALE_FACTOR;
    uint256 yieldGain = ((initialDeposit * (firstPortion + secondPortion)) / snapshots.P) / DECIMAL_PRECISION;
    return LiquityMath._min(yieldGain, newYieldGainsOwed);
}
```

## Related Implementations

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:215
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

## External Calls

- **IActivePool::calcPendingSPYield()**

## State Variable Reads

- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **depositSnapshots** (`mapping(address => struct StabilityPool.Snapshots)`)
- **yieldGainsPending** (`uint256`)
- **yieldGainsOwed** (`uint256`)
- **totalBoldDeposits** (`uint256`)
- **currentEpoch** (`uint128`)
- **lastYieldError** (`uint256`)
- **P** (`uint256`)
- **currentScale** (`uint128`)
- **epochToScaleToB** (`mapping(uint128 => mapping(uint128 => uint256))`)
- **SCALE_FACTOR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.getDepositorYieldGainWithPending(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 1)
      💬 Args: [yieldGain, newYieldGainsOwed]
      👁️  Def: internal
```
