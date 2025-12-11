# Function: name()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 5402:100:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
/// @notice Returns the name of the NFT
///  @dev Should follow the naming convention: (Pool Admin|Pool Member) NFT
///  @return name of the NFT
function name() virtual override external view returns (string memory) {
    return _name;
}
```

## State Variable Reads

- **_name** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns the name of the NFT
 @dev Should follow the naming convention: (Pool Admin|Pool Member) NFT
 @return name of the NFT

### Interface Documentation

 @dev Returns the token collection name.
