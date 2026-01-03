# Function: withdrawColl(uint256,uint256)

**Contract**: [src/Zappers/GasCompZapper.sol/contract_GasCompZapper.md]

## Metadata

- **Contract**: GasCompZapper
- **Signature**: `withdrawColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4200:360:132

## Implementation

```solidity
function withdrawColl(uint256 _troveId, uint256 _amount) external {
    address owner = troveNFT.ownerOf(_troveId);
    address receiver = _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(_troveId, owner);
    borrowerOperations.withdrawColl(_troveId, _amount);
    collToken.safeTransfer(receiver, _amount);
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
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasCompZapper.withdrawColl(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 1)
      💬 Args: [_troveId, owner]
      👁️  Def: internal
```
