# Function: grantRole(bytes32,address)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol/contract_ERC20PresetMinterPauser.md]

## Metadata

- **Contract**: ERC20PresetMinterPauser
- **Signature**: `grantRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 4929:145:67
- **Inherited From**: AccessControl

## Implementation

```solidity
///  @dev Grants `role` to `account`.
///  If `account` had not been already granted `role`, emits a {RoleGranted}
///  event.
///  Requirements:
///  - the caller must have ``role``'s admin role.
///  May emit a {RoleGranted} event.
function grantRole(bytes32 role, address account) virtual override public onlyRole(getRoleAdmin(role)) {
    _grantRole(role, account);
}
```

## Related Implementations

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
┌─ [0] ⚙️ FUNCTION: AccessControl.grantRole(bytes32,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AccessControlEnumerable._grantRole(bytes32,address) (NodeID: 1)
  │   💬 Args: [role, account]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 2)
  │ │   💬 Args: [role, account]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 3)
  │ │ │   💬 Args: [role, account]
  │ │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 4)
  │ │     💬 Args: [no args]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 5)
  │     💬 Args: [_roleMembers[role], account]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 6)
  │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │       👁️  Def: private
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 7)
  │         💬 Args: [set, value]
  │         👁️  Def: private
  └─ [1] 🔒 MODIFIER: AccessControl.onlyRole(bytes32) (NodeID: 8)
      💬 Args: [getRoleAdmin(role)]
    ├─ [2] ⚙️ FUNCTION: AccessControl.getRoleAdmin(bytes32) (NodeID: 9)
    │   💬 Args: [role]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: AccessControl._checkRole(bytes32) (NodeID: 10)
        💬 Args: [getRoleAdmin(role)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: AccessControl._checkRole(bytes32,address) (NodeID: 11)
          💬 Args: [role, _msgSender()]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 16)
        │   💬 Args: [no args]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 12)
        │   💬 Args: [role, account]
        │   👁️  Def: public
        ├─ [4] ⚙️ FUNCTION: Strings.toHexString(address) (NodeID: 13)
        │   💬 Args: [account]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: Strings.toHexString(uint256,uint256) (NodeID: 14)
        │     💬 Args: [uint256(uint160(addr)), _ADDRESS_LENGTH]
        │     👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Strings.toHexString(uint256,uint256) (NodeID: 15)
            💬 Args: [uint256(role), 32]
            👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev Grants `role` to `account`.
 If `account` had not been already granted `role`, emits a {RoleGranted}
 event.
 Requirements:
 - the caller must have ``role``'s admin role.
 May emit a {RoleGranted} event.

### Interface Documentation

 @dev Grants `role` to `account`.
 If `account` had not been already granted `role`, emits a {RoleGranted}
 event.
 Requirements:
 - the caller must have ``role``'s admin role.
