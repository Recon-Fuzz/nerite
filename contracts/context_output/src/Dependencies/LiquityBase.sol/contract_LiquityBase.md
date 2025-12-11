# Contract: LiquityBase

## Metadata

- **Name**: LiquityBase
- **Type**: Contract
- **Path**: src/Dependencies/LiquityBase.sol

## Implements Interfaces

- **ILiquityBase** [src/Interfaces/ILiquityBase.sol/interface_ILiquityBase.md]

## State Variables

### activePool

```solidity
IActivePool public activePool
```

**IActivePool**: [src/Interfaces/IActivePool.sol/interface_IActivePool.md]

### defaultPool

```solidity
IDefaultPool internal defaultPool
```

**IDefaultPool**: [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

### priceFeed

```solidity
IPriceFeed internal priceFeed
```

**IPriceFeed**: [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## Events

### ActivePoolAddressChanged

```solidity
event ActivePoolAddressChanged(address _newActivePoolAddress);
```

### DefaultPoolAddressChanged

```solidity
event DefaultPoolAddressChanged(address _newDefaultPoolAddress);
```

### PriceFeedAddressChanged

```solidity
event PriceFeedAddressChanged(address _newPriceFeedAddress);
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 816:401:214
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry);
```

### getEntireSystemColl()

- **Signature**: `getEntireSystemColl()`
- **Visibility**: public
- **Source Range**: 1265:251:214
- **Details**: [function_getEntireSystemColl.md](./function_getEntireSystemColl.md)

**Signature:**
```solidity
function getEntireSystemColl() public view returns (uint256 entireSystemColl);
```

### getEntireSystemDebt()

- **Signature**: `getEntireSystemDebt()`
- **Visibility**: public
- **Source Range**: 1522:237:214
- **Details**: [function_getEntireSystemDebt.md](./function_getEntireSystemDebt.md)

**Signature:**
```solidity
function getEntireSystemDebt() public view returns (uint256 entireSystemDebt);
```
