# Function: owner()

**Contract**: [lib/openzeppelin-contracts/contracts/proxy/beacon/UpgradeableBeacon.sol/contract_UpgradeableBeacon.md]

## Metadata

- **Contract**: UpgradeableBeacon
- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1201:85:71
- **Inherited From**: Ownable

## Implementation

```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address) {
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
