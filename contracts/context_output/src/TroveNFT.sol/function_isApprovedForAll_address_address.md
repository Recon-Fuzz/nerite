# Function: isApprovedForAll(address,address)

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `isApprovedForAll(address,address)`
- **Visibility**: public
- **Source Range**: 4388:162:96
- **Inherited From**: ERC721

## Implementation

```solidity
///  @dev See {IERC721-isApprovedForAll}.
function isApprovedForAll(address owner, address operator) virtual override public view returns (bool) {
    return _operatorApprovals[owner][operator];
}
```

## State Variable Reads

- **_operatorApprovals** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC721.isApprovedForAll(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev See {IERC721-isApprovedForAll}.

### Interface Documentation

 @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
 See {setApprovalForAll}
