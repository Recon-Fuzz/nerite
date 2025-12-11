# Function: renounceRole(bytes32,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol/contract_TestResolver.md]

## Metadata

- **Contract**: TestResolver
- **Signature**: `renounceRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 6038:214:67
- **Inherited From**: AccessControl

## Implementation

```solidity
///  @dev Revokes `role` from the calling account.
///  Roles are often managed via {grantRole} and {revokeRole}: this function's
///  purpose is to provide a mechanism for accounts to lose their privileges
///  if they are compromised (such as when a trusted device is misplaced).
///  If the calling account had been revoked `role`, emits a {RoleRevoked}
///  event.
///  Requirements:
///  - the caller must be `account`.
///  May emit a {RoleRevoked} event.
function renounceRole(bytes32 role, address account) virtual override public {
    require(account == _msgSender(), "AccessControl: can only renounce roles for self");
    _revokeRole(role, account);
}
```

## Related Implementations

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:104
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### _revokeRole(bytes32,address)

- **Kind**: internal
- **Source**: 2233:171:68
- **Link**: `lib/openzeppelin-contracts/contracts/access/AccessControlEnumerable.sol:AccessControlEnumerable:_revokeRole(bytes32,address)`

```solidity
///  @dev Overload {_revokeRole} to track enumerable memberships
function _revokeRole(bytes32 role, address account) virtual override internal {
    super._revokeRole(role, account);
    _roleMembers[role].remove(account);
}
```

### _revokeRole(bytes32,address)

- **Kind**: internal
- **Source**: 7991:234:67
- **Link**: `lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_revokeRole(bytes32,address)`

```solidity
///  @dev Revokes `role` from `account`.
///  Internal function without access restriction.
///  May emit a {RoleRevoked} event.
function _revokeRole(bytes32 role, address account) virtual internal {
    if (hasRole(role, account)) {
        _roles[role].members[account] = false;
        emit RoleRevoked(role, account, _msgSender());
    }
}
```

### hasRole(bytes32,address)

- **Kind**: internal
- **Source**: 3021:145:67
- **Link**: `lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:hasRole(bytes32,address)`

```solidity
///  @dev Returns `true` if `account` has been granted `role`.
function hasRole(bytes32 role, address account) virtual override public view returns (bool) {
    return _roles[role].members[account];
}
```

### remove(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8623:156:118
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:remove(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Removes a value from a set. O(1).
///  Returns true if the value was removed from the set, that is if it was
///  present.
function remove(AddressSet storage set, address value) internal returns (bool) {
    return _remove(set._inner, bytes32(uint256(uint160(value))));
}
```

### _remove(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2786:1388:118
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_remove(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Removes a value from a set. O(1).
///  Returns true if the value was removed from the set, that is if it was
///  present.
function _remove(Set storage set, bytes32 value) private returns (bool) {
    uint256 valueIndex = set._indexes[value];
    if (valueIndex != 0) {
        uint256 toDeleteIndex = valueIndex - 1;
        uint256 lastIndex = set._values.length - 1;
        if (lastIndex != toDeleteIndex) {
            bytes32 lastValue = set._values[lastIndex];
            set._values[toDeleteIndex] = lastValue;
            set._indexes[lastValue] = valueIndex;
        }
        set._values.pop();
        delete set._indexes[value];
        return true;
    } else {
        return false;
    }
}
```

## State Variable Reads

- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## State Variable Writes

- **_roleMembers** (`mapping(bytes32 => struct EnumerableSet.AddressSet)`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AccessControl.renounceRole(bytes32,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Context._msgSender() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AccessControlEnumerable._revokeRole(bytes32,address) (NodeID: 2)
      💬 Args: [role, account]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AccessControl._revokeRole(bytes32,address) (NodeID: 3)
    │   💬 Args: [role, account]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 4)
    │ │   💬 Args: [role, account]
    │ │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 5)
    │     💬 Args: [no args]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet.remove(struct EnumerableSet.AddressSet,address) (NodeID: 6)
        💬 Args: [_roleMembers[role], account]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet._remove(struct EnumerableSet.Set,bytes32) (NodeID: 7)
          💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
          👁️  Def: private
```

## Documentation

### Function Documentation

 @dev Revokes `role` from the calling account.
 Roles are often managed via {grantRole} and {revokeRole}: this function's
 purpose is to provide a mechanism for accounts to lose their privileges
 if they are compromised (such as when a trusted device is misplaced).
 If the calling account had been revoked `role`, emits a {RoleRevoked}
 event.
 Requirements:
 - the caller must be `account`.
 May emit a {RoleRevoked} event.

### Interface Documentation

 @dev Revokes `role` from the calling account.
 Roles are often managed via {grantRole} and {revokeRole}: this function's
 purpose is to provide a mechanism for accounts to lose their privileges
 if they are compromised (such as when a trusted device is misplaced).
 If the calling account had been granted `role`, emits a {RoleRevoked}
 event.
 Requirements:
 - the caller must be `account`.
