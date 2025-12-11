# Function: symbol()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 5644:104:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
/// @notice Returns the symbol of the NFT
///  @dev Should follow the naming convention: PA|PM
///  @return symbol of the NFT
function symbol() virtual override external view returns (string memory) {
    return _symbol;
}
```

## State Variable Reads

- **_symbol** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.symbol() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns the symbol of the NFT
 @dev Should follow the naming convention: PA|PM
 @return symbol of the NFT

### Interface Documentation

 @dev Returns the token collection symbol.
