# Contract: json

## Metadata

- **Name**: json
- **Type**: Contract
- **Path**: src/NFTMetadata/utils/JSON.sol

## State Variables

### DOUBLE_QUOTES

```solidity
/// @dev JSON requires that double quotes be escaped or JSONs will not build correctly
///  string.concat also requires an escape, use \\" or the constant DOUBLE_QUOTES to represent " in JSON
string internal constant DOUBLE_QUOTES = "\\\""
```

### _TABLE

```solidity
///  taken from Openzeppelin
///  @dev Base64 Encoding/Decoding Table
string internal constant _TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
```
