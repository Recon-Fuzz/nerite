# Contract: DefaultPool

## Metadata

- **Name**: DefaultPool
- **Type**: Contract
- **Path**: src/DefaultPool.sol

## Implements Interfaces

- **IDefaultPool** [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

## State Variables

### NAME

```solidity
string public constant NAME = "DefaultPool"
```

### collToken

```solidity
IERC20 public immutable collToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### troveManagerAddress

```solidity
address public immutable troveManagerAddress
```

### activePoolAddress

```solidity
address public immutable activePoolAddress
```

### collBalance

```solidity
uint256 internal collBalance
```

### BoldDebt

```solidity
uint256 internal BoldDebt
```

## Events

### CollTokenAddressChanged

```solidity
event CollTokenAddressChanged(address _newCollTokenAddress);
```

### ActivePoolAddressChanged

```solidity
event ActivePoolAddressChanged(address _newActivePoolAddress);
```

### TroveManagerAddressChanged

```solidity
event TroveManagerAddressChanged(address _newTroveManagerAddress);
```

### DefaultPoolBoldDebtUpdated

```solidity
event DefaultPoolBoldDebtUpdated(uint256 _boldDebt);
```

### DefaultPoolCollBalanceUpdated

```solidity
event DefaultPoolCollBalanceUpdated(uint256 _collBalance);
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 1348:558:57
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry);
```

### getCollBalance()

- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 2162:102:57
- **Details**: [function_getCollBalance.md](./function_getCollBalance.md)

**Signature:**
```solidity
function getCollBalance() override external view returns (uint256);
```

### getBoldDebt()

- **Signature**: `getBoldDebt()`
- **Visibility**: external
- **Source Range**: 2270:96:57
- **Details**: [function_getBoldDebt.md](./function_getBoldDebt.md)

**Signature:**
```solidity
function getBoldDebt() override external view returns (uint256);
```

### sendCollToActivePool(uint256)

- **Signature**: `sendCollToActivePool(uint256)`
- **Visibility**: external
- **Source Range**: 2407:403:57
- **Details**: [function_sendCollToActivePool_uint256.md](./function_sendCollToActivePool_uint256.md)

**Signature:**
```solidity
function sendCollToActivePool(uint256 _amount) override external;
```

### receiveColl(uint256)

- **Signature**: `receiveColl(uint256)`
- **Visibility**: external
- **Source Range**: 2816:365:57
- **Details**: [function_receiveColl_uint256.md](./function_receiveColl_uint256.md)

**Signature:**
```solidity
function receiveColl(uint256 _amount) external;
```

### increaseBoldDebt(uint256)

- **Signature**: `increaseBoldDebt(uint256)`
- **Visibility**: external
- **Source Range**: 3187:198:57
- **Details**: [function_increaseBoldDebt_uint256.md](./function_increaseBoldDebt_uint256.md)

**Signature:**
```solidity
function increaseBoldDebt(uint256 _amount) override external;
```

### decreaseBoldDebt(uint256)

- **Signature**: `decreaseBoldDebt(uint256)`
- **Visibility**: external
- **Source Range**: 3391:198:57
- **Details**: [function_decreaseBoldDebt_uint256.md](./function_decreaseBoldDebt_uint256.md)

**Signature:**
```solidity
function decreaseBoldDebt(uint256 _amount) override external;
```
