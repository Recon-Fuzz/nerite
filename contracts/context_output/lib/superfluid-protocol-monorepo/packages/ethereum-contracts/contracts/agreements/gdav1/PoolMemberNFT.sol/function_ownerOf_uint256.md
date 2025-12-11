# Function: ownerOf(uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
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
- **Source**: 1567:140:125
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol:PoolMemberNFT:_ownerOf(uint256)`

```solidity
function _ownerOf(uint256 tokenId) override internal view returns (address) {
    return _poolMemberDataByTokenId[tokenId].member;
}
```

## State Variable Reads

- **_poolMemberDataByTokenId** (`mapping(uint256 => struct IPoolMemberNFT.PoolMemberNFTData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.ownerOf(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: PoolMemberNFT._ownerOf(uint256) (NodeID: 1)
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
