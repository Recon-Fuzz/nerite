# Contract: ERC20PresetMinterPauser

## Metadata

- **Name**: ERC20PresetMinterPauser
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol
- **Documentation**:  @dev {ERC20} token, including:
    - ability for holders to burn (destroy) their tokens
    - a minter role that allows for token minting (creation)
    - a pauser role that allows to stop all token transfers
   This contract uses {AccessControl} to lock permissioned functions using the
   different roles - head to its documentation for details.
   The account that deploys the contract will be granted the minter and pauser
   roles, as well as the default admin role, which will let it grant both minter
   and pauser roles to other accounts.
   _Deprecated in favor of https://wizard.openzeppelin.com/[Contracts Wizard]._

## Implements Interfaces

- **IERC20Metadata** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **IERC165** [lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]
- **IAccessControlEnumerable** [lib/openzeppelin-contracts/contracts/access/IAccessControlEnumerable.sol/interface_IAccessControlEnumerable.md]
- **IAccessControl** [lib/openzeppelin-contracts/contracts/access/IAccessControl.sol/interface_IAccessControl.md]

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

### _balances (inherited from ERC20)

```solidity
mapping(address => uint256) private _balances
```

### _allowances (inherited from ERC20)

```solidity
mapping(address => mapping(address => uint256)) private _allowances
```

### _totalSupply (inherited from ERC20)

```solidity
uint256 private _totalSupply
```

### _name (inherited from ERC20)

```solidity
string private _name
```

### _symbol (inherited from ERC20)

```solidity
string private _symbol
```

### _paused (inherited from Pausable)

```solidity
bool private _paused
```

### MINTER_ROLE

```solidity
bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE")
```

### PAUSER_ROLE

```solidity
bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE")
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

### Transfer (inherited from IERC20)

```solidity
///  @dev Emitted when `value` tokens are moved from one account (`from`) to
///  another (`to`).
///  Note that `value` may be zero.
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval (inherited from IERC20)

```solidity
///  @dev Emitted when the allowance of a `spender` for an `owner` is set by
///  a call to {approve}. `value` is the new allowance.
event Approval(address indexed owner, address indexed spender, uint256 value);
```

### Paused (inherited from Pausable)

```solidity
///  @dev Emitted when the pause is triggered by `account`.
event Paused(address account);
```

### Unpaused (inherited from Pausable)

```solidity
///  @dev Emitted when the pause is lifted by `account`.
event Unpaused(address account);
```

## Public/External Functions

### constructor(string,string)

- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 1424:230:94
- **Details**: [function_constructor_string_string.md](./function_constructor_string_string.md)

**Signature:**
```solidity
///  @dev Grants `DEFAULT_ADMIN_ROLE`, `MINTER_ROLE` and `PAUSER_ROLE` to the
///  account that deploys the contract.
///  See {ERC20-constructor}.
constructor(string memory name, string memory symbol) ERC20(name,symbol);
```

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 1843:202:94
- **Details**: [function_mint_address_uint256.md](./function_mint_address_uint256.md)

**Signature:**
```solidity
///  @dev Creates `amount` new tokens for `to`.
///  See {ERC20-_mint}.
///  Requirements:
///  - the caller must have the `MINTER_ROLE`.
function mint(address to, uint256 amount) virtual public;
```

### pause()

- **Signature**: `pause()`
- **Visibility**: public
- **Source Range**: 2248:169:94
- **Details**: [function_pause.md](./function_pause.md)

**Signature:**
```solidity
///  @dev Pauses all token transfers.
///  See {ERC20Pausable} and {Pausable-_pause}.
///  Requirements:
///  - the caller must have the `PAUSER_ROLE`.
function pause() virtual public;
```

### unpause()

- **Signature**: `unpause()`
- **Visibility**: public
- **Source Range**: 2624:175:94
- **Details**: [function_unpause.md](./function_unpause.md)

**Signature:**
```solidity
///  @dev Unpauses all token transfers.
///  See {ERC20Pausable} and {Pausable-_unpause}.
///  Requirements:
///  - the caller must have the `PAUSER_ROLE`.
function unpause() virtual public;
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

### name() (inherited from ERC20)

- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 2158:98:86
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() virtual override public view returns (string memory);
```

### symbol() (inherited from ERC20)

- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 2369:102:86
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
///  @dev Returns the symbol of the token, usually a shorter version of the
///  name.
function symbol() virtual override public view returns (string memory);
```

### decimals() (inherited from ERC20)

- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 3104:91:86
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
///  @dev Returns the number of decimals used to get its user representation.
///  For example, if `decimals` equals `2`, a balance of `505` tokens should
///  be displayed to a user as `5.05` (`505 / 10 ** 2`).
///  Tokens usually opt for a value of 18, imitating the relationship between
///  Ether and Wei. This is the default value returned by this function, unless
///  it's overridden.
///  NOTE: This information is only used for _display_ purposes: it in
///  no way affects any of the arithmetic of the contract, including
///  {IERC20-balanceOf} and {IERC20-transfer}.
function decimals() virtual override public view returns (uint8);
```

### totalSupply() (inherited from ERC20)

- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 3255:106:86
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
///  @dev See {IERC20-totalSupply}.
function totalSupply() virtual override public view returns (uint256);
```

### balanceOf(address) (inherited from ERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 3419:125:86
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
///  @dev See {IERC20-balanceOf}.
function balanceOf(address account) virtual override public view returns (uint256);
```

### transfer(address,uint256) (inherited from ERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 3740:189:86
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC20-transfer}.
///  Requirements:
///  - `to` cannot be the zero address.
///  - the caller must have a balance of at least `amount`.
function transfer(address to, uint256 amount) virtual override public returns (bool);
```

### allowance(address,address) (inherited from ERC20)

- **Signature**: `allowance(address,address)`
- **Visibility**: public
- **Source Range**: 3987:149:86
- **Details**: [function_allowance_address_address.md](./function_allowance_address_address.md)

**Signature:**
```solidity
///  @dev See {IERC20-allowance}.
function allowance(address owner, address spender) virtual override public view returns (uint256);
```

### approve(address,uint256) (inherited from ERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 4444:197:86
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC20-approve}.
///  NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
///  `transferFrom`. This is semantically equivalent to an infinite approval.
///  Requirements:
///  - `spender` cannot be the zero address.
function approve(address spender, uint256 amount) virtual override public returns (bool);
```

### transferFrom(address,address,uint256) (inherited from ERC20)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 5203:256:86
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC20-transferFrom}.
///  Emits an {Approval} event indicating the updated allowance. This is not
///  required by the EIP. See the note at the beginning of {ERC20}.
///  NOTE: Does not update the allowance if the current allowance
///  is the maximum `uint256`.
///  Requirements:
///  - `from` and `to` cannot be the zero address.
///  - `from` must have a balance of at least `amount`.
///  - the caller must have allowance for ``from``'s tokens of at least
///  `amount`.
function transferFrom(address from, address to, uint256 amount) virtual override public returns (bool);
```

### increaseAllowance(address,uint256) (inherited from ERC20)

- **Signature**: `increaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 5854:234:86
- **Details**: [function_increaseAllowance_address_uint256.md](./function_increaseAllowance_address_uint256.md)

**Signature:**
```solidity
///  @dev Atomically increases the allowance granted to `spender` by the caller.
///  This is an alternative to {approve} that can be used as a mitigation for
///  problems described in {IERC20-approve}.
///  Emits an {Approval} event indicating the updated allowance.
///  Requirements:
///  - `spender` cannot be the zero address.
function increaseAllowance(address spender, uint256 addedValue) virtual public returns (bool);
```

### decreaseAllowance(address,uint256) (inherited from ERC20)

- **Signature**: `decreaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 6575:427:86
- **Details**: [function_decreaseAllowance_address_uint256.md](./function_decreaseAllowance_address_uint256.md)

**Signature:**
```solidity
///  @dev Atomically decreases the allowance granted to `spender` by the caller.
///  This is an alternative to {approve} that can be used as a mitigation for
///  problems described in {IERC20-approve}.
///  Emits an {Approval} event indicating the updated allowance.
///  Requirements:
///  - `spender` cannot be the zero address.
///  - `spender` must have allowance for the caller of at least
///  `subtractedValue`.
function decreaseAllowance(address spender, uint256 subtractedValue) virtual public returns (bool);
```

### burn(uint256) (inherited from ERC20Burnable)

- **Signature**: `burn(uint256)`
- **Visibility**: public
- **Source Range**: 578:89:88
- **Details**: [function_burn_uint256.md](./function_burn_uint256.md)

**Signature:**
```solidity
///  @dev Destroys `amount` tokens from the caller.
///  See {ERC20-_burn}.
function burn(uint256 amount) virtual public;
```

### burnFrom(address,uint256) (inherited from ERC20Burnable)

- **Signature**: `burnFrom(address,uint256)`
- **Visibility**: public
- **Source Range**: 973:161:88
- **Details**: [function_burnFrom_address_uint256.md](./function_burnFrom_address_uint256.md)

**Signature:**
```solidity
///  @dev Destroys `amount` tokens from `account`, deducting from the caller's
///  allowance.
///  See {ERC20-_burn} and {ERC20-allowance}.
///  Requirements:
///  - the caller must have allowance for ``accounts``'s tokens of at least
///  `amount`.
function burnFrom(address account, uint256 amount) virtual public;
```

### paused() (inherited from Pausable)

- **Signature**: `paused()`
- **Visibility**: public
- **Source Range**: 1615:84:85
- **Details**: [function_paused.md](./function_paused.md)

**Signature:**
```solidity
///  @dev Returns true if the contract is paused, and false otherwise.
function paused() virtual public view returns (bool);
```
