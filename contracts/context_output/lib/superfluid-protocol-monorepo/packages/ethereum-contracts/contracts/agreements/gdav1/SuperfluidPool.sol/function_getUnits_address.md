# Function: getUnits(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `getUnits(address)`
- **Visibility**: external
- **Source Range**: 8147:124:127

## Implementation

```solidity
/// @inheritdoc ISuperfluidPool
function getUnits(address memberAddr) override external view returns (uint128) {
    return _getUnits(memberAddr);
}
```

## Related Implementations

### _getUnits(address)

- **Kind**: internal
- **Source**: 8277:130:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_getUnits(address)`

```solidity
function _getUnits(address memberAddr) internal view returns (uint128) {
    return _membersData[memberAddr].ownedUnits;
}
```

## State Variable Reads

- **_membersData** (`mapping(address => struct SuperfluidPool.MemberData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.getUnits(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidPool._getUnits(address) (NodeID: 1)
      💬 Args: [memberAddr]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluidPool

### Interface Documentation

@notice The total number of units for `memberAddr`
 @param memberAddr The address of the member
