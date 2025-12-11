# Function: proxiableUUID()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 1374:161:124

## Implementation

```solidity
function proxiableUUID() override public pure returns (bytes32) {
    return keccak256("org.superfluid-finance.contracts.PoolAdminNFT.implementation");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolAdminNFT.proxiableUUID() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
