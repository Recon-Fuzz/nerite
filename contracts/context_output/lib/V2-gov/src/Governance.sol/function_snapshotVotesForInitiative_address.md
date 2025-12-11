# Function: snapshotVotesForInitiative(address)

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `snapshotVotesForInitiative(address)`
- **Visibility**: external
- **Source Range**: 15295:333:23

## Implementation

```solidity
/// @inheritdoc IGovernance
function snapshotVotesForInitiative(address _initiative) external nonReentrant() returns (VoteSnapshot memory voteSnapshot, InitiativeVoteSnapshot memory initiativeVoteSnapshot) {
    (voteSnapshot, ) = _snapshotVotes();
    (initiativeVoteSnapshot, ) = _snapshotVotesForInitiative(_initiative);
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

### nonReentrant()

- **Kind**: modifier
- **Source**: 2322:103:18
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:nonReentrant()`

```solidity
///  @dev Prevents a contract from calling itself, directly or indirectly.
///  Calling a `nonReentrant` function from another `nonReentrant`
///  function is not supported. It is possible to prevent this from happening
///  by making the `nonReentrant` function external, and making it call a
///  `private` function that does the actual work.
modifier nonReentrant() {
    _nonReentrantBefore();
    _;
    _nonReentrantAfter();
}
```

### _nonReentrantBefore()

- **Kind**: internal
- **Source**: 2431:307:18
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:_nonReentrantBefore()`

```solidity
function _nonReentrantBefore() private {
    if (_status == ENTERED) {
        revert ReentrancyGuardReentrantCall();
    }
    _status = ENTERED;
}
```

### _nonReentrantAfter()

- **Kind**: internal
- **Source**: 2744:208:18
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:_nonReentrantAfter()`

```solidity
function _nonReentrantAfter() private {
    _status = NOT_ENTERED;
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
- **_status** (`uint256`)
- **ENTERED** (`uint256`)
- **NOT_ENTERED** (`uint256`)

## State Variable Writes

- **votesSnapshot** (`struct IGovernance.VoteSnapshot`)
- **boldAccrued** (`uint256`)
- **votesForInitiativeSnapshot** (`mapping(address => struct IGovernance.InitiativeVoteSnapshot)`)
- **_status** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.snapshotVotesForInitiative(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
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
  └─ [1] 🔒 MODIFIER: ReentrancyGuard.nonReentrant() (NodeID: 17)
      💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantBefore() (NodeID: 18)
    │   💬 Args: [no args]
    │   👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantAfter() (NodeID: 19)
        💬 Args: [no args]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@notice Snapshots votes for the previous epoch and accrues funds for the current epoch
 @param _initiative Address of the initiative
 @return voteSnapshot Vote snapshot
 @return initiativeVoteSnapshot Vote snapshot of the initiative
