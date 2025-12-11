# Function: swapToBold(uint256,uint256)

**Contract**: [src/Zappers/Modules/Exchanges/HybridCurveUniV3Exchange.sol/contract_HybridCurveUniV3Exchange.md]

## Metadata

- **Contract**: HybridCurveUniV3Exchange
- **Signature**: `swapToBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3307:1441:298

## Implementation

```solidity
function swapToBold(uint256 _collAmount, uint256 _minBoldAmount) external returns (uint256) {
    InitialBalances memory initialBalances;
    _setHybridExchangeInitialBalances(initialBalances);
    collToken.safeTransferFrom(msg.sender, address(this), _collAmount);
    collToken.approve(address(uniV3Router), _collAmount);
    bytes memory path;
    if (address(WETH) == address(collToken)) {
        path = abi.encodePacked(WETH, feeUsdcWeth, USDC);
    } else {
        path = abi.encodePacked(collToken, feeWethColl, WETH, feeUsdcWeth, USDC);
    }
    ISwapRouter.ExactInputParams memory params = ISwapRouter.ExactInputParams({path: path, recipient: address(this), deadline: block.timestamp, amountIn: _collAmount, amountOutMinimum: 0});
    uint256 uniV3UsdcAmount = uniV3Router.exactInput(params);
    USDC.approve(address(curvePool), uniV3UsdcAmount);
    uint256 boldAmount = curvePool.exchange(int128(USDC_INDEX), int128(BOLD_TOKEN_INDEX), uniV3UsdcAmount, _minBoldAmount);
    boldToken.transfer(msg.sender, boldAmount);
    _returnLeftovers(initialBalances);
    return boldAmount;
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

- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **IERC20::approve(address,uint256)**
- **ISwapRouter::exactInput(struct ISwapRouter.ExactInputParams)**
- **ICurveStableswapNGPool::exchange(int128,int128,uint256,uint256)**
- **IBoldToken::transfer(address,uint256)**
- **IERC20::balanceOf(address)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## Native Transfers

- **boldToken** (state variable) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **uniV3Router** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **feeUsdcWeth** (`uint24`)
- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **feeWethColl** (`uint24`)
- **curvePool** (`contract ICurveStableswapNGPool`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]
- **USDC_INDEX** (`uint128`)
- **BOLD_TOKEN_INDEX** (`uint128`)
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HybridCurveUniV3Exchange.swapToBold(uint256,uint256) (NodeID: 0)
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
