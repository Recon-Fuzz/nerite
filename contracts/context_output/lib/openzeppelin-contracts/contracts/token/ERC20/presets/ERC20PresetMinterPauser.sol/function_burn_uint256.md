# Function: burn(uint256)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol/contract_ERC20PresetMinterPauser.md]

## Metadata

- **Contract**: ERC20PresetMinterPauser
- **Signature**: `burn(uint256)`
- **Visibility**: public
- **Source Range**: 578:89:88
- **Inherited From**: ERC20Burnable

## Implementation

```solidity
///  @dev Destroys `amount` tokens from the caller.
///  See {ERC20-_burn}.
function burn(uint256 amount) virtual public {
    _burn(_msgSender(), amount);
}
```

## Related Implementations

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

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:104
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
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

- **_balances** (`mapping(address => uint256)`)
- **_paused** (`bool`)

## State Variable Writes

- **_balances** (`mapping(address => uint256)`)
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Burnable.burn(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 1)
      💬 Args: [_msgSender(), amount]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 7)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC20PresetMinterPauser._beforeTokenTransfer(address,address,uint256) (NodeID: 2)
    │   💬 Args: [account, address(0), amount]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ERC20Pausable._beforeTokenTransfer(address,address,uint256) (NodeID: 3)
    │     💬 Args: [from, to, amount]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ERC20._beforeTokenTransfer(address,address,uint256) (NodeID: 4)
    │   │   💬 Args: [from, to, amount]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Pausable.paused() (NodeID: 5)
    │       💬 Args: [no args]
    │       👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC20._afterTokenTransfer(address,address,uint256) (NodeID: 6)
        💬 Args: [account, address(0), amount]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev Destroys `amount` tokens from the caller.
 See {ERC20-_burn}.
