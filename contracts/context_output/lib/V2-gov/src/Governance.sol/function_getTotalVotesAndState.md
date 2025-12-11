# Function: getTotalVotesAndState()

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `getTotalVotesAndState()`
- **Visibility**: public
- **Source Range**: 13047:518:23

## Implementation

```solidity
/// @inheritdoc IGovernance
function getTotalVotesAndState() public view returns (VoteSnapshot memory snapshot, GlobalState memory state, bool shouldUpdate) {
    uint256 currentEpoch = epoch();
    snapshot = votesSnapshot;
    state = globalState;
    if (snapshot.forEpoch < (currentEpoch - 1)) {
        shouldUpdate = true;
        snapshot.votes = lqtyToVotes(state.countedVoteLQTY, epochStart(), state.countedVoteOffset);
        snapshot.forEpoch = currentEpoch - 1;
    }
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

### lqtyToVotes(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 11045:179:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:lqtyToVotes(uint256,uint256,uint256)`

```solidity
/// @inheritdoc IGovernance
function lqtyToVotes(uint256 _lqtyAmount, uint256 _timestamp, uint256 _offset) public pure returns (uint256) {
    return _lqtyToVotes(_lqtyAmount, _timestamp, _offset);
}
```

### epochStart()

- **Kind**: internal
- **Source**: 10717:120:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:epochStart()`

```solidity
/// @inheritdoc IGovernance
function epochStart() public view returns (uint256) {
    return EPOCH_START + ((epoch() - 1) * EPOCH_DURATION);
}
```

### _lqtyToVotes(uint256,uint256,uint256)

- **Kind**: free-function
- **Source**: 58:199:41
- **Link**: `lib/V2-gov/src/utils/VotingPower.sol:_lqtyToVotes(uint256,uint256,uint256)`

```solidity
function _lqtyToVotes(uint256 _lqtyAmount, uint256 _timestamp, uint256 _offset) pure returns (uint256) {
    uint256 prod = _lqtyAmount * _timestamp;
    return (prod > _offset) ? (prod - _offset) : 0;
}
```

## State Variable Reads

- **votesSnapshot** (`struct IGovernance.VoteSnapshot`)
- **globalState** (`struct IGovernance.GlobalState`)
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.getTotalVotesAndState() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Governance.epoch() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 2)
      💬 Args: [state.countedVoteLQTY, epochStart(), state.countedVoteOffset]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: Governance.epochStart() (NodeID: 4)
    │   💬 Args: [no args]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: Governance.epoch() (NodeID: 5)
    │     💬 Args: [no args]
    │     👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 3)
        💬 Args: [_lqtyAmount, _timestamp, _offset]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@notice Return the most up to date global snapshot and state as well as a flag to notify whether the state can be updated
 This is a convenience function to always retrieve the most up to date state values
