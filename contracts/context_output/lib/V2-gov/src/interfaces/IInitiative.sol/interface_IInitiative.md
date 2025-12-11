# Interface: IInitiative

## Metadata

- **Name**: IInitiative
- **Type**: Interface
- **Path**: lib/V2-gov/src/interfaces/IInitiative.sol

## Public/External Functions

### onRegisterInitiative(uint256)

- **Signature**: `onRegisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 310:57:28

**Signature:**
```solidity
/// @notice Callback hook that is called by Governance after the initiative was successfully registered
///  @param _atEpoch Epoch at which the initiative is registered
function onRegisterInitiative(uint256 _atEpoch) external;;
```

### onUnregisterInitiative(uint256)

- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 540:59:28

**Signature:**
```solidity
/// @notice Callback hook that is called by Governance after the initiative was unregistered
///  @param _atEpoch Epoch at which the initiative is unregistered
function onUnregisterInitiative(uint256 _atEpoch) external;;
```

### onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)

- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 1016:265:28

**Signature:**
```solidity
/// @notice Callback hook that is called by Governance after the LQTY allocation is updated by a user
///  @param _currentEpoch Epoch at which the LQTY allocation is updated
///  @param _user Address of the user that updated their LQTY allocation
///  @param _userState User state
///  @param _allocation Allocation state from user to initiative
///  @param _initiativeState Initiative state
function onAfterAllocateLQTY(uint256 _currentEpoch, address _user, IGovernance.UserState calldata _userState, IGovernance.Allocation calldata _allocation, IGovernance.InitiativeState calldata _initiativeState) external;;
```

### onClaimForInitiative(uint256,uint256)

- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1548:75:28

**Signature:**
```solidity
/// @notice Callback hook that is called by Governance after the claim for the last epoch was distributed
///  to the initiative
///  @param _claimEpoch Epoch at which the claim was distributed
///  @param _bold Amount of BOLD that was distributed
function onClaimForInitiative(uint256 _claimEpoch, uint256 _bold) external;;
```
