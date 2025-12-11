# Function: constructor(contract IAddressesRegistry)

**Contract**: [src/GasPool.sol/contract_GasPool.md]

## Metadata

- **Contract**: GasPool
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 710:534:217

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    IWETH WETH = _addressesRegistry.WETH();
    IBorrowerOperations borrowerOperations = _addressesRegistry.borrowerOperations();
    ITroveManager troveManager = _addressesRegistry.troveManager();
    WETH.approve(address(borrowerOperations), type(uint256).max);
    WETH.approve(address(troveManager), type(uint256).max);
}
```

## External Calls

- **IAddressesRegistry::WETH()**
- **IAddressesRegistry::borrowerOperations()**
- **IAddressesRegistry::troveManager()**
- **IWETH::approve(address,uint256)**

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: GasPool.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: GasPool
```
