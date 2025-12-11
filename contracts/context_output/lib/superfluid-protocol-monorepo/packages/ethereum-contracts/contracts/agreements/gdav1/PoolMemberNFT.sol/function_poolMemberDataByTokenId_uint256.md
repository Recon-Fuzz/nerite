# Function: poolMemberDataByTokenId(uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
- **Signature**: `poolMemberDataByTokenId(uint256)`
- **Visibility**: public
- **Source Range**: 1713:168:125

## Implementation

```solidity
function poolMemberDataByTokenId(uint256 tokenId) override public view returns (PoolMemberNFTData memory data) {
    return _poolMemberDataByTokenId[tokenId];
}
```

## State Variable Reads

- **_poolMemberDataByTokenId** (`mapping(uint256 => struct IPoolMemberNFT.PoolMemberNFTData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolMemberNFT.poolMemberDataByTokenId(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

View Functions ///
