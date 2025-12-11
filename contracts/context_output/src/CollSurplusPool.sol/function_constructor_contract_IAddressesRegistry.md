# Function: constructor(contract IAddressesRegistry)

**Contract**: [src/CollSurplusPool.sol/contract_CollSurplusPool.md]

## Metadata

- **Contract**: CollSurplusPool
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 997:407:206

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    collToken = _addressesRegistry.collToken();
    borrowerOperationsAddress = address(_addressesRegistry.borrowerOperations());
    troveManagerAddress = address(_addressesRegistry.troveManager());
    emit BorrowerOperationsAddressChanged(borrowerOperationsAddress);
    emit TroveManagerAddressChanged(troveManagerAddress);
}
```

## External Calls

- **IAddressesRegistry::collToken()**
- **IAddressesRegistry::borrowerOperations()**
- **IAddressesRegistry::troveManager()**

## State Variable Reads

- **borrowerOperationsAddress** (`address`)
- **troveManagerAddress** (`address`)

## State Variable Writes

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **borrowerOperationsAddress** (`address`)
- **troveManagerAddress** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: CollSurplusPool.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: CollSurplusPool
```
