# Function: owner()

**Contract**: [src/Dependencies/Ownable.sol/contract_Ownable.md]

## Metadata

- **Contract**: Ownable
- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1015:77:65

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
