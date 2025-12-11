# Function: getAppManifest(contract ISuperApp)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `getAppManifest(contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 17309:526:163

## Implementation

```solidity
function getAppManifest(ISuperApp app) override external view returns (bool isSuperApp, bool isJailed, uint256 noopMask) {
    AppManifest memory manifest = _appManifests[app];
    isSuperApp = (manifest.configWord > 0);
    if (isSuperApp) {
        isJailed = SuperAppDefinitions.isAppJailed(manifest.configWord);
        noopMask = manifest.configWord & SuperAppDefinitions.AGREEMENT_CALLBACK_NOOP_BITMASKS;
    }
}
```

## Related Implementations

### isAppJailed(uint256)

- **Kind**: internal
- **Source**: 1142:145:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperAppDefinitions:isAppJailed(uint256)`

```solidity
function isAppJailed(uint256 configWord) internal pure returns (bool) {
    return (configWord & SuperAppDefinitions.APP_JAIL_BIT) > 0;
}
```

## State Variable Reads

- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.getAppManifest(contract ISuperApp) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperAppDefinitions.isAppJailed(uint256) (NodeID: 1)
      💬 Args: [manifest.configWord]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Get the manifest of the super app
 @param app Super app address
