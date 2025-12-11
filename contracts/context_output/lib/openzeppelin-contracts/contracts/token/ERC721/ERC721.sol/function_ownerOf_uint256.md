# Function: ownerOf(uint256)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol/contract_ERC721.md]

## Metadata

- **Contract**: ERC721
- **Signature**: `ownerOf(uint256)`
- **Visibility**: public
- **Source Range**: 2190:219:96

## Implementation

```solidity
///  @dev See {IERC721-ownerOf}.
function ownerOf(uint256 tokenId) virtual override public view returns (address) {
    address owner = _ownerOf(tokenId);
    require(owner != address(0), "ERC721: invalid token ID");
    return owner;
}
```

## Related Implementations

### _ownerOf(uint256)

- **Kind**: internal
- **Source**: 6702:115:96
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_ownerOf(uint256)`

```solidity
///  @dev Returns the owner of the `tokenId`. Does NOT revert if token doesn't exist
function _ownerOf(uint256 tokenId) virtual internal view returns (address) {
    return _owners[tokenId];
}
```

## State Variable Reads

- **_owners** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC721.ownerOf(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 1)
      💬 Args: [tokenId]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev See {IERC721-ownerOf}.

### Interface Documentation

 @dev Returns the owner of the `tokenId` token.
 Requirements:
 - `tokenId` must exist.
