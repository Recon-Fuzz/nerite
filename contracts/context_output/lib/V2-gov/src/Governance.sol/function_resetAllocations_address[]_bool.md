# Function: resetAllocations(address[],bool)

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `resetAllocations(address[],bool)`
- **Visibility**: external
- **Source Range**: 24168:649:23

## Implementation

```solidity
/// @inheritdoc IGovernance
function resetAllocations(address[] calldata _initiativesToReset, bool checkAll) external nonReentrant() {
    _requireNoDuplicates(_initiativesToReset);
    _resetInitiatives(_initiativesToReset);
    if (checkAll) {
        require(userStates[msg.sender].allocatedLQTY == 0, "Governance: must be a reset");
    }
}
```

## Related Implementations

### _requireNoDuplicates(address[])

- **Kind**: free-function
- **Source**: 150:445:40
- **Link**: `lib/V2-gov/src/utils/UniqueArray.sol:_requireNoDuplicates(address[])`

```solidity
/// @dev Checks that there's no duplicate addresses
///  @param arr - List to check for dups
function _requireNoDuplicates(address[] calldata arr) pure {
    uint256 arrLength = arr.length;
    if (arrLength == 0) return;
    for (uint i; i < (arrLength - 1); ) {
        for (uint j = i + 1; j < arrLength; ) {
            require(arr[i] != arr[j], "dup");
            unchecked {
                ++j;
            }
        }
        unchecked {
            ++i;
        }
    }
}
```

### _resetInitiatives(address[])

- **Kind**: internal
- **Source**: 22322:1808:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:_resetInitiatives(address[])`

```solidity
/// @dev Resets an initiative and return the previous votes
///  NOTE: Technically we don't need vetos
///  NOTE: Technically we want to populate the `ResetInitiativeData` only when `secondsWithinEpoch() > EPOCH_VOTING_CUTOFF`
function _resetInitiatives(address[] calldata _initiativesToReset) internal returns (ResetInitiativeData[] memory) {
    ResetInitiativeData[] memory cachedData = new ResetInitiativeData[](_initiativesToReset.length);
    int256[] memory deltaLQTYVotes = new int256[](_initiativesToReset.length);
    int256[] memory deltaLQTYVetos = new int256[](_initiativesToReset.length);
    int256[] memory deltaOffsetVotes = new int256[](_initiativesToReset.length);
    int256[] memory deltaOffsetVetos = new int256[](_initiativesToReset.length);
    for (uint256 i; i < _initiativesToReset.length; i++) {
        Allocation memory alloc = lqtyAllocatedByUserToInitiative[msg.sender][_initiativesToReset[i]];
        require((alloc.voteLQTY > 0) || (alloc.vetoLQTY > 0), "Governance: nothing to reset");
        cachedData[i] = ResetInitiativeData({initiative: _initiativesToReset[i], LQTYVotes: int256(alloc.voteLQTY), LQTYVetos: int256(alloc.vetoLQTY), OffsetVotes: int256(alloc.voteOffset), OffsetVetos: int256(alloc.vetoOffset)});
        deltaLQTYVotes[i] = -(cachedData[i].LQTYVotes);
        deltaLQTYVetos[i] = -(cachedData[i].LQTYVetos);
        deltaOffsetVotes[i] = -(cachedData[i].OffsetVotes);
        deltaOffsetVetos[i] = -(cachedData[i].OffsetVetos);
    }
    _allocateLQTY(_initiativesToReset, deltaLQTYVotes, deltaLQTYVetos, deltaOffsetVotes, deltaOffsetVetos);
    return cachedData;
}
```

### _allocateLQTY(address[],int256[],int256[],int256[],int256[])

- **Kind**: internal
- **Source**: 30035:7437:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:_allocateLQTY(address[],int256[],int256[],int256[],int256[])`

```solidity
/// @dev For each given initiative applies relative changes to the allocation
///  @dev Assumes that all the input arrays are of equal length
///  @dev NOTE: Given the current usage the function either: Resets the value to 0, or sets the value to a new value
///       Review the flows as the function could be used in many ways, but it ends up being used in just those 2 ways
function _allocateLQTY(address[] memory _initiatives, int256[] memory _deltaLQTYVotes, int256[] memory _deltaLQTYVetos, int256[] memory _deltaOffsetVotes, int256[] memory _deltaOffsetVetos) internal {
    AllocateLQTYMemory memory vars;
    (vars.votesSnapshot_, vars.state) = _snapshotVotes();
    vars.currentEpoch = epoch();
    vars.userState = userStates[msg.sender];
    for (uint256 i = 0; i < _initiatives.length; i++) {
        address initiative = _initiatives[i];
        vars.deltaLQTYVotes = _deltaLQTYVotes[i];
        vars.deltaLQTYVetos = _deltaLQTYVetos[i];
        assert((vars.deltaLQTYVotes != 0) || (vars.deltaLQTYVetos != 0));
        vars.deltaOffsetVotes = _deltaOffsetVotes[i];
        vars.deltaOffsetVetos = _deltaOffsetVetos[i];
        /// === Check FSM === ///
        (vars.votesForInitiativeSnapshot_, vars.initiativeState) = _snapshotVotesForInitiative(initiative);
        (InitiativeStatus status, , ) = getInitiativeState(initiative, vars.votesSnapshot_, vars.votesForInitiativeSnapshot_, vars.initiativeState);
        if ((vars.deltaLQTYVotes > 0) || (vars.deltaLQTYVetos > 0)) {
            /// You cannot vote on `unregisterable` but a vote may have been there
            require(((status == InitiativeStatus.SKIP) || (status == InitiativeStatus.CLAIMABLE)) || (status == InitiativeStatus.CLAIMED), "Governance: active-vote-fsm");
        }
        if (status == InitiativeStatus.DISABLED) {
            require((vars.deltaLQTYVotes <= 0) && (vars.deltaLQTYVetos <= 0), "Must be a withdrawal");
        }
        /// === UPDATE ACCOUNTING === ///
        vars.prevInitiativeState = InitiativeState(vars.initiativeState.voteLQTY, vars.initiativeState.voteOffset, vars.initiativeState.vetoLQTY, vars.initiativeState.vetoOffset, vars.initiativeState.lastEpochClaim);
        vars.initiativeState.voteLQTY = add(vars.initiativeState.voteLQTY, vars.deltaLQTYVotes);
        vars.initiativeState.vetoLQTY = add(vars.initiativeState.vetoLQTY, vars.deltaLQTYVetos);
        vars.initiativeState.voteOffset = add(vars.initiativeState.voteOffset, vars.deltaOffsetVotes);
        vars.initiativeState.vetoOffset = add(vars.initiativeState.vetoOffset, vars.deltaOffsetVetos);
        initiativeStates[initiative] = vars.initiativeState;
        /// We update the state only for non-disabled initiatives
        ///  Disabled initiatves have had their totals subtracted already
        if (status != InitiativeStatus.DISABLED) {
            assert(vars.state.countedVoteLQTY >= vars.prevInitiativeState.voteLQTY);
            vars.state.countedVoteLQTY -= vars.prevInitiativeState.voteLQTY;
            vars.state.countedVoteOffset -= vars.prevInitiativeState.voteOffset;
            vars.state.countedVoteLQTY += vars.initiativeState.voteLQTY;
            vars.state.countedVoteOffset += vars.initiativeState.voteOffset;
        }
        vars.allocation = lqtyAllocatedByUserToInitiative[msg.sender][initiative];
        vars.allocation.voteOffset = add(vars.allocation.voteOffset, vars.deltaOffsetVotes);
        vars.allocation.vetoOffset = add(vars.allocation.vetoOffset, vars.deltaOffsetVetos);
        vars.allocation.voteLQTY = add(vars.allocation.voteLQTY, vars.deltaLQTYVotes);
        vars.allocation.vetoLQTY = add(vars.allocation.vetoLQTY, vars.deltaLQTYVetos);
        vars.allocation.atEpoch = vars.currentEpoch;
        assert((vars.allocation.voteLQTY * block.timestamp) >= vars.allocation.voteOffset);
        assert((vars.allocation.vetoLQTY * block.timestamp) >= vars.allocation.vetoOffset);
        lqtyAllocatedByUserToInitiative[msg.sender][initiative] = vars.allocation;
        vars.userState.unallocatedLQTY = sub(vars.userState.unallocatedLQTY, (vars.deltaLQTYVotes + vars.deltaLQTYVetos));
        vars.userState.unallocatedOffset = sub(vars.userState.unallocatedOffset, (vars.deltaOffsetVotes + vars.deltaOffsetVetos));
        vars.userState.allocatedLQTY = add(vars.userState.allocatedLQTY, (vars.deltaLQTYVotes + vars.deltaLQTYVetos));
        vars.userState.allocatedOffset = add(vars.userState.allocatedOffset, (vars.deltaOffsetVotes + vars.deltaOffsetVetos));
        HookStatus hookStatus;
        if (vars.allocation.vetoLQTY == 0) {
            hookStatus = safeCallWithMinGas(initiative, MIN_GAS_TO_HOOK, 0, abi.encodeCall(IInitiative.onAfterAllocateLQTY, (vars.currentEpoch, msg.sender, vars.userState, vars.allocation, vars.initiativeState))) ? HookStatus.Succeeded : HookStatus.Failed;
        } else {
            hookStatus = HookStatus.NotCalled;
        }
        emit AllocateLQTY(msg.sender, initiative, vars.deltaLQTYVotes, vars.deltaLQTYVetos, vars.currentEpoch, hookStatus);
    }
    require(vars.userState.allocatedLQTY <= stakingV1.stakes(deriveUserProxyAddress(msg.sender)), "Governance: insufficient-or-allocated-lqty");
    globalState = vars.state;
    userStates[msg.sender] = vars.userState;
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

### add(uint256,int256)

- **Kind**: free-function
- **Source**: 58:137:35
- **Link**: `lib/V2-gov/src/utils/Math.sol:add(uint256,int256)`

```solidity
function add(uint256 a, int256 b) pure returns (uint256) {
    if (b < 0) {
        return a - abs(b);
    }
    return a + uint256(b);
}
```

### abs(int256)

- **Kind**: free-function
- **Source**: 425:102:35
- **Link**: `lib/V2-gov/src/utils/Math.sol:abs(int256)`

```solidity
function abs(int256 a) pure returns (uint256) {
    return (a < 0) ? uint256(-int256(a)) : uint256(a);
}
```

### sub(uint256,int256)

- **Kind**: free-function
- **Source**: 197:137:35
- **Link**: `lib/V2-gov/src/utils/Math.sol:sub(uint256,int256)`

```solidity
function sub(uint256 a, int256 b) pure returns (uint256) {
    if (b < 0) {
        return a + abs(b);
    }
    return a - uint256(b);
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

- **ILQTYStaking::stakes(address)**
- **IERC20::balanceOf(address)**

## State Variable Reads

- **userStates** (`mapping(address => struct IGovernance.UserState)`)
- **lqtyAllocatedByUserToInitiative** (`mapping(address => mapping(address => struct IGovernance.Allocation))`)
- **MIN_GAS_TO_HOOK** (`uint256`)
- **stakingV1** (`contract ILQTYStaking`) [lib/V2-gov/src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
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
- **userProxyImplementation** (`address`)
- **_status** (`uint256`)
- **ENTERED** (`uint256`)
- **NOT_ENTERED** (`uint256`)

## State Variable Writes

- **initiativeStates** (`mapping(address => struct IGovernance.InitiativeState)`)
- **lqtyAllocatedByUserToInitiative** (`mapping(address => mapping(address => struct IGovernance.Allocation))`)
- **globalState** (`struct IGovernance.GlobalState`)
- **userStates** (`mapping(address => struct IGovernance.UserState)`)
- **votesSnapshot** (`struct IGovernance.VoteSnapshot`)
- **boldAccrued** (`uint256`)
- **votesForInitiativeSnapshot** (`mapping(address => struct IGovernance.InitiativeVoteSnapshot)`)
- **_status** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.resetAllocations(address[],bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Unknown._requireNoDuplicates(address[]) (NodeID: 1)
  │   💬 Args: [_initiativesToReset]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Governance._resetInitiatives(address[]) (NodeID: 2)
  │   💬 Args: [_initiativesToReset]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Governance._allocateLQTY(address[],int256[],int256[],int256[],int256[]) (NodeID: 3)
  │     💬 Args: [_initiativesToReset, deltaLQTYVotes, deltaLQTYVetos, deltaOffsetVotes, deltaOffsetVetos]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Governance._snapshotVotes() (NodeID: 4)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Governance.getTotalVotesAndState() (NodeID: 5)
  │   │     💬 Args: [no args]
  │   │     👁️  Def: public
  │   │   ├─ [5] ⚙️ FUNCTION: Governance.epoch() (NodeID: 6)
  │   │   │   💬 Args: [no args]
  │   │   │   👁️  Def: public
  │   │   └─ [5] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 7)
  │   │       💬 Args: [state.countedVoteLQTY, epochStart(), state.countedVoteOffset]
  │   │       👁️  Def: public
  │   │     ├─ [6] ⚙️ FUNCTION: Governance.epochStart() (NodeID: 9)
  │   │     │   💬 Args: [no args]
  │   │     │   👁️  Def: public
  │   │     │ └─ [7] ⚙️ FUNCTION: Governance.epoch() (NodeID: 10)
  │   │     │     💬 Args: [no args]
  │   │     │     👁️  Def: public
  │   │     └─ [6] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 8)
  │   │         💬 Args: [_lqtyAmount, _timestamp, _offset]
  │   │         👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Governance.epoch() (NodeID: 11)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: Governance._snapshotVotesForInitiative(address) (NodeID: 12)
  │   │   💬 Args: [initiative]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Governance.getInitiativeSnapshotAndState(address) (NodeID: 13)
  │   │     💬 Args: [_initiative]
  │   │     👁️  Def: public
  │   │   ├─ [5] ⚙️ FUNCTION: Governance.epoch() (NodeID: 14)
  │   │   │   💬 Args: [no args]
  │   │   │   👁️  Def: public
  │   │   ├─ [5] ⚙️ FUNCTION: Governance.epochStart() (NodeID: 15)
  │   │   │   💬 Args: [no args]
  │   │   │   👁️  Def: public
  │   │   │ └─ [6] ⚙️ FUNCTION: Governance.epoch() (NodeID: 16)
  │   │   │     💬 Args: [no args]
  │   │   │     👁️  Def: public
  │   │   ├─ [5] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 17)
  │   │   │   💬 Args: [initiativeState.voteLQTY, start, initiativeState.voteOffset]
  │   │   │   👁️  Def: public
  │   │   │ └─ [6] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 18)
  │   │   │     💬 Args: [_lqtyAmount, _timestamp, _offset]
  │   │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 19)
  │   │       💬 Args: [initiativeState.vetoLQTY, start, initiativeState.vetoOffset]
  │   │       👁️  Def: public
  │   │     └─ [6] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 20)
  │   │         💬 Args: [_lqtyAmount, _timestamp, _offset]
  │   │         👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Governance.getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState) (NodeID: 21)
  │   │   💬 Args: [initiative, vars.votesSnapshot_, vars.votesForInitiativeSnapshot_, vars.initiativeState]
  │   │   👁️  Def: public
  │   │ ├─ [4] ⚙️ FUNCTION: Governance.epoch() (NodeID: 22)
  │   │ │   💬 Args: [no args]
  │   │ │   👁️  Def: public
  │   │ └─ [4] ⚙️ FUNCTION: Governance.calculateVotingThreshold(uint256) (NodeID: 23)
  │   │     💬 Args: [_votesSnapshot.votes]
  │   │     👁️  Def: public
  │   │   └─ [5] ⚙️ FUNCTION: Unknown.max(uint256,uint256) (NodeID: 24)
  │   │       💬 Args: [(_votes * VOTING_THRESHOLD_FACTOR) / WAD, minVotes]
  │   │       👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 25)
  │   │   💬 Args: [vars.initiativeState.voteLQTY, vars.deltaLQTYVotes]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 26)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 27)
  │   │   💬 Args: [vars.initiativeState.vetoLQTY, vars.deltaLQTYVetos]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 28)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 29)
  │   │   💬 Args: [vars.initiativeState.voteOffset, vars.deltaOffsetVotes]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 30)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 31)
  │   │   💬 Args: [vars.initiativeState.vetoOffset, vars.deltaOffsetVetos]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 32)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 33)
  │   │   💬 Args: [vars.allocation.voteOffset, vars.deltaOffsetVotes]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 34)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 35)
  │   │   💬 Args: [vars.allocation.vetoOffset, vars.deltaOffsetVetos]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 36)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 37)
  │   │   💬 Args: [vars.allocation.voteLQTY, vars.deltaLQTYVotes]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 38)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 39)
  │   │   💬 Args: [vars.allocation.vetoLQTY, vars.deltaLQTYVetos]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 40)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.sub(uint256,int256) (NodeID: 41)
  │   │   💬 Args: [vars.userState.unallocatedLQTY, (vars.deltaLQTYVotes + vars.deltaLQTYVetos)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 42)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.sub(uint256,int256) (NodeID: 43)
  │   │   💬 Args: [vars.userState.unallocatedOffset, (vars.deltaOffsetVotes + vars.deltaOffsetVetos)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 44)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 45)
  │   │   💬 Args: [vars.userState.allocatedLQTY, (vars.deltaLQTYVotes + vars.deltaLQTYVetos)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 46)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.add(uint256,int256) (NodeID: 47)
  │   │   💬 Args: [vars.userState.allocatedOffset, (vars.deltaOffsetVotes + vars.deltaOffsetVetos)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.abs(int256) (NodeID: 48)
  │   │     💬 Args: [b]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.safeCallWithMinGas(address,uint256,uint256,bytes) (NodeID: 49)
  │   │   💬 Args: [initiative, MIN_GAS_TO_HOOK, 0, abi.encodeCall(IInitiative.onAfterAllocateLQTY, (vars.currentEpoch, msg.sender, vars.userState, vars.allocation, vars.initiativeState))]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.hasMinGas(uint256,uint256) (NodeID: 50)
  │   │     💬 Args: [_gas, 1_000]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: UserProxyFactory.deriveUserProxyAddress(address) (NodeID: 51)
  │       💬 Args: [msg.sender]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32) (NodeID: 52)
  │         💬 Args: [userProxyImplementation, bytes32(uint256(uint160(_user)))]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32,address) (NodeID: 53)
  │           💬 Args: [implementation, salt, address(this)]
  │           👁️  Def: internal
  └─ [1] 🔒 MODIFIER: ReentrancyGuard.nonReentrant() (NodeID: 54)
      💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantBefore() (NodeID: 55)
    │   💬 Args: [no args]
    │   👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantAfter() (NodeID: 56)
        💬 Args: [no args]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@notice Deallocates the user's LQTY from initiatives
 @param _initiativesToReset Addresses of initiatives to deallocate LQTY from
 @param _checkAll When true, the call will revert if there is still some allocated LQTY left after deallocating
                  from all the addresses in `_initiativesToReset`
