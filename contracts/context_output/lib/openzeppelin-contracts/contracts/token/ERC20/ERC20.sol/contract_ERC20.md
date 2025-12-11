# Contract: ERC20

## Metadata

- **Name**: ERC20
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol
- **Documentation**:  @dev Implementation of the {IERC20} interface.
   This implementation is agnostic to the way tokens are created. This means
   that a supply mechanism has to be added in a derived contract using {_mint}.
   For a generic mechanism see {ERC20PresetMinterPauser}.
   TIP: For a detailed writeup see our guide
   https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
   to implement supply mechanisms].
   The default value of {decimals} is 18. To change this, you should override
   this function so it returns a different value.
   We have followed general OpenZeppelin Contracts guidelines: functions revert
   instead returning `false` on failure. This behavior is nonetheless
   conventional and does not conflict with the expectations of ERC20
   applications.
   Additionally, an {Approval} event is emitted on calls to {transferFrom}.
   This allows applications to reconstruct the allowance for all accounts just
   by listening to said events. Other implementations of the EIP may not emit
   these events, as it isn't required by the specification.
   Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
   functions have been added to mitigate the well-known issues around setting
   allowances. See {IERC20-approve}.

## Implements Interfaces

- **IERC20Metadata** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variables

### _balances

```solidity
mapping(address => uint256) private _balances
```

### _allowances

```solidity
mapping(address => mapping(address => uint256)) private _allowances
```

### _totalSupply

```solidity
uint256 private _totalSupply
```

### _name

```solidity
string private _name
```

### _symbol

```solidity
string private _symbol
```

## Events

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

## Public/External Functions

### constructor(string,string)

- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 1980:113:86
- **Details**: [function_constructor_string_string.md](./function_constructor_string_string.md)

**Signature:**
```solidity
///  @dev Sets the values for {name} and {symbol}.
///  All two of these values are immutable: they can only be set once during
///  construction.
constructor(string memory name_, string memory symbol_);
```

### name()

- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 2158:98:86
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() virtual override public view returns (string memory);
```

### symbol()

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

### decimals()

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

### totalSupply()

- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 3255:106:86
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
///  @dev See {IERC20-totalSupply}.
function totalSupply() virtual override public view returns (uint256);
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 3419:125:86
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
///  @dev See {IERC20-balanceOf}.
function balanceOf(address account) virtual override public view returns (uint256);
```

### transfer(address,uint256)

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

### allowance(address,address)

- **Signature**: `allowance(address,address)`
- **Visibility**: public
- **Source Range**: 3987:149:86
- **Details**: [function_allowance_address_address.md](./function_allowance_address_address.md)

**Signature:**
```solidity
///  @dev See {IERC20-allowance}.
function allowance(address owner, address spender) virtual override public view returns (uint256);
```

### approve(address,uint256)

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

### transferFrom(address,address,uint256)

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

### increaseAllowance(address,uint256)

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

### decreaseAllowance(address,uint256)

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
