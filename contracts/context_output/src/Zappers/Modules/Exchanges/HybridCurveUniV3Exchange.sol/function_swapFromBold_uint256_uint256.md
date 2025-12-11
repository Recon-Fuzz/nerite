# Function: swapFromBold(uint256,uint256)

**Contract**: [src/Zappers/Modules/Exchanges/HybridCurveUniV3Exchange.sol/contract_HybridCurveUniV3Exchange.md]

## Metadata

- **Contract**: HybridCurveUniV3Exchange
- **Signature**: `swapFromBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1910:1305:298

## Implementation

```solidity
function swapFromBold(uint256 _boldAmount, uint256 _minCollAmount) external {
    InitialBalances memory initialBalances;
    _setHybridExchangeInitialBalances(initialBalances);
    boldToken.transferFrom(msg.sender, address(this), _boldAmount);
    boldToken.approve(address(curvePool), _boldAmount);
    uint256 curveUsdcAmount = curvePool.exchange(int128(BOLD_TOKEN_INDEX), int128(USDC_INDEX), _boldAmount, 0);
    USDC.approve(address(uniV3Router), curveUsdcAmount);
    bytes memory path;
    if (address(WETH) == address(collToken)) {
        path = abi.encodePacked(USDC, feeUsdcWeth, WETH);
    } else {
        path = abi.encodePacked(USDC, feeUsdcWeth, WETH, feeWethColl, collToken);
    }
    ISwapRouter.ExactInputParams memory params = ISwapRouter.ExactInputParams({path: path, recipient: msg.sender, deadline: block.timestamp, amountIn: curveUsdcAmount, amountOutMinimum: _minCollAmount});
    uniV3Router.exactInput(params);
    _returnLeftovers(initialBalances);
}
```

## Related Implementations

### _setHybridExchangeInitialBalances(struct LeftoversSweep.InitialBalances)

- **Kind**: internal
- **Source**: 4754:393:298
- **Link**: `src/Zappers/Modules/Exchanges/HybridCurveUniV3Exchange.sol:HybridCurveUniV3Exchange:_setHybridExchangeInitialBalances(struct LeftoversSweep.InitialBalances)`

```solidity
function _setHybridExchangeInitialBalances(InitialBalances memory initialBalances) internal view {
    initialBalances.tokens[0] = boldToken;
    initialBalances.tokens[1] = USDC;
    initialBalances.tokens[2] = WETH;
    if (address(WETH) != address(collToken)) {
        initialBalances.tokens[3] = collToken;
    }
    _setInitialBalances(initialBalances);
}
```

### _setInitialBalances(struct LeftoversSweep.InitialBalances)

- **Kind**: internal
- **Source**: 1126:161:290
- **Link**: `src/Zappers/LeftoversSweep.sol:LeftoversSweep:_setInitialBalances(struct LeftoversSweep.InitialBalances)`

```solidity
function _setInitialBalances(InitialBalances memory _initialBalances) internal view {
    _setInitialBalancesAndReceiver(_initialBalances, msg.sender);
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
- **ICurveStableswapNGPool::exchange(int128,int128,uint256,uint256)**
- **IERC20::approve(address,uint256)**
- **ISwapRouter::exactInput(struct ISwapRouter.ExactInputParams)**
- **IERC20::balanceOf(address)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **curvePool** (`contract ICurveStableswapNGPool`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]
- **BOLD_TOKEN_INDEX** (`uint128`)
- **USDC_INDEX** (`uint128`)
- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **uniV3Router** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **feeUsdcWeth** (`uint24`)
- **feeWethColl** (`uint24`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HybridCurveUniV3Exchange.swapFromBold(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: HybridCurveUniV3Exchange._setHybridExchangeInitialBalances(struct LeftoversSweep.InitialBalances) (NodeID: 1)
  │   💬 Args: [initialBalances]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LeftoversSweep._setInitialBalances(struct LeftoversSweep.InitialBalances) (NodeID: 2)
  │     💬 Args: [initialBalances]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: LeftoversSweep._setInitialBalancesAndReceiver(struct LeftoversSweep.InitialBalances,address) (NodeID: 3)
  │       💬 Args: [_initialBalances, msg.sender]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: LeftoversSweep._returnLeftovers(struct LeftoversSweep.InitialBalances) (NodeID: 4)
      💬 Args: [initialBalances]
      👁️  Def: internal
```
