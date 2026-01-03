# Function: priceToSqrtPrice(contract IBoldToken,contract IERC20,uint256)

**Contract**: [src/Zappers/Modules/Exchanges/UniV3Exchange.sol/contract_UniV3Exchange.md]

## Metadata

- **Contract**: UniV3Exchange
- **Signature**: `priceToSqrtPrice(contract IBoldToken,contract IERC20,uint256)`
- **Visibility**: public
- **Source Range**: 3178:327:149

## Implementation

```solidity
function priceToSqrtPrice(IBoldToken _boldToken, IERC20 _collToken, uint256 _price) public pure returns (uint160) {
    uint256 price = _zeroForOne(_boldToken, _collToken) ? ((DECIMAL_PRECISION * DECIMAL_PRECISION) / _price) : _price;
    return priceToSqrtPriceX96(price);
}
```

## Related Implementations

### _zeroForOne(contract IBoldToken,contract IERC20)

- **Kind**: internal
- **Source**: 3616:157:149
- **Link**: `src/Zappers/Modules/Exchanges/UniV3Exchange.sol:UniV3Exchange:_zeroForOne(contract IBoldToken,contract IERC20)`

```solidity
function _zeroForOne(IBoldToken _boldToken, IERC20 _collToken) internal pure returns (bool) {
    return address(_boldToken) < address(_collToken);
}
```

### priceToSqrtPriceX96(uint256)

- **Kind**: internal
- **Source**: 230:378:156
- **Link**: `src/Zappers/Modules/Exchanges/UniswapV3/UniPriceConverter.sol:UniPriceConverter:priceToSqrtPriceX96(uint256)`

```solidity
function priceToSqrtPriceX96(uint256 _price) public pure returns (uint160 sqrtPriceX96) {
    if (_price > (1 << 64)) {
        sqrtPriceX96 = uint160(Math.sqrt(_price / DECIMAL_PRECISION) << 96);
    } else {
        sqrtPriceX96 = uint160(Math.sqrt((_price << 192) / DECIMAL_PRECISION));
    }
}
```

### sqrt(uint256)

- **Kind**: internal
- **Source**: 6530:1642:29
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:sqrt(uint256)`

```solidity
///  @dev Returns the square root of a number. If the number is not a perfect square, the value is rounded down.
///  Inspired by Henry S. Warren, Jr.'s "Hacker's Delight" (Chapter 11).
function sqrt(uint256 a) internal pure returns (uint256) {
    if (a == 0) {
        return 0;
    }
    uint256 result = 1 << (log2(a) >> 1);
    unchecked {
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        result = (result + (a / result)) >> 1;
        return min(result, a / result);
    }
}
```

### log2(uint256)

- **Kind**: internal
- **Source**: 8633:983:29
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log2(uint256)`

```solidity
///  @dev Return the log in base 2, rounded down, of a positive value.
///  Returns 0 if given 0.
function log2(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if ((value >> 128) > 0) {
            value >>= 128;
            result += 128;
        }
        if ((value >> 64) > 0) {
            value >>= 64;
            result += 64;
        }
        if ((value >> 32) > 0) {
            value >>= 32;
            result += 32;
        }
        if ((value >> 16) > 0) {
            value >>= 16;
            result += 16;
        }
        if ((value >> 8) > 0) {
            value >>= 8;
            result += 8;
        }
        if ((value >> 4) > 0) {
            value >>= 4;
            result += 4;
        }
        if ((value >> 2) > 0) {
            value >>= 2;
            result += 2;
        }
        if ((value >> 1) > 0) {
            result += 1;
        }
    }
    return result;
}
```

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 588:104:29
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV3Exchange.priceToSqrtPrice(contract IBoldToken,contract IERC20,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: UniV3Exchange._zeroForOne(contract IBoldToken,contract IERC20) (NodeID: 1)
  │   💬 Args: [_boldToken, _collToken]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: UniPriceConverter.priceToSqrtPriceX96(uint256) (NodeID: 2)
      💬 Args: [price]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: Math.sqrt(uint256) (NodeID: 3)
    │   💬 Args: [_price / DECIMAL_PRECISION]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Math.log2(uint256) (NodeID: 4)
    │ │   💬 Args: [a]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 5)
    │     💬 Args: [result, a / result]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Math.sqrt(uint256) (NodeID: 6)
        💬 Args: [(_price << 192) / DECIMAL_PRECISION]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Math.log2(uint256) (NodeID: 7)
      │   💬 Args: [a]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 8)
          💬 Args: [result, a / result]
          👁️  Def: internal
```
