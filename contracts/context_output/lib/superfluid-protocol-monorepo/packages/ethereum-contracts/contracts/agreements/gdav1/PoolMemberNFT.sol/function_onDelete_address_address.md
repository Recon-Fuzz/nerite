# Function: onDelete(address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
- **Signature**: `onDelete(address,address)`
- **Visibility**: external
- **Source Range**: 4076:150:125

## Implementation

```solidity
/// @notice Destroys token with `tokenId` and clears approvals from previous owner.
///  @dev `tokenId` must exist AND we emit a {Transfer} event
///  @param pool The pool address
///  @param member The member address
function onDelete(address pool, address member) override external {
    uint256 tokenId = _getTokenId(pool, member);
    _burn(tokenId);
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

### _burn(uint256)

- **Kind**: internal
- **Source**: 5117:581:125
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol:PoolMemberNFT:_burn(uint256)`

```solidity
function _burn(uint256 tokenId) override internal {
    PoolMemberNFTData storage data = _poolMemberDataByTokenId[tokenId];
    if (ISuperfluidPool(data.pool).getUnits(data.member) > 0) {
        revert POOL_MEMBER_NFT_HAS_UNITS();
    }
    address owner = _ownerOf(tokenId);
    assert(owner != address(0));
    super._burn(tokenId);
    delete _poolMemberDataByTokenId[tokenId];
    emit Transfer(owner, address(0), tokenId);
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

### _burn(uint256)

- **Kind**: internal
- **Source**: 10676:148:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:_burn(uint256)`

```solidity
/// @dev Deletes the tokenApprovals for `tokenId`
///  @param tokenId the token id whose approvals we're clearing
function _burn(uint256 tokenId) virtual internal {
    delete _tokenApprovals[tokenId];
}
```

## External Calls

- **ISuperfluidPool::getUnits(address)**

## State Variable Reads

- **_poolMemberDataByTokenId** (`mapping(uint256 => struct IPoolMemberNFT.PoolMemberNFTData)`)

## State Variable Writes

- **_poolMemberDataByTokenId** (`mapping(uint256 => struct IPoolMemberNFT.PoolMemberNFTData)`)
- **_tokenApprovals** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolMemberNFT.onDelete(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: PoolMemberNFT._getTokenId(address,address) (NodeID: 1)
  │   💬 Args: [pool, member]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: PoolMemberNFT._burn(uint256) (NodeID: 2)
      💬 Args: [tokenId]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: PoolMemberNFT._ownerOf(uint256) (NodeID: 3)
    │   💬 Args: [tokenId]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: PoolNFTBase._burn(uint256) (NodeID: 4)
        💬 Args: [tokenId]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Destroys token with `tokenId` and clears approvals from previous owner.
 @dev `tokenId` must exist AND we emit a {Transfer} event
 @param pool The pool address
 @param member The member address
