# Contract: HybridCurveUniV3ExchangeHelpers

## Metadata

- **Name**: HybridCurveUniV3ExchangeHelpers
- **Type**: Contract
- **Path**: src/Zappers/Modules/Exchanges/HybridCurveUniV3ExchangeHelpers.sol

## Implements Interfaces

- **IExchangeHelpers** [src/Zappers/Interfaces/IExchangeHelpers.sol/interface_IExchangeHelpers.md]

## State Variables

### DECIMAL_PRECISION

```solidity
uint256 private constant DECIMAL_PRECISION = 1e18
```

### USDC

```solidity
IERC20 public immutable USDC
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### WETH

```solidity
IWETH public immutable WETH
```

**IWETH**: [src/Interfaces/IWETH.sol/interface_IWETH.md]

### curvePool

```solidity
ICurveStableswapNGPool public immutable curvePool
```

**ICurveStableswapNGPool**: [src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol/interface_ICurveStableswapNGPool.md]

### USDC_INDEX

```solidity
uint128 public immutable USDC_INDEX
```

### BOLD_TOKEN_INDEX

```solidity
uint128 public immutable BOLD_TOKEN_INDEX
```

### feeUsdcWeth

```solidity
uint24 public immutable feeUsdcWeth
```

### feeWethColl

```solidity
uint24 public immutable feeWethColl
```

### uniV3Quoter

```solidity
IQuoterV2 public immutable uniV3Quoter
```

**IQuoterV2**: [src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol/interface_IQuoterV2.md]

## Public/External Functions

### constructor(contract IERC20,contract IWETH,contract ICurveStableswapNGPool,uint128,uint128,uint24,uint24,contract IQuoterV2)

- **Signature**: `constructor(contract IERC20,contract IWETH,contract ICurveStableswapNGPool,uint128,uint128,uint24,uint24,contract IQuoterV2)`
- **Visibility**: public
- **Source Range**: 1270:585:148
- **Details**: [function_constructor_contract_IERC20_contract_IWETH_contract_ICurveStableswapNGPool_uint128_uint128_uint24_uint24_contract_IQuoterV2.md](./function_constructor_contract_IERC20_contract_IWETH_contract_ICurveStableswapNGPool_uint128_uint128_uint24_uint24_contract_IQuoterV2.md)

**Signature:**
```solidity
constructor(IERC20 _usdc, IWETH _weth, ICurveStableswapNGPool _curvePool, uint128 _usdcIndex, uint128 _boldIndex, uint24 _feeUsdcWeth, uint24 _feeWethColl, IQuoterV2 _uniV3Quoter);
```

### getCollFromBold(uint256,contract IERC20,uint256)

- **Signature**: `getCollFromBold(uint256,contract IERC20,uint256)`
- **Visibility**: external
- **Source Range**: 1861:905:148
- **Details**: [function_getCollFromBold_uint256_contract_IERC20_uint256.md](./function_getCollFromBold_uint256_contract_IERC20_uint256.md)

**Signature:**
```solidity
function getCollFromBold(uint256 _boldAmount, IERC20 _collToken, uint256 _desiredCollAmount) external returns (uint256 collAmount, uint256 deviation);
```
