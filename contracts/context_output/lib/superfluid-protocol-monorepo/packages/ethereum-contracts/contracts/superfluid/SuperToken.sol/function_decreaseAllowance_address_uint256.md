# Function: decreaseAllowance(address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `decreaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 18309:296:161

## Implementation

```solidity
function decreaseAllowance(address spender, uint256 subtractedValue) virtual override public returns (bool) {
    _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue, "SuperToken: decreased allowance below zero"));
    return true;
}
```

## Related Implementations

### _approve(address,address,uint256)

- **Kind**: internal
- **Source**: 13858:406:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_approve(address,address,uint256)`

```solidity
///  @notice Sets `amount` as the allowance of `spender` over the `account`s tokens.
///  This is internal function is equivalent to `approve`, and can be used to
///  e.g. set automatic allowances for certain subsystems, etc.
///  Emits an {Approval} event.
///  Requirements:
///  - `account` cannot be the zero address.
///  - `spender` cannot be the zero address.
function _approve(address account, address spender, uint256 amount) internal {
    if (account == address(0)) {
        revert SUPER_TOKEN_APPROVE_FROM_ZERO_ADDRESS();
    }
    if (spender == address(0)) {
        revert SUPER_TOKEN_APPROVE_TO_ZERO_ADDRESS();
    }
    _allowances[account][spender] = amount;
    emit Approval(account, spender, amount);
}
```

### sub(uint256,uint256,string)

- **Kind**: internal
- **Source**: 4959:201:116
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeMath.sol:SafeMath:sub(uint256,uint256,string)`

```solidity
///  @dev Returns the subtraction of two unsigned integers, reverting with custom message on
///  overflow (when the result is negative).
///  CAUTION: This function is deprecated because it requires allocating memory for the error
///  message unnecessarily. For custom revert reasons use {trySub}.
///  Counterpart to Solidity's `-` operator.
///  Requirements:
///  - Subtraction cannot overflow.
function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    unchecked {
        require(b <= a, errorMessage);
        return a - b;
    }
}
```

## State Variable Reads

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.decreaseAllowance(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SuperToken._approve(address,address,uint256) (NodeID: 1)
      💬 Args: [msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue, "SuperToken: decreased allowance below zero")]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SafeMath.sub(uint256,uint256,string) (NodeID: 2)
        💬 Args: [_allowances[msg.sender][spender], subtractedValue, "SuperToken: decreased allowance below zero"]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Atomically decreases the allowance granted to `spender` by the caller.
 This is an alternative to {approve} that can be used as a mitigation for
 problems described in {IERC20-approve}.
 @custom:emits an {Approval} event indicating the updated allowance.
 @custom:requirements
 - `spender` cannot be the zero address.
 - `spender` must have allowance for the caller of at least
 `subtractedValue`.
