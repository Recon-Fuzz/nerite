# Interface: IQuoterV2

## Metadata

- **Name**: IQuoterV2
- **Type**: Interface
- **Path**: src/Zappers/Modules/Exchanges/UniswapV3/IQuoterV2.sol
- **Documentation**: @title QuoterV2 Interface
   @notice Supports quoting the calculated amounts from exact input or exact output swaps.
   @notice For each pool also tells you the number of initialized ticks crossed and the sqrt price of the pool after the swap.
   @dev These functions are not marked view because they rely on calling non-view functions and reverting
   to compute the result. They are also not gas efficient and should not be called on-chain.

## Structs

### QuoteExactInputSingleParams

```solidity
struct QuoteExactInputSingleParams {
    address tokenIn;
    address tokenOut;
    uint256 amountIn;
    uint24 fee;
    uint160 sqrtPriceLimitX96;
}
```

### QuoteExactOutputSingleParams

```solidity
struct QuoteExactOutputSingleParams {
    address tokenIn;
    address tokenOut;
    uint256 amount;
    uint24 fee;
    uint160 sqrtPriceLimitX96;
}
```

## Public/External Functions

### quoteExactInput(bytes,uint256)

- **Signature**: `quoteExactInput(bytes,uint256)`
- **Visibility**: external
- **Source Range**: 1191:279:152

**Signature:**
```solidity
/// @notice Returns the amount out received for a given exact input swap without executing the swap
///  @param path The path of the swap, i.e. each token pair and the pool fee
///  @param amountIn The amount of the first token to swap
///  @return amountOut The amount of the last token that would be received
///  @return sqrtPriceX96AfterList List of the sqrt price after the swap for each pool in the path
///  @return initializedTicksCrossedList List of the initialized ticks that the swap crossed for each pool in the path
///  @return gasEstimate The estimate of the gas that the swap consumes
function quoteExactInput(bytes memory path, uint256 amountIn) external returns (uint256 amountOut, uint160[] memory sqrtPriceX96AfterList, uint32[] memory initializedTicksCrossedList, uint256 gasEstimate);;
```

### quoteExactInputSingle(struct IQuoterV2.QuoteExactInputSingleParams)

- **Signature**: `quoteExactInputSingle(struct IQuoterV2.QuoteExactInputSingleParams)`
- **Visibility**: external
- **Source Range**: 2451:207:152

**Signature:**
```solidity
/// @notice Returns the amount out received for a given exact input but for a swap of a single pool
///  @param params The params for the quote, encoded as `QuoteExactInputSingleParams`
///  tokenIn The token being swapped in
///  tokenOut The token being swapped out
///  fee The fee of the token pool to consider for the pair
///  amountIn The desired input amount
///  sqrtPriceLimitX96 The price limit of the pool that cannot be exceeded by the swap
///  @return amountOut The amount of `tokenOut` that would be received
///  @return sqrtPriceX96After The sqrt price of the pool after the swap
///  @return initializedTicksCrossed The number of initialized ticks that the swap crossed
///  @return gasEstimate The estimate of the gas that the swap consumes
function quoteExactInputSingle(QuoteExactInputSingleParams memory params) external returns (uint256 amountOut, uint160 sqrtPriceX96After, uint32 initializedTicksCrossed, uint256 gasEstimate);;
```

### quoteExactOutput(bytes,uint256)

- **Signature**: `quoteExactOutput(bytes,uint256)`
- **Visibility**: external
- **Source Range**: 3323:280:152

**Signature:**
```solidity
/// @notice Returns the amount in required for a given exact output swap without executing the swap
///  @param path The path of the swap, i.e. each token pair and the pool fee. Path must be provided in reverse order
///  @param amountOut The amount of the last token to receive
///  @return amountIn The amount of first token required to be paid
///  @return sqrtPriceX96AfterList List of the sqrt price after the swap for each pool in the path
///  @return initializedTicksCrossedList List of the initialized ticks that the swap crossed for each pool in the path
///  @return gasEstimate The estimate of the gas that the swap consumes
function quoteExactOutput(bytes memory path, uint256 amountOut) external returns (uint256 amountIn, uint160[] memory sqrtPriceX96AfterList, uint32[] memory initializedTicksCrossedList, uint256 gasEstimate);;
```

### quoteExactOutputSingle(struct IQuoterV2.QuoteExactOutputSingleParams)

- **Signature**: `quoteExactOutputSingle(struct IQuoterV2.QuoteExactOutputSingleParams)`
- **Visibility**: external
- **Source Range**: 4631:208:152

**Signature:**
```solidity
/// @notice Returns the amount in required to receive the given exact output amount but for a swap of a single pool
///  @param params The params for the quote, encoded as `QuoteExactOutputSingleParams`
///  tokenIn The token being swapped in
///  tokenOut The token being swapped out
///  fee The fee of the token pool to consider for the pair
///  amountOut The desired output amount
///  sqrtPriceLimitX96 The price limit of the pool that cannot be exceeded by the swap
///  @return amountIn The amount required as the input for the swap in order to receive `amountOut`
///  @return sqrtPriceX96After The sqrt price of the pool after the swap
///  @return initializedTicksCrossed The number of initialized ticks that the swap crossed
///  @return gasEstimate The estimate of the gas that the swap consumes
function quoteExactOutputSingle(QuoteExactOutputSingleParams memory params) external returns (uint256 amountIn, uint160 sqrtPriceX96After, uint32 initializedTicksCrossed, uint256 gasEstimate);;
```
