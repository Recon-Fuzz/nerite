# Function: getHost()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

## Metadata

- **Contract**: SuperTokenFactory
- **Signature**: `getHost()`
- **Visibility**: external
- **Source Range**: 4558:146:162
- **Inherited From**: SuperTokenFactoryBase

## Implementation

```solidity
/// @inheritdoc ISuperTokenFactory
function getHost() override(ISuperTokenFactory) external view returns (address host) {
    return address(_host);
}
```

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperTokenFactoryBase.getHost() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperTokenFactory

### Interface Documentation

 @dev Get superfluid host contract address
