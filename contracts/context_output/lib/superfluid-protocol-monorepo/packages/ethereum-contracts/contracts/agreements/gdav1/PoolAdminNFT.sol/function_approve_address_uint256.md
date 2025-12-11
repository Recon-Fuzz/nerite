# Function: approve(address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 6236:418:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
/// @inheritdoc IERC721
function approve(address to, uint256 tokenId) virtual override public {
    address owner = PoolNFTBase.ownerOf(tokenId);
    if (to == owner) {
        revert POOL_NFT_APPROVE_TO_CURRENT_OWNER();
    }
    if ((msg.sender != owner) && (!isApprovedForAll(owner, msg.sender))) {
        revert POOL_NFT_APPROVE_CALLER_NOT_OWNER_OR_APPROVED_FOR_ALL();
    }
    _approve(to, tokenId);
}
```

## Related Implementations

### ownerOf(uint256)

- **Kind**: internal
- **Source**: 4720:246:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:ownerOf(uint256)`

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

### _ownerOf(uint256)

- **Kind**: internal
- **Source**: 1541:138:124
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol:PoolAdminNFT:_ownerOf(uint256)`

```solidity
function _ownerOf(uint256 tokenId) override internal view returns (address) {
    return _poolAdminDataByTokenId[tokenId].admin;
}
```

### isApprovedForAll(address,address)

- **Kind**: internal
- **Source**: 7076:162:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:isApprovedForAll(address,address)`

```solidity
/// @inheritdoc IERC721
function isApprovedForAll(address owner, address operator) virtual override public view returns (bool) {
    return _operatorApprovals[owner][operator];
}
```

### _approve(address,uint256)

- **Kind**: internal
- **Source**: 9533:158:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:_approve(address,uint256)`

```solidity
function _approve(address to, uint256 tokenId) internal {
    _tokenApprovals[tokenId] = to;
    emit Approval(_ownerOf(tokenId), to, tokenId);
}
```

## State Variable Reads

- **_poolAdminDataByTokenId** (`mapping(uint256 => struct IPoolAdminNFT.PoolAdminNFTData)`)
- **_operatorApprovals** (`mapping(address => mapping(address => bool))`)

## State Variable Writes

- **_tokenApprovals** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.approve(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: PoolNFTBase.ownerOf(uint256) (NodeID: 1)
  │   💬 Args: [tokenId]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: PoolAdminNFT._ownerOf(uint256) (NodeID: 2)
  │     💬 Args: [tokenId]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: PoolNFTBase.isApprovedForAll(address,address) (NodeID: 3)
  │   💬 Args: [owner, msg.sender]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: PoolNFTBase._approve(address,uint256) (NodeID: 4)
      💬 Args: [to, tokenId]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: PoolAdminNFT._ownerOf(uint256) (NodeID: 5)
        💬 Args: [tokenId]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IERC721

### Interface Documentation

 @dev Gives permission to `to` to transfer `tokenId` token to another account.
 The approval is cleared when the token is transferred.
 Only a single account can be approved at a time, so approving the zero address clears previous approvals.
 Requirements:
 - The caller must own the token or be an approved operator.
 - `tokenId` must exist.
 Emits an {Approval} event.
