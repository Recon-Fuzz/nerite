# Function: hasRole(bytes32,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol/contract_TestResolver.md]

## Metadata

- **Contract**: TestResolver
- **Signature**: `hasRole(bytes32,address)`
- **Visibility**: public
- **Source Range**: 3021:145:67
- **Inherited From**: AccessControl

## Implementation

```solidity
///  @dev Returns `true` if `account` has been granted `role`.
function hasRole(bytes32 role, address account) virtual override public view returns (bool) {
    return _roles[role].members[account];
}
```

## State Variable Reads

- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns `true` if `account` has been granted `role`.

### Interface Documentation

 @dev Returns `true` if `account` has been granted `role`.
