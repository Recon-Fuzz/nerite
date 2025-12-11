# Interface: ISwapRouter

## Metadata

- **Name**: ISwapRouter
- **Type**: Interface
- **Path**: src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol
- **Documentation**: @title Router token swapping functionality
   @notice Functions for swapping tokens via Uniswap V3

## Structs

### ExactInputSingleParams

```solidity
struct ExactInputSingleParams {
    address tokenIn;
    address tokenOut;
    uint24 fee;
    address recipient;
    uint256 deadline;
    uint256 amountIn;
    uint256 amountOutMinimum;
    uint160 sqrtPriceLimitX96;
}
```

### ExactInputParams

```solidity
struct ExactInputParams {
    bytes path;
    address recipient;
    uint256 deadline;
    uint256 amountIn;
    uint256 amountOutMinimum;
}
```

### ExactOutputSingleParams

```solidity
struct ExactOutputSingleParams {
    address tokenIn;
    address tokenOut;
    uint24 fee;
    address recipient;
    uint256 deadline;
    uint256 amountOut;
    uint256 amountInMaximum;
    uint160 sqrtPriceLimitX96;
}
```

### ExactOutputParams

```solidity
struct ExactOutputParams {
    bytes path;
    address recipient;
    uint256 deadline;
    uint256 amountOut;
    uint256 amountInMaximum;
}
```

## Public/External Functions

### exactInputSingle(struct ISwapRouter.ExactInputSingleParams)

- **Signature**: `exactInputSingle(struct ISwapRouter.ExactInputSingleParams)`
- **Visibility**: external
- **Source Range**: 740:111:304

**Signature:**
```solidity
/// @notice Swaps `amountIn` of one token for as much as possible of another token
///  @param params The parameters necessary for the swap, encoded as `ExactInputSingleParams` in calldata
///  @return amountOut The amount of the received token
function exactInputSingle(ExactInputSingleParams calldata params) external payable returns (uint256 amountOut);;
```

### exactInput(struct ISwapRouter.ExactInputParams)

- **Signature**: `exactInput(struct ISwapRouter.ExactInputParams)`
- **Visibility**: external
- **Source Range**: 1305:99:304

**Signature:**
```solidity
/// @notice Swaps `amountIn` of one token for as much as possible of another along the specified path
///  @param params The parameters necessary for the multi-hop swap, encoded as `ExactInputParams` in calldata
///  @return amountOut The amount of the received token
function exactInput(ExactInputParams calldata params) external payable returns (uint256 amountOut);;
```

### exactOutputSingle(struct ISwapRouter.ExactOutputSingleParams)

- **Signature**: `exactOutputSingle(struct ISwapRouter.ExactOutputSingleParams)`
- **Visibility**: external
- **Source Range**: 1928:112:304

**Signature:**
```solidity
/// @notice Swaps as little as possible of one token for `amountOut` of another token
///  @param params The parameters necessary for the swap, encoded as `ExactOutputSingleParams` in calldata
///  @return amountIn The amount of the input token
function exactOutputSingle(ExactOutputSingleParams calldata params) external payable returns (uint256 amountIn);;
```

### exactOutput(struct ISwapRouter.ExactOutputParams)

- **Signature**: `exactOutput(struct ISwapRouter.ExactOutputParams)`
- **Visibility**: external
- **Source Range**: 2506:100:304

**Signature:**
```solidity
/// @notice Swaps as little as possible of one token for `amountOut` of another along the specified path (reversed)
///  @param params The parameters necessary for the multi-hop swap, encoded as `ExactOutputParams` in calldata
///  @return amountIn The amount of the input token
function exactOutput(ExactOutputParams calldata params) external payable returns (uint256 amountIn);;
```
