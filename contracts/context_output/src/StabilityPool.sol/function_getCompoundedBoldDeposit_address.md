# Function: getCompoundedBoldDeposit(address)

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `getCompoundedBoldDeposit(address)`
- **Visibility**: public
- **Source Range**: 32042:411:274

## Implementation

```solidity
function getCompoundedBoldDeposit(address _depositor) override public view returns (uint256) {
    uint256 initialDeposit = deposits[_depositor].initialValue;
    if (initialDeposit == 0) return 0;
    Snapshots memory snapshots = depositSnapshots[_depositor];
    uint256 compoundedDeposit = _getCompoundedStakeFromSnapshots(initialDeposit, snapshots);
    return compoundedDeposit;
}
```

## Related Implementations

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

## State Variable Reads

- **deposits** (`mapping(address => struct StabilityPool.Deposit)`)
- **depositSnapshots** (`mapping(address => struct StabilityPool.Snapshots)`)
- **currentEpoch** (`uint128`)
- **currentScale** (`uint128`)
- **P** (`uint256`)
- **SCALE_FACTOR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.getCompoundedBoldDeposit(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StabilityPool._getCompoundedStakeFromSnapshots(uint256,struct StabilityPool.Snapshots) (NodeID: 1)
      💬 Args: [initialDeposit, snapshots]
      👁️  Def: internal
```
