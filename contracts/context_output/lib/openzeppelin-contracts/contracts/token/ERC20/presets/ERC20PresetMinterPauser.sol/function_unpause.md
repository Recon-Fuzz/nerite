# Function: unpause()

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol/contract_ERC20PresetMinterPauser.md]

## Metadata

- **Contract**: ERC20PresetMinterPauser
- **Signature**: `unpause()`
- **Visibility**: public
- **Source Range**: 2624:175:94

## Implementation

```solidity
///  @dev Unpauses all token transfers.
///  See {ERC20Pausable} and {Pausable-_unpause}.
///  Requirements:
///  - the caller must have the `PAUSER_ROLE`.
function unpause() virtual public {
    require(hasRole(PAUSER_ROLE, _msgSender()), "ERC20PresetMinterPauser: must have pauser role to unpause");
    _unpause();
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

### _unpause()

- **Kind**: internal
- **Source**: 2433:117:85
- **Link**: `lib/openzeppelin-contracts/contracts/security/Pausable.sol:Pausable:_unpause()`

```solidity
///  @dev Returns to normal state.
///  Requirements:
///  - The contract must be paused.
function _unpause() virtual internal whenPaused() {
    _paused = false;
    emit Unpaused(_msgSender());
}
```

### whenPaused()

- **Kind**: modifier
- **Source**: 1454:66:85
- **Link**: `lib/openzeppelin-contracts/contracts/security/Pausable.sol:Pausable:whenPaused()`

```solidity
///  @dev Modifier to make a function callable only when the contract is paused.
///  Requirements:
///  - The contract must be paused.
modifier whenPaused() {
    _requirePaused();
    _;
}
```

### _requirePaused()

- **Kind**: internal
- **Source**: 1945:106:85
- **Link**: `lib/openzeppelin-contracts/contracts/security/Pausable.sol:Pausable:_requirePaused()`

```solidity
///  @dev Throws if the contract is not paused.
function _requirePaused() virtual internal view {
    require(paused(), "Pausable: not paused");
}
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

## State Variable Reads

- **PAUSER_ROLE** (`bytes32`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)
- **_paused** (`bool`)

## State Variable Writes

- **_paused** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20PresetMinterPauser.unpause() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 1)
  │   💬 Args: [PAUSER_ROLE, _msgSender()]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Pausable._unpause() (NodeID: 3)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 4)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Pausable.whenPaused() (NodeID: 5)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: Pausable._requirePaused() (NodeID: 6)
          💬 Args: [no args]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Pausable.paused() (NodeID: 7)
            💬 Args: [no args]
            👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Unpauses all token transfers.
 See {ERC20Pausable} and {Pausable-_unpause}.
 Requirements:
 - the caller must have the `PAUSER_ROLE`.
