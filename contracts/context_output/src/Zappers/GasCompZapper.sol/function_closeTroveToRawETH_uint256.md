# Function: closeTroveToRawETH(uint256)

**Contract**: [src/Zappers/GasCompZapper.sol/contract_GasCompZapper.md]

## Metadata

- **Contract**: GasCompZapper
- **Signature**: `closeTroveToRawETH(uint256)`
- **Visibility**: external
- **Source Range**: 8475:765:132

## Implementation

```solidity
function closeTroveToRawETH(uint256 _troveId) external {
    address owner = troveNFT.ownerOf(_troveId);
    address payable receiver = payable(_requireSenderIsOwnerOrRemoveManagerAndGetReceiver(_troveId, owner));
    LatestTroveData memory trove = troveManager.getLatestTroveData(_troveId);
    boldToken.transferFrom(msg.sender, address(this), trove.entireDebt);
    borrowerOperations.closeTrove(_troveId);
    collToken.safeTransfer(receiver, trove.entireColl);
    WETH.withdraw(ETH_GAS_COMPENSATION);
    (bool success, ) = receiver.call{value: ETH_GAS_COMPENSATION}("");
    require(success, "GCZ: Sending ETH failed");
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
- **ITroveManager::getLatestTroveData(uint256)**
- **IBoldToken::transferFrom(address,address,uint256)**
- **IBorrowerOperations::closeTrove(uint256)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **IWETH::withdraw(uint256)**
- **unknown::unknown**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasCompZapper.closeTroveToRawETH(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 1)
      💬 Args: [_troveId, owner]
      👁️  Def: internal
```
