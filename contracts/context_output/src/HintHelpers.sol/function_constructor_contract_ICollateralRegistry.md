# Function: constructor(contract ICollateralRegistry)

**Contract**: [src/HintHelpers.sol/contract_HintHelpers.md]

## Metadata

- **Contract**: HintHelpers
- **Signature**: `constructor(contract ICollateralRegistry)`
- **Visibility**: public
- **Source Range**: 386:110:67

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
┌─ [0] 🏗️ CONSTRUCTOR: HintHelpers.constructor(contract ICollateralRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: HintHelpers
```
