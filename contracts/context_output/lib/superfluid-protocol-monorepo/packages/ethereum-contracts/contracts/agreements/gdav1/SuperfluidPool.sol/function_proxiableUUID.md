# Function: proxiableUUID()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 4632:163:127

## Implementation

```solidity
function proxiableUUID() override public pure returns (bytes32) {
    return keccak256("org.superfluid-finance.contracts.SuperfluidPool.implementation");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.proxiableUUID() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
