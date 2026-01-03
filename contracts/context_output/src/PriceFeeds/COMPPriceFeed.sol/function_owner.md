# Function: owner()

**Contract**: [src/PriceFeeds/COMPPriceFeed.sol/contract_COMPPriceFeed.md]

## Metadata

- **Contract**: COMPPriceFeed
- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1015:77:65
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
