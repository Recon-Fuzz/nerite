# Function: ownerOf(uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `ownerOf(uint256)`
- **Visibility**: public
- **Source Range**: 4720:246:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
/// @inheritdoc IERC721
function ownerOf(uint256 tokenId) virtual override public view returns (address) {
    address owner = _ownerOf(tokenId);
    if (owner == address(0)) {
        revert POOL_NFT_INVALID_TOKEN_ID();
    }
    return owner;
}
```

## Related Implementations

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

- **_poolAdminDataByTokenId** (`mapping(uint256 => struct IPoolAdminNFT.PoolAdminNFTData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.ownerOf(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: PoolAdminNFT._ownerOf(uint256) (NodeID: 1)
      💬 Args: [tokenId]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IERC721

### Interface Documentation

 @dev Returns the owner of the `tokenId` token.
 Requirements:
 - `tokenId` must exist.
