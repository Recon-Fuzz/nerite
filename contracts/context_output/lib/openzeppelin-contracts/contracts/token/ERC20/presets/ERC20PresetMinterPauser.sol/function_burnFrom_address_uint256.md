# Function: burnFrom(address,uint256)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol/contract_ERC20PresetMinterPauser.md]

## Metadata

- **Contract**: ERC20PresetMinterPauser
- **Signature**: `burnFrom(address,uint256)`
- **Visibility**: public
- **Source Range**: 973:161:88
- **Inherited From**: ERC20Burnable

## Implementation

```solidity
///  @dev Destroys `amount` tokens from `account`, deducting from the caller's
///  allowance.
///  See {ERC20-_burn} and {ERC20-allowance}.
///  Requirements:
///  - the caller must have allowance for ``accounts``'s tokens of at least
///  `amount`.
function burnFrom(address account, uint256 amount) virtual public {
    _spendAllowance(account, _msgSender(), amount);
    _burn(account, amount);
}
```

## Related Implementations

### _spendAllowance(address,address,uint256)

- **Kind**: internal
- **Source**: 11078:411:86
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_spendAllowance(address,address,uint256)`

```solidity
///  @dev Updates `owner` s allowance for `spender` based on spent `amount`.
///  Does not update the allowance amount in case of infinite allowance.
///  Revert if not enough allowance is available.
///  Might emit an {Approval} event.
function _spendAllowance(address owner, address spender, uint256 amount) virtual internal {
    uint256 currentAllowance = allowance(owner, spender);
    if (currentAllowance != type(uint256).max) {
        require(currentAllowance >= amount, "ERC20: insufficient allowance");
        unchecked {
            _approve(owner, spender, currentAllowance - amount);
        }
    }
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

### _burn(address,uint256)

- **Kind**: internal
- **Source**: 9375:659:86
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_burn(address,uint256)`

```solidity
///  @dev Destroys `amount` tokens from `account`, reducing the
///  total supply.
///  Emits a {Transfer} event with `to` set to the zero address.
///  Requirements:
///  - `account` cannot be the zero address.
///  - `account` must have at least `amount` tokens.
function _burn(address account, uint256 amount) virtual internal {
    require(account != address(0), "ERC20: burn from the zero address");
    _beforeTokenTransfer(account, address(0), amount);
    uint256 accountBalance = _balances[account];
    require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
    unchecked {
        _balances[account] = accountBalance - amount;
        _totalSupply -= amount;
    }
    emit Transfer(account, address(0), amount);
    _afterTokenTransfer(account, address(0), amount);
}
```

### _beforeTokenTransfer(address,address,uint256)

- **Kind**: internal
- **Source**: 2805:211:94
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol:ERC20PresetMinterPauser:_beforeTokenTransfer(address,address,uint256)`

```solidity
function _beforeTokenTransfer(address from, address to, uint256 amount) virtual override(ERC20, ERC20Pausable) internal {
    super._beforeTokenTransfer(from, to, amount);
}
```

### _beforeTokenTransfer(address,address,uint256)

- **Kind**: internal
- **Source**: 1046:234:89
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Pausable.sol:ERC20Pausable:_beforeTokenTransfer(address,address,uint256)`

```solidity
///  @dev See {ERC20-_beforeTokenTransfer}.
///  Requirements:
///  - the contract must not be paused.
function _beforeTokenTransfer(address from, address to, uint256 amount) virtual override internal {
    super._beforeTokenTransfer(from, to, amount);
    require(!paused(), "ERC20Pausable: token transfer while paused");
}
```

### _beforeTokenTransfer(address,address,uint256)

- **Kind**: internal
- **Source**: 12073:91:86
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_beforeTokenTransfer(address,address,uint256)`

```solidity
///  @dev Hook that is called before any transfer of tokens. This includes
///  minting and burning.
///  Calling conditions:
///  - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
///  will be transferred to `to`.
///  - when `from` is zero, `amount` tokens will be minted for `to`.
///  - when `to` is zero, `amount` of ``from``'s tokens will be burned.
///  - `from` and `to` are never both zero.
///  To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
function _beforeTokenTransfer(address from, address to, uint256 amount) virtual internal {}
```

### paused()

- **Kind**: internal
- **Source**: 1615:84:85
- **Link**: `lib/openzeppelin-contracts/contracts/security/Pausable.sol:Pausable:paused()`

```solidity
///  @dev Returns true if the contract is paused, and false otherwise.
function paused() virtual public view returns (bool) {
    return _paused;
}
```

### _afterTokenTransfer(address,address,uint256)

- **Kind**: internal
- **Source**: 12752:90:86
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_afterTokenTransfer(address,address,uint256)`

```solidity
///  @dev Hook that is called after any transfer of tokens. This includes
///  minting and burning.
///  Calling conditions:
///  - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
///  has been transferred to `to`.
///  - when `from` is zero, `amount` tokens have been minted for `to`.
///  - when `to` is zero, `amount` of ``from``'s tokens have been burned.
///  - `from` and `to` are never both zero.
///  To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
function _afterTokenTransfer(address from, address to, uint256 amount) virtual internal {}
```

## State Variable Reads

- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_balances** (`mapping(address => uint256)`)
- **_paused** (`bool`)

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_balances** (`mapping(address => uint256)`)
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Burnable.burnFrom(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC20._spendAllowance(address,address,uint256) (NodeID: 1)
  │   💬 Args: [account, _msgSender(), amount]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 4)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ERC20.allowance(address,address) (NodeID: 2)
  │ │   💬 Args: [owner, spender]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ERC20._approve(address,address,uint256) (NodeID: 3)
  │     💬 Args: [owner, spender, currentAllowance - amount]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 5)
      💬 Args: [account, amount]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC20PresetMinterPauser._beforeTokenTransfer(address,address,uint256) (NodeID: 6)
    │   💬 Args: [account, address(0), amount]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ERC20Pausable._beforeTokenTransfer(address,address,uint256) (NodeID: 7)
    │     💬 Args: [from, to, amount]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ERC20._beforeTokenTransfer(address,address,uint256) (NodeID: 8)
    │   │   💬 Args: [from, to, amount]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Pausable.paused() (NodeID: 9)
    │       💬 Args: [no args]
    │       👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC20._afterTokenTransfer(address,address,uint256) (NodeID: 10)
        💬 Args: [account, address(0), amount]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev Destroys `amount` tokens from `account`, deducting from the caller's
 allowance.
 See {ERC20-_burn} and {ERC20-allowance}.
 Requirements:
 - the caller must have allowance for ``accounts``'s tokens of at least
 `amount`.
