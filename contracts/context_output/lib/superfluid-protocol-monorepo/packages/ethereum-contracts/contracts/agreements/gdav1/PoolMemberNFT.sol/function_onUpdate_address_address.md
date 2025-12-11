# Function: onUpdate(address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
- **Signature**: `onUpdate(address,address)`
- **Visibility**: external
- **Source Range**: 3444:395:125

## Implementation

```solidity
/// @notice Updates token with `tokenId`.
///  @dev `tokenId` must exist AND we emit a {MetadataUpdate} event
///  @param pool The pool address
///  @param member The member address
function onUpdate(address pool, address member) override external {
    uint256 tokenId = _getTokenId(pool, member);
    address owner = _ownerOf(tokenId);
    assert(owner != address(0));
    PoolMemberNFTData storage data = _poolMemberDataByTokenId[tokenId];
    data.units = ISuperfluidPool(data.pool).getUnits(data.member);
    _triggerMetadataUpdate(tokenId);
}
```

## Related Implementations

### _getTokenId(address,address)

- **Kind**: internal
- **Source**: 2370:191:125
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol:PoolMemberNFT:_getTokenId(address,address)`

```solidity
function _getTokenId(address pool, address member) internal view returns (uint256 tokenId) {
    return uint256(keccak256(abi.encode("PoolMemberNFT", block.chainid, pool, member)));
}
```

### _ownerOf(uint256)

- **Kind**: internal
- **Source**: 1567:140:125
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol:PoolMemberNFT:_ownerOf(uint256)`

```solidity
function _ownerOf(uint256 tokenId) override internal view returns (address) {
    return _poolMemberDataByTokenId[tokenId].member;
}
```

### _triggerMetadataUpdate(uint256)

- **Kind**: internal
- **Source**: 9424:103:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:_triggerMetadataUpdate(uint256)`

```solidity
function _triggerMetadataUpdate(uint256 tokenId) internal {
    emit MetadataUpdate(tokenId);
}
```

## External Calls

- **ISuperfluidPool::getUnits(address)**

## State Variable Reads

- **_poolMemberDataByTokenId** (`mapping(uint256 => struct IPoolMemberNFT.PoolMemberNFTData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolMemberNFT.onUpdate(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: PoolMemberNFT._getTokenId(address,address) (NodeID: 1)
  │   💬 Args: [pool, member]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: PoolMemberNFT._ownerOf(uint256) (NodeID: 2)
  │   💬 Args: [tokenId]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: PoolNFTBase._triggerMetadataUpdate(uint256) (NodeID: 3)
      💬 Args: [tokenId]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Updates token with `tokenId`.
 @dev `tokenId` must exist AND we emit a {MetadataUpdate} event
 @param pool The pool address
 @param member The member address
