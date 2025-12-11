# Function: constructor(address,bytes)

**Contract**: [lib/openzeppelin-contracts/contracts/proxy/beacon/BeaconProxy.sol/contract_BeaconProxy.md]

## Metadata

- **Contract**: BeaconProxy
- **Signature**: `constructor(address,bytes)`
- **Visibility**: public
- **Source Range**: 1060:116:81

## Implementation

```solidity
///  @dev Initializes the proxy with `beacon`.
///  If `data` is nonempty, it's used as data in a delegate call to the implementation returned by the beacon. This
///  will typically be an encoded function call, and allows initializing the storage of the proxy like a Solidity
///  constructor.
///  Requirements:
///  - `beacon` must be a contract with the interface {IBeacon}.
constructor(address beacon, bytes memory data) payable {
    _upgradeBeaconToAndCall(beacon, data, false);
}
```

## Related Implementations

### _upgradeBeaconToAndCall(address,bytes,bool)

- **Kind**: internal
- **Source**: 5728:313:79
- **Link**: `lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Upgrade.sol:ERC1967Upgrade:_upgradeBeaconToAndCall(address,bytes,bool)`

```solidity
///  @dev Perform beacon upgrade with additional setup call. Note: This upgrades the address of the beacon, it does
///  not upgrade the implementation contained in the beacon (see {UpgradeableBeacon-_setImplementation} for that).
///  Emits a {BeaconUpgraded} event.
function _upgradeBeaconToAndCall(address newBeacon, bytes memory data, bool forceCall) internal {
    _setBeacon(newBeacon);
    emit BeaconUpgraded(newBeacon);
    if ((data.length > 0) || forceCall) {
        Address.functionDelegateCall(IBeacon(newBeacon).implementation(), data);
    }
}
```

### _setBeacon(address)

- **Kind**: internal
- **Source**: 5054:371:79
- **Link**: `lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Upgrade.sol:ERC1967Upgrade:_setBeacon(address)`

```solidity
///  @dev Stores a new beacon in the EIP1967 beacon slot.
function _setBeacon(address newBeacon) private {
    require(Address.isContract(newBeacon), "ERC1967: new beacon is not a contract");
    require(Address.isContract(IBeacon(newBeacon).implementation()), "ERC1967: beacon implementation is not a contract");
    StorageSlot.getAddressSlot(_BEACON_SLOT).value = newBeacon;
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

### getAddressSlot(bytes32)

- **Kind**: internal
- **Source**: 1859:190:107
- **Link**: `lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol:StorageSlot:getAddressSlot(bytes32)`

```solidity
///  @dev Returns an `AddressSlot` with member `value` located at `slot`.
function getAddressSlot(bytes32 slot) internal pure returns (AddressSlot storage r) {
    /// @solidity memory-safe-assembly
    assembly {
        r.slot := slot
    }
}
```

### functionDelegateCall(address,bytes)

- **Kind**: internal
- **Source**: 6674:198:103
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Address.sol:Address:functionDelegateCall(address,bytes)`

```solidity
///  @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
///  but performing a delegate call.
///  _Available since v3.4._
function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
    return functionDelegateCall(target, data, "Address: low-level delegate call failed");
}
```

### functionDelegateCall(address,bytes,string)

- **Kind**: internal
- **Source**: 7058:325:103
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Address.sol:Address:functionDelegateCall(address,bytes,string)`

```solidity
///  @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
///  but performing a delegate call.
///  _Available since v3.4._
function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
    (bool success, bytes memory returndata) = target.delegatecall(data);
    return verifyCallResultFromTarget(target, success, returndata, errorMessage);
}
```

### verifyCallResultFromTarget(address,bool,bytes,string)

- **Kind**: internal
- **Source**: 7671:628:103
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Address.sol:Address:verifyCallResultFromTarget(address,bool,bytes,string)`

```solidity
///  @dev Tool to verify that a low level call to smart-contract was successful, and revert (either by bubbling
///  the revert reason or using the provided one) in case of unsuccessful call or if target was not a contract.
///  _Available since v4.8._
function verifyCallResultFromTarget(address target, bool success, bytes memory returndata, string memory errorMessage) internal view returns (bytes memory) {
    if (success) {
        if (returndata.length == 0) {
            require(isContract(target), "Address: call to non-contract");
        }
        return returndata;
    } else {
        _revert(returndata, errorMessage);
    }
}
```

### _revert(bytes,string)

- **Kind**: internal
- **Source**: 8821:540:103
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Address.sol:Address:_revert(bytes,string)`

```solidity
function _revert(bytes memory returndata, string memory errorMessage) private pure {
    if (returndata.length > 0) {
        /// @solidity memory-safe-assembly
        assembly {
            let returndata_size := mload(returndata)
            revert(add(32, returndata), returndata_size)
        }
    } else {
        revert(errorMessage);
    }
}
```

## External Calls

- **IBeacon::implementation()**
- **address::delegatecall(bytes memory)**

## State Variable Writes

- **_BEACON_SLOT** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: BeaconProxy.constructor(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: BeaconProxy
  └─ [1] ⚙️ FUNCTION: ERC1967Upgrade._upgradeBeaconToAndCall(address,bytes,bool) (NodeID: 1)
      💬 Args: [beacon, data, false]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC1967Upgrade._setBeacon(address) (NodeID: 2)
    │   💬 Args: [newBeacon]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: Address.isContract(address) (NodeID: 3)
    │ │   💬 Args: [newBeacon]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Address.isContract(address) (NodeID: 4)
    │ │   💬 Args: [IBeacon(newBeacon).implementation()]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: StorageSlot.getAddressSlot(bytes32) (NodeID: 5)
    │     💬 Args: [_BEACON_SLOT]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Address.functionDelegateCall(address,bytes) (NodeID: 6)
        💬 Args: [IBeacon(newBeacon).implementation(), data]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Address.functionDelegateCall(address,bytes,string) (NodeID: 7)
          💬 Args: [target, data, "Address: low-level delegate call failed"]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Address.verifyCallResultFromTarget(address,bool,bytes,string) (NodeID: 8)
            💬 Args: [target, success, returndata, errorMessage]
            👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: Address.isContract(address) (NodeID: 9)
          │   💬 Args: [target]
          │   👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: Address._revert(bytes,string) (NodeID: 10)
              💬 Args: [returndata, errorMessage]
              👁️  Def: private
```

## Documentation

### Function Documentation

 @dev Initializes the proxy with `beacon`.
 If `data` is nonempty, it's used as data in a delegate call to the implementation returned by the beacon. This
 will typically be an encoded function call, and allows initializing the storage of the proxy like a Solidity
 constructor.
 Requirements:
 - `beacon` must be a contract with the interface {IBeacon}.
