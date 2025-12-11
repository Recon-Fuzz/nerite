# Function: constructor(address)

**Contract**: [lib/V2-gov/src/utils/Ownable.sol/contract_Ownable.md]

## Metadata

- **Contract**: Ownable
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 806:133:37

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
