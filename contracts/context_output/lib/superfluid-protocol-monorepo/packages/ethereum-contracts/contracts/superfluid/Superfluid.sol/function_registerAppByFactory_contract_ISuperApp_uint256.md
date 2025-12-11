# Function: registerAppByFactory(contract ISuperApp,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `registerAppByFactory(contract ISuperApp,uint256)`
- **Visibility**: external
- **Source Range**: 15599:792:163

## Implementation

```solidity
/// @custom:deprecated
function registerAppByFactory(ISuperApp app, uint256 configWord) override external {
    if ((address(app)).code.length == 0) revert HOST_MUST_BE_CONTRACT();
    if (APP_WHITE_LISTING_ENABLED) {
        bytes32 configKey = SuperfluidGovernanceConfigs.getAppFactoryConfigKey(msg.sender);
        bool isAuthorizedAppFactory = _gov.getConfigAsUint256(this, ISuperfluidToken(address(0)), configKey) == 1;
        if (!isAuthorizedAppFactory) revert HOST_NO_APP_REGISTRATION_PERMISSION();
    }
    _registerApp(app, configWord);
}
```

## Related Implementations

### getAppFactoryConfigKey(address)

- **Kind**: internal
- **Source**: 11611:225:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperfluidGovernanceConfigs:getAppFactoryConfigKey(address)`

```solidity
function getAppFactoryConfigKey(address factory) internal pure returns (bytes32) {
    return keccak256(abi.encode("org.superfluid-finance.superfluid.appWhiteListing.factory", factory));
}
```

### _registerApp(contract ISuperApp,uint256)

- **Kind**: internal
- **Source**: 16397:590:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_registerApp(contract ISuperApp,uint256)`

```solidity
function _registerApp(ISuperApp app, uint256 configWord) private {
    if (((!SuperAppDefinitions.isConfigWordClean(configWord)) || (SuperAppDefinitions.getAppCallbackLevel(configWord) == 0)) || ((configWord & SuperAppDefinitions.APP_JAIL_BIT) != 0)) {
        revert HOST_INVALID_CONFIG_WORD();
    }
    if (_appManifests[ISuperApp(app)].configWord != 0) revert HOST_SUPER_APP_ALREADY_REGISTERED();
    _appManifests[ISuperApp(app)] = AppManifest(configWord);
    emit AppRegistered(app);
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

### isConfigWordClean(uint256)

- **Kind**: internal
- **Source**: 2958:196:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperAppDefinitions:isConfigWordClean(uint256)`

```solidity
function isConfigWordClean(uint256 configWord) internal pure returns (bool) {
    return (configWord & (~((APP_LEVEL_MASK | APP_JAIL_BIT) | AGREEMENT_CALLBACK_NOOP_BITMASKS))) == uint256(0);
}
```

## External Calls

- **ISuperfluidGovernance::getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)**

## State Variable Reads

- **APP_WHITE_LISTING_ENABLED** (`bool`)
- **_gov** (`contract ISuperfluidGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol/interface_ISuperfluidGovernance.md]
- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]
- **APP_LEVEL_MASK** (`uint256`)
- **APP_JAIL_BIT** (`uint256`)
- **AGREEMENT_CALLBACK_NOOP_BITMASKS** (`uint256`)

## State Variable Writes

- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.registerAppByFactory(contract ISuperApp,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.getAppFactoryConfigKey(address) (NodeID: 1)
  │   💬 Args: [msg.sender]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Superfluid._registerApp(contract ISuperApp,uint256) (NodeID: 2)
      💬 Args: [app, configWord]
      👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: SuperAppDefinitions.getAppCallbackLevel(uint256) (NodeID: 3)
    │   💬 Args: [configWord]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperAppDefinitions.isConfigWordClean(uint256) (NodeID: 4)
        💬 Args: [configWord]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@custom:deprecated

### Interface Documentation

 @dev DO NOT USE for new deployments
 @custom:deprecated you should use `registerApp(ISuperApp app, uint256 configWord) instead.
