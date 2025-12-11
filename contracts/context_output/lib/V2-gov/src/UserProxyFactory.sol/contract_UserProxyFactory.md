# Contract: UserProxyFactory

## Metadata

- **Name**: UserProxyFactory
- **Type**: Contract
- **Path**: lib/V2-gov/src/UserProxyFactory.sol

## Implements Interfaces

- **IUserProxyFactory** [lib/V2-gov/src/interfaces/IUserProxyFactory.sol/interface_IUserProxyFactory.md]

## State Variables

### userProxyImplementation

```solidity
/// @inheritdoc IUserProxyFactory
address public immutable userProxyImplementation
```

## Events

### DeployUserProxy (inherited from IUserProxyFactory)

```solidity
event DeployUserProxy(address indexed user, address indexed userProxy);
```

## Public/External Functions

### constructor(address,address,address)

- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 382:153:25
- **Details**: [function_constructor_address_address_address.md](./function_constructor_address_address_address.md)

**Signature:**
```solidity
constructor(address _lqty, address _lusd, address _stakingV1);
```

### deriveUserProxyAddress(address)

- **Signature**: `deriveUserProxyAddress(address)`
- **Visibility**: public
- **Source Range**: 579:194:25
- **Details**: [function_deriveUserProxyAddress_address.md](./function_deriveUserProxyAddress_address.md)

**Signature:**
```solidity
/// @inheritdoc IUserProxyFactory
function deriveUserProxyAddress(address _user) public view returns (address);
```

### deployUserProxy()

- **Signature**: `deployUserProxy()`
- **Visibility**: public
- **Source Range**: 817:310:25
- **Details**: [function_deployUserProxy.md](./function_deployUserProxy.md)

**Signature:**
```solidity
/// @inheritdoc IUserProxyFactory
function deployUserProxy() public returns (address);
```
