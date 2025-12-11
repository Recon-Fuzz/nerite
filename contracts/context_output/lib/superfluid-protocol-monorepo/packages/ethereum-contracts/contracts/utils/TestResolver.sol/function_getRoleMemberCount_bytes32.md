# Function: getRoleMemberCount(bytes32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol/contract_TestResolver.md]

## Metadata

- **Contract**: TestResolver
- **Signature**: `getRoleMemberCount(bytes32)`
- **Visibility**: public
- **Source Range**: 1750:140:68
- **Inherited From**: AccessControlEnumerable

## Implementation

```solidity
///  @dev Returns the number of accounts that have `role`. Can be used
///  together with {getRoleMember} to enumerate all bearers of a role.
function getRoleMemberCount(bytes32 role) virtual override public view returns (uint256) {
    return _roleMembers[role].length();
}
```

## Related Implementations

### length(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 9106:115:118
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:length(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Returns the number of values in the set. O(1).
function length(AddressSet storage set) internal view returns (uint256) {
    return _length(set._inner);
}
```

### _length(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 4463:107:118
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_length(struct EnumerableSet.Set)`

```solidity
///  @dev Returns the number of values on the set. O(1).
function _length(Set storage set) private view returns (uint256) {
    return set._values.length;
}
```

## State Variable Reads

- **_roleMembers** (`mapping(bytes32 => struct EnumerableSet.AddressSet)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AccessControlEnumerable.getRoleMemberCount(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: EnumerableSet.length(struct EnumerableSet.AddressSet) (NodeID: 1)
      💬 Args: [_roleMembers[role]]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet._length(struct EnumerableSet.Set) (NodeID: 2)
        💬 Args: [set._inner]
        👁️  Def: private
```

## Documentation

### Function Documentation

 @dev Returns the number of accounts that have `role`. Can be used
 together with {getRoleMember} to enumerate all bearers of a role.

### Interface Documentation

 @dev Returns the number of accounts that have `role`. Can be used
 together with {getRoleMember} to enumerate all bearers of a role.
