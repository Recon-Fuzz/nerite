# Function: isApp(contract ISuperApp)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `isApp(contract ISuperApp)`
- **Visibility**: public
- **Source Range**: 16993:122:163

## Implementation

```solidity
function isApp(ISuperApp app) override public view returns (bool) {
    return _appManifests[app].configWord > 0;
}
```

## State Variable Reads

- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.isApp(contract ISuperApp) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Query if the app is registered
 @param app Super app address
