# Function: swapToBold(uint256,uint256)

**Contract**: [src/Zappers/Modules/Exchanges/UniV3Exchange.sol/contract_UniV3Exchange.md]

## Metadata

- **Contract**: UniV3Exchange
- **Signature**: `swapToBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2042:1130:300

## Implementation

```solidity
function swapToBold(uint256 _collAmount, uint256 _minBoldAmount) external returns (uint256) {
    ISwapRouter uniV3RouterCached = uniV3Router;
    InitialBalances memory initialBalances;
    _setInitialTokensAndBalances(collToken, boldToken, initialBalances);
    collToken.safeTransferFrom(msg.sender, address(this), _collAmount);
    collToken.approve(address(uniV3RouterCached), _collAmount);
    ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams({tokenIn: address(collToken), tokenOut: address(boldToken), fee: fee, recipient: msg.sender, deadline: block.timestamp, amountIn: _collAmount, amountOutMinimum: _minBoldAmount, sqrtPriceLimitX96: 0});
    uint256 amountOut = uniV3RouterCached.exactInputSingle(params);
    _returnLeftovers(initialBalances);
    return amountOut;
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

- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **IERC20::approve(address,uint256)**
- **ISwapRouter::exactInputSingle(struct ISwapRouter.ExactInputSingleParams)**
- **IERC20::balanceOf(address)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **uniV3Router** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **fee** (`uint24`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV3Exchange.swapToBold(uint256,uint256) (NodeID: 0)
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
