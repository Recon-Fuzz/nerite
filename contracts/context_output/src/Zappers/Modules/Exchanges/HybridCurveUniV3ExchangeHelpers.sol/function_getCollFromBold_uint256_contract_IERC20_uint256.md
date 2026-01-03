# Function: getCollFromBold(uint256,contract IERC20,uint256)

**Contract**: [src/Zappers/Modules/Exchanges/HybridCurveUniV3ExchangeHelpers.sol/contract_HybridCurveUniV3ExchangeHelpers.md]

## Metadata

- **Contract**: HybridCurveUniV3ExchangeHelpers
- **Signature**: `getCollFromBold(uint256,contract IERC20,uint256)`
- **Visibility**: external
- **Source Range**: 1861:905:148

## Implementation

```solidity
function getCollFromBold(uint256 _boldAmount, IERC20 _collToken, uint256 _desiredCollAmount) external returns (uint256 collAmount, uint256 deviation) {
    uint256 curveUsdcAmount = curvePool.get_dy(int128(BOLD_TOKEN_INDEX), int128(USDC_INDEX), _boldAmount);
    bytes memory path;
    if (address(WETH) == address(_collToken)) {
        path = abi.encodePacked(USDC, feeUsdcWeth, WETH);
    } else {
        path = abi.encodePacked(USDC, feeUsdcWeth, WETH, feeWethColl, _collToken);
    }
    (collAmount, , , ) = uniV3Quoter.quoteExactInput(path, curveUsdcAmount);
    if ((_desiredCollAmount > 0) && (collAmount <= _desiredCollAmount)) {
        deviation = DECIMAL_PRECISION - ((collAmount * DECIMAL_PRECISION) / _desiredCollAmount);
    }
    return (collAmount, deviation);
}
```

## External Calls

- **ICurveStableswapNGPool::get_dy(int128,int128,uint256)**
- **IQuoterV2::quoteExactInput(bytes,uint256)**

## State Variable Reads

- **curvePool** (`contract ICurveStableswapNGPool`) [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]
- **BOLD_TOKEN_INDEX** (`uint128`)
- **USDC_INDEX** (`uint128`)
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **feeUsdcWeth** (`uint24`)
- **feeWethColl** (`uint24`)
- **uniV3Quoter** (`contract IQuoterV2`) [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]
- **DECIMAL_PRECISION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HybridCurveUniV3ExchangeHelpers.getCollFromBold(uint256,contract IERC20,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
