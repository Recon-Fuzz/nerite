# Function: constructor(contract IAddressesRegistry)

**Contract**: [src/Dependencies/LiquityBase.sol/contract_LiquityBase.md]

## Metadata

- **Contract**: LiquityBase
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 816:401:63

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    activePool = _addressesRegistry.activePool();
    defaultPool = _addressesRegistry.defaultPool();
    priceFeed = _addressesRegistry.priceFeed();
    emit ActivePoolAddressChanged(address(activePool));
    emit DefaultPoolAddressChanged(address(defaultPool));
    emit PriceFeedAddressChanged(address(priceFeed));
}
```

## External Calls

- **IAddressesRegistry::activePool()**
- **IAddressesRegistry::defaultPool()**
- **IAddressesRegistry::priceFeed()**

## State Variable Reads

- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **priceFeed** (`contract IPriceFeed`) [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## State Variable Writes

- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **priceFeed** (`contract IPriceFeed`) [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: LiquityBase.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: LiquityBase
```
