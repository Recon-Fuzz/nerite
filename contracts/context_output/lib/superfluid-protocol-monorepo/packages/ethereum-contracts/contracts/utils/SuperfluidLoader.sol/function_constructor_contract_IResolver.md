# Function: constructor(contract IResolver)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidLoader.sol/contract_SuperfluidLoader.md]

## Metadata

- **Contract**: SuperfluidLoader
- **Signature**: `constructor(contract IResolver)`
- **Visibility**: public
- **Source Range**: 884:69:182

## Implementation

```solidity
constructor(IResolver resolver) {
    _resolver = resolver;
}
```

## State Variable Writes

- **_resolver** (`contract IResolver`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/utils/IResolver.sol/interface_IResolver.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperfluidLoader.constructor(contract IResolver) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperfluidLoader
```
