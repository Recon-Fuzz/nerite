# Function: tokenURI(uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `tokenURI(uint256)`
- **Visibility**: external
- **Source Range**: 2565:160:124

## Implementation

```solidity
/// @inheritdoc PoolNFTBase
function tokenURI(uint256 tokenId) override(IERC721Metadata, PoolNFTBase) external view returns (string memory) {
    return super._tokenURI(tokenId);
}
```

## Related Implementations

### _tokenURI(uint256)

- **Kind**: internal
- **Source**: 6057:145:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:_tokenURI(uint256)`

```solidity
function _tokenURI(uint256) virtual internal view returns (string memory) {
    return string(abi.encodePacked(baseURI()));
}
```

### baseURI()

- **Kind**: internal
- **Source**: 922:83:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:baseURI()`

```solidity
function baseURI() public pure returns (string memory) {
    return DEFAULT_BASE_URI;
}
```

## State Variable Reads

- **DEFAULT_BASE_URI** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolAdminNFT.tokenURI(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: PoolNFTBase._tokenURI(uint256) (NodeID: 1)
      💬 Args: [tokenId]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: PoolNFTBase.baseURI() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc PoolNFTBase

### Interface Documentation

 @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
