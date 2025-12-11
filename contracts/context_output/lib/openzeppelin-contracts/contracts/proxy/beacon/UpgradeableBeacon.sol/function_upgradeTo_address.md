# Function: upgradeTo(address)

**Contract**: [lib/openzeppelin-contracts/contracts/proxy/beacon/UpgradeableBeacon.sol/contract_UpgradeableBeacon.md]

## Metadata

- **Contract**: UpgradeableBeacon
- **Signature**: `upgradeTo(address)`
- **Visibility**: public
- **Source Range**: 1469:167:83

## Implementation

```solidity
///  @dev Upgrades the beacon to a new implementation.
///  Emits an {Upgraded} event.
///  Requirements:
///  - msg.sender must be the owner of the contract.
///  - `newImplementation` must be a contract.
function upgradeTo(address newImplementation) virtual public onlyOwner() {
    _setImplementation(newImplementation);
    emit Upgraded(newImplementation);
}
```

## Related Implementations

### _setImplementation(address)

- **Kind**: internal
- **Source**: 1811:226:83
- **Link**: `lib/openzeppelin-contracts/contracts/proxy/beacon/UpgradeableBeacon.sol:UpgradeableBeacon:_setImplementation(address)`

```solidity
///  @dev Sets the implementation contract address for this beacon
///  Requirements:
///  - `newImplementation` must be a contract.
function _setImplementation(address newImplementation) private {
    require(Address.isContract(newImplementation), "UpgradeableBeacon: implementation is not a contract");
    _implementation = newImplementation;
}
```

### isContract(address)

- **Kind**: internal
- **Source**: 1412:320:103
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Address.sol:Address:isContract(address)`

```solidity
///  @dev Returns true if `account` is a contract.
///  [IMPORTANT]
///  ====
///  It is unsafe to assume that an address for which this function returns
///  false is an externally-owned account (EOA) and not a contract.
///  Among others, `isContract` will return false for the following
///  types of addresses:
///   - an externally-owned account
///   - a contract in construction
///   - an address where a contract will be created
///   - an address where a contract lived, but was destroyed
///  Furthermore, `isContract` will also return true if the target contract within
///  the same transaction is already scheduled for destruction by `SELFDESTRUCT`,
///  which only has an effect at the end of a transaction.
///  ====
///  [IMPORTANT]
///  ====
///  You shouldn't rely on `isContract` to protect against flash loan attacks!
///  Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
///  like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
///  constructor.
///  ====
function isContract(address account) internal view returns (bool) {
    return account.code.length > 0;
}
```

### onlyOwner()

- **Kind**: modifier
- **Source**: 1063:62:71
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:onlyOwner()`

```solidity
///  @dev Throws if called by any account other than the owner.
modifier onlyOwner() {
    _checkOwner();
    _;
}
```

### _checkOwner()

- **Kind**: internal
- **Source**: 1359:130:71
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:_checkOwner()`

```solidity
///  @dev Throws if the sender is not the owner.
function _checkOwner() virtual internal view {
    require(owner() == _msgSender(), "Ownable: caller is not the owner");
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

### owner()

- **Kind**: internal
- **Source**: 1201:85:71
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:owner()`

```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address) {
    return _owner;
}
```

## State Variable Reads

- **_owner** (`address`)

## State Variable Writes

- **_implementation** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpgradeableBeacon.upgradeTo(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: UpgradeableBeacon._setImplementation(address) (NodeID: 1)
  │   💬 Args: [newImplementation]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: Address.isContract(address) (NodeID: 2)
  │     💬 Args: [newImplementation]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Ownable.onlyOwner() (NodeID: 3)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Ownable._checkOwner() (NodeID: 4)
        💬 Args: [no args]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 5)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Ownable.owner() (NodeID: 6)
          💬 Args: [no args]
          👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Upgrades the beacon to a new implementation.
 Emits an {Upgraded} event.
 Requirements:
 - msg.sender must be the owner of the contract.
 - `newImplementation` must be a contract.
