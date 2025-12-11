# Contract: SuperfluidUpgradeableBeacon

## Metadata

- **Name**: SuperfluidUpgradeableBeacon
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/SuperfluidUpgradeableBeacon.sol

## Implements Interfaces

- **IBeacon** [lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol/interface_IBeacon.md]

## State Variables

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### _implementation (inherited from UpgradeableBeacon)

```solidity
address private _implementation
```

## Errors

### ZERO_ADDRESS_IMPLEMENTATION

```solidity
error ZERO_ADDRESS_IMPLEMENTATION();
```

### INCOMPATIBLE_LOGIC

```solidity
error INCOMPATIBLE_LOGIC();
```

### NO_PROXY_LOOP

```solidity
error NO_PROXY_LOOP();
```

## Events

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

### Upgraded (inherited from UpgradeableBeacon)

```solidity
///  @dev Emitted when the implementation returned by the beacon is changed.
event Upgraded(address indexed implementation);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 458:74:168
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address implementation_) UpgradeableBeacon(implementation_);
```

### upgradeTo(address)

- **Signature**: `upgradeTo(address)`
- **Visibility**: public
- **Source Range**: 538:499:168
- **Details**: [function_upgradeTo_address.md](./function_upgradeTo_address.md)

**Signature:**
```solidity
function upgradeTo(address newImplementation) override public onlyOwner();
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

### implementation() (inherited from UpgradeableBeacon)

- **Signature**: `implementation()`
- **Visibility**: public
- **Source Range**: 1098:112:83
- **Details**: [function_implementation.md](./function_implementation.md)

**Signature:**
```solidity
///  @dev Returns the current implementation address.
function implementation() virtual override public view returns (address);
```
