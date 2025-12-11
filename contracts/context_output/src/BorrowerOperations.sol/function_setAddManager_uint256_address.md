# Function: setAddManager(uint256,address)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `setAddManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2102:163:209
- **Inherited From**: AddRemoveManagers

## Implementation

```solidity
function setAddManager(uint256 _troveId, address _manager) external {
    _requireCallerIsBorrower(_troveId);
    _setAddManager(_troveId, _manager);
}
```

## Related Implementations

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

### _setAddManager(uint256,address)

- **Kind**: internal
- **Source**: 2271:171:209
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_setAddManager(uint256,address)`

```solidity
function _setAddManager(uint256 _troveId, address _manager) internal {
    addManagerOf[_troveId] = _manager;
    emit AddManagerUpdated(_troveId, _manager);
}
```

## External Calls

- **ITroveNFT::ownerOf(uint256)**

## State Variable Reads

- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## State Variable Writes

- **addManagerOf** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AddRemoveManagers.setAddManager(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 1)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._setAddManager(uint256,address) (NodeID: 2)
      💬 Args: [_troveId, _manager]
      👁️  Def: internal
```
