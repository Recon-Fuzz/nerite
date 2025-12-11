# Interface: ISuperfluidPool

## Metadata

- **Name**: ISuperfluidPool
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/ISuperfluidPool.sol
- **Documentation**:  @dev The interface for any super token pool regardless of the distribution schemes.

## Implements Interfaces

- **IERC20Metadata** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Errors

### SUPERFLUID_POOL_INVALID_TIME

```solidity
error SUPERFLUID_POOL_INVALID_TIME();
```

### SUPERFLUID_POOL_NO_POOL_MEMBERS

```solidity
error SUPERFLUID_POOL_NO_POOL_MEMBERS();
```

### SUPERFLUID_POOL_NO_ZERO_ADDRESS

```solidity
error SUPERFLUID_POOL_NO_ZERO_ADDRESS();
```

### SUPERFLUID_POOL_NOT_POOL_ADMIN_OR_GDA

```solidity
error SUPERFLUID_POOL_NOT_POOL_ADMIN_OR_GDA();
```

### SUPERFLUID_POOL_NOT_GDA

```solidity
error SUPERFLUID_POOL_NOT_GDA();
```

### SUPERFLUID_POOL_TRANSFER_UNITS_NOT_ALLOWED

```solidity
error SUPERFLUID_POOL_TRANSFER_UNITS_NOT_ALLOWED();
```

### SUPERFLUID_POOL_SELF_TRANSFER_NOT_ALLOWED

```solidity
error SUPERFLUID_POOL_SELF_TRANSFER_NOT_ALLOWED();
```

## Events

### Transfer (inherited from IERC20)

```solidity
///  @dev Emitted when `value` tokens are moved from one account (`from`) to
///  another (`to`).
///  Note that `value` may be zero.
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval (inherited from IERC20)

```solidity
///  @dev Emitted when the allowance of a `spender` for an `owner` is set by
///  a call to {approve}. `value` is the new allowance.
event Approval(address indexed owner, address indexed spender, uint256 value);
```

### MemberUnitsUpdated

```solidity
event MemberUnitsUpdated(ISuperfluidToken indexed token, address indexed member, uint128 oldUnits, uint128 newUnits);
```

### DistributionClaimed

```solidity
event DistributionClaimed(ISuperfluidToken indexed token, address indexed member, int256 claimedAmount, int256 totalClaimed);
```

## Public/External Functions

### transferabilityForUnitsOwner()

- **Signature**: `transferabilityForUnitsOwner()`
- **Visibility**: external
- **Source Range**: 1288:69:137

**Signature:**
```solidity
/// @notice A boolean indicating whether pool members can transfer their units
function transferabilityForUnitsOwner() external view returns (bool);;
```

### distributionFromAnyAddress()

- **Signature**: `distributionFromAnyAddress()`
- **Visibility**: external
- **Source Range**: 1472:67:137

**Signature:**
```solidity
/// @notice A boolean indicating whether addresses other than the pool admin can distribute via the pool
function distributionFromAnyAddress() external view returns (bool);;
```

### admin()

- **Signature**: `admin()`
- **Visibility**: external
- **Source Range**: 1726:49:137

**Signature:**
```solidity
/// @notice The pool admin
///  @dev The admin is the creator of the pool and has permissions to update member units
///  and is the recipient of the adjustment flow rate
function admin() external view returns (address);;
```

### superToken()

- **Signature**: `superToken()`
- **Visibility**: external
- **Source Range**: 1825:63:137

**Signature:**
```solidity
/// @notice The SuperToken for the pool
function superToken() external view returns (ISuperfluidToken);;
```

### getTotalUnits()

- **Signature**: `getTotalUnits()`
- **Visibility**: external
- **Source Range**: 1938:57:137

**Signature:**
```solidity
/// @notice The total units of the pool
function getTotalUnits() external view returns (uint128);;
```

### getTotalConnectedUnits()

- **Signature**: `getTotalConnectedUnits()`
- **Visibility**: external
- **Source Range**: 2064:66:137

**Signature:**
```solidity
/// @notice The total number of units of connected members
function getTotalConnectedUnits() external view returns (uint128);;
```

### getTotalDisconnectedUnits()

- **Signature**: `getTotalDisconnectedUnits()`
- **Visibility**: external
- **Source Range**: 2202:69:137

**Signature:**
```solidity
/// @notice The total number of units of disconnected members
function getTotalDisconnectedUnits() external view returns (uint128);;
```

### getUnits(address)

- **Signature**: `getUnits(address)`
- **Visibility**: external
- **Source Range**: 2388:70:137

**Signature:**
```solidity
/// @notice The total number of units for `memberAddr`
///  @param memberAddr The address of the member
function getUnits(address memberAddr) external view returns (uint128);;
```

### getTotalFlowRate()

- **Signature**: `getTotalFlowRate()`
- **Visibility**: external
- **Source Range**: 2512:58:137

**Signature:**
```solidity
/// @notice The total flow rate of the pool
function getTotalFlowRate() external view returns (int96);;
```

### getTotalConnectedFlowRate()

- **Signature**: `getTotalConnectedFlowRate()`
- **Visibility**: external
- **Source Range**: 2631:67:137

**Signature:**
```solidity
/// @notice The flow rate of the connected members
function getTotalConnectedFlowRate() external view returns (int96);;
```

### getTotalDisconnectedFlowRate()

- **Signature**: `getTotalDisconnectedFlowRate()`
- **Visibility**: external
- **Source Range**: 2762:70:137

**Signature:**
```solidity
/// @notice The flow rate of the disconnected members
function getTotalDisconnectedFlowRate() external view returns (int96);;
```

### getDisconnectedBalance(uint32)

- **Signature**: `getDisconnectedBalance(uint32)`
- **Visibility**: external
- **Source Range**: 2946:84:137

**Signature:**
```solidity
/// @notice The balance of all the disconnected members at `time`
///  @param time The time to query
function getDisconnectedBalance(uint32 time) external view returns (int256 balance);;
```

### getTotalAmountReceivedByMember(address)

- **Signature**: `getTotalAmountReceivedByMember(address)`
- **Visibility**: external
- **Source Range**: 3234:112:137

**Signature:**
```solidity
/// @notice The total amount received by `memberAddr` in the pool
///  @param memberAddr The address of the member
///  @return totalAmountReceived The total amount received by the member
function getTotalAmountReceivedByMember(address memberAddr) external view returns (uint256 totalAmountReceived);;
```

### getMemberFlowRate(address)

- **Signature**: `getMemberFlowRate(address)`
- **Visibility**: external
- **Source Range**: 3470:77:137

**Signature:**
```solidity
/// @notice The flow rate a member is receiving from the pool
///  @param memberAddr The address of the member
function getMemberFlowRate(address memberAddr) external view returns (int96);;
```

### getClaimable(address,uint32)

- **Signature**: `getClaimable(address,uint32)`
- **Visibility**: external
- **Source Range**: 3720:86:137

**Signature:**
```solidity
/// @notice The claimable balance for `memberAddr` at `time` in the pool
///  @param memberAddr The address of the member
///  @param time The time to query
function getClaimable(address memberAddr, uint32 time) external view returns (int256);;
```

### getClaimableNow(address)

- **Signature**: `getClaimableNow(address)`
- **Visibility**: external
- **Source Range**: 3952:112:137

**Signature:**
```solidity
/// @notice The claimable balance for `memberAddr` at `block.timestamp` in the pool
///  @param memberAddr The address of the member
function getClaimableNow(address memberAddr) external view returns (int256 claimableBalance, uint256 timestamp);;
```

### updateMemberUnits(address,uint128)

- **Signature**: `updateMemberUnits(address,uint128)`
- **Visibility**: external
- **Source Range**: 4234:89:137

**Signature:**
```solidity
/// @notice Sets `memberAddr` ownedUnits to `newUnits`
///  @param memberAddr The address of the member
///  @param newUnits The new units for the member
function updateMemberUnits(address memberAddr, uint128 newUnits) external returns (bool);;
```

### claimAll(address)

- **Signature**: `claimAll(address)`
- **Visibility**: external
- **Source Range**: 4464:62:137

**Signature:**
```solidity
/// @notice Claims the claimable balance for `memberAddr` at `block.timestamp`
///  @param memberAddr The address of the member
function claimAll(address memberAddr) external returns (bool);;
```

### claimAll()

- **Signature**: `claimAll()`
- **Visibility**: external
- **Source Range**: 4615:44:137

**Signature:**
```solidity
/// @notice Claims the claimable balance for `msg.sender` at `block.timestamp`
function claimAll() external returns (bool);;
```

### increaseAllowance(address,uint256)

- **Signature**: `increaseAllowance(address,uint256)`
- **Visibility**: external
- **Source Range**: 4885:88:137

**Signature:**
```solidity
/// @notice Increases the allowance of `spender` by `addedValue`
///  @param spender The address of the spender
///  @param addedValue The amount to increase the allowance by
///  @return true if successful
function increaseAllowance(address spender, uint256 addedValue) external returns (bool);;
```

### decreaseAllowance(address,uint256)

- **Signature**: `decreaseAllowance(address,uint256)`
- **Visibility**: external
- **Source Range**: 5209:93:137

**Signature:**
```solidity
/// @notice Decreases the allowance of `spender` by `subtractedValue`
///  @param spender The address of the spender
///  @param subtractedValue The amount to decrease the allowance by
///  @return true if successful
function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);;
```

### totalSupply() (inherited from IERC20)

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 774:55:87

**Signature:**
```solidity
///  @dev Returns the amount of tokens in existence.
function totalSupply() external view returns (uint256);;
```

### balanceOf(address) (inherited from IERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 912:68:87

**Signature:**
```solidity
///  @dev Returns the amount of tokens owned by `account`.
function balanceOf(address account) external view returns (uint256);;
```

### transfer(address,uint256) (inherited from IERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 1193:70:87

**Signature:**
```solidity
///  @dev Moves `amount` tokens from the caller's account to `to`.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transfer(address to, uint256 amount) external returns (bool);;
```

### allowance(address,address) (inherited from IERC20)

- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 1538:83:87

**Signature:**
```solidity
///  @dev Returns the remaining number of tokens that `spender` will be
///  allowed to spend on behalf of `owner` through {transferFrom}. This is
///  zero by default.
///  This value changes when {approve} or {transferFrom} are called.
function allowance(address owner, address spender) external view returns (uint256);;
```

### approve(address,uint256) (inherited from IERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 2274:74:87

**Signature:**
```solidity
///  @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
///  Returns a boolean value indicating whether the operation succeeded.
///  IMPORTANT: Beware that changing an allowance with this method brings the risk
///  that someone may use both the old and the new allowance by unfortunate
///  transaction ordering. One possible solution to mitigate this race
///  condition is to first reduce the spender's allowance to 0 and set the
///  desired value afterwards:
///  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
///  Emits an {Approval} event.
function approve(address spender, uint256 amount) external returns (bool);;
```

### transferFrom(address,address,uint256) (inherited from IERC20)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2646:88:87

**Signature:**
```solidity
///  @dev Moves `amount` tokens from `from` to `to` using the
///  allowance mechanism. `amount` is then deducted from the caller's
///  allowance.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transferFrom(address from, address to, uint256 amount) external returns (bool);;
```

### name() (inherited from IERC20Metadata)

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 377:54:92

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() external view returns (string memory);;
```

### symbol() (inherited from IERC20Metadata)

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 498:56:92

**Signature:**
```solidity
///  @dev Returns the symbol of the token.
function symbol() external view returns (string memory);;
```

### decimals() (inherited from IERC20Metadata)

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 630:50:92

**Signature:**
```solidity
///  @dev Returns the decimals places of the token.
function decimals() external view returns (uint8);;
```
