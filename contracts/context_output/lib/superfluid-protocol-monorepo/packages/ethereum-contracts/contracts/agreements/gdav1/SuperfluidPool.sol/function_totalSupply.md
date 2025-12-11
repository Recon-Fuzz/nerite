# Function: totalSupply()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 7634:104:127

## Implementation

```solidity
/// @notice Returns the total number of units for a pool
function totalSupply() override external view returns (uint256) {
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
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.totalSupply() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidPool._getTotalUnits() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Returns the total number of units for a pool

### Interface Documentation

 @dev Returns the amount of tokens in existence.
