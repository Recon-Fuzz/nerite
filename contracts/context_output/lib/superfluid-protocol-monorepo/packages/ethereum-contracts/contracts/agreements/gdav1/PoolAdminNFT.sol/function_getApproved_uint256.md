# Function: getApproved(uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `getApproved(uint256)`
- **Visibility**: public
- **Source Range**: 6688:167:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
/// @inheritdoc IERC721
function getApproved(uint256 tokenId) virtual override public view returns (address) {
    _requireMinted(tokenId);
    return _tokenApprovals[tokenId];
}
```

## Related Implementations

### _requireMinted(uint256)

- **Kind**: internal
- **Source**: 8761:129:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:_requireMinted(uint256)`

```solidity
/// @notice Reverts if `tokenId` doesn't exist
///  @param tokenId the token id whose existence we are checking
function _requireMinted(uint256 tokenId) internal view {
    if (!_exists(tokenId)) revert POOL_NFT_INVALID_TOKEN_ID();
}
```

### _exists(uint256)

- **Kind**: internal
- **Source**: 9300:118:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:_exists(uint256)`

```solidity
/// @notice Returns whether `tokenId` exists
///  @dev Tokens can be managed by their owner or approved accounts via `approve` or `setApprovalForAll`.
///  Tokens start existing when they are minted (`_mint`),
///  and stop existing when they are burned (`_burn`).
///  @param tokenId the token id we're interested in seeing if exists
///  @return bool whether ot not the token exists
function _exists(uint256 tokenId) internal view returns (bool) {
    return _ownerOf(tokenId) != address(0);
}
```

### _ownerOf(uint256)

- **Kind**: internal
- **Source**: 1541:138:124
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol:PoolAdminNFT:_ownerOf(uint256)`

```solidity
function _ownerOf(uint256 tokenId) override internal view returns (address) {
    return _poolAdminDataByTokenId[tokenId].admin;
}
```

## State Variable Reads

- **_tokenApprovals** (`mapping(uint256 => address)`)
- **_poolAdminDataByTokenId** (`mapping(uint256 => struct IPoolAdminNFT.PoolAdminNFTData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.getApproved(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: PoolNFTBase._requireMinted(uint256) (NodeID: 1)
      💬 Args: [tokenId]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: PoolNFTBase._exists(uint256) (NodeID: 2)
        💬 Args: [tokenId]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: PoolAdminNFT._ownerOf(uint256) (NodeID: 3)
          💬 Args: [tokenId]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IERC721

### Interface Documentation

 @dev Returns the account approved for `tokenId` token.
 Requirements:
 - `tokenId` must exist.
