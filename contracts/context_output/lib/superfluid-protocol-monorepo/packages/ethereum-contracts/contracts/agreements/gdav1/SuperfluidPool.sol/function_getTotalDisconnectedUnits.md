# Function: getTotalDisconnectedUnits()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `getTotalDisconnectedUnits()`
- **Visibility**: external
- **Source Range**: 7972:133:127

## Implementation

```solidity
/// @inheritdoc ISuperfluidPool
function getTotalDisconnectedUnits() override external view returns (uint128) {
    return _disconnectedMembers.ownedUnits;
}
```

## State Variable Reads

- **_disconnectedMembers** (`struct SuperfluidPool.MemberData`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.getTotalDisconnectedUnits() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluidPool

### Interface Documentation

@notice The total number of units of disconnected members
