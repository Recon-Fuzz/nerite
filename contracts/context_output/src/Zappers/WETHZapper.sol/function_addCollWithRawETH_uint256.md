# Function: addCollWithRawETH(uint256)

**Contract**: [src/Zappers/WETHZapper.sol/contract_WETHZapper.md]

## Metadata

- **Contract**: WETHZapper
- **Signature**: `addCollWithRawETH(uint256)`
- **Visibility**: external
- **Source Range**: 3399:312:160

## Implementation

```solidity
function addCollWithRawETH(uint256 _troveId) external payable {
    address owner = troveNFT.ownerOf(_troveId);
    _requireSenderIsOwnerOrAddManager(_troveId, owner);
    WETH.deposit{value: msg.value}();
    borrowerOperations.addColl(_troveId, msg.value);
}
```

## Related Implementations

### _requireSenderIsOwnerOrAddManager(uint256,address)

- **Kind**: internal
- **Source**: 3919:297:58
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
- **unknown::unknown**
- **IBorrowerOperations::addColl(uint256,uint256)**

## State Variable Reads

- **addManagerOf** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: WETHZapper.addCollWithRawETH(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrAddManager(uint256,address) (NodeID: 1)
      💬 Args: [_troveId, owner]
      👁️  Def: internal
```
