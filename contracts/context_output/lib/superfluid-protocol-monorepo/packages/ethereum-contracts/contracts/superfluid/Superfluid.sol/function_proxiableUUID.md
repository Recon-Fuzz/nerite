# Function: proxiableUUID()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 4707:159:163

## Implementation

```solidity
function proxiableUUID() override public pure returns (bytes32) {
    return keccak256("org.superfluid-finance.contracts.Superfluid.implementation");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.proxiableUUID() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
