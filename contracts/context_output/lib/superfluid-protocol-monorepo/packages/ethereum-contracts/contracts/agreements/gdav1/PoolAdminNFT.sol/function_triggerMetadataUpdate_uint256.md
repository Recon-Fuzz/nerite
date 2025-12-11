# Function: triggerMetadataUpdate(uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `triggerMetadataUpdate(uint256)`
- **Visibility**: external
- **Source Range**: 3894:105:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
/// @notice Emits the MetadataUpdate event with `tokenId` as the argument.
///  @dev Callable by anyone.
///  @param tokenId the token id to trigger a metaupdate for
function triggerMetadataUpdate(uint256 tokenId) external {
    _triggerMetadataUpdate(tokenId);
}
```

## Related Implementations

### _triggerMetadataUpdate(uint256)

- **Kind**: internal
- **Source**: 9424:103:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:_triggerMetadataUpdate(uint256)`

```solidity
function _triggerMetadataUpdate(uint256 tokenId) internal {
    emit MetadataUpdate(tokenId);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.triggerMetadataUpdate(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: PoolNFTBase._triggerMetadataUpdate(uint256) (NodeID: 1)
      💬 Args: [tokenId]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Emits the MetadataUpdate event with `tokenId` as the argument.
 @dev Callable by anyone.
 @param tokenId the token id to trigger a metaupdate for
