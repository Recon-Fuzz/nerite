# Contract: UpgradeableBeacon

## Metadata

- **Name**: UpgradeableBeacon
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts/contracts/proxy/beacon/UpgradeableBeacon.sol
- **Documentation**:  @dev This contract is used in conjunction with one or more instances of {BeaconProxy} to determine their
   implementation contract, which is where they will delegate all function calls.
   An owner is able to change the implementation the beacon points to, thus upgrading the proxies that use this beacon.

## Implements Interfaces

- **IBeacon** [lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol/interface_IBeacon.md]

## State Variables

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### _implementation

```solidity
address private _implementation
```

## Events

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

### Upgraded

```solidity
///  @dev Emitted when the implementation returned by the beacon is changed.
event Upgraded(address indexed implementation);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 931:89:83
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
///  @dev Sets the address of the initial implementation, and the deployer account as the owner who can upgrade the
///  beacon.
constructor(address implementation_);
```

### implementation()

- **Signature**: `implementation()`
- **Visibility**: public
- **Source Range**: 1098:112:83
- **Details**: [function_implementation.md](./function_implementation.md)

**Signature:**
```solidity
///  @dev Returns the current implementation address.
function implementation() virtual override public view returns (address);
```

### upgradeTo(address)

- **Signature**: `upgradeTo(address)`
- **Visibility**: public
- **Source Range**: 1469:167:83
- **Details**: [function_upgradeTo_address.md](./function_upgradeTo_address.md)

**Signature:**
```solidity
///  @dev Upgrades the beacon to a new implementation.
///  Emits an {Upgraded} event.
///  Requirements:
///  - msg.sender must be the owner of the contract.
///  - `newImplementation` must be a contract.
function upgradeTo(address newImplementation) virtual public onlyOwner();
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1201:85:71
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address);
```

### renounceOwnership() (inherited from Ownable)

- **Signature**: `renounceOwnership()`
- **Visibility**: public
- **Source Range**: 1824:101:71
- **Details**: [function_renounceOwnership.md](./function_renounceOwnership.md)

**Signature:**
```solidity
///  @dev Leaves the contract without owner. It will not be possible to call
///  `onlyOwner` functions. Can only be called by the current owner.
///  NOTE: Renouncing ownership will leave the contract without an owner,
///  thereby disabling any functionality that is only available to the owner.
function renounceOwnership() virtual public onlyOwner();
```

### transferOwnership(address) (inherited from Ownable)

- **Signature**: `transferOwnership(address)`
- **Visibility**: public
- **Source Range**: 2074:198:71
- **Details**: [function_transferOwnership_address.md](./function_transferOwnership_address.md)

**Signature:**
```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`).
///  Can only be called by the current owner.
function transferOwnership(address newOwner) virtual public onlyOwner();
```
