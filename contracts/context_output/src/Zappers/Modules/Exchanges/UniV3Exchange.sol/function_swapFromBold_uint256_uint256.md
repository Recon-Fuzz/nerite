# Function: swapFromBold(uint256,uint256)

**Contract**: [src/Zappers/Modules/Exchanges/UniV3Exchange.sol/contract_UniV3Exchange.md]

## Metadata

- **Contract**: UniV3Exchange
- **Signature**: `swapFromBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 970:1066:300

## Implementation

```solidity
function swapFromBold(uint256 _boldAmount, uint256 _minCollAmount) external {
    ISwapRouter uniV3RouterCached = uniV3Router;
    InitialBalances memory initialBalances;
    _setInitialTokensAndBalances(collToken, boldToken, initialBalances);
    boldToken.transferFrom(msg.sender, address(this), _boldAmount);
    boldToken.approve(address(uniV3RouterCached), _boldAmount);
    ISwapRouter.ExactOutputSingleParams memory params = ISwapRouter.ExactOutputSingleParams({tokenIn: address(boldToken), tokenOut: address(collToken), fee: fee, recipient: msg.sender, deadline: block.timestamp, amountOut: _minCollAmount, amountInMaximum: _boldAmount, sqrtPriceLimitX96: 0});
    uniV3RouterCached.exactOutputSingle(params);
    _returnLeftovers(initialBalances);
}
```

## Related Implementations

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

- **IBoldToken::transferFrom(address,address,uint256)**
- **IBoldToken::approve(address,uint256)**
- **ISwapRouter::exactOutputSingle(struct ISwapRouter.ExactOutputSingleParams)**
- **IERC20::balanceOf(address)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **uniV3Router** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **fee** (`uint24`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV3Exchange.swapFromBold(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: LeftoversSweep._setInitialTokensAndBalances(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances) (NodeID: 1)
  │   💬 Args: [collToken, boldToken, initialBalances]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LeftoversSweep._setInitialTokensBalancesAndReceiver(contract IERC20,contract IBoldToken,struct LeftoversSweep.InitialBalances,address) (NodeID: 2)
  │     💬 Args: [_collToken, _boldToken, _initialBalances, msg.sender]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LeftoversSweep._setInitialBalancesAndReceiver(struct LeftoversSweep.InitialBalances,address) (NodeID: 3)
  │       💬 Args: [_initialBalances, _receiver]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: LeftoversSweep._returnLeftovers(struct LeftoversSweep.InitialBalances) (NodeID: 4)
      💬 Args: [initialBalances]
      👁️  Def: internal
```
