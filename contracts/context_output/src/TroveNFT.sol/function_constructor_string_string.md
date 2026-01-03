# Function: constructor(string,string)

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 1390:113:14
- **Inherited From**: ERC721

## Implementation

```solidity
///  @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

## State Variable Writes

- **_name** (`string`)
- **_symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: ERC721.constructor(string,string) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: ERC721
```

## Documentation

### Function Documentation

 @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
