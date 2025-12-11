# Function: constructor(string,string)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol/contract_ERC20PresetMinterPauser.md]

## Metadata

- **Contract**: ERC20PresetMinterPauser
- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 1424:230:94

## Implementation

```solidity
///  @dev Grants `DEFAULT_ADMIN_ROLE`, `MINTER_ROLE` and `PAUSER_ROLE` to the
///  account that deploys the contract.
///  See {ERC20-constructor}.
constructor(string memory name, string memory symbol) ERC20(name,symbol) {
    _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    _setupRole(MINTER_ROLE, _msgSender());
    _setupRole(PAUSER_ROLE, _msgSender());
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

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:104
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
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

### (string,string)

- **Kind**: internal
- **Source**: 1980:113:86
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:constructor(string,string)`

```solidity
///  @dev Sets the values for {name} and {symbol}.
///  All two of these values are immutable: they can only be set once during
///  construction.
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

## State Variable Reads

- **MINTER_ROLE** (`bytes32`)
- **PAUSER_ROLE** (`bytes32`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## State Variable Writes

- **_roleMembers** (`mapping(bytes32 => struct EnumerableSet.AddressSet)`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)
- **_name** (`string`)
- **_symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: ERC20PresetMinterPauser.constructor(string,string) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: ERC20PresetMinterPauser
  ├─ [1] ⚙️ FUNCTION: AccessControl._setupRole(bytes32,address) (NodeID: 1)
  │   💬 Args: [DEFAULT_ADMIN_ROLE, _msgSender()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 9)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AccessControlEnumerable._grantRole(bytes32,address) (NodeID: 2)
  │     💬 Args: [role, account]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 3)
  │   │   💬 Args: [role, account]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 4)
  │   │ │   💬 Args: [role, account]
  │   │ │   👁️  Def: public
  │   │ └─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 5)
  │   │     💬 Args: [no args]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 6)
  │       💬 Args: [_roleMembers[role], account]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 7)
  │         💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │         👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 8)
  │           💬 Args: [set, value]
  │           👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: AccessControl._setupRole(bytes32,address) (NodeID: 10)
  │   💬 Args: [MINTER_ROLE, _msgSender()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 18)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AccessControlEnumerable._grantRole(bytes32,address) (NodeID: 11)
  │     💬 Args: [role, account]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 12)
  │   │   💬 Args: [role, account]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 13)
  │   │ │   💬 Args: [role, account]
  │   │ │   👁️  Def: public
  │   │ └─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 14)
  │   │     💬 Args: [no args]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 15)
  │       💬 Args: [_roleMembers[role], account]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 16)
  │         💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │         👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 17)
  │           💬 Args: [set, value]
  │           👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: AccessControl._setupRole(bytes32,address) (NodeID: 19)
  │   💬 Args: [PAUSER_ROLE, _msgSender()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 27)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AccessControlEnumerable._grantRole(bytes32,address) (NodeID: 20)
  │     💬 Args: [role, account]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: AccessControl._grantRole(bytes32,address) (NodeID: 21)
  │   │   💬 Args: [role, account]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 22)
  │   │ │   💬 Args: [role, account]
  │   │ │   👁️  Def: public
  │   │ └─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 23)
  │   │     💬 Args: [no args]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 24)
  │       💬 Args: [_roleMembers[role], account]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 25)
  │         💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │         👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 26)
  │           💬 Args: [set, value]
  │           👁️  Def: private
  └─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 28)
      💬 Args: [name, symbol]
      🏗️  Contract: ERC20
```

## Documentation

### Function Documentation

 @dev Grants `DEFAULT_ADMIN_ROLE`, `MINTER_ROLE` and `PAUSER_ROLE` to the
 account that deploys the contract.
 See {ERC20-constructor}.
