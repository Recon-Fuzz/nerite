# Function: symbol()

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 2633:102:96
- **Inherited From**: ERC721

## Implementation

```solidity
///  @dev See {IERC721Metadata-symbol}.
function symbol() virtual override public view returns (string memory) {
    return _symbol;
}
```

## State Variable Reads

- **_symbol** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC721.symbol() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev See {IERC721Metadata-symbol}.

### Interface Documentation

 @dev Returns the token collection symbol.
