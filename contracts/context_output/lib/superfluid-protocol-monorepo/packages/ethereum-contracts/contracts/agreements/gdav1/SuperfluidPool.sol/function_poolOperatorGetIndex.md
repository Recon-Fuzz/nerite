# Function: poolOperatorGetIndex()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `poolOperatorGetIndex()`
- **Visibility**: external
- **Source Range**: 4877:107:127

## Implementation

```solidity
/// @dev This function is only meant to be called by the GDAv1 contract
function poolOperatorGetIndex() external view returns (PoolIndexData memory) {
    return _index;
}
```

## State Variable Reads

- **_index** (`struct SuperfluidPool.PoolIndexData`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.poolOperatorGetIndex() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@dev This function is only meant to be called by the GDAv1 contract
