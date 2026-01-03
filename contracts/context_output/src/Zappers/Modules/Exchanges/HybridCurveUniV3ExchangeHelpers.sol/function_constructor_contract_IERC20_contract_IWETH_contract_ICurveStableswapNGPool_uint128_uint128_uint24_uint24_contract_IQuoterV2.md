# Function: constructor(contract IERC20,contract IWETH,contract ICurveStableswapNGPool,uint128,uint128,uint24,uint24,contract IQuoterV2)

**Contract**: [src/Zappers/Modules/Exchanges/HybridCurveUniV3ExchangeHelpers.sol/contract_HybridCurveUniV3ExchangeHelpers.md]

## Metadata

- **Contract**: HybridCurveUniV3ExchangeHelpers
- **Signature**: `constructor(contract IERC20,contract IWETH,contract ICurveStableswapNGPool,uint128,uint128,uint24,uint24,contract IQuoterV2)`
- **Visibility**: public
- **Source Range**: 1270:585:148

## Implementation

```solidity
constructor(IERC20 _usdc, IWETH _weth, ICurveStableswapNGPool _curvePool, uint128 _usdcIndex, uint128 _boldIndex, uint24 _feeUsdcWeth, uint24 _feeWethColl, IQuoterV2 _uniV3Quoter) {
    USDC = _usdc;
    WETH = _weth;
    curvePool = _curvePool;
    USDC_INDEX = _usdcIndex;
    BOLD_TOKEN_INDEX = _boldIndex;
    feeUsdcWeth = _feeUsdcWeth;
    feeWethColl = _feeWethColl;
    uniV3Quoter = _uniV3Quoter;
}
```

## State Variable Writes

- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **curvePool** (`contract ICurveStableswapNGPool`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]
- **USDC_INDEX** (`uint128`)
- **BOLD_TOKEN_INDEX** (`uint128`)
- **feeUsdcWeth** (`uint24`)
- **feeWethColl** (`uint24`)
- **uniV3Quoter** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: HybridCurveUniV3ExchangeHelpers.constructor(contract IERC20,contract IWETH,contract ICurveStableswapNGPool,uint128,uint128,uint24,uint24,contract IQuoterV2) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: HybridCurveUniV3ExchangeHelpers
```
