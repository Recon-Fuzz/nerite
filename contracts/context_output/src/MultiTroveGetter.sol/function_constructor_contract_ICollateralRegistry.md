# Function: constructor(contract ICollateralRegistry)

**Contract**: [src/MultiTroveGetter.sol/contract_MultiTroveGetter.md]

## Metadata

- **Contract**: MultiTroveGetter
- **Signature**: `constructor(contract ICollateralRegistry)`
- **Visibility**: public
- **Source Range**: 404:110:101

## Implementation

```solidity
constructor(ICollateralRegistry _collateralRegistry) {
    collateralRegistry = _collateralRegistry;
}
```

## State Variable Writes

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MultiTroveGetter.constructor(contract ICollateralRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MultiTroveGetter
```
