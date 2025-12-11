# Function: sqrtPriceX96ToPrice(uint160)

**Contract**: [src/Zappers/Modules/Exchanges/UniV3Exchange.sol/contract_UniV3Exchange.md]

## Metadata

- **Contract**: UniV3Exchange
- **Signature**: `sqrtPriceX96ToPrice(uint160)`
- **Visibility**: public
- **Source Range**: 614:539:307
- **Inherited From**: UniPriceConverter

## Implementation

```solidity
function sqrtPriceX96ToPrice(uint160 _sqrtPriceX96) public pure returns (uint256 price) {
    uint256 squaredPrice = uint256(_sqrtPriceX96) * uint256(_sqrtPriceX96);
    if (squaredPrice > 115e57) {
        price = ((squaredPrice >> 96) * DECIMAL_PRECISION) >> 96;
    } else {
        price = (squaredPrice * DECIMAL_PRECISION) >> 192;
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniPriceConverter.sqrtPriceX96ToPrice(uint160) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
