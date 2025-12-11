# Function: registerApp(contract ISuperApp,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `registerApp(contract ISuperApp,uint256)`
- **Visibility**: external
- **Source Range**: 14056:362:163

## Implementation

```solidity
/// @inheritdoc ISuperfluid
function registerApp(ISuperApp app, uint256 configWord) override external {
    if ((address(app)).code.length == 0) revert HOST_MUST_BE_CONTRACT();
    if (APP_WHITE_LISTING_ENABLED) {
        _enforceAppRegistrationPermissioning("k1", msg.sender);
    }
    _registerApp(app, configWord);
}
```

## Related Implementations

### _enforceAppRegistrationPermissioning(string,address)

- **Kind**: internal
- **Source**: 14881:685:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_enforceAppRegistrationPermissioning(string,address)`

```solidity
function _enforceAppRegistrationPermissioning(string memory registrationKey, address deployer) internal view {
    bytes32 configKey = SuperfluidGovernanceConfigs.getAppRegistrationConfigKey(deployer, registrationKey);
    if (_gov.getConfigAsUint256(this, ISuperfluidToken(address(0)), configKey) < block.timestamp) {
        revert HOST_NO_APP_REGISTRATION_PERMISSION();
    }
}
```

### getAppRegistrationConfigKey(address,string)

- **Kind**: internal
- **Source**: 11297:308:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperfluidGovernanceConfigs:getAppRegistrationConfigKey(address,string)`

```solidity
function getAppRegistrationConfigKey(address deployer, string memory registrationKey) internal pure returns (bytes32) {
    return keccak256(abi.encode("org.superfluid-finance.superfluid.appWhiteListing.registrationKey", deployer, registrationKey));
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
┌─ [0] ⚙️ FUNCTION: Superfluid.registerApp(contract ISuperApp,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Superfluid._enforceAppRegistrationPermissioning(string,address) (NodeID: 1)
  │   💬 Args: ["k1", msg.sender]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.getAppRegistrationConfigKey(address,string) (NodeID: 2)
  │     💬 Args: [deployer, registrationKey]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Superfluid._registerApp(contract ISuperApp,uint256) (NodeID: 3)
      💬 Args: [app, configWord]
      👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: SuperAppDefinitions.getAppCallbackLevel(uint256) (NodeID: 4)
    │   💬 Args: [configWord]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperAppDefinitions.isConfigWordClean(uint256) (NodeID: 5)
        💬 Args: [configWord]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluid

### Interface Documentation

 @dev Registers an app (must be a contract) as a super app.
 @param app The super app address
 @param configWord The super app manifest configuration, flags are defined in
 `SuperAppDefinitions`
 @notice On some mainnet deployments, pre-authorization by governance may be needed for this to succeed.
 See https://github.com/superfluid-finance/protocol-monorepo/wiki/Super-App-White-listing-Guide
