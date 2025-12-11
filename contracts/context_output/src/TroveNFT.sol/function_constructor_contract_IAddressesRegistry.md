# Function: constructor(contract IAddressesRegistry)

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 660:471:276

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) ERC721(string.concat("Liquity v2 Trove - ", _addressesRegistry.collToken().name()),string.concat("Lv2T_", _addressesRegistry.collToken().symbol())) {
    troveManager = _addressesRegistry.troveManager();
    collToken = _addressesRegistry.collToken();
    metadataNFT = _addressesRegistry.metadataNFT();
    boldToken = _addressesRegistry.boldToken();
}
```

## Related Implementations

### (string,string)

- **Kind**: internal
- **Source**: 1390:113:96
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:constructor(string,string)`

```solidity
///  @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

## External Calls

- **IAddressesRegistry::troveManager()**
- **IAddressesRegistry::collToken()**
- **IAddressesRegistry::metadataNFT()**
- **IAddressesRegistry::boldToken()**

## State Variable Writes

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **collToken** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **metadataNFT** (`contract IMetadataNFT`) [src/NFTMetadata/MetadataNFT.sol/interface_IMetadataNFT.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **_name** (`string`)
- **_symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: TroveNFT.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: TroveNFT
  └─ [1] 🏗️ CONSTRUCTOR: ERC721.constructor(string,string) (NodeID: 1)
      💬 Args: [string.concat("Liquity v2 Trove - ", _addressesRegistry.collToken().name()), string.concat("Lv2T_", _addressesRegistry.collToken().symbol())]
      🏗️  Contract: ERC721
```
