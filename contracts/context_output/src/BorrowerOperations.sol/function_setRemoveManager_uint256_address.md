# Function: setRemoveManager(uint256,address)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `setRemoveManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2448:164:209
- **Inherited From**: AddRemoveManagers

## Implementation

```solidity
function setRemoveManager(uint256 _troveId, address _manager) external {
    setRemoveManagerWithReceiver(_troveId, _manager, troveNFT.ownerOf(_troveId));
}
```

## Related Implementations

### setRemoveManagerWithReceiver(uint256,address,address)

- **Kind**: internal
- **Source**: 2618:220:209
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:setRemoveManagerWithReceiver(uint256,address,address)`

```solidity
function setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) public {
    _requireCallerIsBorrower(_troveId);
    _setRemoveManagerAndReceiver(_troveId, _manager, _receiver);
}
```

### _requireCallerIsBorrower(uint256)

- **Kind**: internal
- **Source**: 3740:173:209
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireCallerIsBorrower(uint256)`

```solidity
function _requireCallerIsBorrower(uint256 _troveId) internal view {
    if (msg.sender != troveNFT.ownerOf(_troveId)) {
        revert NotBorrower();
    }
}
```

### _setRemoveManagerAndReceiver(uint256,address,address)

- **Kind**: internal
- **Source**: 2844:377:209
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_setRemoveManagerAndReceiver(uint256,address,address)`

```solidity
function _setRemoveManagerAndReceiver(uint256 _troveId, address _manager, address _receiver) internal {
    _requireNonZeroManagerUnlessWiping(_manager, _receiver);
    removeManagerReceiverOf[_troveId].manager = _manager;
    removeManagerReceiverOf[_troveId].receiver = _receiver;
    emit RemoveManagerAndReceiverUpdated(_troveId, _manager, _receiver);
}
```

### _requireNonZeroManagerUnlessWiping(address,address)

- **Kind**: internal
- **Source**: 3522:212:209
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireNonZeroManagerUnlessWiping(address,address)`

```solidity
function _requireNonZeroManagerUnlessWiping(address _manager, address _receiver) internal pure {
    if ((_manager == address(0)) && (_receiver != address(0))) {
        revert EmptyManager();
    }
}
```

## External Calls

- **ITroveNFT::ownerOf(uint256)**

## State Variable Reads

- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## State Variable Writes

- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AddRemoveManagers.setRemoveManager(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers.setRemoveManagerWithReceiver(uint256,address,address) (NodeID: 1)
      💬 Args: [_troveId, _manager, troveNFT.ownerOf(_troveId)]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 2)
    │   💬 Args: [_troveId]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AddRemoveManagers._setRemoveManagerAndReceiver(uint256,address,address) (NodeID: 3)
        💬 Args: [_troveId, _manager, _receiver]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: AddRemoveManagers._requireNonZeroManagerUnlessWiping(address,address) (NodeID: 4)
          💬 Args: [_manager, _receiver]
          👁️  Def: internal
```
