# Function: registerInitiative(address)

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `registerInitiative(address)`
- **Visibility**: external
- **Source Range**: 19879:2024:23

## Implementation

```solidity
/// @inheritdoc IGovernance
function registerInitiative(address _initiative) external nonReentrant() {
    uint256 currentEpoch = epoch();
    require(currentEpoch > 2, "Governance: registration-not-yet-enabled");
    require(_initiative != address(0), "Governance: zero-address");
    (InitiativeStatus status, , ) = getInitiativeState(_initiative);
    require(status == InitiativeStatus.NONEXISTENT, "Governance: initiative-already-registered");
    address userProxyAddress = deriveUserProxyAddress(msg.sender);
    (VoteSnapshot memory snapshot, ) = _snapshotVotes();
    UserState memory userState = userStates[msg.sender];
    bold.safeTransferFrom(msg.sender, address(this), REGISTRATION_FEE);
    uint256 upscaledSnapshotVotes = snapshot.votes;
    uint256 totalUserOffset = userState.allocatedOffset + userState.unallocatedOffset;
    require(lqtyToVotes(stakingV1.stakes(userProxyAddress), epochStart(), totalUserOffset) >= ((upscaledSnapshotVotes * REGISTRATION_THRESHOLD_FACTOR) / WAD), "Governance: insufficient-lqty");
    registeredInitiatives[_initiative] = currentEpoch;
    /// This ensures that the initiatives has UNREGISTRATION_AFTER_EPOCHS even after the first epoch
    initiativeStates[_initiative].lastEpochClaim = currentEpoch - 1;
    bool success = safeCallWithMinGas(_initiative, MIN_GAS_TO_HOOK, 0, abi.encodeCall(IInitiative.onRegisterInitiative, (currentEpoch)));
    emit RegisterInitiative(_initiative, msg.sender, currentEpoch, success ? HookStatus.Succeeded : HookStatus.Failed);
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

### getInitiativeState(address)

- **Kind**: internal
- **Source**: 16008:507:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:getInitiativeState(address)`

```solidity
/// @notice Given an inititive address, updates all snapshots and return the initiative state
///      See the view version of `getInitiativeState` for the underlying logic on Initatives FSM
function getInitiativeState(address _initiative) public returns (InitiativeStatus status, uint256 lastEpochClaim, uint256 claimableAmount) {
    (VoteSnapshot memory votesSnapshot_, ) = _snapshotVotes();
    (InitiativeVoteSnapshot memory votesForInitiativeSnapshot_, InitiativeState memory initiativeState) = _snapshotVotesForInitiative(_initiative);
    return getInitiativeState(_initiative, votesSnapshot_, votesForInitiativeSnapshot_, initiativeState);
}
```

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

### deriveUserProxyAddress(address)

- **Kind**: internal
- **Source**: 579:194:25
- **Link**: `lib/V2-gov/src/UserProxyFactory.sol:UserProxyFactory:deriveUserProxyAddress(address)`

```solidity
/// @inheritdoc IUserProxyFactory
function deriveUserProxyAddress(address _user) public view returns (address) {
    return Clones.predictDeterministicAddress(userProxyImplementation, bytes32(uint256(uint160(_user))));
}
```

### predictDeterministicAddress(address,bytes32)

- **Kind**: internal
- **Source**: 3930:227:12
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/proxy/Clones.sol:Clones:predictDeterministicAddress(address,bytes32)`

```solidity
///  @dev Computes the address of a clone deployed using {Clones-cloneDeterministic}.
function predictDeterministicAddress(address implementation, bytes32 salt) internal view returns (address predicted) {
    return predictDeterministicAddress(implementation, salt, address(this));
}
```

### predictDeterministicAddress(address,bytes32,address)

- **Kind**: internal
- **Source**: 3140:680:12
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/proxy/Clones.sol:Clones:predictDeterministicAddress(address,bytes32,address)`

```solidity
///  @dev Computes the address of a clone deployed using {Clones-cloneDeterministic}.
function predictDeterministicAddress(address implementation, bytes32 salt, address deployer) internal pure returns (address predicted) {
    /// @solidity memory-safe-assembly
    assembly {
        let ptr := mload(0x40)
        mstore(add(ptr, 0x38), deployer)
        mstore(add(ptr, 0x24), 0x5af43d82803e903d91602b57fd5bf3ff)
        mstore(add(ptr, 0x14), implementation)
        mstore(ptr, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73)
        mstore(add(ptr, 0x58), salt)
        mstore(add(ptr, 0x78), keccak256(add(ptr, 0x0c), 0x37))
        predicted := keccak256(add(ptr, 0x43), 0x55)
    }
}
```

### safeCallWithMinGas(address,uint256,uint256,bytes)

- **Kind**: free-function
- **Source**: 775:892:38
- **Link**: `lib/V2-gov/src/utils/SafeCallMinGas.sol:safeCallWithMinGas(address,uint256,uint256,bytes)`

```solidity
/// @dev Performs a call ignoring the recipient existing or not, passing the exact gas value, ignoring any return value
function safeCallWithMinGas(address _target, uint256 _gas, uint256 _value, bytes memory _calldata) returns (bool success) {
    /// This is not necessary
    ///  But this is basically a worst case estimate of mem exp cost + operations before the call
    require(hasMinGas(_gas, 1_000), "Must have minGas");
    assembly {
        success := call(_gas, _target, _value, add(_calldata, 0x20), mload(_calldata), 0, 0)
    }
    return (success);
}
```

### hasMinGas(uint256,uint256)

- **Kind**: free-function
- **Source**: 325:328:38
- **Link**: `lib/V2-gov/src/utils/SafeCallMinGas.sol:hasMinGas(uint256,uint256)`

```solidity
/// @notice Given the gas requirement, ensures that the current context has sufficient gas to perform a call + a fixed buffer
///  @dev Credits: https://github.com/ethereum-optimism/optimism/blob/develop/packages/contracts-bedrock/src/libraries/SafeCall.sol#L100-L107
function hasMinGas(uint256 _minGas, uint256 _reservedGas) view returns (bool) {
    bool _hasMinGas;
    assembly {
        _hasMinGas := iszero(lt(mul(gas(), 63), add(mul(_minGas, 64), mul(add(40000, _reservedGas), 63))))
    }
    return _hasMinGas;
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

- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **ILQTYStaking::stakes(address)**
- **IERC20::balanceOf(address)**

## State Variable Reads

- **userStates** (`mapping(address => struct IGovernance.UserState)`)
- **bold** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **REGISTRATION_FEE** (`uint256`)
- **stakingV1** (`contract ILQTYStaking`) [lib/V2-gov/src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
- **REGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **MIN_GAS_TO_HOOK** (`uint256`)
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **MIN_ACCRUAL** (`uint256`)
- **boldAccrued** (`uint256`)
- **votesSnapshot** (`struct IGovernance.VoteSnapshot`)
- **globalState** (`struct IGovernance.GlobalState`)
- **votesForInitiativeSnapshot** (`mapping(address => struct IGovernance.InitiativeVoteSnapshot)`)
- **initiativeStates** (`mapping(address => struct IGovernance.InitiativeState)`)
- **registeredInitiatives** (`mapping(address => uint256)`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **MIN_CLAIM** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)
- **userProxyImplementation** (`address`)
- **_status** (`uint256`)
- **ENTERED** (`uint256`)
- **NOT_ENTERED** (`uint256`)

## State Variable Writes

- **registeredInitiatives** (`mapping(address => uint256)`)
- **initiativeStates** (`mapping(address => struct IGovernance.InitiativeState)`)
- **votesSnapshot** (`struct IGovernance.VoteSnapshot`)
- **boldAccrued** (`uint256`)
- **votesForInitiativeSnapshot** (`mapping(address => struct IGovernance.InitiativeVoteSnapshot)`)
- **_status** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.registerInitiative(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Governance.epoch() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Governance.getInitiativeState(address) (NodeID: 2)
  │   💬 Args: [_initiative]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: Governance._snapshotVotes() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Governance.getTotalVotesAndState() (NodeID: 4)
  │ │     💬 Args: [no args]
  │ │     👁️  Def: public
  │ │   ├─ [4] ⚙️ FUNCTION: Governance.epoch() (NodeID: 5)
  │ │   │   💬 Args: [no args]
  │ │   │   👁️  Def: public
  │ │   └─ [4] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 6)
  │ │       💬 Args: [state.countedVoteLQTY, epochStart(), state.countedVoteOffset]
  │ │       👁️  Def: public
  │ │     ├─ [5] ⚙️ FUNCTION: Governance.epochStart() (NodeID: 8)
  │ │     │   💬 Args: [no args]
  │ │     │   👁️  Def: public
  │ │     │ └─ [6] ⚙️ FUNCTION: Governance.epoch() (NodeID: 9)
  │ │     │     💬 Args: [no args]
  │ │     │     👁️  Def: public
  │ │     └─ [5] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 7)
  │ │         💬 Args: [_lqtyAmount, _timestamp, _offset]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Governance._snapshotVotesForInitiative(address) (NodeID: 10)
  │ │   💬 Args: [_initiative]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Governance.getInitiativeSnapshotAndState(address) (NodeID: 11)
  │ │     💬 Args: [_initiative]
  │ │     👁️  Def: public
  │ │   ├─ [4] ⚙️ FUNCTION: Governance.epoch() (NodeID: 12)
  │ │   │   💬 Args: [no args]
  │ │   │   👁️  Def: public
  │ │   ├─ [4] ⚙️ FUNCTION: Governance.epochStart() (NodeID: 13)
  │ │   │   💬 Args: [no args]
  │ │   │   👁️  Def: public
  │ │   │ └─ [5] ⚙️ FUNCTION: Governance.epoch() (NodeID: 14)
  │ │   │     💬 Args: [no args]
  │ │   │     👁️  Def: public
  │ │   ├─ [4] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 15)
  │ │   │   💬 Args: [initiativeState.voteLQTY, start, initiativeState.voteOffset]
  │ │   │   👁️  Def: public
  │ │   │ └─ [5] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 16)
  │ │   │     💬 Args: [_lqtyAmount, _timestamp, _offset]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 17)
  │ │       💬 Args: [initiativeState.vetoLQTY, start, initiativeState.vetoOffset]
  │ │       👁️  Def: public
  │ │     └─ [5] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 18)
  │ │         💬 Args: [_lqtyAmount, _timestamp, _offset]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Governance.getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState) (NodeID: 19)
  │     💬 Args: [_initiative, votesSnapshot_, votesForInitiativeSnapshot_, initiativeState]
  │     👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: Governance.epoch() (NodeID: 20)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: Governance.calculateVotingThreshold(uint256) (NodeID: 21)
  │       💬 Args: [_votesSnapshot.votes]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: Unknown.max(uint256,uint256) (NodeID: 22)
  │         💬 Args: [(_votes * VOTING_THRESHOLD_FACTOR) / WAD, minVotes]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UserProxyFactory.deriveUserProxyAddress(address) (NodeID: 23)
  │   💬 Args: [msg.sender]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32) (NodeID: 24)
  │     💬 Args: [userProxyImplementation, bytes32(uint256(uint160(_user)))]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32,address) (NodeID: 25)
  │       💬 Args: [implementation, salt, address(this)]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Governance._snapshotVotes() (NodeID: 26)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Governance.getTotalVotesAndState() (NodeID: 27)
  │     💬 Args: [no args]
  │     👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: Governance.epoch() (NodeID: 28)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 29)
  │       💬 Args: [state.countedVoteLQTY, epochStart(), state.countedVoteOffset]
  │       👁️  Def: public
  │     ├─ [4] ⚙️ FUNCTION: Governance.epochStart() (NodeID: 31)
  │     │   💬 Args: [no args]
  │     │   👁️  Def: public
  │     │ └─ [5] ⚙️ FUNCTION: Governance.epoch() (NodeID: 32)
  │     │     💬 Args: [no args]
  │     │     👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 30)
  │         💬 Args: [_lqtyAmount, _timestamp, _offset]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 33)
  │   💬 Args: [stakingV1.stakes(userProxyAddress), epochStart(), totalUserOffset]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: Governance.epochStart() (NodeID: 35)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: Governance.epoch() (NodeID: 36)
  │ │     💬 Args: [no args]
  │ │     👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 34)
  │     💬 Args: [_lqtyAmount, _timestamp, _offset]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Unknown.safeCallWithMinGas(address,uint256,uint256,bytes) (NodeID: 37)
  │   💬 Args: [_initiative, MIN_GAS_TO_HOOK, 0, abi.encodeCall(IInitiative.onRegisterInitiative, (currentEpoch))]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.hasMinGas(uint256,uint256) (NodeID: 38)
  │     💬 Args: [_gas, 1_000]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: ReentrancyGuard.nonReentrant() (NodeID: 39)
      💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantBefore() (NodeID: 40)
    │   💬 Args: [no args]
    │   👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantAfter() (NodeID: 41)
        💬 Args: [no args]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@notice Registers a new initiative
 @param _initiative Address of the initiative
