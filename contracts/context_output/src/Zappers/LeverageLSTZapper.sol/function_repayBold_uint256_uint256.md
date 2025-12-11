# Function: repayBold(uint256,uint256)

**Contract**: [src/Zappers/LeverageLSTZapper.sol/contract_LeverageLSTZapper.md]

## Metadata

- **Contract**: LeverageLSTZapper
- **Signature**: `repayBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4975:616:283
- **Inherited From**: GasCompZapper

## Implementation

```solidity
function repayBold(uint256 _troveId, uint256 _boldAmount) external {
    address owner = troveNFT.ownerOf(_troveId);
    _requireSenderIsOwnerOrAddManager(_troveId, owner);
    InitialBalances memory initialBalances;
    _setInitialTokensAndBalances(collToken, boldToken, initialBalances);
    boldToken.transferFrom(msg.sender, address(this), _boldAmount);
    borrowerOperations.repayBold(_troveId, _boldAmount);
    _returnLeftovers(initialBalances);
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

### _setInitialTokensAndBalances(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances)

- **Kind**: internal
- **Source**: 468:272:290
- **Link**: `src/Zappers/LeftoversSweep.sol:LeftoversSweep:_setInitialTokensAndBalances(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances)`

```solidity
function _setInitialTokensAndBalances(IERC20 _collToken, IBoldToken _boldToken, InitialBalances memory _initialBalances) internal view {
    _setInitialTokensBalancesAndReceiver(_collToken, _boldToken, _initialBalances, msg.sender);
}
```

### _setInitialTokensBalancesAndReceiver(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances,address)

- **Kind**: internal
- **Source**: 746:374:290
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
- **Source**: 1293:420:290
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
- **Source**: 1719:577:290
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
- **IBoldToken::transferFrom(address,address,uint256)**
- **IBorrowerOperations::repayBold(uint256,uint256)**
- **IERC20::balanceOf(address)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **addManagerOf** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasCompZapper.repayBold(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrAddManager(uint256,address) (NodeID: 1)
  │   💬 Args: [_troveId, owner]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LeftoversSweep._setInitialTokensAndBalances(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances) (NodeID: 2)
  │   💬 Args: [collToken, boldToken, initialBalances]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LeftoversSweep._setInitialTokensBalancesAndReceiver(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances,address) (NodeID: 3)
  │     💬 Args: [_collToken, _boldToken, _initialBalances, msg.sender]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LeftoversSweep._setInitialBalancesAndReceiver(struct LeftoversSweep.InitialBalances,address) (NodeID: 4)
  │       💬 Args: [_initialBalances, _receiver]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: LeftoversSweep._returnLeftovers(struct LeftoversSweep.InitialBalances) (NodeID: 5)
      💬 Args: [initialBalances]
      👁️  Def: internal
```
