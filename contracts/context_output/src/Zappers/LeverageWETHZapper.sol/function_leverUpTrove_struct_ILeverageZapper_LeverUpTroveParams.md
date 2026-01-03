# Function: leverUpTrove(struct ILeverageZapper.LeverUpTroveParams)

**Contract**: [src/Zappers/LeverageWETHZapper.sol/contract_LeverageWETHZapper.md]

## Metadata

- **Contract**: LeverageWETHZapper
- **Signature**: `leverUpTrove(struct ILeverageZapper.LeverUpTroveParams)`
- **Visibility**: external
- **Source Range**: 4571:710:141

## Implementation

```solidity
function leverUpTrove(LeverUpTroveParams calldata _params) external {
    address owner = troveNFT.ownerOf(_params.troveId);
    address receiver = _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(_params.troveId, owner);
    InitialBalances memory initialBalances;
    _setInitialTokensBalancesAndReceiver(WETH, boldToken, initialBalances, receiver);
    flashLoanProvider.makeFlashLoan(WETH, _params.flashLoanAmount, IFlashLoanProvider.Operation.LeverUpTrove, abi.encode(_params));
    _returnLeftovers(initialBalances);
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

### _setInitialTokensBalancesAndReceiver(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances,address)

- **Kind**: internal
- **Source**: 746:374:139
- **Link**: `src/Zappers/LeftoversSweep.sol:LeftoversSweep:_setInitialTokensBalancesAndReceiver(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances,address)`

```solidity
function _setInitialTokensBalancesAndReceiver(IERC20 _collToken, IBoldToken _boldToken, InitialBalances memory _initialBalances, address _receiver) internal view {
    _initialBalances.tokens[0] = _collToken;
    _initialBalances.tokens[1] = _boldToken;
    _setInitialBalancesAndReceiver(_initialBalances, _receiver);
}
```

### _setInitialBalancesAndReceiver(struct LeftoversSweep.InitialBalances,address)

- **Kind**: internal
- **Source**: 1293:420:139
- **Link**: `src/Zappers/LeftoversSweep.sol:LeftoversSweep:_setInitialBalancesAndReceiver(struct LeftoversSweep.InitialBalances,address)`

```solidity
function _setInitialBalancesAndReceiver(InitialBalances memory _initialBalances, address _receiver) internal view {
    for (uint256 i = 0; i < _initialBalances.tokens.length; i++) {
        if (address(_initialBalances.tokens[i]) == address(0)) break;
        _initialBalances.balances[i] = _initialBalances.tokens[i].balanceOf(address(this));
    }
    _initialBalances.receiver = _receiver;
}
```

### _returnLeftovers(struct LeftoversSweep.InitialBalances)

- **Kind**: internal
- **Source**: 1719:577:139
- **Link**: `src/Zappers/LeftoversSweep.sol:LeftoversSweep:_returnLeftovers(struct LeftoversSweep.InitialBalances)`

```solidity
function _returnLeftovers(InitialBalances memory _initialBalances) internal {
    for (uint256 i = 0; i < _initialBalances.tokens.length; i++) {
        if (address(_initialBalances.tokens[i]) == address(0)) break;
        uint256 currentBalance = _initialBalances.tokens[i].balanceOf(address(this));
        if (currentBalance > _initialBalances.balances[i]) {
            _initialBalances.tokens[i].safeTransfer(_initialBalances.receiver, currentBalance - _initialBalances.balances[i]);
        }
    }
}
```

## External Calls

- **ITroveNFT::ownerOf(uint256)**
- **IFlashLoanProvider::makeFlashLoan(contract IERC20,uint256,enum IFlashLoanProvider.Operation,bytes)**
- **IERC20::balanceOf(address)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LeverageWETHZapper.leverUpTrove(struct ILeverageZapper.LeverUpTroveParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 1)
  │   💬 Args: [_params.troveId, owner]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LeftoversSweep._setInitialTokensBalancesAndReceiver(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances,address) (NodeID: 2)
  │   💬 Args: [WETH, boldToken, initialBalances, receiver]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LeftoversSweep._setInitialBalancesAndReceiver(struct LeftoversSweep.InitialBalances,address) (NodeID: 3)
  │     💬 Args: [_initialBalances, _receiver]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: LeftoversSweep._returnLeftovers(struct LeftoversSweep.InitialBalances) (NodeID: 4)
      💬 Args: [initialBalances]
      👁️  Def: internal
```
