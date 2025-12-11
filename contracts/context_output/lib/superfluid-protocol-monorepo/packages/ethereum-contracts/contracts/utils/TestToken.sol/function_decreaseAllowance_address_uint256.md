# Function: decreaseAllowance(address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestToken.sol/contract_TestToken.md]

## Metadata

- **Contract**: TestToken
- **Signature**: `decreaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 6575:427:86
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev Atomically decreases the allowance granted to `spender` by the caller.
///  This is an alternative to {approve} that can be used as a mitigation for
///  problems described in {IERC20-approve}.
///  Emits an {Approval} event indicating the updated allowance.
///  Requirements:
///  - `spender` cannot be the zero address.
///  - `spender` must have allowance for the caller of at least
///  `subtractedValue`.
function decreaseAllowance(address spender, uint256 subtractedValue) virtual public returns (bool) {
    address owner = _msgSender();
    uint256 currentAllowance = allowance(owner, spender);
    require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
    unchecked {
        _approve(owner, spender, currentAllowance - subtractedValue);
    }
    return true;
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

### allowance(address,address)

- **Kind**: internal
- **Source**: 3987:149:86
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:allowance(address,address)`

```solidity
///  @dev See {IERC20-allowance}.
function allowance(address owner, address spender) virtual override public view returns (uint256) {
    return _allowances[owner][spender];
}
```

### _approve(address,address,uint256)

- **Kind**: internal
- **Source**: 10457:340:86
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_approve(address,address,uint256)`

```solidity
///  @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
///  This internal function is equivalent to `approve`, and can be used to
///  e.g. set automatic allowances for certain subsystems, etc.
///  Emits an {Approval} event.
///  Requirements:
///  - `owner` cannot be the zero address.
///  - `spender` cannot be the zero address.
function _approve(address owner, address spender, uint256 amount) virtual internal {
    require(owner != address(0), "ERC20: approve from the zero address");
    require(spender != address(0), "ERC20: approve to the zero address");
    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
}
```

## State Variable Reads

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.decreaseAllowance(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Context._msgSender() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ERC20.allowance(address,address) (NodeID: 2)
  │   💬 Args: [owner, spender]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20._approve(address,address,uint256) (NodeID: 3)
      💬 Args: [owner, spender, currentAllowance - subtractedValue]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev Atomically decreases the allowance granted to `spender` by the caller.
 This is an alternative to {approve} that can be used as a mitigation for
 problems described in {IERC20-approve}.
 Emits an {Approval} event indicating the updated allowance.
 Requirements:
 - `spender` cannot be the zero address.
 - `spender` must have allowance for the caller of at least
 `subtractedValue`.
