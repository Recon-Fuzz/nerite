# Contract: HybridCurveUniV3Exchange

## Metadata

- **Name**: HybridCurveUniV3Exchange
- **Type**: Contract
- **Path**: src/Zappers/Modules/Exchanges/HybridCurveUniV3Exchange.sol

## Implements Interfaces

- **IExchange** [src/Zappers/Interfaces/IExchange.sol/interface_IExchange.md]

## State Variables

### collToken

```solidity
IERC20 public immutable collToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### boldToken

```solidity
IBoldToken public immutable boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

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

### uniV3Router

```solidity
ISwapRouter public immutable uniV3Router
```

**ISwapRouter**: [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]

## Structs

### InitialBalances (inherited from LeftoversSweep)

```solidity
struct InitialBalances {
    IERC20[4] tokens;
    uint256[4] balances;
    address receiver;
}
```

## Public/External Functions

### constructor(contract IERC20,contract IBoldToken,contract IERC20,contract IWETH,contract ICurveStableswapNGPool,uint128,uint128,uint24,uint24,contract ISwapRouter)

- **Signature**: `constructor(contract IERC20,contract IBoldToken,contract IERC20,contract IWETH,contract ICurveStableswapNGPool,uint128,uint128,uint24,uint24,contract ISwapRouter)`
- **Visibility**: public
- **Source Range**: 1108:709:147
- **Details**: [function_constructor_contract_IERC20_contract_IBoldToken_contract_IERC20_contract_IWETH_contract_ICurveStableswapNGPool_uint128_uint128_uint24_uint24_contract_ISwapRouter.md](./function_constructor_contract_IERC20_contract_IBoldToken_contract_IERC20_contract_IWETH_contract_ICurveStableswapNGPool_uint128_uint128_uint24_uint24_contract_ISwapRouter.md)

**Signature:**
```solidity
constructor(IERC20 _collToken, IBoldToken _boldToken, IERC20 _usdc, IWETH _weth, ICurveStableswapNGPool _curvePool, uint128 _usdcIndex, uint128 _boldIndex, uint24 _feeUsdcWeth, uint24 _feeWethColl, ISwapRouter _uniV3Router);
```

### swapFromBold(uint256,uint256)

- **Signature**: `swapFromBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1910:1305:147
- **Details**: [function_swapFromBold_uint256_uint256.md](./function_swapFromBold_uint256_uint256.md)

**Signature:**
```solidity
function swapFromBold(uint256 _boldAmount, uint256 _minCollAmount) external;
```

### swapToBold(uint256,uint256)

- **Signature**: `swapToBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3307:1441:147
- **Details**: [function_swapToBold_uint256_uint256.md](./function_swapToBold_uint256_uint256.md)

**Signature:**
```solidity
function swapToBold(uint256 _collAmount, uint256 _minBoldAmount) external returns (uint256);
```
