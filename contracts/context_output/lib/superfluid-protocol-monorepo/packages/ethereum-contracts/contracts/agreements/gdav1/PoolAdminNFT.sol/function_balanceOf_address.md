# Function: balanceOf(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 5122:119:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
/// @notice Returns a hardcoded balance of 1
///  @dev We always return 1 to avoid the need for additional mapping
///  @return balance = 1
function balanceOf(address) external pure returns (uint256 balance) {
    balance = 1;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.balanceOf(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns a hardcoded balance of 1
 @dev We always return 1 to avoid the need for additional mapping
 @return balance = 1

### Interface Documentation

 @dev Returns the number of tokens in ``owner``'s account.
