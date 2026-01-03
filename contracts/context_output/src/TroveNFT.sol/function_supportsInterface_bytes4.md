# Function: supportsInterface(bytes4)

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 829:155:27
- **Inherited From**: ERC165

## Implementation

```solidity
///  @dev See {IERC165-supportsInterface}.
function supportsInterface(bytes4 interfaceId) virtual override public view returns (bool) {
    return interfaceId == type(IERC165).interfaceId;
}
```

## Call Tree

```
No call tree available
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
