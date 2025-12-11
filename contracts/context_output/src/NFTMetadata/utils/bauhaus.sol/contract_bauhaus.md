# Contract: bauhaus

## Metadata

- **Name**: bauhaus
- **Type**: Contract
- **Path**: src/NFTMetadata/utils/bauhaus.sol

## State Variables

### GOLDEN

```solidity
string internal constant GOLDEN = "#F5D93A"
```

### CORAL

```solidity
string internal constant CORAL = "#FB7C59"
```

### GREEN

```solidity
string internal constant GREEN = "#63D77D"
```

### CYAN

```solidity
string internal constant CYAN = "#95CBF3"
```

### BLUE

```solidity
string internal constant BLUE = "#405AE5"
```

### DARK_BLUE

```solidity
string internal constant DARK_BLUE = "#121B44"
```

### BROWN

```solidity
string internal constant BROWN = "#D99664"
```

## Structs

### COLORS

```solidity
struct COLORS {
    colorCode rect1;
    colorCode rect2;
    colorCode rect3;
    colorCode rect4;
    colorCode rect5;
    colorCode poly;
    colorCode circle1;
    colorCode circle2;
    colorCode circle3;
}
```

## Enums

### colorCode

```solidity
enum colorCode {
    GOLDEN,
    CORAL,
    GREEN,
    CYAN,
    BLUE,
    DARK_BLUE,
    BROWN
}
```
