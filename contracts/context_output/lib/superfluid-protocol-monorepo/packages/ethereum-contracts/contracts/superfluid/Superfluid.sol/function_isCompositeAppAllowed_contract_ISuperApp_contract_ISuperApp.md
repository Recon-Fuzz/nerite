# Function: isCompositeAppAllowed(contract ISuperApp,contract ISuperApp)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `isCompositeAppAllowed(contract ISuperApp,contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 18544:201:163

## Implementation

```solidity
function isCompositeAppAllowed(ISuperApp app, ISuperApp targetApp) override external view returns (bool) {
    return _compositeApps[app][targetApp];
}
```

## State Variable Reads

- **_compositeApps** (`mapping(contract ISuperApp => mapping(contract ISuperApp => bool))`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.isCompositeAppAllowed(contract ISuperApp,contract ISuperApp) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Query if source app is allowed to call the target app as downstream app
 @param app Super app address
 @param targetApp The target super app address
