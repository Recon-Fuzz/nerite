# Function: constructor(string,string)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol/contract_ERC20.md]

## Metadata

- **Contract**: ERC20
- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 1980:113:7

## Implementation

```solidity
///  @dev Sets the values for {name} and {symbol}.
///  All two of these values are immutable: they can only be set once during
///  construction.
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

## State Variable Writes

- **_name** (`string`)
- **_symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: ERC20
```

## Documentation

### Function Documentation

 @dev Sets the values for {name} and {symbol}.
 All two of these values are immutable: they can only be set once during
 construction.
