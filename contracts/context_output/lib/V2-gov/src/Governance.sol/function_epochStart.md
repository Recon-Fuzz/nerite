# Function: epochStart()

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `epochStart()`
- **Visibility**: public
- **Source Range**: 10717:120:23

## Implementation

```solidity
/// @inheritdoc IGovernance
function epochStart() public view returns (uint256) {
    return EPOCH_START + ((epoch() - 1) * EPOCH_DURATION);
}
```

## Related Implementations

### epoch()

- **Kind**: internal
- **Source**: 10554:125:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:epoch()`

```solidity
/// @inheritdoc IGovernance
function epoch() public view returns (uint256) {
    return ((block.timestamp - EPOCH_START) / EPOCH_DURATION) + 1;
}
```

## State Variable Reads

- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.epochStart() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Governance.epoch() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@notice Returns the timestamp at which the current epoch started
 @return epochStart Epoch start of the current epoch
