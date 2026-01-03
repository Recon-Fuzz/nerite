# Function: constructor(contract IAddressesRegistry)

**Contract**: [src/Zappers/LeverageLSTZapper.sol/contract_LeverageLSTZapper.md]

## Metadata

- **Contract**: LeverageLSTZapper
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 1932:164:58
- **Inherited From**: AddRemoveManagers

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    troveNFT = _addressesRegistry.troveNFT();
    emit TroveNFTAddressChanged(address(troveNFT));
}
```

## External Calls

- **IAddressesRegistry::troveNFT()**

## State Variable Reads

- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## State Variable Writes

- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: AddRemoveManagers.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: AddRemoveManagers
```
