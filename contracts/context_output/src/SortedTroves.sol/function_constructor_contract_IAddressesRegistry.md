# Function: constructor(contract IAddressesRegistry)

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 2988:552:122

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    nodes[ROOT_NODE_ID].nextId = ROOT_NODE_ID;
    nodes[ROOT_NODE_ID].prevId = ROOT_NODE_ID;
    troveManager = ITroveManager(_addressesRegistry.troveManager());
    borrowerOperationsAddress = address(_addressesRegistry.borrowerOperations());
    emit TroveManagerAddressChanged(address(troveManager));
    emit BorrowerOperationsAddressChanged(borrowerOperationsAddress);
}
```

## External Calls

- **IAddressesRegistry::troveManager()**
- **IAddressesRegistry::borrowerOperations()**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **borrowerOperationsAddress** (`address`)

## State Variable Writes

- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **borrowerOperationsAddress** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SortedTroves.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SortedTroves
```
