# Function: getSuperTokenFactory()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `getSuperTokenFactory()`
- **Visibility**: external
- **Source Range**: 10558:154:163

## Implementation

```solidity
function getSuperTokenFactory() override external view returns (ISuperTokenFactory factory) {
    return _superTokenFactory;
}
```

## State Variable Reads

- **_superTokenFactory** (`contract ISuperTokenFactory`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperTokenFactory.sol/interface_ISuperTokenFactory.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.getSuperTokenFactory() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Get the super token factory
 @return factory The factory
