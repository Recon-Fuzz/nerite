# Contract: UniPriceConverter

## Metadata

- **Name**: UniPriceConverter
- **Type**: Contract
- **Path**: src/Zappers/Modules/Exchanges/UniswapV3/UniPriceConverter.sol

## Public/External Functions

### priceToSqrtPriceX96(uint256)

- **Signature**: `priceToSqrtPriceX96(uint256)`
- **Visibility**: public
- **Source Range**: 230:378:156
- **Details**: [function_priceToSqrtPriceX96_uint256.md](./function_priceToSqrtPriceX96_uint256.md)

**Signature:**
```solidity
function priceToSqrtPriceX96(uint256 _price) public pure returns (uint160 sqrtPriceX96);
```

### sqrtPriceX96ToPrice(uint160)

- **Signature**: `sqrtPriceX96ToPrice(uint160)`
- **Visibility**: public
- **Source Range**: 614:539:156
- **Details**: [function_sqrtPriceX96ToPrice_uint160.md](./function_sqrtPriceX96ToPrice_uint160.md)

**Signature:**
```solidity
function sqrtPriceX96ToPrice(uint160 _sqrtPriceX96) public pure returns (uint256 price);
```
