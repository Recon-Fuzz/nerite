# Contract: AddRemoveManagers

## Metadata

- **Name**: AddRemoveManagers
- **Type**: Contract
- **Path**: src/Dependencies/AddRemoveManagers.sol

## Implements Interfaces

- **IAddRemoveManagers** [src/Interfaces/IAddRemoveManagers.sol/interface_IAddRemoveManagers.md]

## State Variables

### troveNFT

```solidity
ITroveNFT internal immutable troveNFT
```

**ITroveNFT**: [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

### addManagerOf

```solidity
mapping(uint256 => address) public addManagerOf
```

### removeManagerReceiverOf

```solidity
mapping(uint256 => RemoveManagerReceiver) public removeManagerReceiverOf
```

## Structs

### RemoveManagerReceiver

```solidity
struct RemoveManagerReceiver {
    address manager;
    address receiver;
}
```

## Errors

### EmptyManager

```solidity
error EmptyManager();
```

### NotBorrower

```solidity
error NotBorrower();
```

### NotOwnerNorAddManager

```solidity
error NotOwnerNorAddManager();
```

### NotOwnerNorRemoveManager

```solidity
error NotOwnerNorRemoveManager();
```

## Events

### TroveNFTAddressChanged

```solidity
event TroveNFTAddressChanged(address _newTroveNFTAddress);
```

### AddManagerUpdated

```solidity
event AddManagerUpdated(uint256 indexed _troveId, address _newAddManager);
```

### RemoveManagerAndReceiverUpdated

```solidity
event RemoveManagerAndReceiverUpdated(uint256 indexed _troveId, address _newRemoveManager, address _newReceiver);
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 1932:164:58
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry);
```

### setAddManager(uint256,address)

- **Signature**: `setAddManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2102:163:58
- **Details**: [function_setAddManager_uint256_address.md](./function_setAddManager_uint256_address.md)

**Signature:**
```solidity
function setAddManager(uint256 _troveId, address _manager) external;
```

### setRemoveManager(uint256,address)

- **Signature**: `setRemoveManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2448:164:58
- **Details**: [function_setRemoveManager_uint256_address.md](./function_setRemoveManager_uint256_address.md)

**Signature:**
```solidity
function setRemoveManager(uint256 _troveId, address _manager) external;
```

### setRemoveManagerWithReceiver(uint256,address,address)

- **Signature**: `setRemoveManagerWithReceiver(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 2618:220:58
- **Details**: [function_setRemoveManagerWithReceiver_uint256_address_address.md](./function_setRemoveManagerWithReceiver_uint256_address_address.md)

**Signature:**
```solidity
function setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) public;
```
