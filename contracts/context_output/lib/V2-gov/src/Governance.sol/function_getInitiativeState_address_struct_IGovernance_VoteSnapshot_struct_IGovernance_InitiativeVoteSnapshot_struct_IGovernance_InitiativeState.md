# Function: getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState)

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState)`
- **Visibility**: public
- **Source Range**: 16627:3214:23

## Implementation

```solidity
/// @dev Given an initiative address and its snapshot, determines the current state for an initiative
function getInitiativeState(address _initiative, VoteSnapshot memory _votesSnapshot, InitiativeVoteSnapshot memory _votesForInitiativeSnapshot, InitiativeState memory _initiativeState) public view returns (InitiativeStatus status, uint256 lastEpochClaim, uint256 claimableAmount) {
    uint256 initiativeRegistrationEpoch = registeredInitiatives[_initiative];
    if (initiativeRegistrationEpoch == 0) {
        return (InitiativeStatus.NONEXISTENT, 0, 0);
    }
    uint256 currentEpoch = epoch();
    if (initiativeRegistrationEpoch == currentEpoch) {
        return (InitiativeStatus.WARM_UP, 0, 0);
    }
    lastEpochClaim = initiativeStates[_initiative].lastEpochClaim;
    if (initiativeRegistrationEpoch == UNREGISTERED_INITIATIVE) {
        return (InitiativeStatus.DISABLED, lastEpochClaim, 0);
    }
    if (lastEpochClaim >= (currentEpoch - 1)) {
        return (InitiativeStatus.CLAIMED, lastEpochClaim, claimableAmount);
    }
    uint256 votingTheshold = calculateVotingThreshold(_votesSnapshot.votes);
    if ((_votesForInitiativeSnapshot.votes > votingTheshold) && (_votesForInitiativeSnapshot.votes > _votesForInitiativeSnapshot.vetos)) {
        uint256 claim = (_votesForInitiativeSnapshot.votes * boldAccrued) / _votesSnapshot.votes;
        return (InitiativeStatus.CLAIMABLE, lastEpochClaim, claim);
    }
    if (((_initiativeState.lastEpochClaim + UNREGISTRATION_AFTER_EPOCHS) < (currentEpoch - 1)) || ((_votesForInitiativeSnapshot.vetos > _votesForInitiativeSnapshot.votes) && (_votesForInitiativeSnapshot.vetos > ((votingTheshold * UNREGISTRATION_THRESHOLD_FACTOR) / WAD)))) {
        return (InitiativeStatus.UNREGISTERABLE, lastEpochClaim, 0);
    }
    return (InitiativeStatus.SKIP, lastEpochClaim, 0);
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

### calculateVotingThreshold(uint256)

- **Kind**: internal
- **Source**: 11889:442:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:calculateVotingThreshold(uint256)`

```solidity
/// @inheritdoc IGovernance
function calculateVotingThreshold(uint256 _votes) public view returns (uint256) {
    if (_votes == 0) return 0;
    uint256 minVotes;
    uint256 payoutPerVote = (boldAccrued * WAD) / _votes;
    if (payoutPerVote != 0) {
        minVotes = (MIN_CLAIM * WAD) / payoutPerVote;
    }
    return max((_votes * VOTING_THRESHOLD_FACTOR) / WAD, minVotes);
}
```

### max(uint256,uint256)

- **Kind**: free-function
- **Source**: 336:87:35
- **Link**: `lib/V2-gov/src/utils/Math.sol:max(uint256,uint256)`

```solidity
function max(uint256 a, uint256 b) pure returns (uint256) {
    return (a > b) ? a : b;
}
```

## State Variable Reads

- **registeredInitiatives** (`mapping(address => uint256)`)
- **initiativeStates** (`mapping(address => struct IGovernance.InitiativeState)`)
- **boldAccrued** (`uint256`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **MIN_CLAIM** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Governance.epoch() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Governance.calculateVotingThreshold(uint256) (NodeID: 2)
      💬 Args: [_votesSnapshot.votes]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Unknown.max(uint256,uint256) (NodeID: 3)
        💬 Args: [(_votes * VOTING_THRESHOLD_FACTOR) / WAD, minVotes]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Given an initiative address and its snapshot, determines the current state for an initiative
