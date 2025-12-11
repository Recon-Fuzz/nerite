# Function: appCallbackPush(bytes,contract ISuperApp,uint256,int256,contract ISuperfluidToken)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `appCallbackPush(bytes,contract ISuperApp,uint256,int256,contract ISuperfluidToken)`
- **Visibility**: external
- **Source Range**: 21112:1191:163

## Implementation

```solidity
function appCallbackPush(bytes calldata ctx, ISuperApp app, uint256 appCreditGranted, int256 appCreditUsed, ISuperfluidToken appCreditToken) override external onlyAgreement() assertValidCtx(ctx) returns (bytes memory appCtx) {
    Context memory context = decodeCtx(ctx);
    if (isApp(ISuperApp(context.msgSender)) && (context.appCallbackLevel >= 1)) {
        if (!_compositeApps[ISuperApp(context.msgSender)][app]) {
            revert APP_RULE(SuperAppDefinitions.APP_RULE_COMPOSITE_APP_IS_NOT_WHITELISTED);
        }
    }
    context.appCallbackLevel++;
    context.callType = ContextDefinitions.CALL_INFO_CALL_TYPE_APP_CALLBACK;
    context.appCreditGranted = appCreditGranted;
    context.appCreditUsed = appCreditUsed;
    context.appAddress = address(app);
    context.appCreditToken = appCreditToken;
    appCtx = _updateContext(context);
}
```

## Related Implementations

### decodeCtx(bytes)

- **Kind**: internal
- **Source**: 29063:150:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:decodeCtx(bytes)`

```solidity
function decodeCtx(bytes memory ctx) override public pure returns (Context memory context) {
    return _decodeCtx(ctx);
}
```

### _decodeCtx(bytes)

- **Kind**: internal
- **Source**: 38076:1203:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_decodeCtx(bytes)`

```solidity
function _decodeCtx(bytes memory ctx) private pure returns (Context memory context) {
    bytes memory ctx1;
    bytes memory ctx2;
    (ctx1, ctx2) = abi.decode(ctx, (bytes, bytes));
    {
        uint256 callInfo;
        (callInfo, context.timestamp, context.msgSender, context.agreementSelector, context.userData) = abi.decode(ctx1, (uint256, uint256, address, bytes4, bytes));
        (context.appCallbackLevel, context.callType) = ContextDefinitions.decodeCallInfo(callInfo);
    }
    {
        uint256 creditIO;
        (creditIO, context.appCreditUsed, context.appAddress, context.appCreditToken) = abi.decode(ctx2, (uint256, int256, address, ISuperfluidToken));
        context.appCreditGranted = creditIO & type(uint128).max;
        context.appCreditWantedDeprecated = creditIO >> 128;
    }
}
```

### decodeCallInfo(uint256)

- **Kind**: internal
- **Source**: 3883:297:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:ContextDefinitions:decodeCallInfo(uint256)`

```solidity
function decodeCallInfo(uint256 callInfo) internal pure returns (uint8 appCallbackLevel, uint8 callType) {
    appCallbackLevel = uint8(callInfo & CALL_INFO_APP_LEVEL_MASK);
    callType = uint8((callInfo & CALL_INFO_CALL_TYPE_MASK) >> CALL_INFO_CALL_TYPE_SHIFT);
}
```

### isApp(contract ISuperApp)

- **Kind**: internal
- **Source**: 16993:122:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:isApp(contract ISuperApp)`

```solidity
function isApp(ISuperApp app) override public view returns (bool) {
    return _appManifests[app].configWord > 0;
}
```

### _updateContext(struct ISuperfluid.Context)

- **Kind**: internal
- **Source**: 36987:1083:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_updateContext(struct ISuperfluid.Context)`

```solidity
function _updateContext(Context memory context) private returns (bytes memory ctx) {
    if (context.appCallbackLevel > MAX_APP_CALLBACK_LEVEL) {
        revert APP_RULE(SuperAppDefinitions.APP_RULE_MAX_APP_LEVEL_REACHED);
    }
    uint256 callInfo = ContextDefinitions.encodeCallInfo(context.appCallbackLevel, context.callType);
    uint256 creditIO = context.appCreditGranted.toUint128() | (uint256(context.appCreditWantedDeprecated.toUint128()) << 128);
    ctx = abi.encode(abi.encode(callInfo, context.timestamp, context.msgSender, context.agreementSelector, context.userData), abi.encode(creditIO, context.appCreditUsed, context.appAddress, context.appCreditToken));
    _ctxStamp = keccak256(ctx);
}
```

### encodeCallInfo(uint8,uint8)

- **Kind**: internal
- **Source**: 4186:225:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:ContextDefinitions:encodeCallInfo(uint8,uint8)`

```solidity
function encodeCallInfo(uint8 appCallbackLevel, uint8 callType) internal pure returns (uint256 callInfo) {
    return uint256(appCallbackLevel) | (uint256(callType) << CALL_INFO_CALL_TYPE_SHIFT);
}
```

### toUint128(uint256)

- **Kind**: internal
- **Source**: 9088:192:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint128(uint256)`

```solidity
///  @dev Returns the downcasted uint128 from uint256, reverting on
///  overflow (when the input is greater than largest uint128).
///  Counterpart to Solidity's `uint128` operator.
///  Requirements:
///  - input must fit into 128 bits
///  _Available since v2.5._
function toUint128(uint256 value) internal pure returns (uint128) {
    require(value <= type(uint128).max, "SafeCast: value doesn't fit in 128 bits");
    return uint128(value);
}
```

### assertValidCtx(bytes)

- **Kind**: modifier
- **Source**: 43756:94:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:assertValidCtx(bytes)`

```solidity
modifier assertValidCtx(bytes memory ctx) {
    assert(_isCtxValid(ctx));
    _;
}
```

### _isCtxValid(bytes)

- **Kind**: internal
- **Source**: 39285:137:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_isCtxValid(bytes)`

```solidity
function _isCtxValid(bytes memory ctx) private view returns (bool) {
    return (ctx.length != 0) && (keccak256(ctx) == _ctxStamp);
}
```

### onlyAgreement()

- **Kind**: modifier
- **Source**: 44305:170:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:onlyAgreement()`

```solidity
modifier onlyAgreement() {
    if (!isAgreementClassListed(ISuperAgreement(msg.sender))) {
        revert HOST_ONLY_LISTED_AGREEMENT();
    }
    _;
}
```

### isAgreementClassListed(contract ISuperAgreement)

- **Kind**: internal
- **Source**: 8208:394:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:isAgreementClassListed(contract ISuperAgreement)`

```solidity
function isAgreementClassListed(ISuperAgreement agreementClass) override public view returns (bool yes) {
    bytes32 agreementType = agreementClass.agreementType();
    uint idx = _agreementClassIndices[agreementType];
    return (idx != 0) && (_agreementClasses[idx - 1] == agreementClass);
}
```

## External Calls

- **ISuperAgreement::agreementType()**

## State Variable Reads

- **_compositeApps** (`mapping(contract ISuperApp => mapping(contract ISuperApp => bool))`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]
- **CALL_INFO_APP_LEVEL_MASK** (`uint256`)
- **CALL_INFO_CALL_TYPE_MASK** (`uint256`)
- **CALL_INFO_CALL_TYPE_SHIFT** (`uint256`)
- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]
- **MAX_APP_CALLBACK_LEVEL** (`uint256`)
- **_ctxStamp** (`bytes32`)
- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)
- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]

## State Variable Writes

- **_ctxStamp** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.appCallbackPush(bytes,contract ISuperApp,uint256,int256,contract ISuperfluidToken) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Superfluid.decodeCtx(bytes) (NodeID: 1)
  │   💬 Args: [ctx]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Superfluid._decodeCtx(bytes) (NodeID: 2)
  │     💬 Args: [ctx]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: ContextDefinitions.decodeCallInfo(uint256) (NodeID: 3)
  │       💬 Args: [callInfo]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Superfluid.isApp(contract ISuperApp) (NodeID: 4)
  │   💬 Args: [ISuperApp(context.msgSender)]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Superfluid._updateContext(struct ISuperfluid.Context) (NodeID: 5)
  │   💬 Args: [context]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: ContextDefinitions.encodeCallInfo(uint8,uint8) (NodeID: 6)
  │ │   💬 Args: [context.appCallbackLevel, context.callType]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 7)
  │ │   💬 Args: [context.appCreditWantedDeprecated]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 8)
  │     💬 Args: [context.appCreditGranted]
  │     👁️  Def: internal
  ├─ [1] 🔒 MODIFIER: Superfluid.assertValidCtx(bytes) (NodeID: 9)
  │   💬 Args: [ctx]
  │ └─ [2] ⚙️ FUNCTION: Superfluid._isCtxValid(bytes) (NodeID: 10)
  │     💬 Args: [ctx]
  │     👁️  Def: private
  └─ [1] 🔒 MODIFIER: Superfluid.onlyAgreement() (NodeID: 11)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Superfluid.isAgreementClassListed(contract ISuperAgreement) (NodeID: 12)
        💬 Args: [ISuperAgreement(msg.sender)]
        👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev (For agreements) Create a new callback stack
 @param  ctx                     The current ctx, it will be validated.
 @param  app                     The super app.
 @param  appCreditGranted        App credit granted so far.
 @param  appCreditUsed           App credit used so far.
 @return newCtx                  The current context of the transaction.
