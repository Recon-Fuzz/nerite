# Function: constructor()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol/contract_TestResolver.md]

## Metadata

- **Contract**: TestResolver
- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 637:73:178
- **Inherited From**: Resolver

## Implementation

```solidity
constructor() {
    _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
}
```

## Related Implementations

### _setupRole(bytes32,address)

- **Kind**: internal
- **Source**: 6937:110:67
- **Link**: `lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_setupRole(bytes32,address)`

```solidity
///  @dev Grants `role` to `account`.
///  If `account` had not been already granted `role`, emits a {RoleGranted}
///  event. Note that unlike {grantRole}, this function doesn't perform any
///  checks on the calling account.
///  May emit a {RoleGranted} event.
///  [WARNING]
///  ====
///  This function should only be called from the constructor when setting
///  up the initial roles for the system.
///  Using this function in any other way is effectively circumventing the admin
///  system imposed by {AccessControl}.
///  ====
///  NOTE: This function is deprecated in favor of {_grantRole}.
function _setupRole(bytes32 role, address account) virtual internal {
    _grantRole(role, account);
}
```

### _grantRole(bytes32,address)

- **Kind**: internal
- **Source**: 1978:166:68
- **Link**: `lib/openzeppelin-contracts/contracts/access/AccessControlEnumerable.sol:AccessControlEnumerable:_grantRole(bytes32,address)`

```solidity
///  @dev Overload {_grantRole} to track enumerable memberships
function _grantRole(bytes32 role, address account) virtual override internal {
    super._grantRole(role, account);
    _roleMembers[role].add(account);
}
```

### _grantRole(bytes32,address)

- **Kind**: internal
- **Source**: 7587:233:67
- **Link**: `lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_grantRole(bytes32,address)`

```solidity
///  @dev Grants `role` to `account`.
///  Internal function without access restriction.
///  May emit a {RoleGranted} event.
function _grantRole(bytes32 role, address account) virtual internal {
    if (!hasRole(role, account)) {
        _roles[role].members[account] = true;
        emit RoleGranted(role, account, _msgSender());
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

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:104
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8305:150:118
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function add(AddressSet storage set, address value) internal returns (bool) {
    return _add(set._inner, bytes32(uint256(uint160(value))));
}
```

### _add(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2214:404:118
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._indexes[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 4255:127:118
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._indexes[value] != 0;
}
```

## State Variable Reads

- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## State Variable Writes

- **_roleMembers** (`mapping(bytes32 => struct EnumerableSet.AddressSet)`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: Resolver.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: Resolver
  └─ [1] ⚙️ FUNCTION: AccessControl._setupRole(bytes32,address) (NodeID: 1)
      💬 Args: [DEFAULT_ADMIN_ROLE, msg.sender]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AccessControlEnumerable._grantRole(bytes32,address) (NodeID: 2)
        💬 Args: [role, account]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 3)
      │   💬 Args: [role, account]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 4)
      │ │   💬 Args: [role, account]
      │ │   👁️  Def: public
      │ └─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 5)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 6)
          💬 Args: [_roleMembers[role], account]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 7)
            💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
            👁️  Def: private
          └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 8)
              💬 Args: [set, value]
              👁️  Def: private
```
