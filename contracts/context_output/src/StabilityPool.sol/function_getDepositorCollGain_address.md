# Function: getDepositorCollGain(address)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `getDepositorCollGain(address)`
- **Visibility**: public
- **Source Range**: 28005:1111:123

## Implementation

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

## Related Implementations

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:64
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

## State Variable Reads

- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **depositSnapshots** (`mapping(address => struct StabilityPool.Snapshots)`)
- **epochToScaleToS** (`mapping(uint128 => mapping(uint128 => uint256))`)
- **SCALE_FACTOR** (`uint256`)
- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.getDepositorCollGain(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 1)
      💬 Args: [collGain, collBalance]
      👁️  Def: internal
```
