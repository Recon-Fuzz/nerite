# Function: isApprovedForAll(address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `isApprovedForAll(address,address)`
- **Visibility**: public
- **Source Range**: 7076:162:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
/// @inheritdoc IERC721
function isApprovedForAll(address owner, address operator) virtual override public view returns (bool) {
    return _operatorApprovals[owner][operator];
}
```

## State Variable Reads

- **_operatorApprovals** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.isApprovedForAll(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IERC721

### Interface Documentation

 @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
 See {setApprovalForAll}
