# Function: getAppCallbackLevel(contract ISuperApp)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `getAppCallbackLevel(contract ISuperApp)`
- **Visibility**: public
- **Source Range**: 17121:182:163

## Implementation

```solidity
function getAppCallbackLevel(ISuperApp appAddr) override public view returns (uint8) {
    return SuperAppDefinitions.getAppCallbackLevel(_appManifests[appAddr].configWord);
}
```

## Related Implementations

### getAppCallbackLevel(uint256)

- **Kind**: internal
- **Source**: 945:137:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperAppDefinitions:getAppCallbackLevel(uint256)`

```solidity
function getAppCallbackLevel(uint256 configWord) internal pure returns (uint8) {
    return uint8(configWord & APP_LEVEL_MASK);
}
```

## State Variable Reads

- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]
- **APP_LEVEL_MASK** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.getAppCallbackLevel(contract ISuperApp) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SuperAppDefinitions.getAppCallbackLevel(uint256) (NodeID: 1)
      💬 Args: [_appManifests[appAddr].configWord]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Query app callbacklevel
 @param app Super app address
