# Function: receiveFlashLoanOnOpenLeveragedTrove(struct ILeverageZapper.OpenLeveragedTroveParams,uint256)

**Contract**: [src/Zappers/LeverageWETHZapper.sol/contract_LeverageWETHZapper.md]

## Metadata

- **Contract**: LeverageWETHZapper
- **Signature**: `receiveFlashLoanOnOpenLeveragedTrove(struct ILeverageZapper.OpenLeveragedTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 1662:2903:141

## Implementation

```solidity
function receiveFlashLoanOnOpenLeveragedTrove(OpenLeveragedTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) override external {
    require(msg.sender == address(flashLoanProvider), "LZ: Caller not FlashLoan provider");
    uint256 totalCollAmount = _params.collAmount + _effectiveFlashLoanAmount;
    uint256 troveId;
    if (_params.batchManager == address(0)) {
        troveId = borrowerOperations.openTrove(_params.owner, _params.ownerIndex, totalCollAmount, _params.boldAmount, _params.upperHint, _params.lowerHint, _params.annualInterestRate, _params.maxUpfrontFee, address(this), address(this), address(this));
    } else {
        IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory openTroveAndJoinInterestBatchManagerParams = IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({owner: _params.owner, ownerIndex: _params.ownerIndex, collAmount: totalCollAmount, boldAmount: _params.boldAmount, upperHint: _params.upperHint, lowerHint: _params.lowerHint, interestBatchManager: _params.batchManager, maxUpfrontFee: _params.maxUpfrontFee, addManager: address(this), removeManager: address(this), receiver: address(this)});
        troveId = borrowerOperations.openTroveAndJoinInterestBatchManager(openTroveAndJoinInterestBatchManagerParams);
    }
    _setAddManager(troveId, _params.addManager);
    _setRemoveManagerAndReceiver(troveId, _params.removeManager, _params.receiver);
    exchange.swapFromBold(_params.boldAmount, _params.flashLoanAmount);
    WETH.transfer(address(flashLoanProvider), _params.flashLoanAmount);
}
```

## Related Implementations

### _setAddManager(uint256,address)

- **Kind**: internal
- **Source**: 2271:171:58
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_setAddManager(uint256,address)`

```solidity
function _setAddManager(uint256 _troveId, address _manager) internal {
    addManagerOf[_troveId] = _manager;
    emit AddManagerUpdated(_troveId, _manager);
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

- **IBorrowerOperations::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **IBorrowerOperations::openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams)**
- **IExchange::swapFromBold(uint256,uint256)**
- **IWETH::transfer(address,uint256)**

## Native Transfers

- **WETH** (computed)

## State Variable Writes

- **addManagerOf** (`mapping(uint256 => address)`)
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LeverageWETHZapper.receiveFlashLoanOnOpenLeveragedTrove(struct ILeverageZapper.OpenLeveragedTroveParams,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._setAddManager(uint256,address) (NodeID: 1)
  │   💬 Args: [troveId, _params.addManager]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AddRemoveManagers._setRemoveManagerAndReceiver(uint256,address,address) (NodeID: 2)
      💬 Args: [troveId, _params.removeManager, _params.receiver]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AddRemoveManagers._requireNonZeroManagerUnlessWiping(address,address) (NodeID: 3)
        💬 Args: [_manager, _receiver]
        👁️  Def: internal
```
