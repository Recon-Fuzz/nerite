# Function: supportsInterface(bytes4)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol/contract_ERC721.md]

## Metadata

- **Contract**: ERC721
- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 1570:300:96

## Implementation

```solidity
///  @dev See {IERC165-supportsInterface}.
function supportsInterface(bytes4 interfaceId) virtual override(ERC165, IERC165) public view returns (bool) {
    return ((interfaceId == type(IERC721).interfaceId) || (interfaceId == type(IERC721Metadata).interfaceId)) || super.supportsInterface(interfaceId);
}
```

## Related Implementations

### supportsInterface(bytes4)

- **Kind**: internal
- **Source**: 829:155:111
- **Link**: `lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol:ERC165:supportsInterface(bytes4)`

```solidity
///  @dev See {IERC165-supportsInterface}.
function supportsInterface(bytes4 interfaceId) virtual override public view returns (bool) {
    return interfaceId == type(IERC165).interfaceId;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC721.supportsInterface(bytes4) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC165.supportsInterface(bytes4) (NodeID: 1)
      💬 Args: [interfaceId]
      👁️  Def: public
```

## Documentation

### Function Documentation

 @dev See {IERC165-supportsInterface}.

### Interface Documentation

 @dev Returns true if this contract implements the interface defined by
 `interfaceId`. See the corresponding
 https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
 to learn more about how these ids are created.
 This function call must use less than 30 000 gas.
