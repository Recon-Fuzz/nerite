# Function: getSuperTokenLogic()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

## Metadata

- **Contract**: SuperTokenFactory
- **Signature**: `getSuperTokenLogic()`
- **Visibility**: external
- **Source Range**: 6767:137:162
- **Inherited From**: SuperTokenFactoryBase

## Implementation

```solidity
/// @inheritdoc ISuperTokenFactory
function getSuperTokenLogic() override external view returns (ISuperToken) {
    return _SUPER_TOKEN_LOGIC;
}
```

## State Variable Reads

- **_SUPER_TOKEN_LOGIC** (`contract ISuperToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperTokenFactoryBase.getSuperTokenLogic() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperTokenFactory

### Interface Documentation

 @notice Get the canonical super token logic.
