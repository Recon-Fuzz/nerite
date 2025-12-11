# Function: allowCompositeApp(contract ISuperApp)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `allowCompositeApp(contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 18040:498:163

## Implementation

```solidity
function allowCompositeApp(ISuperApp targetApp) override external {
    ISuperApp sourceApp = ISuperApp(msg.sender);
    if (!isApp(sourceApp)) revert HOST_SENDER_IS_NOT_SUPER_APP();
    if (!isApp(targetApp)) revert HOST_RECEIVER_IS_NOT_SUPER_APP();
    if (getAppCallbackLevel(sourceApp) <= getAppCallbackLevel(targetApp)) {
        revert HOST_SOURCE_APP_NEEDS_HIGHER_APP_LEVEL();
    }
    _compositeApps[sourceApp][targetApp] = true;
}
```

## Related Implementations

### isApp(contract ISuperApp)

- **Kind**: internal
- **Source**: 16993:122:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:isApp(contract ISuperApp)`

```solidity
function isApp(ISuperApp app) override public view returns (bool) {
    return _appManifests[app].configWord > 0;
}
```

### getAppCallbackLevel(contract ISuperApp)

- **Kind**: internal
- **Source**: 17121:182:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:getAppCallbackLevel(contract ISuperApp)`

```solidity
function getAppCallbackLevel(ISuperApp appAddr) override public view returns (uint8) {
    return SuperAppDefinitions.getAppCallbackLevel(_appManifests[appAddr].configWord);
}
```

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

## State Variable Writes

- **_compositeApps** (`mapping(contract ISuperApp => mapping(contract ISuperApp => bool))`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.allowCompositeApp(contract ISuperApp) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Superfluid.isApp(contract ISuperApp) (NodeID: 1)
  │   💬 Args: [sourceApp]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Superfluid.isApp(contract ISuperApp) (NodeID: 2)
  │   💬 Args: [targetApp]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Superfluid.getAppCallbackLevel(contract ISuperApp) (NodeID: 3)
  │   💬 Args: [targetApp]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: SuperAppDefinitions.getAppCallbackLevel(uint256) (NodeID: 4)
  │     💬 Args: [_appManifests[appAddr].configWord]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Superfluid.getAppCallbackLevel(contract ISuperApp) (NodeID: 5)
      💬 Args: [sourceApp]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: SuperAppDefinitions.getAppCallbackLevel(uint256) (NodeID: 6)
        💬 Args: [_appManifests[appAddr].configWord]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Whitelist the target app for app composition for the source app (msg.sender)
 @param targetApp The target super app address
