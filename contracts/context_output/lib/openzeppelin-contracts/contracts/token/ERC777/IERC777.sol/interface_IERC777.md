# Interface: IERC777

## Metadata

- **Name**: IERC777
- **Type**: Interface
- **Path**: lib/openzeppelin-contracts/contracts/token/ERC777/IERC777.sol
- **Documentation**:  @dev Interface of the ERC777Token standard as defined in the EIP.
   This contract uses the
   https://eips.ethereum.org/EIPS/eip-1820[ERC1820 registry standard] to let
   token holders and recipients react to token movements by using setting implementers
   for the associated interfaces in said registry. See {IERC1820Registry} and
   {ERC1820Implementer}.

## Events

### Minted

```solidity
///  @dev Emitted when `amount` tokens are created by `operator` and assigned to `to`.
///  Note that some additional user `data` and `operatorData` can be logged in the event.
event Minted(address indexed operator, address indexed to, uint256 amount, bytes data, bytes operatorData);
```

### Burned

```solidity
///  @dev Emitted when `operator` destroys `amount` tokens from `account`.
///  Note that some additional user `data` and `operatorData` can be logged in the event.
event Burned(address indexed operator, address indexed from, uint256 amount, bytes data, bytes operatorData);
```

### AuthorizedOperator

```solidity
///  @dev Emitted when `operator` is made operator for `tokenHolder`.
event AuthorizedOperator(address indexed operator, address indexed tokenHolder);
```

### RevokedOperator

```solidity
///  @dev Emitted when `operator` is revoked its operator status for `tokenHolder`.
event RevokedOperator(address indexed operator, address indexed tokenHolder);
```

### Sent

```solidity
event Sent(address indexed operator, address indexed from, address indexed to, uint256 amount, bytes data, bytes operatorData);
```

## Public/External Functions

### name()

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 1572:54:100

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() external view returns (string memory);;
```

### symbol()

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 1739:56:100

**Signature:**
```solidity
///  @dev Returns the symbol of the token, usually a shorter version of the
///  name.
function symbol() external view returns (string memory);;
```

### granularity()

- **Signature**: `granularity()`
- **Visibility**: external
- **Source Range**: 2093:55:100

**Signature:**
```solidity
///  @dev Returns the smallest part of the token that is not divisible. This
///  means all token operations (creation, movement and destruction) must have
///  amounts that are a multiple of this number.
///  For most token contracts, this value will equal 1.
function granularity() external view returns (uint256);;
```

### totalSupply()

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 2225:55:100

**Signature:**
```solidity
///  @dev Returns the amount of tokens in existence.
function totalSupply() external view returns (uint256);;
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 2374:66:100

**Signature:**
```solidity
///  @dev Returns the amount of tokens owned by an account (`owner`).
function balanceOf(address owner) external view returns (uint256);;
```

### send(address,uint256,bytes)

- **Signature**: `send(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 3036:79:100

**Signature:**
```solidity
///  @dev Moves `amount` tokens from the caller's account to `recipient`.
///  If send or receive hooks are registered for the caller and `recipient`,
///  the corresponding functions will be called with `data` and empty
///  `operatorData`. See {IERC777Sender} and {IERC777Recipient}.
///  Emits a {Sent} event.
///  Requirements
///  - the caller must have at least `amount` tokens.
///  - `recipient` cannot be the zero address.
///  - if `recipient` is a contract, it must implement the {IERC777Recipient}
///  interface.
function send(address recipient, uint256 amount, bytes calldata data) external;;
```

### burn(uint256,bytes)

- **Signature**: `burn(uint256,bytes)`
- **Visibility**: external
- **Source Range**: 3530:60:100

**Signature:**
```solidity
///  @dev Destroys `amount` tokens from the caller's account, reducing the
///  total supply.
///  If a send hook is registered for the caller, the corresponding function
///  will be called with `data` and empty `operatorData`. See {IERC777Sender}.
///  Emits a {Burned} event.
///  Requirements
///  - the caller must have at least `amount` tokens.
function burn(uint256 amount, bytes calldata data) external;;
```

### isOperatorFor(address,address)

- **Signature**: `isOperatorFor(address,address)`
- **Visibility**: external
- **Source Range**: 3850:91:100

**Signature:**
```solidity
///  @dev Returns true if an account is an operator of `tokenHolder`.
///  Operators can send and burn tokens on behalf of their owners. All
///  accounts are their own operator.
///  See {operatorSend} and {operatorBurn}.
function isOperatorFor(address operator, address tokenHolder) external view returns (bool);;
```

### authorizeOperator(address)

- **Signature**: `authorizeOperator(address)`
- **Visibility**: external
- **Source Range**: 4185:54:100

**Signature:**
```solidity
///  @dev Make an account an operator of the caller.
///  See {isOperatorFor}.
///  Emits an {AuthorizedOperator} event.
///  Requirements
///  - `operator` cannot be calling address.
function authorizeOperator(address operator) external;;
```

### revokeOperator(address)

- **Signature**: `revokeOperator(address)`
- **Visibility**: external
- **Source Range**: 4511:51:100

**Signature:**
```solidity
///  @dev Revoke an account's operator status for the caller.
///  See {isOperatorFor} and {defaultOperators}.
///  Emits a {RevokedOperator} event.
///  Requirements
///  - `operator` cannot be calling address.
function revokeOperator(address operator) external;;
```

### defaultOperators()

- **Signature**: `defaultOperators()`
- **Visibility**: external
- **Source Range**: 4911:69:100

**Signature:**
```solidity
///  @dev Returns the list of default operators. These accounts are operators
///  for all token holders, even if {authorizeOperator} was never called on
///  them.
///  This list is immutable, but individual holders may revoke these via
///  {revokeOperator}, in which case {isOperatorFor} will return false.
function defaultOperators() external view returns (address[] memory);;
```

### operatorSend(address,address,uint256,bytes,bytes)

- **Signature**: `operatorSend(address,address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 5705:178:100

**Signature:**
```solidity
///  @dev Moves `amount` tokens from `sender` to `recipient`. The caller must
///  be an operator of `sender`.
///  If send or receive hooks are registered for `sender` and `recipient`,
///  the corresponding functions will be called with `data` and
///  `operatorData`. See {IERC777Sender} and {IERC777Recipient}.
///  Emits a {Sent} event.
///  Requirements
///  - `sender` cannot be the zero address.
///  - `sender` must have at least `amount` tokens.
///  - the caller must be an operator for `sender`.
///  - `recipient` cannot be the zero address.
///  - if `recipient` is a contract, it must implement the {IERC777Recipient}
///  interface.
function operatorSend(address sender, address recipient, uint256 amount, bytes calldata data, bytes calldata operatorData) external;;
```

### operatorBurn(address,uint256,bytes,bytes)

- **Signature**: `operatorBurn(address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 6426:114:100

**Signature:**
```solidity
///  @dev Destroys `amount` tokens from `account`, reducing the total supply.
///  The caller must be an operator of `account`.
///  If a send hook is registered for `account`, the corresponding function
///  will be called with `data` and `operatorData`. See {IERC777Sender}.
///  Emits a {Burned} event.
///  Requirements
///  - `account` cannot be the zero address.
///  - `account` must have at least `amount` tokens.
///  - the caller must be an operator for `account`.
function operatorBurn(address account, uint256 amount, bytes calldata data, bytes calldata operatorData) external;;
```
