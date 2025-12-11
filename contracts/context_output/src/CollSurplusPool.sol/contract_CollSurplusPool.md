# Contract: CollSurplusPool

## Metadata

- **Name**: CollSurplusPool
- **Type**: Contract
- **Path**: src/CollSurplusPool.sol

## Implements Interfaces

- **ICollSurplusPool** [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]

## State Variables

### NAME

```solidity
string public constant NAME = "CollSurplusPool"
```

### collToken

```solidity
IERC20 public immutable collToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### borrowerOperationsAddress

```solidity
address public immutable borrowerOperationsAddress
```

### troveManagerAddress

```solidity
address public immutable troveManagerAddress
```

### collBalance

```solidity
uint256 internal collBalance
```

### balances

```solidity
mapping(address => uint256) internal balances
```

## Events

### BorrowerOperationsAddressChanged

```solidity
event BorrowerOperationsAddressChanged(address _newBorrowerOperationsAddress);
```

### TroveManagerAddressChanged

```solidity
event TroveManagerAddressChanged(address _newTroveManagerAddress);
```

### CollBalanceUpdated

```solidity
event CollBalanceUpdated(address indexed _account, uint256 _newBalance);
```

### CollSent

```solidity
event CollSent(address indexed _to, uint256 _amount);
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 997:407:206
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry);
```

### getCollBalance()

- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 1554:102:206
- **Details**: [function_getCollBalance.md](./function_getCollBalance.md)

**Signature:**
```solidity
function getCollBalance() override external view returns (uint256);
```

### getCollateral(address)

- **Signature**: `getCollateral(address)`
- **Visibility**: external
- **Source Range**: 1662:124:206
- **Details**: [function_getCollateral_address.md](./function_getCollateral_address.md)

**Signature:**
```solidity
function getCollateral(address _account) override external view returns (uint256);
```

### accountSurplus(address,uint256)

- **Signature**: `accountSurplus(address,uint256)`
- **Visibility**: external
- **Source Range**: 1827:323:206
- **Details**: [function_accountSurplus_address_uint256.md](./function_accountSurplus_address_uint256.md)

**Signature:**
```solidity
function accountSurplus(address _account, uint256 _amount) override external;
```

### claimColl(address)

- **Signature**: `claimColl(address)`
- **Visibility**: external
- **Source Range**: 2156:486:206
- **Details**: [function_claimColl_address.md](./function_claimColl_address.md)

**Signature:**
```solidity
function claimColl(address _account) override external;
```
