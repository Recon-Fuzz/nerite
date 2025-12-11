# Function: getInitiativeState(address)

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `getInitiativeState(address)`
- **Visibility**: public
- **Source Range**: 16008:507:23

## Implementation

```solidity
/// @notice Given an inititive address, updates all snapshots and return the initiative state
///      See the view version of `getInitiativeState` for the underlying logic on Initatives FSM
function getInitiativeState(address _initiative) public returns (InitiativeStatus status, uint256 lastEpochClaim, uint256 claimableAmount) {
    (VoteSnapshot memory votesSnapshot_, ) = _snapshotVotes();
    (InitiativeVoteSnapshot memory votesForInitiativeSnapshot_, InitiativeState memory initiativeState) = _snapshotVotesForInitiative(_initiative);
    return getInitiativeState(_initiative, votesSnapshot_, votesForInitiativeSnapshot_, initiativeState);
}
```

## Related Implementations

### _snapshotVotes()

- **Kind**: internal
- **Source**: 12513:496:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:_snapshotVotes()`

```solidity
function _snapshotVotes() internal returns (VoteSnapshot memory snapshot, GlobalState memory state) {
    bool shouldUpdate;
    (snapshot, state, shouldUpdate) = getTotalVotesAndState();
    if (shouldUpdate) {
        votesSnapshot = snapshot;
        uint256 boldBalance = bold.balanceOf(address(this));
        boldAccrued = (boldBalance < MIN_ACCRUAL) ? 0 : boldBalance;
        emit SnapshotVotes(snapshot.votes, snapshot.forEpoch, boldAccrued);
    }
}
```

### getTotalVotesAndState()

- **Kind**: internal
- **Source**: 13047:518:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:getTotalVotesAndState()`

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

### _snapshotVotesForInitiative(address)

- **Kind**: internal
- **Source**: 13635:608:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:_snapshotVotesForInitiative(address)`

```solidity
function _snapshotVotesForInitiative(address _initiative) internal returns (InitiativeVoteSnapshot memory initiativeSnapshot, InitiativeState memory initiativeState) {
    bool shouldUpdate;
    (initiativeSnapshot, initiativeState, shouldUpdate) = getInitiativeSnapshotAndState(_initiative);
    if (shouldUpdate) {
        votesForInitiativeSnapshot[_initiative] = initiativeSnapshot;
        emit SnapshotVotesForInitiative(_initiative, initiativeSnapshot.votes, initiativeSnapshot.vetos, initiativeSnapshot.forEpoch);
    }
}
```

### getInitiativeSnapshotAndState(address)

- **Kind**: internal
- **Source**: 14281:976:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:getInitiativeSnapshotAndState(address)`

```solidity
/// @inheritdoc IGovernance
function getInitiativeSnapshotAndState(address _initiative) public view returns (InitiativeVoteSnapshot memory initiativeSnapshot, InitiativeState memory initiativeState, bool shouldUpdate) {
    uint256 currentEpoch = epoch();
    initiativeSnapshot = votesForInitiativeSnapshot[_initiative];
    initiativeState = initiativeStates[_initiative];
    if (initiativeSnapshot.forEpoch < (currentEpoch - 1)) {
        shouldUpdate = true;
        uint256 start = epochStart();
        uint256 votes = lqtyToVotes(initiativeState.voteLQTY, start, initiativeState.voteOffset);
        uint256 vetos = lqtyToVotes(initiativeState.vetoLQTY, start, initiativeState.vetoOffset);
        initiativeSnapshot.votes = votes;
        initiativeSnapshot.vetos = vetos;
        initiativeSnapshot.forEpoch = currentEpoch - 1;
    }
}
```

### getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState)

- **Kind**: internal
- **Source**: 16627:3214:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState)`

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

## External Calls

- **IERC20::balanceOf(address)**

## State Variable Reads

- **bold** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **MIN_ACCRUAL** (`uint256`)
- **boldAccrued** (`uint256`)
- **votesSnapshot** (`struct IGovernance.VoteSnapshot`)
- **globalState** (`struct IGovernance.GlobalState`)
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **votesForInitiativeSnapshot** (`mapping(address => struct IGovernance.InitiativeVoteSnapshot)`)
- **initiativeStates** (`mapping(address => struct IGovernance.InitiativeState)`)
- **registeredInitiatives** (`mapping(address => uint256)`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **MIN_CLAIM** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)

## State Variable Writes

- **votesSnapshot** (`struct IGovernance.VoteSnapshot`)
- **boldAccrued** (`uint256`)
- **votesForInitiativeSnapshot** (`mapping(address => struct IGovernance.InitiativeVoteSnapshot)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.getInitiativeState(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Governance._snapshotVotes() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Governance.getTotalVotesAndState() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: Governance.epoch() (NodeID: 3)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 4)
  │       💬 Args: [state.countedVoteLQTY, epochStart(), state.countedVoteOffset]
  │       👁️  Def: public
  │     ├─ [4] ⚙️ FUNCTION: Governance.epochStart() (NodeID: 6)
  │     │   💬 Args: [no args]
  │     │   👁️  Def: public
  │     │ └─ [5] ⚙️ FUNCTION: Governance.epoch() (NodeID: 7)
  │     │     💬 Args: [no args]
  │     │     👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 5)
  │         💬 Args: [_lqtyAmount, _timestamp, _offset]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Governance._snapshotVotesForInitiative(address) (NodeID: 8)
  │   💬 Args: [_initiative]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Governance.getInitiativeSnapshotAndState(address) (NodeID: 9)
  │     💬 Args: [_initiative]
  │     👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: Governance.epoch() (NodeID: 10)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: Governance.epochStart() (NodeID: 11)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: public
  │   │ └─ [4] ⚙️ FUNCTION: Governance.epoch() (NodeID: 12)
  │   │     💬 Args: [no args]
  │   │     👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 13)
  │   │   💬 Args: [initiativeState.voteLQTY, start, initiativeState.voteOffset]
  │   │   👁️  Def: public
  │   │ └─ [4] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 14)
  │   │     💬 Args: [_lqtyAmount, _timestamp, _offset]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 15)
  │       💬 Args: [initiativeState.vetoLQTY, start, initiativeState.vetoOffset]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 16)
  │         💬 Args: [_lqtyAmount, _timestamp, _offset]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Governance.getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState) (NodeID: 17)
      💬 Args: [_initiative, votesSnapshot_, votesForInitiativeSnapshot_, initiativeState]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: Governance.epoch() (NodeID: 18)
    │   💬 Args: [no args]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Governance.calculateVotingThreshold(uint256) (NodeID: 19)
        💬 Args: [_votesSnapshot.votes]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: Unknown.max(uint256,uint256) (NodeID: 20)
          💬 Args: [(_votes * VOTING_THRESHOLD_FACTOR) / WAD, minVotes]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Given an inititive address, updates all snapshots and return the initiative state
     See the view version of `getInitiativeState` for the underlying logic on Initatives FSM
