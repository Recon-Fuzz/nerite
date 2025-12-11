# Function: supportsInterface(bytes4)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 4352:334:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
/// @notice This contract supports IERC165, IERC721 and IERC721Metadata
///  @dev This is part of the Standard Interface Detection EIP: https://eips.ethereum.org/EIPS/eip-165
///  @param interfaceId the XOR of all function selectors in the interface
///  @return boolean true if the interface is supported
///  @inheritdoc IERC165
function supportsInterface(bytes4 interfaceId) virtual override external pure returns (bool) {
    return ((interfaceId == 0x01ffc9a7) || (interfaceId == 0x80ac58cd)) || (interfaceId == 0x5b5e139f);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.supportsInterface(bytes4) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice This contract supports IERC165, IERC721 and IERC721Metadata
 @dev This is part of the Standard Interface Detection EIP: https://eips.ethereum.org/EIPS/eip-165
 @param interfaceId the XOR of all function selectors in the interface
 @return boolean true if the interface is supported
 @inheritdoc IERC165

### Interface Documentation

 @dev Returns true if this contract implements the interface defined by
 `interfaceId`. See the corresponding
 https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
 to learn more about how these ids are created.
 This function call must use less than 30 000 gas.
