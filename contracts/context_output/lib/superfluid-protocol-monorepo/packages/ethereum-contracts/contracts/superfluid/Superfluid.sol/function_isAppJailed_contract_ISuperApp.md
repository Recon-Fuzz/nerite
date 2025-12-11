# Function: isAppJailed(contract ISuperApp)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `isAppJailed(contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 17841:193:163

## Implementation

```solidity
function isAppJailed(ISuperApp app) override external view returns (bool) {
    return SuperAppDefinitions.isAppJailed(_appManifests[app].configWord);
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
┌─ [0] ⚙️ FUNCTION: Superfluid.isAppJailed(contract ISuperApp) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperAppDefinitions.isAppJailed(uint256) (NodeID: 1)
      💬 Args: [_appManifests[app].configWord]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Query if the app has been jailed
 @param app Super app address
