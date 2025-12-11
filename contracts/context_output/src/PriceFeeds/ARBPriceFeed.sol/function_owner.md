# Function: owner()

**Contract**: [src/PriceFeeds/ARBPriceFeed.sol/contract_ARBPriceFeed.md]

## Metadata

- **Contract**: ARBPriceFeed
- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1015:77:216
- **Inherited From**: Ownable

## Implementation

```solidity
///  @dev Returns the address of the current owner.
function owner() public view returns (address) {
    return _owner;
}
```

## State Variable Reads

- **_owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Ownable.owner() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns the address of the current owner.
