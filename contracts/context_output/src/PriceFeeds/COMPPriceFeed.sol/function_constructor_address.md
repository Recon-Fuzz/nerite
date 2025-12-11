# Function: constructor(address)

**Contract**: [src/PriceFeeds/COMPPriceFeed.sol/contract_COMPPriceFeed.md]

## Metadata

- **Contract**: COMPPriceFeed
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 806:133:216
- **Inherited From**: Ownable

## Implementation

```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner) {
    _owner = initialOwner;
    emit OwnershipTransferred(address(0), initialOwner);
}
```

## State Variable Writes

- **_owner** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: Ownable
```

## Documentation

### Function Documentation

 @dev Initializes the contract setting `initialOwner` as the initial owner.
