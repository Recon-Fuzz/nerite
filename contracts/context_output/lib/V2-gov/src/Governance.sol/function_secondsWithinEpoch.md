# Function: secondsWithinEpoch()

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `secondsWithinEpoch()`
- **Visibility**: public
- **Source Range**: 10875:132:23

## Implementation

```solidity
/// @inheritdoc IGovernance
function secondsWithinEpoch() public view returns (uint256) {
    return (block.timestamp - EPOCH_START) % EPOCH_DURATION;
}
```

## State Variable Reads

- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.secondsWithinEpoch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@notice Returns the number of seconds that have gone by since the current epoch started
 @return secondsWithinEpoch Seconds within the current epoch
