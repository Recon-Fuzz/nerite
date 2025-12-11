# Function: poolAdminDataByTokenId(uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `poolAdminDataByTokenId(uint256)`
- **Visibility**: external
- **Source Range**: 1685:167:124

## Implementation

```solidity
function poolAdminDataByTokenId(uint256 tokenId) override external view returns (PoolAdminNFTData memory data) {
    return _poolAdminDataByTokenId[tokenId];
}
```

## State Variable Reads

- **_poolAdminDataByTokenId** (`mapping(uint256 => struct IPoolAdminNFT.PoolAdminNFTData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolAdminNFT.poolAdminDataByTokenId(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
