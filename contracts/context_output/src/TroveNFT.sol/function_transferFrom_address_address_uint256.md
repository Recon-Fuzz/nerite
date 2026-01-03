# Function: transferFrom(address,address,uint256)

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 4612:296:14
- **Inherited From**: ERC721

## Implementation

```solidity
///  @dev See {IERC721-transferFrom}.
function transferFrom(address from, address to, uint256 tokenId) virtual override public {
    require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: caller is not token owner or approved");
    _transfer(from, to, tokenId);
}
```

## Related Implementations

### _isApprovedOrOwner(address,uint256)

- **Kind**: internal
- **Source**: 7404:261:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_isApprovedOrOwner(address,uint256)`

```solidity
///  @dev Returns whether `spender` is allowed to manage `tokenId`.
///  Requirements:
///  - `tokenId` must exist.
function _isApprovedOrOwner(address spender, uint256 tokenId) virtual internal view returns (bool) {
    address owner = ERC721.ownerOf(tokenId);
    return (((spender == owner) || isApprovedForAll(owner, spender)) || (getApproved(tokenId) == spender));
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

### getApproved(uint256)

- **Kind**: internal
- **Source**: 3935:167:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:getApproved(uint256)`

```solidity
///  @dev See {IERC721-getApproved}.
function getApproved(uint256 tokenId) virtual override public view returns (address) {
    _requireMinted(tokenId);
    return _tokenApprovals[tokenId];
}
```

### _requireMinted(uint256)

- **Kind**: internal
- **Source**: 13240:133:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_requireMinted(uint256)`

```solidity
///  @dev Reverts if the `tokenId` has not been minted yet.
function _requireMinted(uint256 tokenId) virtual internal view {
    require(_exists(tokenId), "ERC721: invalid token ID");
}
```

### _exists(uint256)

- **Kind**: internal
- **Source**: 7120:126:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_exists(uint256)`

```solidity
///  @dev Returns whether `tokenId` exists.
///  Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
///  Tokens start existing when they are minted (`_mint`),
///  and stop existing when they are burned (`_burn`).
function _exists(uint256 tokenId) virtual internal view returns (bool) {
    return _ownerOf(tokenId) != address(0);
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

### _transfer(address,address,uint256)

- **Kind**: internal
- **Source**: 11257:1203:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_transfer(address,address,uint256)`

```solidity
///  @dev Transfers `tokenId` from `from` to `to`.
///   As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
///  Requirements:
///  - `to` cannot be the zero address.
///  - `tokenId` token must be owned by `from`.
///  Emits a {Transfer} event.
function _transfer(address from, address to, uint256 tokenId) virtual internal {
    require(ERC721.ownerOf(tokenId) == from, "ERC721: transfer from incorrect owner");
    require(to != address(0), "ERC721: transfer to the zero address");
    _beforeTokenTransfer(from, to, tokenId, 1);
    require(ERC721.ownerOf(tokenId) == from, "ERC721: transfer from incorrect owner");
    delete _tokenApprovals[tokenId];
    unchecked {
        _balances[from] -= 1;
        _balances[to] += 1;
    }
    _owners[tokenId] = to;
    emit Transfer(from, to, tokenId);
    _afterTokenTransfer(from, to, tokenId, 1);
}
```

### _beforeTokenTransfer(address,address,uint256,uint256)

- **Kind**: internal
- **Source**: 15472:116:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_beforeTokenTransfer(address,address,uint256,uint256)`

```solidity
///  @dev Hook that is called before any token transfer. This includes minting and burning. If {ERC721Consecutive} is
///  used, the hook may be called as part of a consecutive (batch) mint, as indicated by `batchSize` greater than 1.
///  Calling conditions:
///  - When `from` and `to` are both non-zero, ``from``'s tokens will be transferred to `to`.
///  - When `from` is zero, the tokens will be minted for `to`.
///  - When `to` is zero, ``from``'s tokens will be burned.
///  - `from` and `to` are never both zero.
///  - `batchSize` is non-zero.
///  To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
function _beforeTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize) virtual internal {}
```

### _afterTokenTransfer(address,address,uint256,uint256)

- **Kind**: internal
- **Source**: 16294:115:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_afterTokenTransfer(address,address,uint256,uint256)`

```solidity
///  @dev Hook that is called after any token transfer. This includes minting and burning. If {ERC721Consecutive} is
///  used, the hook may be called as part of a consecutive (batch) mint, as indicated by `batchSize` greater than 1.
///  Calling conditions:
///  - When `from` and `to` are both non-zero, ``from``'s tokens were transferred to `to`.
///  - When `from` is zero, the tokens were minted for `to`.
///  - When `to` is zero, ``from``'s tokens were burned.
///  - `from` and `to` are never both zero.
///  - `batchSize` is non-zero.
///  To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
function _afterTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize) virtual internal {}
```

## State Variable Reads

- **_owners** (`mapping(uint256 => address)`)
- **_tokenApprovals** (`mapping(uint256 => address)`)
- **_operatorApprovals** (`mapping(address => mapping(address => bool))`)

## State Variable Writes

- **_tokenApprovals** (`mapping(uint256 => address)`)
- **_balances** (`mapping(address => uint256)`)
- **_owners** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC721.transferFrom(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC721._isApprovedOrOwner(address,uint256) (NodeID: 1)
  │   💬 Args: [_msgSender(), tokenId]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 9)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ERC721.ownerOf(uint256) (NodeID: 2)
  │ │   💬 Args: [tokenId]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 3)
  │ │     💬 Args: [tokenId]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ERC721.getApproved(uint256) (NodeID: 4)
  │ │   💬 Args: [tokenId]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: ERC721._requireMinted(uint256) (NodeID: 5)
  │ │     💬 Args: [tokenId]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: ERC721._exists(uint256) (NodeID: 6)
  │ │       💬 Args: [tokenId]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 7)
  │ │         💬 Args: [tokenId]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ERC721.isApprovedForAll(address,address) (NodeID: 8)
  │     💬 Args: [owner, spender]
  │     👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC721._transfer(address,address,uint256) (NodeID: 10)
      💬 Args: [from, to, tokenId]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC721.ownerOf(uint256) (NodeID: 11)
    │   💬 Args: [tokenId]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 12)
    │     💬 Args: [tokenId]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC721._beforeTokenTransfer(address,address,uint256,uint256) (NodeID: 13)
    │   💬 Args: [from, to, tokenId, 1]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC721.ownerOf(uint256) (NodeID: 14)
    │   💬 Args: [tokenId]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 15)
    │     💬 Args: [tokenId]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC721._afterTokenTransfer(address,address,uint256,uint256) (NodeID: 16)
        💬 Args: [from, to, tokenId, 1]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev See {IERC721-transferFrom}.

### Interface Documentation

 @dev Transfers `tokenId` token from `from` to `to`.
 WARNING: Note that the caller is responsible to confirm that the recipient is capable of receiving ERC721
 or else they may be permanently lost. Usage of {safeTransferFrom} prevents loss, though the caller must
 understand this adds an external call which potentially creates a reentrancy vulnerability.
 Requirements:
 - `from` cannot be the zero address.
 - `to` cannot be the zero address.
 - `tokenId` token must be owned by `from`.
 - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
 Emits a {Transfer} event.
