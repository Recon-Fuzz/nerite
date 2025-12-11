# Function: proxiableUUID()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 5762:167:161

## Implementation

```solidity
function proxiableUUID() virtual override public pure returns (bytes32) {
    return keccak256("org.superfluid-finance.contracts.SuperToken.implementation");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.proxiableUUID() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
