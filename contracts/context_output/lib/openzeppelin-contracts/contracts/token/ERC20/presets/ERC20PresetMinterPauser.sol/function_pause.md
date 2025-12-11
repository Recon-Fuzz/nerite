# Function: pause()

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol/contract_ERC20PresetMinterPauser.md]

## Metadata

- **Contract**: ERC20PresetMinterPauser
- **Signature**: `pause()`
- **Visibility**: public
- **Source Range**: 2248:169:94

## Implementation

```solidity
///  @dev Pauses all token transfers.
///  See {ERC20Pausable} and {Pausable-_pause}.
///  Requirements:
///  - the caller must have the `PAUSER_ROLE`.
function pause() virtual public {
    require(hasRole(PAUSER_ROLE, _msgSender()), "ERC20PresetMinterPauser: must have pauser role to pause");
    _pause();
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

### _pause()

- **Kind**: internal
- **Source**: 2186:115:85
- **Link**: `lib/openzeppelin-contracts/contracts/security/Pausable.sol:Pausable:_pause()`

```solidity
///  @dev Triggers stopped state.
///  Requirements:
///  - The contract must not be paused.
function _pause() virtual internal whenNotPaused() {
    _paused = true;
    emit Paused(_msgSender());
}
```

### whenNotPaused()

- **Kind**: modifier
- **Source**: 1204:72:85
- **Link**: `lib/openzeppelin-contracts/contracts/security/Pausable.sol:Pausable:whenNotPaused()`

```solidity
///  @dev Modifier to make a function callable only when the contract is not paused.
///  Requirements:
///  - The contract must not be paused.
modifier whenNotPaused() {
    _requireNotPaused();
    _;
}
```

### _requireNotPaused()

- **Kind**: internal
- **Source**: 1767:106:85
- **Link**: `lib/openzeppelin-contracts/contracts/security/Pausable.sol:Pausable:_requireNotPaused()`

```solidity
///  @dev Throws if the contract is paused.
function _requireNotPaused() virtual internal view {
    require(!paused(), "Pausable: paused");
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
┌─ [0] ⚙️ FUNCTION: ERC20PresetMinterPauser.pause() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 1)
  │   💬 Args: [PAUSER_ROLE, _msgSender()]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Pausable._pause() (NodeID: 3)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 4)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Pausable.whenNotPaused() (NodeID: 5)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: Pausable._requireNotPaused() (NodeID: 6)
          💬 Args: [no args]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Pausable.paused() (NodeID: 7)
            💬 Args: [no args]
            👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Pauses all token transfers.
 See {ERC20Pausable} and {Pausable-_pause}.
 Requirements:
 - the caller must have the `PAUSER_ROLE`.
