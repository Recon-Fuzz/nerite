# Function: safeTransferFrom(address,address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `safeTransferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 7586:151:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
/// @inheritdoc IERC721
function safeTransferFrom(address from, address to, uint256 tokenId) virtual override external {
    safeTransferFrom(from, to, tokenId, "");
}
```

## Related Implementations

### safeTransferFrom(address,address,uint256,bytes)

- **Kind**: internal
- **Source**: 7771:311:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:safeTransferFrom(address,address,uint256,bytes)`

```solidity
/// @inheritdoc IERC721
function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) virtual override public {
    if (!_isApprovedOrOwner(msg.sender, tokenId)) {
        revert POOL_NFT_TRANSFER_CALLER_NOT_OWNER_OR_APPROVED_FOR_ALL();
    }
    _safeTransfer(from, to, tokenId, data);
}
```

### _isApprovedOrOwner(address,uint256)

- **Kind**: internal
- **Source**: 8378:258:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:_isApprovedOrOwner(address,uint256)`

```solidity
/// @notice Returns whether `spender` is allowed to manage `tokenId`.
///  @dev Will revert if `tokenId` doesn't exist.
///  @param spender the spender of the token
///  @param tokenId the id of the token to be spent
///  @return whether `tokenId` can be spent by `spender`
function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
    address owner = PoolNFTBase.ownerOf(tokenId);
    return (((spender == owner) || isApprovedForAll(owner, spender)) || (getApproved(tokenId) == spender));
}
```

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

### getApproved(uint256)

- **Kind**: internal
- **Source**: 6688:167:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:getApproved(uint256)`

```solidity
/// @inheritdoc IERC721
function getApproved(uint256 tokenId) virtual override public view returns (address) {
    _requireMinted(tokenId);
    return _tokenApprovals[tokenId];
}
```

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

### _safeTransfer(address,address,uint256,bytes)

- **Kind**: internal
- **Source**: 10361:188:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:_safeTransfer(address,address,uint256,bytes)`

```solidity
function _safeTransfer(address from, address to, uint256 tokenId, bytes memory) virtual internal {
    _transfer(from, to, tokenId);
}
```

### _transfer(address,address,uint256)

- **Kind**: internal
- **Source**: 2000:181:124
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol:PoolAdminNFT:_transfer(address,address,uint256)`

```solidity
/// @notice Reverts - Transfer of pool member NFT is not allowed.
///  @dev We revert when users attempt to transfer pool member NFTs.
function _transfer(address, address, uint256) override internal pure {
    revert POOL_NFT_TRANSFER_NOT_ALLOWED();
}
```

## State Variable Reads

- **_poolAdminDataByTokenId** (`mapping(uint256 => struct IPoolAdminNFT.PoolAdminNFTData)`)
- **_tokenApprovals** (`mapping(uint256 => address)`)
- **_operatorApprovals** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.safeTransferFrom(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: PoolNFTBase.safeTransferFrom(address,address,uint256,bytes) (NodeID: 1)
      💬 Args: [from, to, tokenId, ""]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: PoolNFTBase._isApprovedOrOwner(address,uint256) (NodeID: 2)
    │   💬 Args: [msg.sender, tokenId]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: PoolNFTBase.ownerOf(uint256) (NodeID: 3)
    │ │   💬 Args: [tokenId]
    │ │   👁️  Def: public
    │ │ └─ [4] ⚙️ FUNCTION: PoolAdminNFT._ownerOf(uint256) (NodeID: 4)
    │ │     💬 Args: [tokenId]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: PoolNFTBase.getApproved(uint256) (NodeID: 5)
    │ │   💬 Args: [tokenId]
    │ │   👁️  Def: public
    │ │ └─ [4] ⚙️ FUNCTION: PoolNFTBase._requireMinted(uint256) (NodeID: 6)
    │ │     💬 Args: [tokenId]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: PoolNFTBase._exists(uint256) (NodeID: 7)
    │ │       💬 Args: [tokenId]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: PoolAdminNFT._ownerOf(uint256) (NodeID: 8)
    │ │         💬 Args: [tokenId]
    │ │         👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: PoolNFTBase.isApprovedForAll(address,address) (NodeID: 9)
    │     💬 Args: [owner, spender]
    │     👁️  Def: public
    └─ [2] ⚙️ FUNCTION: PoolNFTBase._safeTransfer(address,address,uint256,bytes) (NodeID: 10)
        💬 Args: [from, to, tokenId, data]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: PoolAdminNFT._transfer(address,address,uint256) (NodeID: 11)
          💬 Args: [from, to, tokenId]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IERC721

### Interface Documentation

 @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
 are aware of the ERC721 protocol to prevent tokens from being forever locked.
 Requirements:
 - `from` cannot be the zero address.
 - `to` cannot be the zero address.
 - `tokenId` token must exist and be owned by `from`.
 - If the caller is not `from`, it must have been allowed to move this token by either {approve} or {setApprovalForAll}.
 - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
 Emits a {Transfer} event.
