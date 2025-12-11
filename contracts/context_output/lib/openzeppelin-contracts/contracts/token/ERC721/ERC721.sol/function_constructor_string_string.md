# Function: constructor(string,string)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol/contract_ERC721.md]

## Metadata

- **Contract**: ERC721
- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 1390:113:96

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
