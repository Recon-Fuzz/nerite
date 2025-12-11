# Function: getTokenId(address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
- **Signature**: `getTokenId(address,address)`
- **Visibility**: external
- **Source Range**: 2216:148:125

## Implementation

```solidity
function getTokenId(address pool, address member) override external view returns (uint256 tokenId) {
    return _getTokenId(pool, member);
}
```

## Related Implementations

### _getTokenId(address,address)

- **Kind**: internal
- **Source**: 2370:191:125
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol:PoolMemberNFT:_getTokenId(address,address)`

```solidity
function _getTokenId(address pool, address member) internal view returns (uint256 tokenId) {
    return uint256(keccak256(abi.encode("PoolMemberNFT", block.chainid, pool, member)));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolMemberNFT.getTokenId(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: PoolMemberNFT._getTokenId(address,address) (NodeID: 1)
      💬 Args: [pool, member]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

@notice Gets the token id
 @dev For PoolAdminNFT, `account` is admin and for PoolMemberNFT, `account` is member
