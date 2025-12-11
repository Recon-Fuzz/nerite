# Function: set(string,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/Resolver.sol/contract_Resolver.md]

## Metadata

- **Contract**: Resolver
- **Signature**: `set(string,address)`
- **Visibility**: external
- **Source Range**: 716:228:178

## Implementation

```solidity
function set(string calldata name, address target) override external {
    require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Caller is not an admin");
    _registry[name] = target;
    emit Set(name, target);
}
```

## Related Implementations

### hasRole(bytes32,address)

- **Kind**: internal
- **Source**: 3021:145:67
- **Link**: `lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:hasRole(bytes32,address)`

```solidity
///  @dev Returns `true` if `account` has been granted `role`.
function hasRole(bytes32 role, address account) virtual override public view returns (bool) {
    return _roles[role].members[account];
}
```

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:104
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

## State Variable Reads

- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## State Variable Writes

- **_registry** (`mapping(string => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Resolver.set(string,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 1)
      💬 Args: [DEFAULT_ADMIN_ROLE, _msgSender()]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Set resolver address name
