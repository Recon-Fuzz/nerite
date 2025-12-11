# Function: getTokenId(address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `getTokenId(address,address)`
- **Visibility**: external
- **Source Range**: 2187:146:124

## Implementation

```solidity
function getTokenId(address pool, address admin) override external view returns (uint256 tokenId) {
    return _getTokenId(pool, admin);
}
```

## Related Implementations

### _getTokenId(address,address)

- **Kind**: internal
- **Source**: 2339:188:124
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol:PoolAdminNFT:_getTokenId(address,address)`

```solidity
function _getTokenId(address pool, address admin) internal view returns (uint256 tokenId) {
    return uint256(keccak256(abi.encode("PoolAdminNFT", block.chainid, pool, admin)));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolAdminNFT.getTokenId(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: PoolAdminNFT._getTokenId(address,address) (NodeID: 1)
      💬 Args: [pool, admin]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

@notice Gets the token id
 @dev For PoolAdminNFT, `account` is admin and for PoolMemberNFT, `account` is member
