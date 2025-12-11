# Function: addColl(uint256,uint256)

**Contract**: [src/Zappers/GasCompZapper.sol/contract_GasCompZapper.md]

## Metadata

- **Contract**: GasCompZapper
- **Signature**: `addColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3782:412:283

## Implementation

```solidity
function addColl(uint256 _troveId, uint256 _amount) external {
    address owner = troveNFT.ownerOf(_troveId);
    _requireSenderIsOwnerOrAddManager(_troveId, owner);
    IBorrowerOperations borrowerOperationsCached = borrowerOperations;
    collToken.safeTransferFrom(msg.sender, address(this), _amount);
    borrowerOperationsCached.addColl(_troveId, _amount);
}
```

## Related Implementations

### _requireSenderIsOwnerOrAddManager(uint256,address)

- **Kind**: internal
- **Source**: 3919:297:209
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireSenderIsOwnerOrAddManager(uint256,address)`

```solidity
function _requireSenderIsOwnerOrAddManager(uint256 _troveId, address _owner) internal view {
    address addManager = addManagerOf[_troveId];
    if (((msg.sender != _owner) && (addManager != address(0))) && (msg.sender != addManager)) {
        revert NotOwnerNorAddManager();
    }
}
```

## External Calls

- **ITroveNFT::ownerOf(uint256)**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **IBorrowerOperations::addColl(uint256,uint256)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **addManagerOf** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasCompZapper.addColl(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrAddManager(uint256,address) (NodeID: 1)
      💬 Args: [_troveId, owner]
      👁️  Def: internal
```
