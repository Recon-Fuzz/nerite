# Function: mint(address,uint256)

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 1867:146:125

## Implementation

```solidity
function mint(address _owner, uint256 _troveId) override external {
    _requireCallerIsTroveManager();
    _mint(_owner, _troveId);
}
```

## Related Implementations

### _requireCallerIsTroveManager()

- **Kind**: internal
- **Source**: 2147:168:125
- **Link**: `src/TroveNFT.sol:TroveNFT:_requireCallerIsTroveManager()`

```solidity
function _requireCallerIsTroveManager() internal view {
    require(msg.sender == address(troveManager), "TroveNFT: Caller is not the TroveManager contract");
}
```

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 8925:920:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_mint(address,uint256)`

```solidity
///  @dev Mints `tokenId` and transfers it to `to`.
///  WARNING: Usage of this method is discouraged, use {_safeMint} whenever possible
///  Requirements:
///  - `tokenId` must not exist.
///  - `to` cannot be the zero address.
///  Emits a {Transfer} event.
function _mint(address to, uint256 tokenId) virtual internal {
    require(to != address(0), "ERC721: mint to the zero address");
    require(!_exists(tokenId), "ERC721: token already minted");
    _beforeTokenTransfer(address(0), to, tokenId, 1);
    require(!_exists(tokenId), "ERC721: token already minted");
    unchecked {
        _balances[to] += 1;
    }
    _owners[tokenId] = to;
    emit Transfer(address(0), to, tokenId);
    _afterTokenTransfer(address(0), to, tokenId, 1);
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

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **_owners** (`mapping(uint256 => address)`)

## State Variable Writes

- **_balances** (`mapping(address => uint256)`)
- **_owners** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveNFT.mint(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TroveNFT._requireCallerIsTroveManager() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC721._mint(address,uint256) (NodeID: 2)
      💬 Args: [_owner, _troveId]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC721._exists(uint256) (NodeID: 3)
    │   💬 Args: [tokenId]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 4)
    │     💬 Args: [tokenId]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC721._beforeTokenTransfer(address,address,uint256,uint256) (NodeID: 5)
    │   💬 Args: [address(0), to, tokenId, 1]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC721._exists(uint256) (NodeID: 6)
    │   💬 Args: [tokenId]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 7)
    │     💬 Args: [tokenId]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC721._afterTokenTransfer(address,address,uint256,uint256) (NodeID: 8)
        💬 Args: [address(0), to, tokenId, 1]
        👁️  Def: internal
```
