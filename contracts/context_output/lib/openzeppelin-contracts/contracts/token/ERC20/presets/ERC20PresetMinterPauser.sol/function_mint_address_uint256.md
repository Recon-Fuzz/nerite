# Function: mint(address,uint256)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol/contract_ERC20PresetMinterPauser.md]

## Metadata

- **Contract**: ERC20PresetMinterPauser
- **Signature**: `mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 1843:202:94

## Implementation

```solidity
///  @dev Creates `amount` new tokens for `to`.
///  See {ERC20-_mint}.
///  Requirements:
///  - the caller must have the `MINTER_ROLE`.
function mint(address to, uint256 amount) virtual public {
    require(hasRole(MINTER_ROLE, _msgSender()), "ERC20PresetMinterPauser: must have minter role to mint");
    _mint(to, amount);
}
```

## Related Implementations

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

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 8520:535:86
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_mint(address,uint256)`

```solidity
/// @dev Creates `amount` tokens and assigns them to `account`, increasing
///  the total supply.
///  Emits a {Transfer} event with `from` set to the zero address.
///  Requirements:
///  - `account` cannot be the zero address.
function _mint(address account, uint256 amount) virtual internal {
    require(account != address(0), "ERC20: mint to the zero address");
    _beforeTokenTransfer(address(0), account, amount);
    _totalSupply += amount;
    unchecked {
        _balances[account] += amount;
    }
    emit Transfer(address(0), account, amount);
    _afterTokenTransfer(address(0), account, amount);
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

- **MINTER_ROLE** (`bytes32`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)
- **_paused** (`bool`)

## State Variable Writes

- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20PresetMinterPauser.mint(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 1)
  │   💬 Args: [MINTER_ROLE, _msgSender()]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 3)
      💬 Args: [to, amount]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC20PresetMinterPauser._beforeTokenTransfer(address,address,uint256) (NodeID: 4)
    │   💬 Args: [address(0), account, amount]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ERC20Pausable._beforeTokenTransfer(address,address,uint256) (NodeID: 5)
    │     💬 Args: [from, to, amount]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ERC20._beforeTokenTransfer(address,address,uint256) (NodeID: 6)
    │   │   💬 Args: [from, to, amount]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Pausable.paused() (NodeID: 7)
    │       💬 Args: [no args]
    │       👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC20._afterTokenTransfer(address,address,uint256) (NodeID: 8)
        💬 Args: [address(0), account, amount]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev Creates `amount` new tokens for `to`.
 See {ERC20-_mint}.
 Requirements:
 - the caller must have the `MINTER_ROLE`.
