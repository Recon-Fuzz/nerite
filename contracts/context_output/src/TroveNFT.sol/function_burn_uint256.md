# Function: burn(uint256)

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `burn(uint256)`
- **Visibility**: external
- **Source Range**: 2019:122:276

## Implementation

```solidity
function burn(uint256 _troveId) override external {
    _requireCallerIsTroveManager();
    _burn(_troveId);
}
```

## Related Implementations

### _requireCallerIsTroveManager()

- **Kind**: internal
- **Source**: 2147:168:276
- **Link**: `src/TroveNFT.sol:TroveNFT:_requireCallerIsTroveManager()`

```solidity
function _requireCallerIsTroveManager() internal view {
    require(msg.sender == address(troveManager), "TroveNFT: Caller is not the TroveManager contract");
}
```

### _burn(uint256)

- **Kind**: internal
- **Source**: 10171:762:96
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_burn(uint256)`

```solidity
///  @dev Destroys `tokenId`.
///  The approval is cleared when the token is burned.
///  This is an internal function that does not check if the sender is authorized to operate on the token.
///  Requirements:
///  - `tokenId` must exist.
///  Emits a {Transfer} event.
function _burn(uint256 tokenId) virtual internal {
    address owner = ERC721.ownerOf(tokenId);
    _beforeTokenTransfer(owner, address(0), tokenId, 1);
    owner = ERC721.ownerOf(tokenId);
    delete _tokenApprovals[tokenId];
    unchecked {
        _balances[owner] -= 1;
    }
    delete _owners[tokenId];
    emit Transfer(owner, address(0), tokenId);
    _afterTokenTransfer(owner, address(0), tokenId, 1);
}
```

### ownerOf(uint256)

- **Kind**: internal
- **Source**: 2190:219:96
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
- **Source**: 6702:115:96
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_ownerOf(uint256)`

```solidity
///  @dev Returns the owner of the `tokenId`. Does NOT revert if token doesn't exist
function _ownerOf(uint256 tokenId) virtual internal view returns (address) {
    return _owners[tokenId];
}
```

### _beforeTokenTransfer(address,address,uint256,uint256)

- **Kind**: internal
- **Source**: 15472:116:96
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
- **Source**: 16294:115:96
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

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **_owners** (`mapping(uint256 => address)`)

## State Variable Writes

- **_tokenApprovals** (`mapping(uint256 => address)`)
- **_balances** (`mapping(address => uint256)`)
- **_owners** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveNFT.burn(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveNFT._requireCallerIsTroveManager() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC721._burn(uint256) (NodeID: 2)
      💬 Args: [_troveId]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC721.ownerOf(uint256) (NodeID: 3)
    │   💬 Args: [tokenId]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 4)
    │     💬 Args: [tokenId]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC721._beforeTokenTransfer(address,address,uint256,uint256) (NodeID: 5)
    │   💬 Args: [owner, address(0), tokenId, 1]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC721.ownerOf(uint256) (NodeID: 6)
    │   💬 Args: [tokenId]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 7)
    │     💬 Args: [tokenId]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC721._afterTokenTransfer(address,address,uint256,uint256) (NodeID: 8)
        💬 Args: [owner, address(0), tokenId, 1]
        👁️  Def: internal
```
