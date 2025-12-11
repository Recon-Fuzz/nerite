# Contract: UserProxy

## Metadata

- **Name**: UserProxy
- **Type**: Contract
- **Path**: lib/V2-gov/src/UserProxy.sol

## Implements Interfaces

- **IUserProxy** [lib/V2-gov/src/interfaces/IUserProxy.sol/interface_IUserProxy.md]

## State Variables

### lqty

```solidity
/// @inheritdoc IUserProxy
IERC20 public immutable lqty
```

**IERC20**: [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### lusd

```solidity
/// @inheritdoc IUserProxy
IERC20 public immutable lusd
```

**IERC20**: [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### stakingV1

```solidity
/// @inheritdoc IUserProxy
ILQTYStaking public immutable stakingV1
```

**ILQTYStaking**: [lib/V2-gov/src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]

### stakingV2

```solidity
/// @inheritdoc IUserProxy
address public immutable stakingV2
```

## Public/External Functions

### constructor(address,address,address)

- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 703:207:24
- **Details**: [function_constructor_address_address_address.md](./function_constructor_address_address_address.md)

**Signature:**
```solidity
constructor(address _lqty, address _lusd, address _stakingV1);
```

### stake(uint256,address,bool,address)

- **Signature**: `stake(uint256,address,bool,address)`
- **Visibility**: public
- **Source Range**: 1073:777:24
- **Details**: [function_stake_uint256_address_bool_address.md](./function_stake_uint256_address_bool_address.md)

**Signature:**
```solidity
/// @inheritdoc IUserProxy
function stake(uint256 _amount, address _lqtyFrom, bool _doSendRewards, address _recipient) public onlyStakingV2() returns (uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent);
```

### stakeViaPermit(uint256,address,struct PermitParams,bool,address)

- **Signature**: `stakeViaPermit(uint256,address,struct PermitParams,bool,address)`
- **Visibility**: external
- **Source Range**: 1887:748:24
- **Details**: [function_stakeViaPermit_uint256_address_struct_PermitParams_bool_address.md](./function_stakeViaPermit_uint256_address_struct_PermitParams_bool_address.md)

**Signature:**
```solidity
/// @inheritdoc IUserProxy
function stakeViaPermit(uint256 _amount, address _lqtyFrom, PermitParams calldata _permitParams, bool _doSendRewards, address _recipient) external onlyStakingV2() returns (uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent);
```

### unstake(uint256,bool,address)

- **Signature**: `unstake(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 2672:1057:24
- **Details**: [function_unstake_uint256_bool_address.md](./function_unstake_uint256_bool_address.md)

**Signature:**
```solidity
/// @inheritdoc IUserProxy
function unstake(uint256 _amount, bool _doSendRewards, address _recipient) external onlyStakingV2() returns (uint256 lqtyReceived, uint256 lqtySent, uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent);
```

### staked()

- **Signature**: `staked()`
- **Visibility**: external
- **Source Range**: 4219:105:24
- **Details**: [function_staked.md](./function_staked.md)

**Signature:**
```solidity
/// @inheritdoc IUserProxy
function staked() external view returns (uint256);
```

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 4330:29:24
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
receive() external payable;
```
