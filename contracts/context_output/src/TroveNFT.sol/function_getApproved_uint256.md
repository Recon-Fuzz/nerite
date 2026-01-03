# Function: getApproved(uint256)

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `getApproved(uint256)`
- **Visibility**: public
- **Source Range**: 3935:167:14
- **Inherited From**: ERC721

## Implementation

```solidity
///  @dev See {IERC721-getApproved}.
function getApproved(uint256 tokenId) virtual override public view returns (address) {
    _requireMinted(tokenId);
    return _tokenApprovals[tokenId];
}
```

## Related Implementations

### _requireMinted(uint256)

- **Kind**: internal
- **Source**: 13240:133:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_requireMinted(uint256)`

```solidity
///  @dev Reverts if the `tokenId` has not been minted yet.
function _requireMinted(uint256 tokenId) virtual internal view {
    require(_exists(tokenId), "ERC721: invalid token ID");
}
```

### _exists(uint256)

- **Kind**: internal
- **Source**: 7120:126:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_exists(uint256)`

```solidity
///  @dev Returns whether `tokenId` exists.
///  Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
///  Tokens start existing when they are minted (`_mint`),
///  and stop existing when they are burned (`_burn`).
function _exists(uint256 tokenId) virtual internal view returns (bool) {
    return _ownerOf(tokenId) != address(0);
}
```

### _ownerOf(uint256)

- **Kind**: internal
- **Source**: 6702:115:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_ownerOf(uint256)`

```solidity
///  @dev Returns the owner of the `tokenId`. Does NOT revert if token doesn't exist
function _ownerOf(uint256 tokenId) virtual internal view returns (address) {
    return _owners[tokenId];
}
```

## State Variable Reads

- **_tokenApprovals** (`mapping(uint256 => address)`)
- **_owners** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC721.getApproved(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC721._requireMinted(uint256) (NodeID: 1)
      💬 Args: [tokenId]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC721._exists(uint256) (NodeID: 2)
        💬 Args: [tokenId]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 3)
          💬 Args: [tokenId]
          👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev See {IERC721-getApproved}.

### Interface Documentation

 @dev Returns the account approved for `tokenId` token.
 Requirements:
 - `tokenId` must exist.
