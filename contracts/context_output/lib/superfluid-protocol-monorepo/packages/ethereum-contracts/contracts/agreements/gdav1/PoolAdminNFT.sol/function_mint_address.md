# Function: mint(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `mint(address)`
- **Visibility**: external
- **Source Range**: 2731:65:124

## Implementation

```solidity
function mint(address pool) external {
    _mint(pool);
}
```

## Related Implementations

### _mint(address)

- **Kind**: internal
- **Source**: 3103:733:124
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol:PoolAdminNFT:_mint(address)`

```solidity
/// @notice Mints `newTokenId` and transfers it to `admin`
///  @dev `pool` must be a registered pool in the GDA.
///  `newTokenId` must not exist, `admin` cannot be `address(0)` and we emit a {Transfer} event.
///  `admin` cannot be equal to `pool`.
///  @param pool The pool address
function _mint(address pool) internal {
    ISuperfluidToken superToken = ISuperfluidPool(pool).superToken();
    if (!GENERAL_DISTRIBUTION_AGREEMENT_V1.isPool(superToken, pool)) {
        revert POOL_NFT_NOT_REGISTERED_POOL();
    }
    ISuperfluidPool poolContract = ISuperfluidPool(pool);
    address admin = poolContract.admin();
    assert(pool != admin);
    uint256 newTokenId = _getTokenId(pool, admin);
    assert(!_exists(newTokenId));
    _poolAdminDataByTokenId[newTokenId] = PoolAdminNFTData(pool, admin);
    emit Transfer(address(0), admin, newTokenId);
}
```

### _getTokenId(address,address)

- **Kind**: internal
- **Source**: 2339:188:124
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol:PoolAdminNFT:_getTokenId(address,address)`

```solidity
function _getTokenId(address pool, address admin) internal view returns (uint256 tokenId) {
    return uint256(keccak256(abi.encode("PoolAdminNFT", block.chainid, pool, admin)));
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

## External Calls

- **ISuperfluidPool::superToken()**
- **IGeneralDistributionAgreementV1::isPool(contract ISuperfluidToken,address)**
- **ISuperfluidPool::admin()**

## State Variable Reads

- **_poolAdminDataByTokenId** (`mapping(uint256 => struct IPoolAdminNFT.PoolAdminNFTData)`)

## State Variable Writes

- **_poolAdminDataByTokenId** (`mapping(uint256 => struct IPoolAdminNFT.PoolAdminNFTData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolAdminNFT.mint(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: PoolAdminNFT._mint(address) (NodeID: 1)
      💬 Args: [pool]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: PoolAdminNFT._getTokenId(address,address) (NodeID: 2)
    │   💬 Args: [pool, admin]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: PoolNFTBase._exists(uint256) (NodeID: 3)
        💬 Args: [newTokenId]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: PoolAdminNFT._ownerOf(uint256) (NodeID: 4)
          💬 Args: [tokenId]
          👁️  Def: internal
```

## Documentation

### Interface Documentation

Write Functions ///
