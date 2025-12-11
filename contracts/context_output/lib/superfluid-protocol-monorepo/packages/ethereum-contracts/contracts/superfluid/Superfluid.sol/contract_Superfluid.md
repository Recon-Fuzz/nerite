# Contract: Superfluid

## Metadata

- **Name**: Superfluid
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol
- **Documentation**:  @dev The Superfluid host implementation.
   NOTE:
   - Please read ISuperfluid for implementation notes.
   - For some deeper technical notes, please visit protocol-monorepo wiki area.
   @author Superfluid

## Implements Interfaces

- **IRelayRecipient** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/utils/IRelayRecipient.sol/interface_IRelayRecipient.md]
- **ISuperfluid** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## State Variables

### _initialized (inherited from Initializable)

```solidity
///  @dev Indicates that the contract has been initialized.
///  @custom:oz-retyped-from bool
uint8 private _initialized
```

### _initializing (inherited from Initializable)

```solidity
///  @dev Indicates that the contract is in the process of being initialized.
bool private _initializing
```

### NON_UPGRADABLE_DEPLOYMENT

```solidity
bool public immutable NON_UPGRADABLE_DEPLOYMENT
```

### APP_WHITE_LISTING_ENABLED

```solidity
bool public immutable APP_WHITE_LISTING_ENABLED
```

### CALLBACK_GAS_LIMIT

```solidity
uint64 public immutable CALLBACK_GAS_LIMIT
```

### SIMPLE_FORWARDER

```solidity
SimpleForwarder public immutable SIMPLE_FORWARDER
```

**SimpleForwarder**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SimpleForwarder.sol/contract_SimpleForwarder.md]

### _ERC2771_FORWARDER

```solidity
ERC2771Forwarder internal immutable _ERC2771_FORWARDER
```

**ERC2771Forwarder**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/ERC2771Forwarder.sol/contract_ERC2771Forwarder.md]

### MAX_APP_CALLBACK_LEVEL

```solidity
///  @dev Maximum number of level of apps can be composed together
///  NOTE:
///  - TODO Composite app feature is currently disabled. Hence app cannot
///    will not be able to call other app.
uint public constant MAX_APP_CALLBACK_LEVEL = 1
```

### MAX_NUM_AGREEMENTS

```solidity
uint32 public constant MAX_NUM_AGREEMENTS = 256
```

### _gov

```solidity
/// @dev Governance contract
ISuperfluidGovernance internal _gov
```

**ISuperfluidGovernance**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol/interface_ISuperfluidGovernance.md]

### _agreementClasses

```solidity
/// @dev Agreement list indexed by agreement index minus one
ISuperAgreement[] internal _agreementClasses
```

**ISuperAgreement**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]

### _agreementClassIndices

```solidity
/// @dev Mapping between agreement type to agreement index (starting from 1)
mapping(bytes32 => uint) internal _agreementClassIndices
```

### _superTokenFactory

```solidity
/// @dev Super token
ISuperTokenFactory internal _superTokenFactory
```

**ISuperTokenFactory**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperTokenFactory.sol/interface_ISuperTokenFactory.md]

### _appManifests

```solidity
/// @dev App manifests
mapping(ISuperApp => AppManifest) internal _appManifests
```

**ISuperApp**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]

### _compositeApps

```solidity
/// @dev Composite app white-listing: source app => (target app => isAllowed)
mapping(ISuperApp => mapping(ISuperApp => bool)) internal _compositeApps
```

**ISuperApp**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]

### _ctxStamp

```solidity
/// @dev Ctx stamp of the current transaction, it should always be cleared to
///       zero before transaction finishes
bytes32 internal _ctxStamp
```

### _appKeysUsedDeprecated

```solidity
/// @dev if app whitelisting is enabled, this is to make sure the keys are used only once
mapping(bytes32 => bool) internal _appKeysUsedDeprecated
```

## Structs

### Context (inherited from ISuperfluid)

```solidity
///  @dev Context Struct
///  @custom:note on backward compatibility:
///  - Non-dynamic fields are padded to 32bytes and packed
///  - Dynamic fields are referenced through a 32bytes offset to their "parents" field (or root)
///  - The order of the fields hence should not be rearranged in order to be backward compatible:
///     - non-dynamic fields will be parsed at the same memory location,
///     - and dynamic fields will simply have a greater offset than it was.
///  - We cannot change the structure of the Context struct because of ABI compatibility requirements
struct Context {
    uint8 appCallbackLevel;
    uint8 callType;
    uint256 timestamp;
    address msgSender;
    bytes4 agreementSelector;
    bytes userData;
    uint256 appCreditGranted;
    uint256 appCreditWantedDeprecated;
    int256 appCreditUsed;
    address appAddress;
    ISuperfluidToken appCreditToken;
}
```

### Operation (inherited from ISuperfluid)

```solidity
///  @dev Batch operation data
struct Operation {
    uint32 operationType;
    address target;
    bytes data;
}
```

### AppManifest

```solidity
struct AppManifest {
    uint256 configWord;
}
```

## Errors

### HOST_AGREEMENT_CALLBACK_IS_NOT_ACTION (inherited from ISuperfluid)

```solidity
error HOST_AGREEMENT_CALLBACK_IS_NOT_ACTION();
```

### HOST_CANNOT_DOWNGRADE_TO_NON_UPGRADEABLE (inherited from ISuperfluid)

```solidity
error HOST_CANNOT_DOWNGRADE_TO_NON_UPGRADEABLE();
```

### HOST_CALL_AGREEMENT_WITH_CTX_FROM_WRONG_ADDRESS (inherited from ISuperfluid)

```solidity
error HOST_CALL_AGREEMENT_WITH_CTX_FROM_WRONG_ADDRESS();
```

### HOST_CALL_APP_ACTION_WITH_CTX_FROM_WRONG_ADDRESS (inherited from ISuperfluid)

```solidity
error HOST_CALL_APP_ACTION_WITH_CTX_FROM_WRONG_ADDRESS();
```

### HOST_INVALID_CONFIG_WORD (inherited from ISuperfluid)

```solidity
error HOST_INVALID_CONFIG_WORD();
```

### HOST_MAX_256_AGREEMENTS (inherited from ISuperfluid)

```solidity
error HOST_MAX_256_AGREEMENTS();
```

### HOST_NON_UPGRADEABLE (inherited from ISuperfluid)

```solidity
error HOST_NON_UPGRADEABLE();
```

### HOST_NON_ZERO_LENGTH_PLACEHOLDER_CTX (inherited from ISuperfluid)

```solidity
error HOST_NON_ZERO_LENGTH_PLACEHOLDER_CTX();
```

### HOST_ONLY_GOVERNANCE (inherited from ISuperfluid)

```solidity
error HOST_ONLY_GOVERNANCE();
```

### HOST_UNKNOWN_BATCH_CALL_OPERATION_TYPE (inherited from ISuperfluid)

```solidity
error HOST_UNKNOWN_BATCH_CALL_OPERATION_TYPE();
```

### HOST_AGREEMENT_ALREADY_REGISTERED (inherited from ISuperfluid)

```solidity
error HOST_AGREEMENT_ALREADY_REGISTERED();
```

### HOST_AGREEMENT_IS_NOT_REGISTERED (inherited from ISuperfluid)

```solidity
error HOST_AGREEMENT_IS_NOT_REGISTERED();
```

### HOST_MUST_BE_CONTRACT (inherited from ISuperfluid)

```solidity
error HOST_MUST_BE_CONTRACT();
```

### HOST_ONLY_LISTED_AGREEMENT (inherited from ISuperfluid)

```solidity
error HOST_ONLY_LISTED_AGREEMENT();
```

### HOST_NEED_MORE_GAS (inherited from ISuperfluid)

```solidity
error HOST_NEED_MORE_GAS();
```

### APP_RULE (inherited from ISuperfluid)

```solidity
error APP_RULE(uint256 _code);
```

### HOST_NOT_A_SUPER_APP (inherited from ISuperfluid)

```solidity
error HOST_NOT_A_SUPER_APP();
```

### HOST_NO_APP_REGISTRATION_PERMISSION (inherited from ISuperfluid)

```solidity
error HOST_NO_APP_REGISTRATION_PERMISSION();
```

### HOST_RECEIVER_IS_NOT_SUPER_APP (inherited from ISuperfluid)

```solidity
error HOST_RECEIVER_IS_NOT_SUPER_APP();
```

### HOST_SENDER_IS_NOT_SUPER_APP (inherited from ISuperfluid)

```solidity
error HOST_SENDER_IS_NOT_SUPER_APP();
```

### HOST_SOURCE_APP_NEEDS_HIGHER_APP_LEVEL (inherited from ISuperfluid)

```solidity
error HOST_SOURCE_APP_NEEDS_HIGHER_APP_LEVEL();
```

### HOST_SUPER_APP_IS_JAILED (inherited from ISuperfluid)

```solidity
error HOST_SUPER_APP_IS_JAILED();
```

### HOST_SUPER_APP_ALREADY_REGISTERED (inherited from ISuperfluid)

```solidity
error HOST_SUPER_APP_ALREADY_REGISTERED();
```

## Events

### Initialized (inherited from Initializable)

```solidity
///  @dev Triggered when the contract has been initialized or reinitialized.
event Initialized(uint8 version);
```

### CodeUpdated (inherited from UUPSProxiable)

```solidity
event CodeUpdated(bytes32 uuid, address codeAddress);
```

### GovernanceReplaced (inherited from ISuperfluid)

```solidity
///  @dev Governance replaced event
///  @param oldGov Address of the old governance contract
///  @param newGov Address of the new governance contract
event GovernanceReplaced(ISuperfluidGovernance oldGov, ISuperfluidGovernance newGov);
```

### AgreementClassRegistered (inherited from ISuperfluid)

```solidity
///  @notice Agreement class registered event
///  @dev agreementType is the keccak256 hash of: "org.superfluid-finance.agreements.<AGREEMENT_NAME>.<VERSION>"
///  @param agreementType The agreement type registered
///  @param code Address of the new agreement
event AgreementClassRegistered(bytes32 agreementType, address code);
```

### AgreementClassUpdated (inherited from ISuperfluid)

```solidity
///  @notice Agreement class updated event
///  @dev agreementType is the keccak256 hash of: "org.superfluid-finance.agreements.<AGREEMENT_NAME>.<VERSION>"
///  @param agreementType The agreement type updated
///  @param code Address of the new agreement
event AgreementClassUpdated(bytes32 agreementType, address code);
```

### SuperTokenFactoryUpdated (inherited from ISuperfluid)

```solidity
///  @dev SuperToken factory updated event
///  @param newFactory Address of the new factory
event SuperTokenFactoryUpdated(ISuperTokenFactory newFactory);
```

### SuperTokenLogicUpdated (inherited from ISuperfluid)

```solidity
///  @notice Update the super token logic to the provided one
///  @dev newLogic must implement UUPSProxiable with matching proxiableUUID
event SuperTokenLogicUpdated(ISuperToken indexed token, address code);
```

### PoolBeaconLogicUpdated (inherited from ISuperfluid)

```solidity
///  @dev Pool Beacon logic updated event
///  @param beaconProxy addrss of the beacon proxy
///  @param newBeaconLogic address of the new beacon logic
event PoolBeaconLogicUpdated(address indexed beaconProxy, address newBeaconLogic);
```

### AppRegistered (inherited from ISuperfluid)

```solidity
///  @dev App registered event
///  @param app Address of jailed app
event AppRegistered(ISuperApp indexed app);
```

### Jail (inherited from ISuperfluid)

```solidity
///  @dev Jail event for the app
///  @param app Address of jailed app
///  @param reason Reason the app is jailed (see Definitions.sol for the full list)
event Jail(ISuperApp indexed app, uint256 reason);
```

## Public/External Functions

### constructor(bool,bool,uint64,address,address)

- **Signature**: `constructor(bool,bool,uint64,address,address)`
- **Visibility**: public
- **Source Range**: 3770:502:163
- **Details**: [function_constructor_bool_bool_uint64_address_address.md](./function_constructor_bool_bool_uint64_address_address.md)

**Signature:**
```solidity
/// NOTE: Whenever modifying the storage layout here it is important to update the validateStorageLayout
///  function in its respective mock contract to ensure that it doesn't break anything or lead to unexpected
///  behaviors/layout when upgrading
constructor(bool nonUpgradable, bool appWhiteListingEnabled, uint64 callbackGasLimit, address simpleForwarderAddress, address erc2771ForwarderAddress);
```

### initialize(contract ISuperfluidGovernance)

- **Signature**: `initialize(contract ISuperfluidGovernance)`
- **Visibility**: external
- **Source Range**: 4542:159:163
- **Details**: [function_initialize_contract_ISuperfluidGovernance.md](./function_initialize_contract_ISuperfluidGovernance.md)

**Signature:**
```solidity
function initialize(ISuperfluidGovernance gov) external initializer();
```

### proxiableUUID()

- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 4707:159:163
- **Details**: [function_proxiableUUID.md](./function_proxiableUUID.md)

**Signature:**
```solidity
function proxiableUUID() override public pure returns (bytes32);
```

### updateCode(address)

- **Signature**: `updateCode(address)`
- **Visibility**: external
- **Source Range**: 4872:305:163
- **Details**: [function_updateCode_address.md](./function_updateCode_address.md)

**Signature:**
```solidity
function updateCode(address newAddress) override external onlyGovernance();
```

### getNow()

- **Signature**: `getNow()`
- **Visibility**: public
- **Source Range**: 5438:142:163
- **Details**: [function_getNow.md](./function_getNow.md)

**Signature:**
```solidity
function getNow() public view returns (uint256);
```

### getGovernance()

- **Signature**: `getGovernance()`
- **Visibility**: external
- **Source Range**: 5847:108:163
- **Details**: [function_getGovernance.md](./function_getGovernance.md)

**Signature:**
```solidity
function getGovernance() override external view returns (ISuperfluidGovernance);
```

### replaceGovernance(contract ISuperfluidGovernance)

- **Signature**: `replaceGovernance(contract ISuperfluidGovernance)`
- **Visibility**: external
- **Source Range**: 5961:167:163
- **Details**: [function_replaceGovernance_contract_ISuperfluidGovernance.md](./function_replaceGovernance_contract_ISuperfluidGovernance.md)

**Signature:**
```solidity
function replaceGovernance(ISuperfluidGovernance newGov) override external onlyGovernance();
```

### registerAgreementClass(contract ISuperAgreement)

- **Signature**: `registerAgreementClass(contract ISuperAgreement)`
- **Visibility**: external
- **Source Range**: 6325:1039:163
- **Details**: [function_registerAgreementClass_contract_ISuperAgreement.md](./function_registerAgreementClass_contract_ISuperAgreement.md)

**Signature:**
```solidity
function registerAgreementClass(ISuperAgreement agreementClassLogic) override external onlyGovernance();
```

### updateAgreementClass(contract ISuperAgreement)

- **Signature**: `updateAgreementClass(contract ISuperAgreement)`
- **Visibility**: external
- **Source Range**: 7370:620:163
- **Details**: [function_updateAgreementClass_contract_ISuperAgreement.md](./function_updateAgreementClass_contract_ISuperAgreement.md)

**Signature:**
```solidity
function updateAgreementClass(ISuperAgreement agreementClassLogic) override external onlyGovernance();
```

### isAgreementTypeListed(bytes32)

- **Signature**: `isAgreementTypeListed(bytes32)`
- **Visibility**: external
- **Source Range**: 7996:206:163
- **Details**: [function_isAgreementTypeListed_bytes32.md](./function_isAgreementTypeListed_bytes32.md)

**Signature:**
```solidity
function isAgreementTypeListed(bytes32 agreementType) override external view returns (bool yes);
```

### isAgreementClassListed(contract ISuperAgreement)

- **Signature**: `isAgreementClassListed(contract ISuperAgreement)`
- **Visibility**: public
- **Source Range**: 8208:394:163
- **Details**: [function_isAgreementClassListed_contract_ISuperAgreement.md](./function_isAgreementClassListed_contract_ISuperAgreement.md)

**Signature:**
```solidity
function isAgreementClassListed(ISuperAgreement agreementClass) override public view returns (bool yes);
```

### getAgreementClass(bytes32)

- **Signature**: `getAgreementClass(bytes32)`
- **Visibility**: external
- **Source Range**: 8608:347:163
- **Details**: [function_getAgreementClass_bytes32.md](./function_getAgreementClass_bytes32.md)

**Signature:**
```solidity
function getAgreementClass(bytes32 agreementType) override external view returns (ISuperAgreement agreementClass);
```

### mapAgreementClasses(uint256)

- **Signature**: `mapAgreementClasses(uint256)`
- **Visibility**: external
- **Source Range**: 8961:617:163
- **Details**: [function_mapAgreementClasses_uint256.md](./function_mapAgreementClasses_uint256.md)

**Signature:**
```solidity
function mapAgreementClasses(uint256 bitmap) override external view returns (ISuperAgreement[] memory agreementClasses);
```

### addToAgreementClassesBitmap(uint256,bytes32)

- **Signature**: `addToAgreementClassesBitmap(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 9584:343:163
- **Details**: [function_addToAgreementClassesBitmap_uint256_bytes32.md](./function_addToAgreementClassesBitmap_uint256_bytes32.md)

**Signature:**
```solidity
function addToAgreementClassesBitmap(uint256 bitmap, bytes32 agreementType) override external view returns (uint256 newBitmap);
```

### removeFromAgreementClassesBitmap(uint256,bytes32)

- **Signature**: `removeFromAgreementClassesBitmap(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 9933:349:163
- **Details**: [function_removeFromAgreementClassesBitmap_uint256_bytes32.md](./function_removeFromAgreementClassesBitmap_uint256_bytes32.md)

**Signature:**
```solidity
function removeFromAgreementClassesBitmap(uint256 bitmap, bytes32 agreementType) override external view returns (uint256 newBitmap);
```

### getSuperTokenFactory()

- **Signature**: `getSuperTokenFactory()`
- **Visibility**: external
- **Source Range**: 10558:154:163
- **Details**: [function_getSuperTokenFactory.md](./function_getSuperTokenFactory.md)

**Signature:**
```solidity
function getSuperTokenFactory() override external view returns (ISuperTokenFactory factory);
```

### getSuperTokenFactoryLogic()

- **Signature**: `getSuperTokenFactoryLogic()`
- **Visibility**: external
- **Source Range**: 10718:326:163
- **Details**: [function_getSuperTokenFactoryLogic.md](./function_getSuperTokenFactoryLogic.md)

**Signature:**
```solidity
function getSuperTokenFactoryLogic() override external view returns (address logic);
```

### updateSuperTokenFactory(contract ISuperTokenFactory)

- **Signature**: `updateSuperTokenFactory(contract ISuperTokenFactory)`
- **Visibility**: external
- **Source Range**: 11050:828:163
- **Details**: [function_updateSuperTokenFactory_contract_ISuperTokenFactory.md](./function_updateSuperTokenFactory_contract_ISuperTokenFactory.md)

**Signature:**
```solidity
function updateSuperTokenFactory(ISuperTokenFactory newFactory) override external onlyGovernance();
```

### updateSuperTokenLogic(contract ISuperToken,address)

- **Signature**: `updateSuperTokenLogic(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 11884:444:163
- **Details**: [function_updateSuperTokenLogic_contract_ISuperToken_address.md](./function_updateSuperTokenLogic_contract_ISuperToken_address.md)

**Signature:**
```solidity
function updateSuperTokenLogic(ISuperToken token, address newLogicOverride) override external onlyGovernance();
```

### changeSuperTokenAdmin(contract ISuperToken,address)

- **Signature**: `changeSuperTokenAdmin(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 12334:136:163
- **Details**: [function_changeSuperTokenAdmin_contract_ISuperToken_address.md](./function_changeSuperTokenAdmin_contract_ISuperToken_address.md)

**Signature:**
```solidity
function changeSuperTokenAdmin(ISuperToken token, address newAdmin) external onlyGovernance();
```

### updatePoolBeaconLogic(address)

- **Signature**: `updatePoolBeaconLogic(address)`
- **Visibility**: external
- **Source Range**: 12788:543:163
- **Details**: [function_updatePoolBeaconLogic_address.md](./function_updatePoolBeaconLogic_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluid
function updatePoolBeaconLogic(address newLogic) override external onlyGovernance();
```

### registerApp(uint256)

- **Signature**: `registerApp(uint256)`
- **Visibility**: external
- **Source Range**: 13632:386:163
- **Details**: [function_registerApp_uint256.md](./function_registerApp_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluid
function registerApp(uint256 configWord) override external;
```

### registerApp(contract ISuperApp,uint256)

- **Signature**: `registerApp(contract ISuperApp,uint256)`
- **Visibility**: external
- **Source Range**: 14056:362:163
- **Details**: [function_registerApp_contract_ISuperApp_uint256.md](./function_registerApp_contract_ISuperApp_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluid
function registerApp(ISuperApp app, uint256 configWord) override external;
```

### registerAppWithKey(uint256,string)

- **Signature**: `registerAppWithKey(uint256,string)`
- **Visibility**: external
- **Source Range**: 14451:361:163
- **Details**: [function_registerAppWithKey_uint256_string.md](./function_registerAppWithKey_uint256_string.md)

**Signature:**
```solidity
/// @custom:deprecated
function registerAppWithKey(uint256 configWord, string calldata registrationKey) override external;
```

### registerAppByFactory(contract ISuperApp,uint256)

- **Signature**: `registerAppByFactory(contract ISuperApp,uint256)`
- **Visibility**: external
- **Source Range**: 15599:792:163
- **Details**: [function_registerAppByFactory_contract_ISuperApp_uint256.md](./function_registerAppByFactory_contract_ISuperApp_uint256.md)

**Signature:**
```solidity
/// @custom:deprecated
function registerAppByFactory(ISuperApp app, uint256 configWord) override external;
```

### isApp(contract ISuperApp)

- **Signature**: `isApp(contract ISuperApp)`
- **Visibility**: public
- **Source Range**: 16993:122:163
- **Details**: [function_isApp_contract_ISuperApp.md](./function_isApp_contract_ISuperApp.md)

**Signature:**
```solidity
function isApp(ISuperApp app) override public view returns (bool);
```

### getAppCallbackLevel(contract ISuperApp)

- **Signature**: `getAppCallbackLevel(contract ISuperApp)`
- **Visibility**: public
- **Source Range**: 17121:182:163
- **Details**: [function_getAppCallbackLevel_contract_ISuperApp.md](./function_getAppCallbackLevel_contract_ISuperApp.md)

**Signature:**
```solidity
function getAppCallbackLevel(ISuperApp appAddr) override public view returns (uint8);
```

### getAppManifest(contract ISuperApp)

- **Signature**: `getAppManifest(contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 17309:526:163
- **Details**: [function_getAppManifest_contract_ISuperApp.md](./function_getAppManifest_contract_ISuperApp.md)

**Signature:**
```solidity
function getAppManifest(ISuperApp app) override external view returns (bool isSuperApp, bool isJailed, uint256 noopMask);
```

### isAppJailed(contract ISuperApp)

- **Signature**: `isAppJailed(contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 17841:193:163
- **Details**: [function_isAppJailed_contract_ISuperApp.md](./function_isAppJailed_contract_ISuperApp.md)

**Signature:**
```solidity
function isAppJailed(ISuperApp app) override external view returns (bool);
```

### allowCompositeApp(contract ISuperApp)

- **Signature**: `allowCompositeApp(contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 18040:498:163
- **Details**: [function_allowCompositeApp_contract_ISuperApp.md](./function_allowCompositeApp_contract_ISuperApp.md)

**Signature:**
```solidity
function allowCompositeApp(ISuperApp targetApp) override external;
```

### isCompositeAppAllowed(contract ISuperApp,contract ISuperApp)

- **Signature**: `isCompositeAppAllowed(contract ISuperApp,contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 18544:201:163
- **Details**: [function_isCompositeAppAllowed_contract_ISuperApp_contract_ISuperApp.md](./function_isCompositeAppAllowed_contract_ISuperApp_contract_ISuperApp.md)

**Signature:**
```solidity
function isCompositeAppAllowed(ISuperApp app, ISuperApp targetApp) override external view returns (bool);
```

### callAppBeforeCallback(contract ISuperApp,bytes,bool,bytes)

- **Signature**: `callAppBeforeCallback(contract ISuperApp,bytes,bool,bytes)`
- **Visibility**: external
- **Source Range**: 18939:826:163
- **Details**: [function_callAppBeforeCallback_contract_ISuperApp_bytes_bool_bytes.md](./function_callAppBeforeCallback_contract_ISuperApp_bytes_bool_bytes.md)

**Signature:**
```solidity
function callAppBeforeCallback(ISuperApp app, bytes calldata callData, bool isTermination, bytes calldata ctx) override external onlyAgreement() assertValidCtx(ctx) returns (bytes memory cbdata);
```

### callAppAfterCallback(contract ISuperApp,bytes,bool,bytes)

- **Signature**: `callAppAfterCallback(contract ISuperApp,bytes,bool,bytes)`
- **Visibility**: external
- **Source Range**: 19771:1335:163
- **Details**: [function_callAppAfterCallback_contract_ISuperApp_bytes_bool_bytes.md](./function_callAppAfterCallback_contract_ISuperApp_bytes_bool_bytes.md)

**Signature:**
```solidity
function callAppAfterCallback(ISuperApp app, bytes calldata callData, bool isTermination, bytes calldata ctx) override external onlyAgreement() assertValidCtx(ctx) returns (bytes memory newCtx);
```

### appCallbackPush(bytes,contract ISuperApp,uint256,int256,contract ISuperfluidToken)

- **Signature**: `appCallbackPush(bytes,contract ISuperApp,uint256,int256,contract ISuperfluidToken)`
- **Visibility**: external
- **Source Range**: 21112:1191:163
- **Details**: [function_appCallbackPush_bytes_contract_ISuperApp_uint256_int256_contract_ISuperfluidToken.md](./function_appCallbackPush_bytes_contract_ISuperApp_uint256_int256_contract_ISuperfluidToken.md)

**Signature:**
```solidity
function appCallbackPush(bytes calldata ctx, ISuperApp app, uint256 appCreditGranted, int256 appCreditUsed, ISuperfluidToken appCreditToken) override external onlyAgreement() assertValidCtx(ctx) returns (bytes memory appCtx);
```

### appCallbackPop(bytes,int256)

- **Signature**: `appCallbackPop(bytes,int256)`
- **Visibility**: external
- **Source Range**: 22309:334:163
- **Details**: [function_appCallbackPop_bytes_int256.md](./function_appCallbackPop_bytes_int256.md)

**Signature:**
```solidity
function appCallbackPop(bytes calldata ctx, int256 appCreditUsedDelta) override external onlyAgreement() returns (bytes memory newCtx);
```

### ctxUseCredit(bytes,int256)

- **Signature**: `ctxUseCredit(bytes,int256)`
- **Visibility**: external
- **Source Range**: 22649:359:163
- **Details**: [function_ctxUseCredit_bytes_int256.md](./function_ctxUseCredit_bytes_int256.md)

**Signature:**
```solidity
function ctxUseCredit(bytes calldata ctx, int256 appCreditUsedMore) override external onlyAgreement() assertValidCtx(ctx) returns (bytes memory newCtx);
```

### jailApp(bytes,contract ISuperApp,uint256)

- **Signature**: `jailApp(bytes,contract ISuperApp,uint256)`
- **Visibility**: external
- **Source Range**: 23014:274:163
- **Details**: [function_jailApp_bytes_contract_ISuperApp_uint256.md](./function_jailApp_bytes_contract_ISuperApp_uint256.md)

**Signature:**
```solidity
function jailApp(bytes calldata ctx, ISuperApp app, uint256 reason) override external onlyAgreement() assertValidCtx(ctx) returns (bytes memory newCtx);
```

### callAgreement(contract ISuperAgreement,bytes,bytes)

- **Signature**: `callAgreement(contract ISuperAgreement,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 24700:290:163
- **Details**: [function_callAgreement_contract_ISuperAgreement_bytes_bytes.md](./function_callAgreement_contract_ISuperAgreement_bytes_bytes.md)

**Signature:**
```solidity
function callAgreement(ISuperAgreement agreementClass, bytes memory callData, bytes memory userData) override external returns (bytes memory returnedData);
```

### callAppAction(contract ISuperApp,bytes)

- **Signature**: `callAppAction(contract ISuperApp,bytes)`
- **Visibility**: external
- **Source Range**: 26245:272:163
- **Details**: [function_callAppAction_contract_ISuperApp_bytes.md](./function_callAppAction_contract_ISuperApp_bytes.md)

**Signature:**
```solidity
function callAppAction(ISuperApp app, bytes memory callData) override external returns (bytes memory returnedData);
```

### callAgreementWithContext(contract ISuperAgreement,bytes,bytes,bytes)

- **Signature**: `callAgreementWithContext(contract ISuperAgreement,bytes,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 26715:1210:163
- **Details**: [function_callAgreementWithContext_contract_ISuperAgreement_bytes_bytes_bytes.md](./function_callAgreementWithContext_contract_ISuperAgreement_bytes_bytes_bytes.md)

**Signature:**
```solidity
function callAgreementWithContext(ISuperAgreement agreementClass, bytes calldata callData, bytes calldata userData, bytes calldata ctx) override external requireValidCtx(ctx) isAgreement(agreementClass) returns (bytes memory newCtx, bytes memory returnedData);
```

### callAppActionWithContext(contract ISuperApp,bytes,bytes)

- **Signature**: `callAppActionWithContext(contract ISuperApp,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 27931:1126:163
- **Details**: [function_callAppActionWithContext_contract_ISuperApp_bytes_bytes.md](./function_callAppActionWithContext_contract_ISuperApp_bytes_bytes.md)

**Signature:**
```solidity
function callAppActionWithContext(ISuperApp app, bytes calldata callData, bytes calldata ctx) override external requireValidCtx(ctx) isAppActive(app) isValidAppAction(callData) returns (bytes memory newCtx);
```

### decodeCtx(bytes)

- **Signature**: `decodeCtx(bytes)`
- **Visibility**: public
- **Source Range**: 29063:150:163
- **Details**: [function_decodeCtx_bytes.md](./function_decodeCtx_bytes.md)

**Signature:**
```solidity
function decodeCtx(bytes memory ctx) override public pure returns (Context memory context);
```

### isCtxValid(bytes)

- **Signature**: `isCtxValid(bytes)`
- **Visibility**: external
- **Source Range**: 29219:138:163
- **Details**: [function_isCtxValid_bytes.md](./function_isCtxValid_bytes.md)

**Signature:**
```solidity
function isCtxValid(bytes calldata ctx) override external view returns (bool);
```

### batchCall(struct ISuperfluid.Operation[])

- **Signature**: `batchCall(struct ISuperfluid.Operation[])`
- **Visibility**: external
- **Source Range**: 35429:162:163
- **Details**: [function_batchCall_struct_ISuperfluid_Operation[].md](./function_batchCall_struct_ISuperfluid_Operation[].md)

**Signature:**
```solidity
/// @dev ISuperfluid.batchCall implementation
function batchCall(Operation[] calldata operations) override external payable;
```

### forwardBatchCall(struct ISuperfluid.Operation[])

- **Signature**: `forwardBatchCall(struct ISuperfluid.Operation[])`
- **Visibility**: external
- **Source Range**: 35654:161:163
- **Details**: [function_forwardBatchCall_struct_ISuperfluid_Operation[].md](./function_forwardBatchCall_struct_ISuperfluid_Operation[].md)

**Signature:**
```solidity
/// @dev ISuperfluid.forwardBatchCall implementation
function forwardBatchCall(Operation[] calldata operations) override external payable;
```

### isTrustedForwarder(address)

- **Signature**: `isTrustedForwarder(address)`
- **Visibility**: public
- **Source Range**: 35887:305:163
- **Details**: [function_isTrustedForwarder_address.md](./function_isTrustedForwarder_address.md)

**Signature:**
```solidity
/// @dev BaseRelayRecipient.isTrustedForwarder implementation
function isTrustedForwarder(address forwarder) override public view returns (bool);
```

### versionRecipient()

- **Signature**: `versionRecipient()`
- **Visibility**: external
- **Source Range**: 36259:123:163
- **Details**: [function_versionRecipient.md](./function_versionRecipient.md)

**Signature:**
```solidity
/// @dev IRelayRecipient.versionRecipient implementation
function versionRecipient() override external pure returns (string memory);
```

### getERC2771Forwarder()

- **Signature**: `getERC2771Forwarder()`
- **Visibility**: external
- **Source Range**: 36388:122:163
- **Details**: [function_getERC2771Forwarder.md](./function_getERC2771Forwarder.md)

**Signature:**
```solidity
function getERC2771Forwarder() override external view returns (address);
```

### getCodeAddress() (inherited from UUPSProxiable)

- **Signature**: `getCodeAddress()`
- **Visibility**: public
- **Source Range**: 401:122:169
- **Details**: [function_getCodeAddress.md](./function_getCodeAddress.md)

**Signature:**
```solidity
///  @dev Get current implementation code address.
function getCodeAddress() public view returns (address codeAddress);
```

### castrate() (inherited from UUPSProxiable)

- **Signature**: `castrate()`
- **Visibility**: external
- **Source Range**: 694:44:169
- **Details**: [function_castrate.md](./function_castrate.md)

**Signature:**
```solidity
function castrate() external initializer();
```
