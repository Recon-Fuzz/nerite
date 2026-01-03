# Function: withdrawCollToRawETH(uint256,uint256)

**Contract**: [src/Zappers/LeverageWETHZapper.sol/contract_LeverageWETHZapper.md]

## Metadata

- **Contract**: LeverageWETHZapper
- **Signature**: `withdrawCollToRawETH(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3717:484:160
- **Inherited From**: WETHZapper

## Implementation

```solidity
function withdrawCollToRawETH(uint256 _troveId, uint256 _amount) external {
    address owner = troveNFT.ownerOf(_troveId);
    address payable receiver = payable(_requireSenderIsOwnerOrRemoveManagerAndGetReceiver(_troveId, owner));
    borrowerOperations.withdrawColl(_troveId, _amount);
    WETH.withdraw(_amount);
    (bool success, ) = receiver.call{value: _amount}("");
    require(success, "WZ: Sending ETH failed");
}
```

## Related Implementations

### _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)

- **Kind**: internal
- **Source**: 4222:544:58
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)`

```solidity
function _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256 _troveId, address _owner) internal view returns (address) {
    address manager = removeManagerReceiverOf[_troveId].manager;
    address receiver = removeManagerReceiverOf[_troveId].receiver;
    if ((msg.sender != _owner) && (msg.sender != manager)) {
        revert NotOwnerNorRemoveManager();
    }
    if ((receiver == address(0)) || (msg.sender != manager)) {
        return _owner;
    }
    return receiver;
}
```

## External Calls

- **ITroveNFT::ownerOf(uint256)**
- **IBorrowerOperations::withdrawColl(uint256,uint256)**
- **IWETH::withdraw(uint256)**
- **unknown::unknown**

## State Variable Reads

- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: WETHZapper.withdrawCollToRawETH(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 1)
      💬 Args: [_troveId, owner]
      👁️  Def: internal
```
