# Function: name()

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 2471:98:96
- **Inherited From**: ERC721

## Implementation

```solidity
///  @dev See {IERC721Metadata-name}.
function name() virtual override public view returns (string memory) {
    return _name;
}
```

## State Variable Reads

- **_name** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC721.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev See {IERC721Metadata-name}.

### Interface Documentation

 @dev Returns the token collection name.
