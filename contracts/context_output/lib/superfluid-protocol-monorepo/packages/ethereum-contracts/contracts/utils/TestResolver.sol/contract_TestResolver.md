# Contract: TestResolver

## Metadata

- **Name**: TestResolver
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol
- **Documentation**: @title TestResolver contract
   @author Superfluid
   @notice A Resolver specifically used for testing
   @dev Used by the SuperfluidFrameworkDeployer to grant admin privileges to its deployer

## Implements Interfaces

- **IERC165** [lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]
- **IAccessControlEnumerable** [lib/openzeppelin-contracts/contracts/access/IAccessControlEnumerable.sol/interface_IAccessControlEnumerable.md]
- **IAccessControl** [lib/openzeppelin-contracts/contracts/access/IAccessControl.sol/interface_IAccessControl.md]
- **IResolver** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/utils/IResolver.sol/interface_IResolver.md]

## State Variables

### _roles (inherited from AccessControl)

```solidity
mapping(bytes32 => RoleData) private _roles
```

### DEFAULT_ADMIN_ROLE (inherited from AccessControl)

```solidity
bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00
```

### _roleMembers (inherited from AccessControlEnumerable)

```solidity
mapping(bytes32 => EnumerableSet.AddressSet) private _roleMembers
```

### _registry (inherited from Resolver)

```solidity
mapping(string => address) private _registry
```

## Structs

### RoleData (inherited from AccessControl)

```solidity
struct RoleData {
    mapping(address => bool) members;
    bytes32 adminRole;
}
```

## Events

### Set (inherited from IResolver)

```solidity
event Set(string indexed name, address target);
```

### RoleAdminChanged (inherited from IAccessControl)

```solidity
///  @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
///  `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
///  {RoleAdminChanged} not being emitted signaling this.
///  _Available since v3.1._
event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);
```

### RoleGranted (inherited from IAccessControl)

```solidity
///  @dev Emitted when `account` is granted `role`.
///  `sender` is the account that originated the contract call, an admin role
///  bearer except when using {AccessControl-_setupRole}.
event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
```

### RoleRevoked (inherited from IAccessControl)

```solidity
///  @dev Emitted when `account` is revoked `role`.
///  `sender` is the account that originated the contract call:
///    - if using `revokeRole`, it is the admin role bearer
///    - if using `renounceRole`, it is the role bearer (i.e. `account`)
event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 343:103:185
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address _additionalAdmin);
```

### addAdmin(address)

- **Signature**: `addAdmin(address)`
- **Visibility**: external
- **Source Range**: 452:118:185
- **Details**: [function_addAdmin_address.md](./function_addAdmin_address.md)

**Signature:**
```solidity
function addAdmin(address _additionalAdmin) external;
```

### supportsInterface(bytes4) (inherited from ERC165)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 829:155:111
- **Details**: [function_supportsInterface_bytes4.md](./function_supportsInterface_bytes4.md)

**Signature:**
```solidity
///  @dev See {IERC165-supportsInterface}.
function supportsInterface(bytes4 interfaceId) virtual override public view returns (bool);
```

### hasRole(bytes32,address) (inherited from AccessControl)

- **Signature**: `hasRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 3021:145:67
- **Details**: [function_hasRole_bytes32_address.md](./function_hasRole_bytes32_address.md)

**Signature:**
```solidity
///  @dev Returns `true` if `account` has been granted `role`.
function hasRole(bytes32 role, address account) virtual override public view returns (bool);
```

### getRoleAdmin(bytes32) (inherited from AccessControl)

- **Signature**: `getRoleAdmin(bytes32)`
- **Visibility**: public
- **Source Range**: 4504:129:67
- **Details**: [function_getRoleAdmin_bytes32.md](./function_getRoleAdmin_bytes32.md)

**Signature:**
```solidity
///  @dev Returns the admin role that controls `role`. See {grantRole} and
///  {revokeRole}.
///  To change a role's admin, use {_setRoleAdmin}.
function getRoleAdmin(bytes32 role) virtual override public view returns (bytes32);
```

### grantRole(bytes32,address) (inherited from AccessControl)

- **Signature**: `grantRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 4929:145:67
- **Details**: [function_grantRole_bytes32_address.md](./function_grantRole_bytes32_address.md)

**Signature:**
```solidity
///  @dev Grants `role` to `account`.
///  If `account` had not been already granted `role`, emits a {RoleGranted}
///  event.
///  Requirements:
///  - the caller must have ``role``'s admin role.
///  May emit a {RoleGranted} event.
function grantRole(bytes32 role, address account) virtual override public onlyRole(getRoleAdmin(role));
```

### revokeRole(bytes32,address) (inherited from AccessControl)

- **Signature**: `revokeRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 5354:147:67
- **Details**: [function_revokeRole_bytes32_address.md](./function_revokeRole_bytes32_address.md)

**Signature:**
```solidity
///  @dev Revokes `role` from `account`.
///  If `account` had been granted `role`, emits a {RoleRevoked} event.
///  Requirements:
///  - the caller must have ``role``'s admin role.
///  May emit a {RoleRevoked} event.
function revokeRole(bytes32 role, address account) virtual override public onlyRole(getRoleAdmin(role));
```

### renounceRole(bytes32,address) (inherited from AccessControl)

- **Signature**: `renounceRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 6038:214:67
- **Details**: [function_renounceRole_bytes32_address.md](./function_renounceRole_bytes32_address.md)

**Signature:**
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
function renounceRole(bytes32 role, address account) virtual override public;
```

### getRoleMember(bytes32,uint256) (inherited from AccessControlEnumerable)

- **Signature**: `getRoleMember(bytes32,uint256)`
- **Visibility**: public
- **Source Range**: 1431:151:68
- **Details**: [function_getRoleMember_bytes32_uint256.md](./function_getRoleMember_bytes32_uint256.md)

**Signature:**
```solidity
///  @dev Returns one of the accounts that have `role`. `index` must be a
///  value between 0 and {getRoleMemberCount}, non-inclusive.
///  Role bearers are not sorted in any particular way, and their ordering may
///  change at any point.
///  WARNING: When using {getRoleMember} and {getRoleMemberCount}, make sure
///  you perform all queries on the same block. See the following
///  https://forum.openzeppelin.com/t/iterating-over-elements-on-enumerableset-in-openzeppelin-contracts/2296[forum post]
///  for more information.
function getRoleMember(bytes32 role, uint256 index) virtual override public view returns (address);
```

### getRoleMemberCount(bytes32) (inherited from AccessControlEnumerable)

- **Signature**: `getRoleMemberCount(bytes32)`
- **Visibility**: public
- **Source Range**: 1750:140:68
- **Details**: [function_getRoleMemberCount_bytes32.md](./function_getRoleMemberCount_bytes32.md)

**Signature:**
```solidity
///  @dev Returns the number of accounts that have `role`. Can be used
///  together with {getRoleMember} to enumerate all bearers of a role.
function getRoleMemberCount(bytes32 role) virtual override public view returns (uint256);
```

### constructor() (inherited from Resolver)

- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 637:73:178
- **Details**: [function_constructor.md](./function_constructor.md)

**Signature:**
```solidity
constructor();
```

### set(string,address) (inherited from Resolver)

- **Signature**: `set(string,address)`
- **Visibility**: external
- **Source Range**: 716:228:178
- **Details**: [function_set_string_address.md](./function_set_string_address.md)

**Signature:**
```solidity
function set(string calldata name, address target) override external;
```

### get(string) (inherited from Resolver)

- **Signature**: `get(string)`
- **Visibility**: external
- **Source Range**: 950:115:178
- **Details**: [function_get_string.md](./function_get_string.md)

**Signature:**
```solidity
function get(string calldata name) override external view returns (address);
```
