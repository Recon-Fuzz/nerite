# Interface: ISuperfluid

## Metadata

- **Name**: ISuperfluid
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol
- **Documentation**:  @title Host interface
   @author Superfluid
   @notice This is the central contract of the system where super agreement, super app
   and super token features are connected.
   The Superfluid host contract is also the entry point for the protocol users,
   where batch call and meta transaction are provided for UX improvements.

## Structs

### Context

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

### Operation

```solidity
///  @dev Batch operation data
struct Operation {
    uint32 operationType;
    address target;
    bytes data;
}
```

## Errors

### HOST_AGREEMENT_CALLBACK_IS_NOT_ACTION

```solidity
error HOST_AGREEMENT_CALLBACK_IS_NOT_ACTION();
```

### HOST_CANNOT_DOWNGRADE_TO_NON_UPGRADEABLE

```solidity
error HOST_CANNOT_DOWNGRADE_TO_NON_UPGRADEABLE();
```

### HOST_CALL_AGREEMENT_WITH_CTX_FROM_WRONG_ADDRESS

```solidity
error HOST_CALL_AGREEMENT_WITH_CTX_FROM_WRONG_ADDRESS();
```

### HOST_CALL_APP_ACTION_WITH_CTX_FROM_WRONG_ADDRESS

```solidity
error HOST_CALL_APP_ACTION_WITH_CTX_FROM_WRONG_ADDRESS();
```

### HOST_INVALID_CONFIG_WORD

```solidity
error HOST_INVALID_CONFIG_WORD();
```

### HOST_MAX_256_AGREEMENTS

```solidity
error HOST_MAX_256_AGREEMENTS();
```

### HOST_NON_UPGRADEABLE

```solidity
error HOST_NON_UPGRADEABLE();
```

### HOST_NON_ZERO_LENGTH_PLACEHOLDER_CTX

```solidity
error HOST_NON_ZERO_LENGTH_PLACEHOLDER_CTX();
```

### HOST_ONLY_GOVERNANCE

```solidity
error HOST_ONLY_GOVERNANCE();
```

### HOST_UNKNOWN_BATCH_CALL_OPERATION_TYPE

```solidity
error HOST_UNKNOWN_BATCH_CALL_OPERATION_TYPE();
```

### HOST_AGREEMENT_ALREADY_REGISTERED

```solidity
error HOST_AGREEMENT_ALREADY_REGISTERED();
```

### HOST_AGREEMENT_IS_NOT_REGISTERED

```solidity
error HOST_AGREEMENT_IS_NOT_REGISTERED();
```

### HOST_MUST_BE_CONTRACT

```solidity
error HOST_MUST_BE_CONTRACT();
```

### HOST_ONLY_LISTED_AGREEMENT

```solidity
error HOST_ONLY_LISTED_AGREEMENT();
```

### HOST_NEED_MORE_GAS

```solidity
error HOST_NEED_MORE_GAS();
```

### APP_RULE

```solidity
error APP_RULE(uint256 _code);
```

### HOST_NOT_A_SUPER_APP

```solidity
error HOST_NOT_A_SUPER_APP();
```

### HOST_NO_APP_REGISTRATION_PERMISSION

```solidity
error HOST_NO_APP_REGISTRATION_PERMISSION();
```

### HOST_RECEIVER_IS_NOT_SUPER_APP

```solidity
error HOST_RECEIVER_IS_NOT_SUPER_APP();
```

### HOST_SENDER_IS_NOT_SUPER_APP

```solidity
error HOST_SENDER_IS_NOT_SUPER_APP();
```

### HOST_SOURCE_APP_NEEDS_HIGHER_APP_LEVEL

```solidity
error HOST_SOURCE_APP_NEEDS_HIGHER_APP_LEVEL();
```

### HOST_SUPER_APP_IS_JAILED

```solidity
error HOST_SUPER_APP_IS_JAILED();
```

### HOST_SUPER_APP_ALREADY_REGISTERED

```solidity
error HOST_SUPER_APP_ALREADY_REGISTERED();
```

## Events

### GovernanceReplaced

```solidity
///  @dev Governance replaced event
///  @param oldGov Address of the old governance contract
///  @param newGov Address of the new governance contract
event GovernanceReplaced(ISuperfluidGovernance oldGov, ISuperfluidGovernance newGov);
```

### AgreementClassRegistered

```solidity
///  @notice Agreement class registered event
///  @dev agreementType is the keccak256 hash of: "org.superfluid-finance.agreements.<AGREEMENT_NAME>.<VERSION>"
///  @param agreementType The agreement type registered
///  @param code Address of the new agreement
event AgreementClassRegistered(bytes32 agreementType, address code);
```

### AgreementClassUpdated

```solidity
///  @notice Agreement class updated event
///  @dev agreementType is the keccak256 hash of: "org.superfluid-finance.agreements.<AGREEMENT_NAME>.<VERSION>"
///  @param agreementType The agreement type updated
///  @param code Address of the new agreement
event AgreementClassUpdated(bytes32 agreementType, address code);
```

### SuperTokenFactoryUpdated

```solidity
///  @dev SuperToken factory updated event
///  @param newFactory Address of the new factory
event SuperTokenFactoryUpdated(ISuperTokenFactory newFactory);
```

### SuperTokenLogicUpdated

```solidity
///  @notice Update the super token logic to the provided one
///  @dev newLogic must implement UUPSProxiable with matching proxiableUUID
event SuperTokenLogicUpdated(ISuperToken indexed token, address code);
```

### PoolBeaconLogicUpdated

```solidity
///  @dev Pool Beacon logic updated event
///  @param beaconProxy addrss of the beacon proxy
///  @param newBeaconLogic address of the new beacon logic
event PoolBeaconLogicUpdated(address indexed beaconProxy, address newBeaconLogic);
```

### AppRegistered

```solidity
///  @dev App registered event
///  @param app Address of jailed app
event AppRegistered(ISuperApp indexed app);
```

### Jail

```solidity
///  @dev Jail event for the app
///  @param app Address of jailed app
///  @param reason Reason the app is jailed (see Definitions.sol for the full list)
event Jail(ISuperApp indexed app, uint256 reason);
```

## Public/External Functions

### getNow()

- **Signature**: `getNow()`
- **Visibility**: external
- **Source Range**: 4779:50:45

**Signature:**
```solidity
function getNow() external view returns (uint256);;
```

### getGovernance()

- **Signature**: `getGovernance()`
- **Visibility**: external
- **Source Range**: 5100:81:45

**Signature:**
```solidity
///  @dev Get the current governance address of the Superfluid host
function getGovernance() external view returns (ISuperfluidGovernance governance);;
```

### replaceGovernance(contract ISuperfluidGovernance)

- **Signature**: `replaceGovernance(contract ISuperfluidGovernance)`
- **Visibility**: external
- **Source Range**: 5261:66:45

**Signature:**
```solidity
///  @dev Replace the current governance with a new one
function replaceGovernance(ISuperfluidGovernance newGov) external;;
```

### registerAgreementClass(contract ISuperAgreement)

- **Signature**: `registerAgreementClass(contract ISuperAgreement)`
- **Visibility**: external
- **Source Range**: 5980:78:45

**Signature:**
```solidity
///  @dev Register a new agreement class to the system
///  @param agreementClassLogic Initial agreement class code
///  @custom:modifiers
///  - onlyGovernance
function registerAgreementClass(ISuperAgreement agreementClassLogic) external;;
```

### updateAgreementClass(contract ISuperAgreement)

- **Signature**: `updateAgreementClass(contract ISuperAgreement)`
- **Visibility**: external
- **Source Range**: 6602:76:45

**Signature:**
```solidity
///  @dev Update code of an agreement class
///  @param agreementClassLogic New code for the agreement class
///  @custom:modifiers
///   - onlyGovernance
function updateAgreementClass(ISuperAgreement agreementClassLogic) external;;
```

### isAgreementTypeListed(bytes32)

- **Signature**: `isAgreementTypeListed(bytes32)`
- **Visibility**: external
- **Source Range**: 7219:86:45

**Signature:**
```solidity
///  @notice Check if the agreement type is whitelisted
///  @dev agreementType is the keccak256 hash of: "org.superfluid-finance.agreements.<AGREEMENT_NAME>.<VERSION>"
function isAgreementTypeListed(bytes32 agreementType) external view returns (bool yes);;
```

### isAgreementClassListed(contract ISuperAgreement)

- **Signature**: `isAgreementClassListed(contract ISuperAgreement)`
- **Visibility**: external
- **Source Range**: 7381:96:45

**Signature:**
```solidity
///  @dev Check if the agreement class is whitelisted
function isAgreementClassListed(ISuperAgreement agreementClass) external view returns (bool yes);;
```

### getAgreementClass(bytes32)

- **Signature**: `getAgreementClass(bytes32)`
- **Visibility**: external
- **Source Range**: 7646:104:45

**Signature:**
```solidity
///  @notice Get agreement class
///  @dev agreementType is the keccak256 hash of: "org.superfluid-finance.agreements.<AGREEMENT_NAME>.<VERSION>"
function getAgreementClass(bytes32 agreementType) external view returns (ISuperAgreement agreementClass);;
```

### mapAgreementClasses(uint256)

- **Signature**: `mapAgreementClasses(uint256)`
- **Visibility**: external
- **Source Range**: 7874:127:45

**Signature:**
```solidity
///  @dev Map list of the agreement classes using a bitmap
///  @param bitmap Agreement class bitmap
function mapAgreementClasses(uint256 bitmap) external view returns (ISuperAgreement[] memory agreementClasses);;
```

### addToAgreementClassesBitmap(uint256,bytes32)

- **Signature**: `addToAgreementClassesBitmap(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 8248:134:45

**Signature:**
```solidity
///  @notice Create a new bitmask by adding a agreement class to it
///  @dev agreementType is the keccak256 hash of: "org.superfluid-finance.agreements.<AGREEMENT_NAME>.<VERSION>"
///  @param bitmap Agreement class bitmap
function addToAgreementClassesBitmap(uint256 bitmap, bytes32 agreementType) external view returns (uint256 newBitmap);;
```

### removeFromAgreementClassesBitmap(uint256,bytes32)

- **Signature**: `removeFromAgreementClassesBitmap(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 8633:139:45

**Signature:**
```solidity
///  @notice Create a new bitmask by removing a agreement class from it
///  @dev agreementType is the keccak256 hash of: "org.superfluid-finance.agreements.<AGREEMENT_NAME>.<VERSION>"
///  @param bitmap Agreement class bitmap
function removeFromAgreementClassesBitmap(uint256 bitmap, bytes32 agreementType) external view returns (uint256 newBitmap);;
```

### getSuperTokenFactory()

- **Signature**: `getSuperTokenFactory()`
- **Visibility**: external
- **Source Range**: 9056:83:45

**Signature:**
```solidity
///  @dev Get the super token factory
///  @return factory The factory
function getSuperTokenFactory() external view returns (ISuperTokenFactory factory);;
```

### getSuperTokenFactoryLogic()

- **Signature**: `getSuperTokenFactoryLogic()`
- **Visibility**: external
- **Source Range**: 9284:75:45

**Signature:**
```solidity
///  @dev Get the super token factory logic (applicable to upgradable deployment)
///  @return logic The factory logic
function getSuperTokenFactoryLogic() external view returns (address logic);;
```

### updateSuperTokenFactory(contract ISuperTokenFactory)

- **Signature**: `updateSuperTokenFactory(contract ISuperTokenFactory)`
- **Visibility**: external
- **Source Range**: 9463:73:45

**Signature:**
```solidity
///  @dev Update super token factory
///  @param newFactory New factory logic
function updateSuperTokenFactory(ISuperTokenFactory newFactory) external;;
```

### updateSuperTokenLogic(contract ISuperToken,address)

- **Signature**: `updateSuperTokenLogic(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 10019:85:45

**Signature:**
```solidity
///  @notice Update the super token logic to the latest (canonical) implementation
///  if `newLogicOverride` is zero, or to `newLogicOverride` otherwise.
///  or to the provided implementation `.
///  @dev Refer to ISuperTokenFactory.Upgradability for expected behaviours
function updateSuperTokenLogic(ISuperToken token, address newLogicOverride) external;;
```

### changeSuperTokenAdmin(contract ISuperToken,address)

- **Signature**: `changeSuperTokenAdmin(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 10578:77:45

**Signature:**
```solidity
///  @notice Change the SuperToken admin address
///  @dev The admin is the only account allowed to update the token logic
///  For backward compatibility, the "host" is the default "admin" if unset (address(0)).
function changeSuperTokenAdmin(ISuperToken token, address newAdmin) external;;
```

### updatePoolBeaconLogic(address)

- **Signature**: `updatePoolBeaconLogic(address)`
- **Visibility**: external
- **Source Range**: 10864:64:45

**Signature:**
```solidity
///  @notice Change the implementation address the pool beacon points to
///  @dev Updating the logic the beacon points to will update the logic of all the Pool BeaconProxy instances
function updatePoolBeaconLogic(address newBeaconLogic) external;;
```

### registerApp(uint256)

- **Signature**: `registerApp(uint256)`
- **Visibility**: external
- **Source Range**: 11800:50:45

**Signature:**
```solidity
///  @dev Message sender (must be a contract) registers itself as a super app.
///  @param configWord The super app manifest configuration, flags are defined in
///  `SuperAppDefinitions`
///  @notice On some mainnet deployments, pre-authorization by governance may be needed for this to succeed.
///  See https://github.com/superfluid-finance/protocol-monorepo/wiki/Super-App-White-listing-Guide
function registerApp(uint256 configWord) external;;
```

### registerApp(contract ISuperApp,uint256)

- **Signature**: `registerApp(contract ISuperApp,uint256)`
- **Visibility**: external
- **Source Range**: 12304:65:45

**Signature:**
```solidity
///  @dev Registers an app (must be a contract) as a super app.
///  @param app The super app address
///  @param configWord The super app manifest configuration, flags are defined in
///  `SuperAppDefinitions`
///  @notice On some mainnet deployments, pre-authorization by governance may be needed for this to succeed.
///  See https://github.com/superfluid-finance/protocol-monorepo/wiki/Super-App-White-listing-Guide
function registerApp(ISuperApp app, uint256 configWord) external;;
```

### registerAppWithKey(uint256,string)

- **Signature**: `registerAppWithKey(uint256,string)`
- **Visibility**: external
- **Source Range**: 12655:90:45

**Signature:**
```solidity
///  @dev DO NOT USE for new deployments
///  @custom:deprecated you should use `registerApp(uint256 configWord) instead.
function registerAppWithKey(uint256 configWord, string calldata registrationKey) external;;
```

### registerAppByFactory(contract ISuperApp,uint256)

- **Signature**: `registerAppByFactory(contract ISuperApp,uint256)`
- **Visibility**: external
- **Source Range**: 12908:74:45

**Signature:**
```solidity
///  @dev DO NOT USE for new deployments
///  @custom:deprecated you should use `registerApp(ISuperApp app, uint256 configWord) instead.
function registerAppByFactory(ISuperApp app, uint256 configWord) external;;
```

### isApp(contract ISuperApp)

- **Signature**: `isApp(contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 13083:58:45

**Signature:**
```solidity
///  @dev Query if the app is registered
///  @param app Super app address
function isApp(ISuperApp app) external view returns (bool);;
```

### getAppCallbackLevel(contract ISuperApp)

- **Signature**: `getAppCallbackLevel(contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 13235:90:45

**Signature:**
```solidity
///  @dev Query app callbacklevel
///  @param app Super app address
function getAppCallbackLevel(ISuperApp app) external view returns (uint8 appCallbackLevel);;
```

### getAppManifest(contract ISuperApp)

- **Signature**: `getAppManifest(contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 13429:188:45

**Signature:**
```solidity
///  @dev Get the manifest of the super app
///  @param app Super app address
function getAppManifest(ISuperApp app) external view returns (bool isSuperApp, bool isJailed, uint256 noopMask);;
```

### isAppJailed(contract ISuperApp)

- **Signature**: `isAppJailed(contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 13720:72:45

**Signature:**
```solidity
///  @dev Query if the app has been jailed
///  @param app Super app address
function isAppJailed(ISuperApp app) external view returns (bool isJail);;
```

### allowCompositeApp(contract ISuperApp)

- **Signature**: `allowCompositeApp(contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 13956:57:45

**Signature:**
```solidity
///  @dev Whitelist the target app for app composition for the source app (msg.sender)
///  @param targetApp The target super app address
function allowCompositeApp(ISuperApp targetApp) external;;
```

### isCompositeAppAllowed(contract ISuperApp,contract ISuperApp)

- **Signature**: `isCompositeAppAllowed(contract ISuperApp,contract ISuperApp)`
- **Visibility**: external
- **Source Range**: 14208:147:45

**Signature:**
```solidity
///  @dev Query if source app is allowed to call the target app as downstream app
///  @param app Super app address
///  @param targetApp The target super app address
function isCompositeAppAllowed(ISuperApp app, ISuperApp targetApp) external view returns (bool isAppAllowed);;
```

### callAppBeforeCallback(contract ISuperApp,bytes,bool,bytes)

- **Signature**: `callAppBeforeCallback(contract ISuperApp,bytes,bool,bytes)`
- **Visibility**: external
- **Source Range**: 15145:259:45

**Signature:**
```solidity
///  @dev (For agreements) StaticCall the app before callback
///  @param  app               The super app.
///  @param  callData          The call data sending to the super app.
///  @param  isTermination     Is it a termination callback?
///  @param  ctx               Current ctx, it will be validated.
///  @return cbdata            Data returned from the callback.
function callAppBeforeCallback(ISuperApp app, bytes calldata callData, bool isTermination, bytes calldata ctx) external returns (bytes memory cbdata);;
```

### callAppAfterCallback(contract ISuperApp,bytes,bool,bytes)

- **Signature**: `callAppAfterCallback(contract ISuperApp,bytes,bool,bytes)`
- **Visibility**: external
- **Source Range**: 15808:258:45

**Signature:**
```solidity
///  @dev (For agreements) Call the app after callback
///  @param  app               The super app.
///  @param  callData          The call data sending to the super app.
///  @param  isTermination     Is it a termination callback?
///  @param  ctx               Current ctx, it will be validated.
///  @return newCtx            The current context of the transaction.
function callAppAfterCallback(ISuperApp app, bytes calldata callData, bool isTermination, bytes calldata ctx) external returns (bytes memory newCtx);;
```

### appCallbackPush(bytes,contract ISuperApp,uint256,int256,contract ISuperfluidToken)

- **Signature**: `appCallbackPush(bytes,contract ISuperApp,uint256,int256,contract ISuperfluidToken)`
- **Visibility**: external
- **Source Range**: 16485:298:45

**Signature:**
```solidity
///  @dev (For agreements) Create a new callback stack
///  @param  ctx                     The current ctx, it will be validated.
///  @param  app                     The super app.
///  @param  appCreditGranted        App credit granted so far.
///  @param  appCreditUsed           App credit used so far.
///  @return newCtx                  The current context of the transaction.
function appCallbackPush(bytes calldata ctx, ISuperApp app, uint256 appCreditGranted, int256 appCreditUsed, ISuperfluidToken appCreditToken) external returns (bytes memory newCtx);;
```

### appCallbackPop(bytes,int256)

- **Signature**: `appCallbackPop(bytes,int256)`
- **Visibility**: external
- **Source Range**: 17348:173:45

**Signature:**
```solidity
///  @dev (For agreements) Pop from the current app callback stack
///  @param  ctx                     The ctx that was pushed before the callback stack.
///  @param  appCreditUsedDelta      App credit used by the app.
///  @return newCtx                  The current context of the transaction.
///  @custom:security
///  - Here we cannot do assertValidCtx(ctx), since we do not really save the stack in memory.
///  - Hence there is still implicit trust that the agreement handles the callback push/pop pair correctly.
function appCallbackPop(bytes calldata ctx, int256 appCreditUsedDelta) external returns (bytes memory newCtx);;
```

### ctxUseCredit(bytes,int256)

- **Signature**: `ctxUseCredit(bytes,int256)`
- **Visibility**: external
- **Source Range**: 17820:201:45

**Signature:**
```solidity
///  @dev (For agreements) Use app credit.
///  @param  ctx                      The current ctx, it will be validated.
///  @param  appCreditUsedMore        See app credit for more details.
///  @return newCtx                   The current context of the transaction.
function ctxUseCredit(bytes calldata ctx, int256 appCreditUsedMore) external returns (bytes memory newCtx);;
```

### jailApp(bytes,contract ISuperApp,uint256)

- **Signature**: `jailApp(bytes,contract ISuperApp,uint256)`
- **Visibility**: external
- **Source Range**: 18276:209:45

**Signature:**
```solidity
///  @dev (For agreements) Jail the app.
///  @param  app                     The super app.
///  @param  reason                  Jail reason code.
///  @return newCtx                  The current context of the transaction.
function jailApp(bytes calldata ctx, ISuperApp app, uint256 reason) external returns (bytes memory newCtx);;
```

### callAgreement(contract ISuperAgreement,bytes,bytes)

- **Signature**: `callAgreement(contract ISuperAgreement,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 19550:256:45

**Signature:**
```solidity
///  @dev Call agreement function
///  @param agreementClass The agreement address you are calling
///  @param callData The contextual call data with placeholder ctx
///  @param userData Extra user data being sent to the super app callbacks
function callAgreement(ISuperAgreement agreementClass, bytes calldata callData, bytes calldata userData) external returns (bytes memory returnedData);;
```

### callAppAction(contract ISuperApp,bytes)

- **Signature**: `callAppAction(contract ISuperApp,bytes)`
- **Visibility**: external
- **Source Range**: 20085:228:45

**Signature:**
```solidity
///  @notice Call app action
///  @dev Main use case is calling app action in a batch call via the host
///  @param callData The contextual call data
///  @custom:note See "Contextless Call Proxies" above for more about contextual call data.
function callAppAction(ISuperApp app, bytes calldata callData) external returns (bytes memory returnedData);;
```

### callAgreementWithContext(contract ISuperAgreement,bytes,bytes,bytes)

- **Signature**: `callAgreementWithContext(contract ISuperAgreement,bytes,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 22898:329:45

**Signature:**
```solidity
function callAgreementWithContext(ISuperAgreement agreementClass, bytes calldata callData, bytes calldata userData, bytes calldata ctx) external returns (bytes memory newCtx, bytes memory returnedData);;
```

### callAppActionWithContext(contract ISuperApp,bytes,bytes)

- **Signature**: `callAppActionWithContext(contract ISuperApp,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 23233:239:45

**Signature:**
```solidity
function callAppActionWithContext(ISuperApp app, bytes calldata callData, bytes calldata ctx) external returns (bytes memory newCtx);;
```

### decodeCtx(bytes)

- **Signature**: `decodeCtx(bytes)`
- **Visibility**: external
- **Source Range**: 23478:100:45

**Signature:**
```solidity
function decodeCtx(bytes memory ctx) external pure returns (Context memory context);;
```

### isCtxValid(bytes)

- **Signature**: `isCtxValid(bytes)`
- **Visibility**: external
- **Source Range**: 23584:69:45

**Signature:**
```solidity
function isCtxValid(bytes calldata ctx) external view returns (bool);;
```

### batchCall(struct ISuperfluid.Operation[])

- **Signature**: `batchCall(struct ISuperfluid.Operation[])`
- **Visibility**: external
- **Source Range**: 24958:69:45

**Signature:**
```solidity
///  @dev Batch call function
///  @param operations Array of batch operations
///  NOTE: `batchCall` is `payable, because there's limited support for sending
///  native tokens to batch operation targets.
///  If value is > 0, the whole amount is sent to the first operation matching any of:
///  - OPERATION_TYPE_SUPERFLUID_CALL_APP_ACTION
///  - OPERATION_TYPE_SIMPLE_FORWARD_CALL
///  - OPERATION_TYPE_ERC2771_FORWARD_CALL
///  If the first such operation does not allow receiving native tokens,
///  the transaction will revert.
///  It's currently not possible to send native tokens to multiple operations, or to
///  any but the first operation of one of the above mentioned types.
///  If no such operation is included, the native tokens will be sent back to the sender.
function batchCall(Operation[] calldata operations) external payable;;
```

### forwardBatchCall(struct ISuperfluid.Operation[])

- **Signature**: `forwardBatchCall(struct ISuperfluid.Operation[])`
- **Visibility**: external
- **Source Range**: 25468:76:45

**Signature:**
```solidity
///  @dev Batch call function with EIP-2771 encoded msgSender
///  @param operations Array of batch operations
///  NOTE: This can be called only by contracts recognized as _trusted forwarder_
///  by the host contract (see `Superfluid.isTrustedForwarder`).
///  If native tokens are passed along, the same rules as for `batchCall` apply,
///  with an optional refund going to the encoded msgSender.
function forwardBatchCall(Operation[] calldata operations) external payable;;
```

### getERC2771Forwarder()

- **Signature**: `getERC2771Forwarder()`
- **Visibility**: external
- **Source Range**: 25836:62:45

**Signature:**
```solidity
///  @dev returns the address of the forwarder contract used to route batch operations of type
///  OPERATION_TYPE_ERC2771_FORWARD_CALL.
///  Needs to be set as _trusted forwarder_ by the call targets of such operations.
function getERC2771Forwarder() external view returns (address);;
```
