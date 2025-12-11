# Function: proxiableUUID()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

## Metadata

- **Contract**: SuperTokenFactory
- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 5102:166:162
- **Inherited From**: SuperTokenFactoryBase

## Implementation

```solidity
function proxiableUUID() override public pure returns (bytes32) {
    return keccak256("org.superfluid-finance.contracts.SuperTokenFactory.implementation");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperTokenFactoryBase.proxiableUUID() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
