# Function: setRemoveManagerWithReceiver(uint256,address,address)

**Contract**: [src/Zappers/GasCompZapper.sol/contract_GasCompZapper.md]

## Metadata

- **Contract**: GasCompZapper
- **Signature**: `setRemoveManagerWithReceiver(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 2618:220:58
- **Inherited From**: AddRemoveManagers

## Implementation

```solidity
function setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) public {
    _requireCallerIsBorrower(_troveId);
    _setRemoveManagerAndReceiver(_troveId, _manager, _receiver);
}
```

## Related Implementations

### _requireCallerIsBorrower(uint256)

- **Kind**: internal
- **Source**: 3740:173:58
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
- **Source**: 2844:377:58
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
- **Source**: 3522:212:58
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
┌─ [0] ⚙️ FUNCTION: AddRemoveManagers.setRemoveManagerWithReceiver(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 1)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._setRemoveManagerAndReceiver(uint256,address,address) (NodeID: 2)
      💬 Args: [_troveId, _manager, _receiver]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AddRemoveManagers._requireNonZeroManagerUnlessWiping(address,address) (NodeID: 3)
        💬 Args: [_manager, _receiver]
        👁️  Def: internal
```
