# Contract: CurveV2GaugeRewards

## Metadata

- **Name**: CurveV2GaugeRewards
- **Type**: Contract
- **Path**: lib/V2-gov/src/CurveV2GaugeRewards.sol

## Implements Interfaces

- **IBribeInitiative** [lib/V2-gov/src/interfaces/IBribeInitiative.sol/interface_IBribeInitiative.md]
- **IInitiative** [lib/V2-gov/src/interfaces/IInitiative.sol/interface_IInitiative.md]

## State Variables

### EPOCH_START (inherited from BribeInitiative)

```solidity
uint256 internal immutable EPOCH_START
```

### EPOCH_DURATION (inherited from BribeInitiative)

```solidity
uint256 internal immutable EPOCH_DURATION
```

### governance (inherited from BribeInitiative)

```solidity
/// @inheritdoc IBribeInitiative
IGovernance public immutable governance
```

**IGovernance**: [lib/V2-gov/src/interfaces/IGovernance.sol/interface_IGovernance.md]

### bold (inherited from BribeInitiative)

```solidity
/// @inheritdoc IBribeInitiative
IERC20 public immutable bold
```

**IERC20**: [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### bribeToken (inherited from BribeInitiative)

```solidity
/// @inheritdoc IBribeInitiative
IERC20 public immutable bribeToken
```

**IERC20**: [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### bribeByEpoch (inherited from BribeInitiative)

```solidity
/// @inheritdoc IBribeInitiative
mapping(uint256 => Bribe) public bribeByEpoch
```

### claimedBribeAtEpoch (inherited from BribeInitiative)

```solidity
/// @inheritdoc IBribeInitiative
mapping(address => mapping(uint256 => bool)) public claimedBribeAtEpoch
```

### totalLQTYAllocationByEpoch (inherited from BribeInitiative)

```solidity
/// Double linked list of the total LQTY allocated at a given epoch
DoubleLinkedList.List internal totalLQTYAllocationByEpoch
```

### lqtyAllocationByUserAtEpoch (inherited from BribeInitiative)

```solidity
/// Double linked list of LQTY allocated by a user at a given epoch
mapping(address => DoubleLinkedList.List) internal lqtyAllocationByUserAtEpoch
```

### gauge

```solidity
ILiquidityGauge public immutable gauge
```

**ILiquidityGauge**: [lib/V2-gov/src/interfaces/ILiquidityGauge.sol/interface_ILiquidityGauge.md]

### duration

```solidity
uint256 public immutable duration
```

### remainder

```solidity
uint256 public remainder
```

## Structs

### Bribe (inherited from IBribeInitiative)

```solidity
struct Bribe {
    uint256 remainingBoldAmount;
    uint256 remainingBribeTokenAmount;
    uint256 claimedVotes;
}
```

### ClaimData (inherited from IBribeInitiative)

```solidity
struct ClaimData {
    uint256 epoch;
    uint256 prevLQTYAllocationEpoch;
    uint256 prevTotalLQTYAllocationEpoch;
}
```

## Events

### DepositBribe (inherited from IBribeInitiative)

```solidity
event DepositBribe(address depositor, uint256 boldAmount, uint256 bribeTokenAmount, uint256 epoch);
```

### ModifyLQTYAllocation (inherited from IBribeInitiative)

```solidity
event ModifyLQTYAllocation(address user, uint256 epoch, uint256 lqtyAllocated, uint256 offset);
```

### ModifyTotalLQTYAllocation (inherited from IBribeInitiative)

```solidity
event ModifyTotalLQTYAllocation(uint256 epoch, uint256 totalLQTYAllocated, uint256 offset);
```

### ClaimBribe (inherited from IBribeInitiative)

```solidity
event ClaimBribe(address user, uint256 epoch, uint256 boldAmount, uint256 bribeTokenAmount);
```

### DepositIntoGauge

```solidity
event DepositIntoGauge(uint256 amount);
```

## Public/External Functions

### constructor(address,address,address,address,uint256)

- **Signature**: `constructor(address,address,address,address,uint256)`
- **Visibility**: public
- **Source Range**: 370:243:22
- **Details**: [function_constructor_address_address_address_address_uint256.md](./function_constructor_address_address_address_address_uint256.md)

**Signature:**
```solidity
constructor(address _governance, address _bold, address _bribeToken, address _gauge, uint256 _duration) BribeInitiative(_governance,_bold,_bribeToken);
```

### onClaimForInitiative(uint256,uint256)

- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 785:128:22
- **Details**: [function_onClaimForInitiative_uint256_uint256.md](./function_onClaimForInitiative_uint256_uint256.md)

**Signature:**
```solidity
/// @notice Governance transfers Bold, and we deposit it into the gauge
///  @dev Doing this allows anyone to trigger the claim
function onClaimForInitiative(uint256, uint256 _bold) override external onlyGovernance();
```

### constructor(address,address,address) (inherited from BribeInitiative)

- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 1506:385:21
- **Details**: [function_constructor_address_address_address.md](./function_constructor_address_address_address.md)

**Signature:**
```solidity
constructor(address _governance, address _bold, address _bribeToken);
```

### totalLQTYAllocatedByEpoch(uint256) (inherited from BribeInitiative)

- **Signature**: `totalLQTYAllocatedByEpoch(uint256)`
- **Visibility**: external
- **Source Range**: 2071:212:21
- **Details**: [function_totalLQTYAllocatedByEpoch_uint256.md](./function_totalLQTYAllocatedByEpoch_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function totalLQTYAllocatedByEpoch(uint256 _epoch) external view returns (uint256, uint256);
```

### lqtyAllocatedByUserAtEpoch(address,uint256) (inherited from BribeInitiative)

- **Signature**: `lqtyAllocatedByUserAtEpoch(address,uint256)`
- **Visibility**: external
- **Source Range**: 2326:278:21
- **Details**: [function_lqtyAllocatedByUserAtEpoch_address_uint256.md](./function_lqtyAllocatedByUserAtEpoch_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function lqtyAllocatedByUserAtEpoch(address _user, uint256 _epoch) external view returns (uint256, uint256);
```

### depositBribe(uint256,uint256,uint256) (inherited from BribeInitiative)

- **Signature**: `depositBribe(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2647:599:21
- **Details**: [function_depositBribe_uint256_uint256_uint256.md](./function_depositBribe_uint256_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function depositBribe(uint256 _boldAmount, uint256 _bribeTokenAmount, uint256 _epoch) external;
```

### claimBribes(struct IBribeInitiative.ClaimData[]) (inherited from BribeInitiative)

- **Signature**: `claimBribes(struct IBribeInitiative.ClaimData[])`
- **Visibility**: external
- **Source Range**: 5953:732:21
- **Details**: [function_claimBribes_struct_IBribeInitiative_ClaimData[].md](./function_claimBribes_struct_IBribeInitiative_ClaimData[].md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function claimBribes(ClaimData[] calldata _claimData) external returns (uint256 boldAmount, uint256 bribeTokenAmount);
```

### onRegisterInitiative(uint256) (inherited from BribeInitiative)

- **Signature**: `onRegisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 6723:82:21
- **Details**: [function_onRegisterInitiative_uint256.md](./function_onRegisterInitiative_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IInitiative
function onRegisterInitiative(uint256) virtual override external onlyGovernance();
```

### onUnregisterInitiative(uint256) (inherited from BribeInitiative)

- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 6843:84:21
- **Details**: [function_onUnregisterInitiative_uint256.md](./function_onUnregisterInitiative_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IInitiative
function onUnregisterInitiative(uint256) virtual override external onlyGovernance();
```

### getMostRecentUserEpoch(address) (inherited from BribeInitiative)

- **Signature**: `getMostRecentUserEpoch(address)`
- **Visibility**: external
- **Source Range**: 7956:207:21
- **Details**: [function_getMostRecentUserEpoch_address.md](./function_getMostRecentUserEpoch_address.md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function getMostRecentUserEpoch(address _user) external view returns (uint256);
```

### getMostRecentTotalEpoch() (inherited from BribeInitiative)

- **Signature**: `getMostRecentTotalEpoch()`
- **Visibility**: external
- **Source Range**: 8206:189:21
- **Details**: [function_getMostRecentTotalEpoch.md](./function_getMostRecentTotalEpoch.md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function getMostRecentTotalEpoch() external view returns (uint256);
```

### onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState) (inherited from BribeInitiative)

- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 8401:937:21
- **Details**: [function_onAfterAllocateLQTY_uint256_address_struct_IGovernance_UserState_struct_IGovernance_Allocation_struct_IGovernance_InitiativeState.md](./function_onAfterAllocateLQTY_uint256_address_struct_IGovernance_UserState_struct_IGovernance_Allocation_struct_IGovernance_InitiativeState.md)

**Signature:**
```solidity
function onAfterAllocateLQTY(uint256 _currentEpoch, address _user, IGovernance.UserState calldata, IGovernance.Allocation calldata _allocation, IGovernance.InitiativeState calldata _initiativeState) virtual external onlyGovernance();
```
