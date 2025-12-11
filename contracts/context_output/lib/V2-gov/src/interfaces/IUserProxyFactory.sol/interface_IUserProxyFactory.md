# Interface: IUserProxyFactory

## Metadata

- **Name**: IUserProxyFactory
- **Type**: Interface
- **Path**: lib/V2-gov/src/interfaces/IUserProxyFactory.sol

## Events

### DeployUserProxy

```solidity
event DeployUserProxy(address indexed user, address indexed userProxy);
```

## Public/External Functions

### userProxyImplementation()

- **Signature**: `userProxyImplementation()`
- **Visibility**: external
- **Source Range**: 314:82:33

**Signature:**
```solidity
/// @notice Address of the UserProxy implementation contract
///  @return implementation Address of the UserProxy implementation contract
function userProxyImplementation() external view returns (address implementation);;
```

### deriveUserProxyAddress(address)

- **Signature**: `deriveUserProxyAddress(address)`
- **Visibility**: external
- **Source Range**: 575:96:33

**Signature:**
```solidity
/// @notice Derive the address of a user's proxy contract
///  @param _user Address of the user
///  @return userProxyAddress Address of the user's proxy contract
function deriveUserProxyAddress(address _user) external view returns (address userProxyAddress);;
```

### deployUserProxy()

- **Signature**: `deployUserProxy()`
- **Visibility**: external
- **Source Range**: 816:71:33

**Signature:**
```solidity
/// @notice Deploy a new UserProxy contract for the sender
///  @return userProxyAddress Address of the deployed UserProxy contract
function deployUserProxy() external returns (address userProxyAddress);;
```
