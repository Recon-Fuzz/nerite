# Function: proxiableUUID()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 1399:162:125

## Implementation

```solidity
function proxiableUUID() override public pure returns (bytes32) {
    return keccak256("org.superfluid-finance.contracts.PoolMemberNFT.implementation");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolMemberNFT.proxiableUUID() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
