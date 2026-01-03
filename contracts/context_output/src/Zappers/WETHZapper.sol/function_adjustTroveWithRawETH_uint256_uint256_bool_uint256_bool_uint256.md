# Function: adjustTroveWithRawETH(uint256,uint256,bool,uint256,bool,uint256)

**Contract**: [src/Zappers/WETHZapper.sol/contract_WETHZapper.md]

## Metadata

- **Contract**: WETHZapper
- **Signature**: `adjustTroveWithRawETH(uint256,uint256,bool,uint256,bool,uint256)`
- **Visibility**: external
- **Source Range**: 5233:697:160

## Implementation

```solidity
function adjustTroveWithRawETH(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) external payable {
    InitialBalances memory initialBalances;
    address payable receiver = _adjustTrovePre(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, initialBalances);
    borrowerOperations.adjustTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _maxUpfrontFee);
    _adjustTrovePost(_collChange, _isCollIncrease, _boldChange, _isDebtIncrease, receiver, initialBalances);
}
```

## Related Implementations

### _adjustTrovePre(uint256,uint256,bool,uint256,bool,struct LeftoversSweep.InitialBalances)

- **Kind**: internal
- **Source**: 6731:1058:160
- **Link**: `src/Zappers/WETHZapper.sol:WETHZapper:_adjustTrovePre(uint256,uint256,bool,uint256,bool,struct LeftoversSweep.InitialBalances)`

```solidity
function _adjustTrovePre(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, InitialBalances memory _initialBalances) internal returns (address payable) {
    if (_isCollIncrease) {
        require(_collChange == msg.value, "WZ: Wrong coll amount");
    } else {
        require(msg.value == 0, "WZ: Not adding coll, no ETH should be received");
    }
    address payable receiver = payable(_checkAdjustTroveManagers(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease));
    _setInitialTokensAndBalances(WETH, boldToken, _initialBalances);
    if (_isCollIncrease) {
        WETH.deposit{value: _collChange}();
    }
    if (!_isDebtIncrease) {
        boldToken.transferFrom(msg.sender, address(this), _boldChange);
    }
    return receiver;
}
```

### _checkAdjustTroveManagers(uint256,uint256,bool,uint256,bool)

- **Kind**: internal
- **Source**: 1340:658:131
- **Link**: `src/Zappers/BaseZapper.sol:BaseZapper:_checkAdjustTroveManagers(uint256,uint256,bool,uint256,bool)`

```solidity
function _checkAdjustTroveManagers(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease) internal view returns (address) {
    address owner = troveNFT.ownerOf(_troveId);
    address receiver = owner;
    if (((!_isCollIncrease) && (_collChange > 0)) || _isDebtIncrease) {
        receiver = _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(_troveId, owner);
    }
    if (_isCollIncrease || ((!_isDebtIncrease) && (_boldChange > 0))) {
        _requireSenderIsOwnerOrAddManager(_troveId, owner);
    }
    return receiver;
}
```

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

### _setInitialTokensAndBalances(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances)

- **Kind**: internal
- **Source**: 468:272:139
- **Link**: `src/Zappers/LeftoversSweep.sol:LeftoversSweep:_setInitialTokensAndBalances(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances)`

```solidity
function _setInitialTokensAndBalances(IERC20 _collToken, IBoldToken _boldToken, InitialBalances memory _initialBalances) internal view {
    _setInitialTokensBalancesAndReceiver(_collToken, _boldToken, _initialBalances, msg.sender);
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

### _adjustTrovePost(uint256,bool,uint256,bool,address payable,struct LeftoversSweep.InitialBalances)

- **Kind**: internal
- **Source**: 7795:1193:160
- **Link**: `src/Zappers/WETHZapper.sol:WETHZapper:_adjustTrovePost(uint256,bool,uint256,bool,address payable,struct LeftoversSweep.InitialBalances)`

```solidity
function _adjustTrovePost(uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, address payable _receiver, InitialBalances memory _initialBalances) internal {
    if (_isDebtIncrease) {
        boldToken.transfer(_receiver, _boldChange);
    }
    uint256 currentBoldBalance = boldToken.balanceOf(address(this));
    if (currentBoldBalance > _initialBalances.balances[1]) {
        boldToken.transfer(_initialBalances.receiver, currentBoldBalance - _initialBalances.balances[1]);
    }
    if ((!_isCollIncrease) && (_collChange > 0)) {
        WETH.withdraw(_collChange);
        (bool success, ) = _receiver.call{value: _collChange}("");
        require(success, "WZ: Sending ETH failed");
    }
    assert(address(this).balance == 0);
    assert(WETH.balanceOf(address(this)) == 0);
}
```

## External Calls

- **IBorrowerOperations::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**
- **unknown::unknown**
- **IBoldToken::transferFrom(address,address,uint256)**
- **ITroveNFT::ownerOf(uint256)**
- **IERC20::balanceOf(address)**
- **IBoldToken::transfer(address,uint256)**
- **IBoldToken::balanceOf(address)**
- **IWETH::withdraw(uint256)**
- **IWETH::balanceOf(address)**

## State Variable Reads

- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)
- **addManagerOf** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: WETHZapper.adjustTroveWithRawETH(uint256,uint256,bool,uint256,bool,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: WETHZapper._adjustTrovePre(uint256,uint256,bool,uint256,bool,struct LeftoversSweep.InitialBalances) (NodeID: 1)
  │   💬 Args: [_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, initialBalances]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseZapper._checkAdjustTroveManagers(uint256,uint256,bool,uint256,bool) (NodeID: 2)
  │ │   💬 Args: [_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 3)
  │ │ │   💬 Args: [_troveId, owner]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrAddManager(uint256,address) (NodeID: 4)
  │ │     💬 Args: [_troveId, owner]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LeftoversSweep._setInitialTokensAndBalances(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances) (NodeID: 5)
  │     💬 Args: [WETH, boldToken, _initialBalances]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LeftoversSweep._setInitialTokensBalancesAndReceiver(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances,address) (NodeID: 6)
  │       💬 Args: [_collToken, _boldToken, _initialBalances, msg.sender]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LeftoversSweep._setInitialBalancesAndReceiver(struct LeftoversSweep.InitialBalances,address) (NodeID: 7)
  │         💬 Args: [_initialBalances, _receiver]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: WETHZapper._adjustTrovePost(uint256,bool,uint256,bool,address payable,struct LeftoversSweep.InitialBalances) (NodeID: 8)
      💬 Args: [_collChange, _isCollIncrease, _boldChange, _isDebtIncrease, receiver, initialBalances]
      👁️  Def: internal
```
