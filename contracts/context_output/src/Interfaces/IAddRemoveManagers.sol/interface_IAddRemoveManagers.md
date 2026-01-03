# Interface: IAddRemoveManagers

## Metadata

- **Name**: IAddRemoveManagers
- **Type**: Interface
- **Path**: src/Interfaces/IAddRemoveManagers.sol

## Public/External Functions

### setAddManager(uint256,address)

- **Signature**: `setAddManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 93:68:69

**Signature:**
```solidity
function setAddManager(uint256 _troveId, address _manager) external;;
```

### setRemoveManager(uint256,address)

- **Signature**: `setRemoveManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 166:71:69

**Signature:**
```solidity
function setRemoveManager(uint256 _troveId, address _manager) external;;
```

### setRemoveManagerWithReceiver(uint256,address,address)

- **Signature**: `setRemoveManagerWithReceiver(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 242:102:69

**Signature:**
```solidity
function setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) external;;
```

### addManagerOf(uint256)

- **Signature**: `addManagerOf(uint256)`
- **Visibility**: external
- **Source Range**: 349:72:69

**Signature:**
```solidity
function addManagerOf(uint256 _troveId) external view returns (address);;
```

### removeManagerReceiverOf(uint256)

- **Signature**: `removeManagerReceiverOf(uint256)`
- **Visibility**: external
- **Source Range**: 426:92:69

**Signature:**
```solidity
function removeManagerReceiverOf(uint256 _troveId) external view returns (address, address);;
```
