# Function: approve(address,uint256)

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3468:406:14
- **Inherited From**: ERC721

## Implementation

```solidity
///  @dev See {IERC721-approve}.
function approve(address to, uint256 tokenId) virtual override public {
    address owner = ERC721.ownerOf(tokenId);
    require(to != owner, "ERC721: approval to current owner");
    require((_msgSender() == owner) || isApprovedForAll(owner, _msgSender()), "ERC721: approve caller is not token owner or approved for all");
    _approve(to, tokenId);
}
```

## Related Implementations

### ownerOf(uint256)

- **Kind**: internal
- **Source**: 2190:219:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:ownerOf(uint256)`

```solidity
///  @dev See {IERC721-ownerOf}.
function ownerOf(uint256 tokenId) virtual override public view returns (address) {
    address owner = _ownerOf(tokenId);
    require(owner != address(0), "ERC721: invalid token ID");
    return owner;
}
```

### _ownerOf(uint256)

- **Kind**: internal
- **Source**: 6702:115:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_ownerOf(uint256)`

```solidity
///  @dev Returns the owner of the `tokenId`. Does NOT revert if token doesn't exist
function _ownerOf(uint256 tokenId) virtual internal view returns (address) {
    return _owners[tokenId];
}
```

### isApprovedForAll(address,address)

- **Kind**: internal
- **Source**: 4388:162:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:isApprovedForAll(address,address)`

```solidity
///  @dev See {IERC721-isApprovedForAll}.
function isApprovedForAll(address owner, address operator) virtual override public view returns (bool) {
    return _operatorApprovals[owner][operator];
}
```

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:20
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### _approve(address,uint256)

- **Kind**: internal
- **Source**: 12572:171:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_approve(address,uint256)`

```solidity
///  @dev Approve `to` to operate on `tokenId`
///  Emits an {Approval} event.
function _approve(address to, uint256 tokenId) virtual internal {
    _tokenApprovals[tokenId] = to;
    emit Approval(ERC721.ownerOf(tokenId), to, tokenId);
}
```

## State Variable Reads

- **_owners** (`mapping(uint256 => address)`)
- **_operatorApprovals** (`mapping(address => mapping(address => bool))`)

## State Variable Writes

- **_tokenApprovals** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC721.approve(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC721.ownerOf(uint256) (NodeID: 1)
  │   💬 Args: [tokenId]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 2)
  │     💬 Args: [tokenId]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ERC721.isApprovedForAll(address,address) (NodeID: 3)
  │   💬 Args: [owner, _msgSender()]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 4)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Context._msgSender() (NodeID: 5)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC721._approve(address,uint256) (NodeID: 6)
      💬 Args: [to, tokenId]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC721.ownerOf(uint256) (NodeID: 7)
        💬 Args: [tokenId]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 8)
          💬 Args: [tokenId]
          👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev See {IERC721-approve}.

### Interface Documentation

 @dev Gives permission to `to` to transfer `tokenId` token to another account.
 The approval is cleared when the token is transferred.
 Only a single account can be approved at a time, so approving the zero address clears previous approvals.
 Requirements:
 - The caller must own the token or be an approved operator.
 - `tokenId` must exist.
 Emits an {Approval} event.
