# Function: isOwner()

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `isOwner()`
- **Visibility**: public
- **Source Range**: 1366:90:37
- **Inherited From**: Ownable

## Implementation

```solidity
///  @dev Returns true if the caller is the current owner.
function isOwner() public view returns (bool) {
    return msg.sender == _owner;
}
```

## State Variable Reads

- **_owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Ownable.isOwner() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns true if the caller is the current owner.
