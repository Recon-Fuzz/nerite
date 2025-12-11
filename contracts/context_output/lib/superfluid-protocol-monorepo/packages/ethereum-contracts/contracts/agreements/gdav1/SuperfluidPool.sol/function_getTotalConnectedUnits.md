# Function: getTotalConnectedUnits()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `getTotalConnectedUnits()`
- **Visibility**: external
- **Source Range**: 7780:150:127

## Implementation

```solidity
/// @inheritdoc ISuperfluidPool
function getTotalConnectedUnits() override external view returns (uint128) {
    return _index.totalUnits - _disconnectedMembers.ownedUnits;
}
```

## State Variable Reads

- **_index** (`struct SuperfluidPool.PoolIndexData`)
- **_disconnectedMembers** (`struct SuperfluidPool.MemberData`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.getTotalConnectedUnits() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluidPool

### Interface Documentation

@notice The total number of units of connected members
