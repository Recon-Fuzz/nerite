# Contract: BeaconProxy

## Metadata

- **Name**: BeaconProxy
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts/contracts/proxy/beacon/BeaconProxy.sol
- **Documentation**:  @dev This contract implements a proxy that gets the implementation address for each call from an {UpgradeableBeacon}.
   The beacon address is stored in storage slot `uint256(keccak256('eip1967.proxy.beacon')) - 1`, so that it doesn't
   conflict with the storage layout of the implementation behind the proxy.
   _Available since v3.4._

## Implements Interfaces

- **IERC1967** [lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol/interface_IERC1967.md]

## State Variables

### _ROLLBACK_SLOT (inherited from ERC1967Upgrade)

```solidity
bytes32 private constant _ROLLBACK_SLOT = 0x4910fdfa16fed3260ed0e7147f7cc6da11a60208b5b9406d12a635614ffd9143
```

### _IMPLEMENTATION_SLOT (inherited from ERC1967Upgrade)

```solidity
///  @dev Storage slot with the address of the current implementation.
///  This is the keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1, and is
///  validated in the constructor.
bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
```

### _ADMIN_SLOT (inherited from ERC1967Upgrade)

```solidity
///  @dev Storage slot with the admin of the contract.
///  This is the keccak-256 hash of "eip1967.proxy.admin" subtracted by 1, and is
///  validated in the constructor.
bytes32 internal constant _ADMIN_SLOT = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103
```

### _BEACON_SLOT (inherited from ERC1967Upgrade)

```solidity
///  @dev The storage slot of the UpgradeableBeacon contract which defines the implementation for this proxy.
///  This is bytes32(uint256(keccak256('eip1967.proxy.beacon')) - 1)) and is validated in the constructor.
bytes32 internal constant _BEACON_SLOT = 0xa3f0ad74e5423aebfd80d3ef4346578335a9a72aeaee59ff6cb3582b35133d50
```

## Events

### Upgraded (inherited from IERC1967)

```solidity
///  @dev Emitted when the implementation is upgraded.
event Upgraded(address indexed implementation);
```

### AdminChanged (inherited from IERC1967)

```solidity
///  @dev Emitted when the admin account has changed.
event AdminChanged(address previousAdmin, address newAdmin);
```

### BeaconUpgraded (inherited from IERC1967)

```solidity
///  @dev Emitted when the beacon is changed.
event BeaconUpgraded(address indexed beacon);
```

## Public/External Functions

### constructor(address,bytes)

- **Signature**: `constructor(address,bytes)`
- **Visibility**: public
- **Source Range**: 1060:116:81
- **Details**: [function_constructor_address_bytes.md](./function_constructor_address_bytes.md)

**Signature:**
```solidity
///  @dev Initializes the proxy with `beacon`.
///  If `data` is nonempty, it's used as data in a delegate call to the implementation returned by the beacon. This
///  will typically be an encoded function call, and allows initializing the storage of the proxy like a Solidity
///  constructor.
///  Requirements:
///  - `beacon` must be a contract with the interface {IBeacon}.
constructor(address beacon, bytes memory data) payable;
```

### fallback() (inherited from Proxy)

- **Signature**: `fallback()`
- **Visibility**: external
- **Source Range**: 2629:64:80
- **Details**: [function_fallback.md](./function_fallback.md)

**Signature:**
```solidity
///  @dev Fallback function that delegates calls to the address returned by `_implementation()`. Will run if no other
///  function in the contract matches the call data.
fallback() virtual external payable;
```

### receive() (inherited from Proxy)

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 2853:63:80
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
///  @dev Fallback function that delegates calls to the address returned by `_implementation()`. Will run if call data
///  is empty.
receive() virtual external payable;
```
