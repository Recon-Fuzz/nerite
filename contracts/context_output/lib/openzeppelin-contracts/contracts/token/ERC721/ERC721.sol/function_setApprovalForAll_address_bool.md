# Function: setApprovalForAll(address,bool)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol/contract_ERC721.md]

## Metadata

- **Contract**: ERC721
- **Signature**: `setApprovalForAll(address,bool)`
- **Visibility**: public
- **Source Range**: 4169:153:14

## Implementation

```solidity
///  @dev See {IERC721-setApprovalForAll}.
function setApprovalForAll(address operator, bool approved) virtual override public {
    _setApprovalForAll(_msgSender(), operator, approved);
}
```

## Related Implementations

### _setApprovalForAll(address,address,bool)

- **Kind**: internal
- **Source**: 12879:277:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_setApprovalForAll(address,address,bool)`

```solidity
///  @dev Approve `operator` to operate on all of `owner` tokens
///  Emits an {ApprovalForAll} event.
function _setApprovalForAll(address owner, address operator, bool approved) virtual internal {
    require(owner != operator, "ERC721: approve to caller");
    _operatorApprovals[owner][operator] = approved;
    emit ApprovalForAll(owner, operator, approved);
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

## State Variable Writes

- **_operatorApprovals** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC721.setApprovalForAll(address,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC721._setApprovalForAll(address,address,bool) (NodeID: 1)
      💬 Args: [_msgSender(), operator, approved]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev See {IERC721-setApprovalForAll}.

### Interface Documentation

 @dev Approve or remove `operator` as an operator for the caller.
 Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
 Requirements:
 - The `operator` cannot be the caller.
 Emits an {ApprovalForAll} event.
