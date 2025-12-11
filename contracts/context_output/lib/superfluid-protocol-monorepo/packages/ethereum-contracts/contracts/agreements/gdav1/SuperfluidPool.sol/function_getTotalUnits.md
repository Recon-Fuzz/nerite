# Function: getTotalUnits()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `getTotalUnits()`
- **Visibility**: external
- **Source Range**: 5026:106:127

## Implementation

```solidity
/// @inheritdoc ISuperfluidPool
function getTotalUnits() override external view returns (uint128) {
    return _getTotalUnits();
}
```

## Related Implementations

### _getTotalUnits()

- **Kind**: internal
- **Source**: 5138:99:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_getTotalUnits()`

```solidity
function _getTotalUnits() internal view returns (uint128) {
    return _index.totalUnits;
}
```

## State Variable Reads

- **_index** (`struct SuperfluidPool.PoolIndexData`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.getTotalUnits() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidPool._getTotalUnits() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluidPool

### Interface Documentation

@notice The total units of the pool
