# Function: owner()

**Contract**: [src/PriceFeeds/UNIPriceFeed.sol/contract_UNIPriceFeed.md]

## Metadata

- **Contract**: UNIPriceFeed
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
