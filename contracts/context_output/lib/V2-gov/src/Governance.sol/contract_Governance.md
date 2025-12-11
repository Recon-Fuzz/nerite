# Contract: Governance

## Metadata

- **Name**: Governance
- **Type**: Contract
- **Path**: lib/V2-gov/src/Governance.sol
- **Documentation**: @title Governance: Modular Initiative based Governance

## Implements Interfaces

- **IGovernance** [lib/V2-gov/src/interfaces/IGovernance.sol/interface_IGovernance.md]
- **IUserProxyFactory** [lib/V2-gov/src/interfaces/IUserProxyFactory.sol/interface_IUserProxyFactory.md]
- **IMultiDelegateCall** [lib/V2-gov/src/interfaces/IMultiDelegateCall.sol/interface_IMultiDelegateCall.md]

## State Variables

### userProxyImplementation (inherited from UserProxyFactory)

```solidity
/// @inheritdoc IUserProxyFactory
address public immutable userProxyImplementation
```

### NOT_ENTERED (inherited from ReentrancyGuard)

```solidity
uint256 private constant NOT_ENTERED = 1
```

### ENTERED (inherited from ReentrancyGuard)

```solidity
uint256 private constant ENTERED = 2
```

### _status (inherited from ReentrancyGuard)

```solidity
uint256 private _status
```

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### MIN_GAS_TO_HOOK

```solidity
uint256 internal constant MIN_GAS_TO_HOOK = 350_000
```

### stakingV1

```solidity
/// @inheritdoc IGovernance
ILQTYStaking public immutable stakingV1
```

**ILQTYStaking**: [lib/V2-gov/src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]

### lqty

```solidity
/// @inheritdoc IGovernance
IERC20 public immutable lqty
```

**IERC20**: [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### bold

```solidity
/// @inheritdoc IGovernance
IERC20 public immutable bold
```

**IERC20**: [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### EPOCH_START

```solidity
/// @inheritdoc IGovernance
uint256 public immutable EPOCH_START
```

### EPOCH_DURATION

```solidity
/// @inheritdoc IGovernance
uint256 public immutable EPOCH_DURATION
```

### EPOCH_VOTING_CUTOFF

```solidity
/// @inheritdoc IGovernance
uint256 public immutable EPOCH_VOTING_CUTOFF
```

### MIN_CLAIM

```solidity
/// @inheritdoc IGovernance
uint256 public immutable MIN_CLAIM
```

### MIN_ACCRUAL

```solidity
/// @inheritdoc IGovernance
uint256 public immutable MIN_ACCRUAL
```

### REGISTRATION_FEE

```solidity
/// @inheritdoc IGovernance
uint256 public immutable REGISTRATION_FEE
```

### REGISTRATION_THRESHOLD_FACTOR

```solidity
/// @inheritdoc IGovernance
uint256 public immutable REGISTRATION_THRESHOLD_FACTOR
```

### UNREGISTRATION_THRESHOLD_FACTOR

```solidity
/// @inheritdoc IGovernance
uint256 public immutable UNREGISTRATION_THRESHOLD_FACTOR
```

### UNREGISTRATION_AFTER_EPOCHS

```solidity
/// @inheritdoc IGovernance
uint256 public immutable UNREGISTRATION_AFTER_EPOCHS
```

### VOTING_THRESHOLD_FACTOR

```solidity
/// @inheritdoc IGovernance
uint256 public immutable VOTING_THRESHOLD_FACTOR
```

### boldAccrued

```solidity
/// @inheritdoc IGovernance
uint256 public boldAccrued
```

### votesSnapshot

```solidity
/// @inheritdoc IGovernance
VoteSnapshot public votesSnapshot
```

### votesForInitiativeSnapshot

```solidity
/// @inheritdoc IGovernance
mapping(address => InitiativeVoteSnapshot) public votesForInitiativeSnapshot
```

### globalState

```solidity
/// @inheritdoc IGovernance
GlobalState public globalState
```

### userStates

```solidity
/// @inheritdoc IGovernance
mapping(address => UserState) public userStates
```

### initiativeStates

```solidity
/// @inheritdoc IGovernance
mapping(address => InitiativeState) public initiativeStates
```

### lqtyAllocatedByUserToInitiative

```solidity
/// @inheritdoc IGovernance
mapping(address => mapping(address => Allocation)) public lqtyAllocatedByUserToInitiative
```

### registeredInitiatives

```solidity
/// @inheritdoc IGovernance
mapping(address => uint256) public override registeredInitiatives
```

## Structs

### Configuration (inherited from IGovernance)

```solidity
struct Configuration {
    uint256 registrationFee;
    uint256 registrationThresholdFactor;
    uint256 unregistrationThresholdFactor;
    uint256 unregistrationAfterEpochs;
    uint256 votingThresholdFactor;
    uint256 minClaim;
    uint256 minAccrual;
    uint256 epochStart;
    uint256 epochDuration;
    uint256 epochVotingCutoff;
}
```

### VoteSnapshot (inherited from IGovernance)

```solidity
struct VoteSnapshot {
    uint256 votes;
    uint256 forEpoch;
}
```

### InitiativeVoteSnapshot (inherited from IGovernance)

```solidity
struct InitiativeVoteSnapshot {
    uint256 votes;
    uint256 forEpoch;
    uint256 lastCountedEpoch;
    uint256 vetos;
}
```

### Allocation (inherited from IGovernance)

```solidity
struct Allocation {
    uint256 voteLQTY;
    uint256 voteOffset;
    uint256 vetoLQTY;
    uint256 vetoOffset;
    uint256 atEpoch;
}
```

### UserState (inherited from IGovernance)

```solidity
struct UserState {
    uint256 unallocatedLQTY;
    uint256 unallocatedOffset;
    uint256 allocatedLQTY;
    uint256 allocatedOffset;
}
```

### InitiativeState (inherited from IGovernance)

```solidity
struct InitiativeState {
    uint256 voteLQTY;
    uint256 voteOffset;
    uint256 vetoLQTY;
    uint256 vetoOffset;
    uint256 lastEpochClaim;
}
```

### GlobalState (inherited from IGovernance)

```solidity
struct GlobalState {
    uint256 countedVoteLQTY;
    uint256 countedVoteOffset;
}
```

### ResetInitiativeData

```solidity
struct ResetInitiativeData {
    address initiative;
    int256 LQTYVotes;
    int256 LQTYVetos;
    int256 OffsetVotes;
    int256 OffsetVetos;
}
```

### AllocateLQTYMemory

```solidity
struct AllocateLQTYMemory {
    VoteSnapshot votesSnapshot_;
    GlobalState state;
    UserState userState;
    InitiativeVoteSnapshot votesForInitiativeSnapshot_;
    InitiativeState initiativeState;
    InitiativeState prevInitiativeState;
    Allocation allocation;
    uint256 currentEpoch;
    int256 deltaLQTYVotes;
    int256 deltaLQTYVetos;
    int256 deltaOffsetVotes;
    int256 deltaOffsetVetos;
}
```

## Errors

### ReentrancyGuardReentrantCall (inherited from ReentrancyGuard)

```solidity
///  @dev Unauthorized reentrant call.
error ReentrancyGuardReentrantCall();
```

## Events

### DeployUserProxy (inherited from IUserProxyFactory)

```solidity
event DeployUserProxy(address indexed user, address indexed userProxy);
```

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

### DepositLQTY (inherited from IGovernance)

```solidity
/// @notice Emitted when a user deposits LQTY
///  @param user The account depositing LQTY
///  @param rewardRecipient The account receiving the LUSD/ETH rewards earned from staking in V1, if claimed
///  @param lqtyAmount The amount of LQTY being deposited
///  @return lusdReceived Amount of LUSD tokens received as a side-effect of staking new LQTY
///  @return lusdSent Amount of LUSD tokens sent to `rewardRecipient` (may include previously received LUSD)
///  @return ethReceived Amount of ETH received as a side-effect of staking new LQTY
///  @return ethSent Amount of ETH sent to `rewardRecipient` (may include previously received ETH)
event DepositLQTY(address indexed user, address rewardRecipient, uint256 lqtyAmount, uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent);
```

### WithdrawLQTY (inherited from IGovernance)

```solidity
/// @notice Emitted when a user withdraws LQTY or claims V1 staking rewards
///  @param user The account withdrawing LQTY or claiming V1 staking rewards
///  @param recipient The account receiving the LQTY withdrawn, and if claimed, the LUSD/ETH rewards earned from staking in V1
///  @return lqtyReceived Amount of LQTY tokens actually withdrawn (may be lower than the `_lqtyAmount` passed to `withdrawLQTY`)
///  @return lqtySent Amount of LQTY tokens sent to `recipient` (may include LQTY sent to the user's proxy from sources other than V1 staking)
///  @return lusdReceived Amount of LUSD tokens received as a side-effect of staking new LQTY
///  @return lusdSent Amount of LUSD tokens sent to `recipient` (may include previously received LUSD)
///  @return ethReceived Amount of ETH received as a side-effect of staking new LQTY
///  @return ethSent Amount of ETH sent to `recipient` (may include previously received ETH)
event WithdrawLQTY(address indexed user, address recipient, uint256 lqtyReceived, uint256 lqtySent, uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent);
```

### SnapshotVotes (inherited from IGovernance)

```solidity
event SnapshotVotes(uint256 votes, uint256 forEpoch, uint256 boldAccrued);
```

### SnapshotVotesForInitiative (inherited from IGovernance)

```solidity
event SnapshotVotesForInitiative(address indexed initiative, uint256 votes, uint256 vetos, uint256 forEpoch);
```

### RegisterInitiative (inherited from IGovernance)

```solidity
event RegisterInitiative(address initiative, address registrant, uint256 atEpoch, HookStatus hookStatus);
```

### UnregisterInitiative (inherited from IGovernance)

```solidity
event UnregisterInitiative(address initiative, uint256 atEpoch, HookStatus hookStatus);
```

### AllocateLQTY (inherited from IGovernance)

```solidity
event AllocateLQTY(address indexed user, address indexed initiative, int256 deltaVoteLQTY, int256 deltaVetoLQTY, uint256 atEpoch, HookStatus hookStatus);
```

### ClaimForInitiative (inherited from IGovernance)

```solidity
event ClaimForInitiative(address indexed initiative, uint256 bold, uint256 forEpoch, HookStatus hookStatus);
```

## Enums

### HookStatus (inherited from IGovernance)

```solidity
enum HookStatus {
    Failed,
    Succeeded,
    NotCalled
}
```

### InitiativeStatus (inherited from IGovernance)

```solidity
enum InitiativeStatus {
    NONEXISTENT,
    WARM_UP,
    SKIP,
    CLAIMABLE,
    CLAIMED,
    UNREGISTERABLE,
    DISABLED
}
```

## Public/External Functions

### constructor(address,address,address,address,struct IGovernance.Configuration,address,address[])

- **Signature**: `constructor(address,address,address,address,struct IGovernance.Configuration,address,address[])`
- **Visibility**: public
- **Source Range**: 3071:1878:23
- **Details**: [function_constructor_address_address_address_address_struct_IGovernance_Configuration_address_address[].md](./function_constructor_address_address_address_address_struct_IGovernance_Configuration_address_address[].md)

**Signature:**
```solidity
constructor(address _lqty, address _lusd, address _stakingV1, address _bold, Configuration memory _config, address _owner, address[] memory _initiatives) UserProxyFactory(_lqty,_lusd,_stakingV1) Ownable(_owner);
```

### registerInitialInitiatives(address[])

- **Signature**: `registerInitialInitiatives(address[])`
- **Visibility**: public
- **Source Range**: 4955:775:23
- **Details**: [function_registerInitialInitiatives_address[].md](./function_registerInitialInitiatives_address[].md)

**Signature:**
```solidity
function registerInitialInitiatives(address[] memory _initiatives) public onlyOwner();
```

### depositLQTY(uint256)

- **Signature**: `depositLQTY(uint256)`
- **Visibility**: external
- **Source Range**: 6558:111:23
- **Details**: [function_depositLQTY_uint256.md](./function_depositLQTY_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function depositLQTY(uint256 _lqtyAmount) external;
```

### depositLQTY(uint256,bool,address)

- **Signature**: `depositLQTY(uint256,bool,address)`
- **Visibility**: public
- **Source Range**: 6675:462:23
- **Details**: [function_depositLQTY_uint256_bool_address.md](./function_depositLQTY_uint256_bool_address.md)

**Signature:**
```solidity
function depositLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public nonReentrant();
```

### depositLQTYViaPermit(uint256,struct PermitParams)

- **Signature**: `depositLQTYViaPermit(uint256,struct PermitParams)`
- **Visibility**: external
- **Source Range**: 7175:181:23
- **Details**: [function_depositLQTYViaPermit_uint256_struct_PermitParams.md](./function_depositLQTYViaPermit_uint256_struct_PermitParams.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function depositLQTYViaPermit(uint256 _lqtyAmount, PermitParams calldata _permitParams) external;
```

### depositLQTYViaPermit(uint256,struct PermitParams,bool,address)

- **Signature**: `depositLQTYViaPermit(uint256,struct PermitParams,bool,address)`
- **Visibility**: public
- **Source Range**: 7362:570:23
- **Details**: [function_depositLQTYViaPermit_uint256_struct_PermitParams_bool_address.md](./function_depositLQTYViaPermit_uint256_struct_PermitParams_bool_address.md)

**Signature:**
```solidity
function depositLQTYViaPermit(uint256 _lqtyAmount, PermitParams calldata _permitParams, bool _doSendRewards, address _recipient) public nonReentrant();
```

### withdrawLQTY(uint256)

- **Signature**: `withdrawLQTY(uint256)`
- **Visibility**: external
- **Source Range**: 7970:112:23
- **Details**: [function_withdrawLQTY_uint256.md](./function_withdrawLQTY_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function withdrawLQTY(uint256 _lqtyAmount) external;
```

### withdrawLQTY(uint256,bool,address)

- **Signature**: `withdrawLQTY(uint256,bool,address)`
- **Visibility**: public
- **Source Range**: 8088:1494:23
- **Details**: [function_withdrawLQTY_uint256_bool_address.md](./function_withdrawLQTY_uint256_bool_address.md)

**Signature:**
```solidity
function withdrawLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public nonReentrant();
```

### claimFromStakingV1(address)

- **Signature**: `claimFromStakingV1(address)`
- **Visibility**: external
- **Source Range**: 9620:717:23
- **Details**: [function_claimFromStakingV1_address.md](./function_claimFromStakingV1_address.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function claimFromStakingV1(address _rewardRecipient) external returns (uint256 lusdSent, uint256 ethSent);
```

### epoch()

- **Signature**: `epoch()`
- **Visibility**: public
- **Source Range**: 10554:125:23
- **Details**: [function_epoch.md](./function_epoch.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function epoch() public view returns (uint256);
```

### epochStart()

- **Signature**: `epochStart()`
- **Visibility**: public
- **Source Range**: 10717:120:23
- **Details**: [function_epochStart.md](./function_epochStart.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function epochStart() public view returns (uint256);
```

### secondsWithinEpoch()

- **Signature**: `secondsWithinEpoch()`
- **Visibility**: public
- **Source Range**: 10875:132:23
- **Details**: [function_secondsWithinEpoch.md](./function_secondsWithinEpoch.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function secondsWithinEpoch() public view returns (uint256);
```

### lqtyToVotes(uint256,uint256,uint256)

- **Signature**: `lqtyToVotes(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 11045:179:23
- **Details**: [function_lqtyToVotes_uint256_uint256_uint256.md](./function_lqtyToVotes_uint256_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function lqtyToVotes(uint256 _lqtyAmount, uint256 _timestamp, uint256 _offset) public pure returns (uint256);
```

### getLatestVotingThreshold()

- **Signature**: `getLatestVotingThreshold()`
- **Visibility**: public
- **Source Range**: 11444:183:23
- **Details**: [function_getLatestVotingThreshold.md](./function_getLatestVotingThreshold.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function getLatestVotingThreshold() public view returns (uint256);
```

### calculateVotingThreshold()

- **Signature**: `calculateVotingThreshold()`
- **Visibility**: public
- **Source Range**: 11665:186:23
- **Details**: [function_calculateVotingThreshold.md](./function_calculateVotingThreshold.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function calculateVotingThreshold() public returns (uint256);
```

### calculateVotingThreshold(uint256)

- **Signature**: `calculateVotingThreshold(uint256)`
- **Visibility**: public
- **Source Range**: 11889:442:23
- **Details**: [function_calculateVotingThreshold_uint256.md](./function_calculateVotingThreshold_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function calculateVotingThreshold(uint256 _votes) public view returns (uint256);
```

### getTotalVotesAndState()

- **Signature**: `getTotalVotesAndState()`
- **Visibility**: public
- **Source Range**: 13047:518:23
- **Details**: [function_getTotalVotesAndState.md](./function_getTotalVotesAndState.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function getTotalVotesAndState() public view returns (VoteSnapshot memory snapshot, GlobalState memory state, bool shouldUpdate);
```

### getInitiativeSnapshotAndState(address)

- **Signature**: `getInitiativeSnapshotAndState(address)`
- **Visibility**: public
- **Source Range**: 14281:976:23
- **Details**: [function_getInitiativeSnapshotAndState_address.md](./function_getInitiativeSnapshotAndState_address.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function getInitiativeSnapshotAndState(address _initiative) public view returns (InitiativeVoteSnapshot memory initiativeSnapshot, InitiativeState memory initiativeState, bool shouldUpdate);
```

### snapshotVotesForInitiative(address)

- **Signature**: `snapshotVotesForInitiative(address)`
- **Visibility**: external
- **Source Range**: 15295:333:23
- **Details**: [function_snapshotVotesForInitiative_address.md](./function_snapshotVotesForInitiative_address.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function snapshotVotesForInitiative(address _initiative) external nonReentrant() returns (VoteSnapshot memory voteSnapshot, InitiativeVoteSnapshot memory initiativeVoteSnapshot);
```

### getInitiativeState(address)

- **Signature**: `getInitiativeState(address)`
- **Visibility**: public
- **Source Range**: 16008:507:23
- **Details**: [function_getInitiativeState_address.md](./function_getInitiativeState_address.md)

**Signature:**
```solidity
/// @notice Given an inititive address, updates all snapshots and return the initiative state
///      See the view version of `getInitiativeState` for the underlying logic on Initatives FSM
function getInitiativeState(address _initiative) public returns (InitiativeStatus status, uint256 lastEpochClaim, uint256 claimableAmount);
```

### getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState)

- **Signature**: `getInitiativeState(address,struct IGovernance.VoteSnapshot,struct IGovernance.InitiativeVoteSnapshot,struct IGovernance.InitiativeState)`
- **Visibility**: public
- **Source Range**: 16627:3214:23
- **Details**: [function_getInitiativeState_address_struct_IGovernance_VoteSnapshot_struct_IGovernance_InitiativeVoteSnapshot_struct_IGovernance_InitiativeState.md](./function_getInitiativeState_address_struct_IGovernance_VoteSnapshot_struct_IGovernance_InitiativeVoteSnapshot_struct_IGovernance_InitiativeState.md)

**Signature:**
```solidity
/// @dev Given an initiative address and its snapshot, determines the current state for an initiative
function getInitiativeState(address _initiative, VoteSnapshot memory _votesSnapshot, InitiativeVoteSnapshot memory _votesForInitiativeSnapshot, InitiativeState memory _initiativeState) public view returns (InitiativeStatus status, uint256 lastEpochClaim, uint256 claimableAmount);
```

### registerInitiative(address)

- **Signature**: `registerInitiative(address)`
- **Visibility**: external
- **Source Range**: 19879:2024:23
- **Details**: [function_registerInitiative_address.md](./function_registerInitiative_address.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function registerInitiative(address _initiative) external nonReentrant();
```

### resetAllocations(address[],bool)

- **Signature**: `resetAllocations(address[],bool)`
- **Visibility**: external
- **Source Range**: 24168:649:23
- **Details**: [function_resetAllocations_address[]_bool.md](./function_resetAllocations_address[]_bool.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function resetAllocations(address[] calldata _initiativesToReset, bool checkAll) external nonReentrant();
```

### allocateLQTY(address[],address[],int256[],int256[])

- **Signature**: `allocateLQTY(address[],address[],int256[],int256[])`
- **Visibility**: external
- **Source Range**: 24855:4250:23
- **Details**: [function_allocateLQTY_address[]_address[]_int256[]_int256[].md](./function_allocateLQTY_address[]_address[]_int256[]_int256[].md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function allocateLQTY(address[] calldata _initiativesToReset, address[] calldata _initiatives, int256[] calldata _absoluteLQTYVotes, int256[] calldata _absoluteLQTYVetos) external nonReentrant();
```

### unregisterInitiative(address)

- **Signature**: `unregisterInitiative(address)`
- **Visibility**: external
- **Source Range**: 37510:1582:23
- **Details**: [function_unregisterInitiative_address.md](./function_unregisterInitiative_address.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function unregisterInitiative(address _initiative) external nonReentrant();
```

### claimForInitiative(address)

- **Signature**: `claimForInitiative(address)`
- **Visibility**: external
- **Source Range**: 39130:1970:23
- **Details**: [function_claimForInitiative_address.md](./function_claimForInitiative_address.md)

**Signature:**
```solidity
/// @inheritdoc IGovernance
function claimForInitiative(address _initiative) external nonReentrant() returns (uint256);
```

### multiDelegateCall(bytes[]) (inherited from MultiDelegateCall)

- **Signature**: `multiDelegateCall(bytes[])`
- **Visibility**: external
- **Source Range**: 226:698:36
- **Details**: [function_multiDelegateCall_bytes[].md](./function_multiDelegateCall_bytes[].md)

**Signature:**
```solidity
/// @inheritdoc IMultiDelegateCall
function multiDelegateCall(bytes[] calldata inputs) external returns (bytes[] memory returnValues);
```

### constructor(address,address,address) (inherited from UserProxyFactory)

- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 382:153:25
- **Details**: [function_constructor_address_address_address.md](./function_constructor_address_address_address.md)

**Signature:**
```solidity
constructor(address _lqty, address _lusd, address _stakingV1);
```

### deriveUserProxyAddress(address) (inherited from UserProxyFactory)

- **Signature**: `deriveUserProxyAddress(address)`
- **Visibility**: public
- **Source Range**: 579:194:25
- **Details**: [function_deriveUserProxyAddress_address.md](./function_deriveUserProxyAddress_address.md)

**Signature:**
```solidity
/// @inheritdoc IUserProxyFactory
function deriveUserProxyAddress(address _user) public view returns (address);
```

### deployUserProxy() (inherited from UserProxyFactory)

- **Signature**: `deployUserProxy()`
- **Visibility**: public
- **Source Range**: 817:310:25
- **Details**: [function_deployUserProxy.md](./function_deployUserProxy.md)

**Signature:**
```solidity
/// @inheritdoc IUserProxyFactory
function deployUserProxy() public returns (address);
```

### constructor(address) (inherited from Ownable)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 806:133:37
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner);
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1015:77:37
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() public view returns (address);
```

### isOwner() (inherited from Ownable)

- **Signature**: `isOwner()`
- **Visibility**: public
- **Source Range**: 1366:90:37
- **Details**: [function_isOwner.md](./function_isOwner.md)

**Signature:**
```solidity
///  @dev Returns true if the caller is the current owner.
function isOwner() public view returns (bool);
```
