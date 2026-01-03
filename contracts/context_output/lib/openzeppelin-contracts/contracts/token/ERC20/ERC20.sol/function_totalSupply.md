# Function: totalSupply()

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol/contract_ERC20.md]

## Metadata

- **Contract**: ERC20
- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 3255:106:7

## Implementation

```solidity
///  @dev See {IERC20-totalSupply}.
function totalSupply() virtual override public view returns (uint256) {
    return _totalSupply;
}
```

## State Variable Reads

- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev See {IERC20-totalSupply}.

### Interface Documentation

 @dev Returns the amount of tokens in existence.
