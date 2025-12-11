# Function: baseURI()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
- **Signature**: `baseURI()`
- **Visibility**: public
- **Source Range**: 922:83:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
function baseURI() public pure returns (string memory) {
    return DEFAULT_BASE_URI;
}
```

## State Variable Reads

- **DEFAULT_BASE_URI** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.baseURI() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
