# Function: adjustTrove(uint256,uint256,bool,uint256,bool,uint256)

**Contract**: [src/Zappers/GasCompZapper.sol/contract_GasCompZapper.md]

## Metadata

- **Contract**: GasCompZapper
- **Signature**: `adjustTrove(uint256,uint256,bool,uint256,bool,uint256)`
- **Visibility**: external
- **Source Range**: 5597:671:132

## Implementation

```solidity
function adjustTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) external {
    InitialBalances memory initialBalances;
    address receiver = _adjustTrovePre(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, initialBalances);
    borrowerOperations.adjustTrove(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease, _maxUpfrontFee);
    _adjustTrovePost(_collChange, _isCollIncrease, _boldChange, _isDebtIncrease, receiver, initialBalances);
}
```

## Related Implementations

### _adjustTrovePre(uint256,uint256,bool,uint256,bool,struct LeftoversSweep.InitialBalances)

- **Kind**: internal
- **Source**: 7043:850:132
- **Link**: `src/Zappers/GasCompZapper.sol:GasCompZapper:_adjustTrovePre(uint256,uint256,bool,uint256,bool,struct LeftoversSweep.InitialBalances)`

```solidity
function _adjustTrovePre(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, InitialBalances memory _initialBalances) internal returns (address) {
    address receiver = _checkAdjustTroveManagers(_troveId, _collChange, _isCollIncrease, _boldChange, _isDebtIncrease);
    _setInitialTokensAndBalances(collToken, boldToken, _initialBalances);
    if (_isCollIncrease) {
        collToken.safeTransferFrom(msg.sender, address(this), _collChange);
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

### _adjustTrovePost(uint256,bool,uint256,bool,address,struct LeftoversSweep.InitialBalances)

- **Kind**: internal
- **Source**: 7899:570:132
- **Link**: `src/Zappers/GasCompZapper.sol:GasCompZapper:_adjustTrovePost(uint256,bool,uint256,bool,address,struct LeftoversSweep.InitialBalances)`

```solidity
function _adjustTrovePost(uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, address _receiver, InitialBalances memory _initialBalances) internal {
    if (!_isCollIncrease) {
        collToken.safeTransfer(_receiver, _collChange);
    }
    if (_isDebtIncrease) {
        boldToken.transfer(_receiver, _boldChange);
    }
    _returnLeftovers(_initialBalances);
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

- **IBorrowerOperations::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **IBoldToken::transferFrom(address,address,uint256)**
- **ITroveNFT::ownerOf(uint256)**
- **IERC20::balanceOf(address)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **IBoldToken::transfer(address,uint256)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)
- **addManagerOf** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasCompZapper.adjustTrove(uint256,uint256,bool,uint256,bool,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: GasCompZapper._adjustTrovePre(uint256,uint256,bool,uint256,bool,struct LeftoversSweep.InitialBalances) (NodeID: 1)
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
  │     💬 Args: [collToken, boldToken, _initialBalances]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LeftoversSweep._setInitialTokensBalancesAndReceiver(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances,address) (NodeID: 6)
  │       💬 Args: [_collToken, _boldToken, _initialBalances, msg.sender]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: LeftoversSweep._setInitialBalancesAndReceiver(struct LeftoversSweep.InitialBalances,address) (NodeID: 7)
  │         💬 Args: [_initialBalances, _receiver]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: GasCompZapper._adjustTrovePost(uint256,bool,uint256,bool,address,struct LeftoversSweep.InitialBalances) (NodeID: 8)
      💬 Args: [_collChange, _isCollIncrease, _boldChange, _isDebtIncrease, receiver, initialBalances]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: LeftoversSweep._returnLeftovers(struct LeftoversSweep.InitialBalances) (NodeID: 9)
        💬 Args: [_initialBalances]
        👁️  Def: internal
```
