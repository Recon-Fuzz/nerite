# Function: openTroveWithRawETH(struct IZapper.OpenTroveParams)

**Contract**: [src/Zappers/GasCompZapper.sol/contract_GasCompZapper.md]

## Metadata

- **Contract**: GasCompZapper
- **Signature**: `openTroveWithRawETH(struct IZapper.OpenTroveParams)`
- **Visibility**: external
- **Source Range**: 1026:2750:283

## Implementation

```solidity
function openTroveWithRawETH(OpenTroveParams calldata _params) external payable returns (uint256) {
    require(msg.value == ETH_GAS_COMPENSATION, "GCZ: Wrong ETH");
    require((_params.batchManager == address(0)) || (_params.annualInterestRate == 0), "GCZ: Cannot choose interest if joining a batch");
    WETH.deposit{value: msg.value}();
    collToken.safeTransferFrom(msg.sender, address(this), _params.collAmount);
    uint256 troveId;
    if (_params.batchManager == address(0)) {
        troveId = borrowerOperations.openTrove(_params.owner, _params.ownerIndex, _params.collAmount, _params.boldAmount, _params.upperHint, _params.lowerHint, _params.annualInterestRate, _params.maxUpfrontFee, address(this), address(this), address(this));
    } else {
        IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams memory openTroveAndJoinInterestBatchManagerParams = IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams({owner: _params.owner, ownerIndex: _params.ownerIndex, collAmount: _params.collAmount, boldAmount: _params.boldAmount, upperHint: _params.upperHint, lowerHint: _params.lowerHint, interestBatchManager: _params.batchManager, maxUpfrontFee: _params.maxUpfrontFee, addManager: address(this), removeManager: address(this), receiver: address(this)});
        troveId = borrowerOperations.openTroveAndJoinInterestBatchManager(openTroveAndJoinInterestBatchManagerParams);
    }
    boldToken.transfer(msg.sender, _params.boldAmount);
    _setAddManager(troveId, _params.addManager);
    _setRemoveManagerAndReceiver(troveId, _params.removeManager, _params.receiver);
    return troveId;
}
```

## Related Implementations

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

- **unknown::unknown**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **IBorrowerOperations::openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)**
- **IBorrowerOperations::openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams)**
- **IBoldToken::transfer(address,uint256)**

## Native Transfers

- **boldToken** (computed)

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Writes

- **addManagerOf** (`mapping(uint256 => address)`)
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasCompZapper.openTroveWithRawETH(struct IZapper.OpenTroveParams) (NodeID: 0)
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
