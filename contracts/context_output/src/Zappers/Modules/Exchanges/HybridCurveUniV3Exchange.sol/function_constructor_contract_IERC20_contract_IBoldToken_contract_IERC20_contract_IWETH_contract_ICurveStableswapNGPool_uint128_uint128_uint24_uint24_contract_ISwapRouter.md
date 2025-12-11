# Function: constructor(contract IERC20,contract IBoldToken,contract IERC20,contract IWETH,contract ICurveStableswapNGPool,uint128,uint128,uint24,uint24,contract ISwapRouter)

**Contract**: [src/Zappers/Modules/Exchanges/HybridCurveUniV3Exchange.sol/contract_HybridCurveUniV3Exchange.md]

## Metadata

- **Contract**: HybridCurveUniV3Exchange
- **Signature**: `constructor(contract IERC20,contract IBoldToken,contract IERC20,contract IWETH,contract ICurveStableswapNGPool,uint128,uint128,uint24,uint24,contract ISwapRouter)`
- **Visibility**: public
- **Source Range**: 1108:709:298

## Implementation

```solidity
constructor(IERC20 _collToken, IBoldToken _boldToken, IERC20 _usdc, IWETH _weth, ICurveStableswapNGPool _curvePool, uint128 _usdcIndex, uint128 _boldIndex, uint24 _feeUsdcWeth, uint24 _feeWethColl, ISwapRouter _uniV3Router) {
    collToken = _collToken;
    boldToken = _boldToken;
    USDC = _usdc;
    WETH = _weth;
    curvePool = _curvePool;
    USDC_INDEX = _usdcIndex;
    BOLD_TOKEN_INDEX = _boldIndex;
    feeUsdcWeth = _feeUsdcWeth;
    feeWethColl = _feeWethColl;
    uniV3Router = _uniV3Router;
}
```

## State Variable Writes

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **curvePool** (`contract ICurveStableswapNGPool`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]
- **USDC_INDEX** (`uint128`)
- **BOLD_TOKEN_INDEX** (`uint128`)
- **feeUsdcWeth** (`uint24`)
- **feeWethColl** (`uint24`)
- **uniV3Router** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: HybridCurveUniV3Exchange.constructor(contract IERC20,contract IBoldToken,contract IERC20,contract IWETH,contract ICurveStableswapNGPool,uint128,uint128,uint24,uint24,contract ISwapRouter) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: HybridCurveUniV3Exchange
```
