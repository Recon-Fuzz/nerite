# Contract: LibString

## Metadata

- **Name**: LibString
- **Type**: Contract
- **Path**: lib/Solady/src/utils/LibString.sol
- **Documentation**: @notice Library for converting numbers into strings and other string operations.
   @author Solady (https://github.com/vectorized/solady/blob/main/src/utils/LibString.sol)
   @author Modified from Solmate (https://github.com/transmissions11/solmate/blob/main/src/utils/LibString.sol)
   @dev Note:
   For performance and bytecode compactness, most of the string operations are restricted to
   byte strings (7-bit ASCII), except where otherwise specified.
   Usage of byte string operations on charsets with runes spanning two or more bytes
   can lead to undefined behavior.

## State Variables

### NOT_FOUND

```solidity
/// @dev The constant returned when the `search` is not found in the string.
uint256 internal constant NOT_FOUND = type(uint256).max
```

### ALPHANUMERIC_7_BIT_ASCII

```solidity
/// @dev Lookup for '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.
uint128 internal constant ALPHANUMERIC_7_BIT_ASCII = 0x7fffffe07fffffe03ff000000000000
```

### LETTERS_7_BIT_ASCII

```solidity
/// @dev Lookup for 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.
uint128 internal constant LETTERS_7_BIT_ASCII = 0x7fffffe07fffffe0000000000000000
```

### LOWERCASE_7_BIT_ASCII

```solidity
/// @dev Lookup for 'abcdefghijklmnopqrstuvwxyz'.
uint128 internal constant LOWERCASE_7_BIT_ASCII = 0x7fffffe000000000000000000000000
```

### UPPERCASE_7_BIT_ASCII

```solidity
/// @dev Lookup for 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
uint128 internal constant UPPERCASE_7_BIT_ASCII = 0x7fffffe0000000000000000
```

### DIGITS_7_BIT_ASCII

```solidity
/// @dev Lookup for '0123456789'.
uint128 internal constant DIGITS_7_BIT_ASCII = 0x3ff000000000000
```

### HEXDIGITS_7_BIT_ASCII

```solidity
/// @dev Lookup for '0123456789abcdefABCDEF'.
uint128 internal constant HEXDIGITS_7_BIT_ASCII = 0x7e0000007e03ff000000000000
```

### OCTDIGITS_7_BIT_ASCII

```solidity
/// @dev Lookup for '01234567'.
uint128 internal constant OCTDIGITS_7_BIT_ASCII = 0xff000000000000
```

### PRINTABLE_7_BIT_ASCII

```solidity
/// @dev Lookup for '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c'.
uint128 internal constant PRINTABLE_7_BIT_ASCII = 0x7fffffffffffffffffffffff00003e00
```

### PUNCTUATION_7_BIT_ASCII

```solidity
/// @dev Lookup for '!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'.
uint128 internal constant PUNCTUATION_7_BIT_ASCII = 0x78000001f8000001fc00fffe00000000
```

### WHITESPACE_7_BIT_ASCII

```solidity
/// @dev Lookup for ' \t\n\r\x0b\x0c'.
uint128 internal constant WHITESPACE_7_BIT_ASCII = 0x100003e00
```

## Errors

### HexLengthInsufficient

```solidity
/// @dev The length of the output is too small to contain all the hex digits.
error HexLengthInsufficient();
```

### TooBigForSmallString

```solidity
/// @dev The length of the string is more than 32 bytes.
error TooBigForSmallString();
```

### StringNot7BitASCII

```solidity
/// @dev The input string must be a 7-bit ASCII.
error StringNot7BitASCII();
```
