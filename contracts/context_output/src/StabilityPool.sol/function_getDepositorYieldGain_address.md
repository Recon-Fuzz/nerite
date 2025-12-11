# Function: getDepositorYieldGain(address)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `getDepositorYieldGain(address)`
- **Visibility**: public
- **Source Range**: 29122:1117:274

## Implementation

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

## State Variable Reads

- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **depositSnapshots** (`mapping(address => struct StabilityPool.Snapshots)`)
- **epochToScaleToB** (`mapping(uint128 => mapping(uint128 => uint256))`)
- **SCALE_FACTOR** (`uint256`)
- **yieldGainsOwed** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.getDepositorYieldGain(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 1)
      💬 Args: [yieldGain, yieldGainsOwed]
      👁️  Def: internal
```
