# Function: initializeCustomSuperToken(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

## Metadata

- **Contract**: SuperTokenFactory
- **Signature**: `initializeCustomSuperToken(address)`
- **Visibility**: external
- **Source Range**: 11899:454:162
- **Inherited From**: SuperTokenFactoryBase

## Implementation

```solidity
/// @inheritdoc ISuperTokenFactory
function initializeCustomSuperToken(address customSuperTokenProxy) override external {
    address payable a = payable(address(uint160(customSuperTokenProxy)));
    UUPSProxy(a).initializeProxy(address(_SUPER_TOKEN_LOGIC));
    emit CustomSuperTokenCreated(ISuperToken(customSuperTokenProxy));
}
```

## External Calls

- **UUPSProxy::initializeProxy(address)**

## State Variable Reads

- **_SUPER_TOKEN_LOGIC** (`contract ISuperToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperTokenFactoryBase.initializeCustomSuperToken(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperTokenFactory

### Interface Documentation

 @dev Creates a new custom super token
 @param customSuperTokenProxy address of the custom supertoken proxy
