# Function: getAdmin()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `getAdmin()`
- **Visibility**: external
- **Source Range**: 6497:96:161

## Implementation

```solidity
function getAdmin() override external view returns (address) {
    return _getAdmin();
}
```

## Related Implementations

### _getAdmin()

- **Kind**: internal
- **Source**: 6599:170:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_getAdmin()`

```solidity
function _getAdmin() internal view returns (address admin) {
    assembly {
        admin := sload(_ADMIN_SLOT)
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.getAdmin() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperToken._getAdmin() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Returns the admin address for the SuperToken
