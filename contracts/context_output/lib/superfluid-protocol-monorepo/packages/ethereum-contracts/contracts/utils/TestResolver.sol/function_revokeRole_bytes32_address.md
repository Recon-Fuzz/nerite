# Function: revokeRole(bytes32,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol/contract_TestResolver.md]

## Metadata

- **Contract**: TestResolver
- **Signature**: `revokeRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 5354:147:67
- **Inherited From**: AccessControl

## Implementation

```solidity
///  @dev Revokes `role` from `account`.
///  If `account` had been granted `role`, emits a {RoleRevoked} event.
///  Requirements:
///  - the caller must have ``role``'s admin role.
///  May emit a {RoleRevoked} event.
function revokeRole(bytes32 role, address account) virtual override public onlyRole(getRoleAdmin(role)) {
    _revokeRole(role, account);
}
```

## Related Implementations

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

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:104
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
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

### onlyRole(bytes32)

- **Kind**: modifier
- **Source**: 2589:76:67
- **Link**: `lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:onlyRole(bytes32)`

```solidity
///  @dev Modifier that checks that an account has a specific role. Reverts
///  with a standardized message including the required role.
///  The format of the revert reason is given by the following regular expression:
///   /^AccessControl: account (0x[0-9a-f]{40}) is missing role (0x[0-9a-f]{64})$/
///  _Available since v4.1._
modifier onlyRole(bytes32 role) {
    _checkRole(role);
    _;
}
```

### getRoleAdmin(bytes32)

- **Kind**: internal
- **Source**: 4504:129:67
- **Link**: `lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:getRoleAdmin(bytes32)`

```solidity
///  @dev Returns the admin role that controls `role`. See {grantRole} and
///  {revokeRole}.
///  To change a role's admin, use {_setRoleAdmin}.
function getRoleAdmin(bytes32 role) virtual override public view returns (bytes32) {
    return _roles[role].adminRole;
}
```

### _checkRole(bytes32)

- **Kind**: internal
- **Source**: 3460:103:67
- **Link**: `lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_checkRole(bytes32)`

```solidity
///  @dev Revert with a standard message if `_msgSender()` is missing `role`.
///  Overriding this function changes the behavior of the {onlyRole} modifier.
///  Format of the revert message is described in {_checkRole}.
///  _Available since v4.6._
function _checkRole(bytes32 role) virtual internal view {
    _checkRole(role, _msgSender());
}
```

### _checkRole(bytes32,address)

- **Kind**: internal
- **Source**: 3844:479:67
- **Link**: `lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_checkRole(bytes32,address)`

```solidity
///  @dev Revert with a standard message if `account` is missing `role`.
///  The format of the revert reason is given by the following regular expression:
///   /^AccessControl: account (0x[0-9a-f]{40}) is missing role (0x[0-9a-f]{64})$/
function _checkRole(bytes32 role, address account) virtual internal view {
    if (!hasRole(role, account)) {
        revert(string(abi.encodePacked("AccessControl: account ", Strings.toHexString(account), " is missing role ", Strings.toHexString(uint256(role), 32))));
    }
}
```

### toHexString(address)

- **Kind**: internal
- **Source**: 2407:149:108
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toHexString(address)`

```solidity
///  @dev Converts an `address` with fixed length of 20 bytes to its not checksummed ASCII `string` hexadecimal representation.
function toHexString(address addr) internal pure returns (string memory) {
    return toHexString(uint256(uint160(addr)), _ADDRESS_LENGTH);
}
```

### toHexString(uint256,uint256)

- **Kind**: internal
- **Source**: 1818:437:108
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toHexString(uint256,uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
    bytes memory buffer = new bytes((2 * length) + 2);
    buffer[0] = "0";
    buffer[1] = "x";
    for (uint256 i = (2 * length) + 1; i > 1; --i) {
        buffer[i] = _SYMBOLS[value & 0xf];
        value >>= 4;
    }
    require(value == 0, "Strings: hex length insufficient");
    return string(buffer);
}
```

## State Variable Reads

- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)
- **_ADDRESS_LENGTH** (`uint8`)
- **_SYMBOLS** (`bytes16`)

## State Variable Writes

- **_roleMembers** (`mapping(bytes32 => struct EnumerableSet.AddressSet)`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AccessControl.revokeRole(bytes32,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AccessControlEnumerable._revokeRole(bytes32,address) (NodeID: 1)
  │   💬 Args: [role, account]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl._revokeRole(bytes32,address) (NodeID: 2)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 3)
  │ │ │   💬 Args: [role, account]
  │ │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 4)
  │ │     💬 Args: [no args]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet.remove(struct EnumerableSet.AddressSet,address) (NodeID: 5)
  │     💬 Args: [_roleMembers[role], account]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._remove(struct EnumerableSet.Set,bytes32) (NodeID: 6)
  │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │       👁️  Def: private
  └─ [1] 🔒 MODIFIER: AccessControl.onlyRole(bytes32) (NodeID: 7)
      💬 Args: [getRoleAdmin(role)]
    ├─ [2] ⚙️ FUNCTION: AccessControl.getRoleAdmin(bytes32) (NodeID: 8)
    │   💬 Args: [role]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: AccessControl._checkRole(bytes32) (NodeID: 9)
        💬 Args: [getRoleAdmin(role)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: AccessControl._checkRole(bytes32,address) (NodeID: 10)
          💬 Args: [role, _msgSender()]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 15)
        │   💬 Args: [no args]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 11)
        │   💬 Args: [role, account]
        │   👁️  Def: public
        ├─ [4] ⚙️ FUNCTION: Strings.toHexString(address) (NodeID: 12)
        │   💬 Args: [account]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: Strings.toHexString(uint256,uint256) (NodeID: 13)
        │     💬 Args: [uint256(uint160(addr)), _ADDRESS_LENGTH]
        │     👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Strings.toHexString(uint256,uint256) (NodeID: 14)
            💬 Args: [uint256(role), 32]
            👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev Revokes `role` from `account`.
 If `account` had been granted `role`, emits a {RoleRevoked} event.
 Requirements:
 - the caller must have ``role``'s admin role.
 May emit a {RoleRevoked} event.

### Interface Documentation

 @dev Revokes `role` from `account`.
 If `account` had been granted `role`, emits a {RoleRevoked} event.
 Requirements:
 - the caller must have ``role``'s admin role.
