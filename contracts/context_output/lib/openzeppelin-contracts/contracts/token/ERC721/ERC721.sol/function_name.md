# Function: name()

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol/contract_ERC721.md]

## Metadata

- **Contract**: ERC721
- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 2471:98:14

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
