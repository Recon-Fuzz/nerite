# Function: onCreate(address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
- **Signature**: `onCreate(address,address)`
- **Visibility**: external
- **Source Range**: 3141:102:125

## Implementation

```solidity
/// @notice Mints `newTokenId` and transfers it to `member`
///  @dev `pool` must be a registered pool in the GDA.
///  `newTokenId` must not exist, `member` cannot be `address(0)`, `pool` cannot be `address(0)`,
///  and `pool` cannot be `member`.
///  We emit a {Transfer} event.
///  @param pool The pool address
///  @param member The member address
function onCreate(address pool, address member) override external {
    _mint(pool, member);
}
```

## Related Implementations

### _mint(address,address)

- **Kind**: internal
- **Source**: 4232:879:125
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol:PoolMemberNFT:_mint(address,address)`

```solidity
function _mint(address pool, address member) internal {
    ISuperfluidToken superToken = ISuperfluidPool(pool).superToken();
    if (!GENERAL_DISTRIBUTION_AGREEMENT_V1.isPool(superToken, pool)) {
        revert POOL_NFT_NOT_REGISTERED_POOL();
    }
    assert(pool != address(0));
    assert(member != address(0));
    assert(pool != member);
    uint256 newTokenId = _getTokenId(pool, member);
    assert(!_exists(newTokenId));
    uint128 units = ISuperfluidPool(pool).getUnits(member);
    if (units == 0) {
        revert POOL_MEMBER_NFT_NO_UNITS();
    }
    _poolMemberDataByTokenId[newTokenId] = PoolMemberNFTData(pool, member, units);
    emit Transfer(address(0), member, newTokenId);
}
```

### _getTokenId(address,address)

- **Kind**: internal
- **Source**: 2370:191:125
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol:PoolMemberNFT:_getTokenId(address,address)`

```solidity
function _getTokenId(address pool, address member) internal view returns (uint256 tokenId) {
    return uint256(keccak256(abi.encode("PoolMemberNFT", block.chainid, pool, member)));
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
- **Source**: 1567:140:125
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol:PoolMemberNFT:_ownerOf(uint256)`

```solidity
function _ownerOf(uint256 tokenId) override internal view returns (address) {
    return _poolMemberDataByTokenId[tokenId].member;
}
```

## External Calls

- **ISuperfluidPool::superToken()**
- **IGeneralDistributionAgreementV1::isPool(contract ISuperfluidToken,address)**
- **ISuperfluidPool::getUnits(address)**

## State Variable Reads

- **_poolMemberDataByTokenId** (`mapping(uint256 => struct IPoolMemberNFT.PoolMemberNFTData)`)

## State Variable Writes

- **_poolMemberDataByTokenId** (`mapping(uint256 => struct IPoolMemberNFT.PoolMemberNFTData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolMemberNFT.onCreate(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: PoolMemberNFT._mint(address,address) (NodeID: 1)
      💬 Args: [pool, member]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: PoolMemberNFT._getTokenId(address,address) (NodeID: 2)
    │   💬 Args: [pool, member]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: PoolNFTBase._exists(uint256) (NodeID: 3)
        💬 Args: [newTokenId]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: PoolMemberNFT._ownerOf(uint256) (NodeID: 4)
          💬 Args: [tokenId]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Mints `newTokenId` and transfers it to `member`
 @dev `pool` must be a registered pool in the GDA.
 `newTokenId` must not exist, `member` cannot be `address(0)`, `pool` cannot be `address(0)`,
 and `pool` cannot be `member`.
 We emit a {Transfer} event.
 @param pool The pool address
 @param member The member address
