# Function: callAppAction(contract ISuperApp,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `callAppAction(contract ISuperApp,bytes)`
- **Visibility**: external
- **Source Range**: 26245:272:163

## Implementation

```solidity
function callAppAction(ISuperApp app, bytes memory callData) override external returns (bytes memory returnedData) {
    return _callAppAction(msg.sender, app, 0, callData);
}
```

## Related Implementations

### _callAppAction(address,contract ISuperApp,uint256,bytes)

- **Kind**: internal
- **Source**: 24996:1243:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_callAppAction(address,contract ISuperApp,uint256,bytes)`

```solidity
function _callAppAction(address msgSender, ISuperApp app, uint256 value, bytes memory callData) internal cleanCtx() isAppActive(app) isValidAppAction(callData) returns (bytes memory returnedData) {
    bytes memory ctx = _updateContext(Context({appCallbackLevel: 0, callType: ContextDefinitions.CALL_INFO_CALL_TYPE_APP_ACTION, timestamp: getNow(), msgSender: msgSender, agreementSelector: 0, userData: "", appCreditGranted: 0, appCreditWantedDeprecated: 0, appCreditUsed: 0, appAddress: address(app), appCreditToken: ISuperfluidToken(address(0))}));
    bool success;
    (success, returnedData) = _callExternalWithReplacedCtx(address(app), callData, value, ctx);
    if (success) {
        ctx = abi.decode(returnedData, (bytes));
        if (!_isCtxValid(ctx)) revert APP_RULE(SuperAppDefinitions.APP_RULE_CTX_IS_READONLY);
    } else {
        CallUtils.revertFromReturnedData(returnedData);
    }
    _ctxStamp = 0;
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

### getNow()

- **Kind**: internal
- **Source**: 5438:142:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:getNow()`

```solidity
function getNow() public view returns (uint256) {
    return block.timestamp;
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

### _callExternalWithReplacedCtx(address,bytes,uint256,bytes)

- **Kind**: internal
- **Source**: 39428:1029:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_callExternalWithReplacedCtx(address,bytes,uint256,bytes)`

```solidity
function _callExternalWithReplacedCtx(address target, bytes memory callData, uint256 value, bytes memory ctx) private returns (bool success, bytes memory returnedData) {
    assert(target != address(0));
    callData = _replacePlaceholderCtx(callData, ctx);
    (success, returnedData) = target.call{value: value}(callData);
    if (success) {
        if (returnedData.length == 0) {
            revert APP_RULE(SuperAppDefinitions.APP_RULE_CTX_IS_MALFORMATED);
        }
    }
}
```

### _replacePlaceholderCtx(bytes,bytes)

- **Kind**: internal
- **Source**: 41877:1712:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_replacePlaceholderCtx(bytes,bytes)`

```solidity
///  @dev Replace the placeholder ctx with the actual ctx
function _replacePlaceholderCtx(bytes memory data, bytes memory ctx) internal pure returns (bytes memory dataWithCtx) {
    uint256 dataLen = data.length;
    {
        uint256 placeHolderCtxLength;
        assembly {
            placeHolderCtxLength := mload(add(data, dataLen))
        }
        if (placeHolderCtxLength != 0) revert HOST_NON_ZERO_LENGTH_PLACEHOLDER_CTX();
    }
    assembly {
        mstore(data, sub(dataLen, 0x20))
    }
    return abi.encodePacked(data, uint256(ctx.length), ctx, new bytes(CallUtils.padLength32(ctx.length) - ctx.length));
}
```

### padLength32(uint256)

- **Kind**: internal
- **Source**: 3327:163:153
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/CallUtils.sol:CallUtils:padLength32(uint256)`

```solidity
///  @dev Pad length to 32 bytes word boundary
function padLength32(uint256 len) internal pure returns (uint256 paddedLen) {
    return ((len / 32) + (((len & 31) > 0) ? 1 : 0)) * 32;
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

### revertFromReturnedData(bytes)

- **Kind**: internal
- **Source**: 429:2289:153
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/CallUtils.sol:CallUtils:revertFromReturnedData(bytes)`

```solidity
/// @dev Bubble up the revert from the returnedData (supports Panic, Error & Custom Errors)
///  @notice This is needed in order to provide some human-readable revert message from a call
///  @param returnedData Response of the call
function revertFromReturnedData(bytes memory returnedData) internal pure {
    if (returnedData.length < 4) {
        revert("CallUtils: target revert()");
    } else {
        bytes4 errorSelector;
        assembly {
            errorSelector := mload(add(returnedData, 0x20))
        }
        if (errorSelector == bytes4(0x4e487b71)) {
            string memory reason = "CallUtils: target panicked: 0x__";
            uint errorCode;
            assembly {
                errorCode := mload(add(returnedData, 0x24))
                let reasonWord := mload(add(reason, 0x20))
                let e1 := add(and(errorCode, 0xf), 0x30)
                let e2 := shl(8, add(shr(4, and(errorCode, 0xf0)), 0x30))
                reasonWord := or(and(reasonWord, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000), or(e2, e1))
                mstore(add(reason, 0x20), reasonWord)
            }
            revert(reason);
        } else {
            uint len = returnedData.length;
            assembly {
                revert(add(returnedData, 0x20), len)
            }
        }
    }
}
```

### isValidAppAction(bytes)

- **Kind**: modifier
- **Source**: 44753:657:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:isValidAppAction(bytes)`

```solidity
modifier isValidAppAction(bytes memory callData) {
    bytes4 actionSelector = CallUtils.parseSelector(callData);
    if ((((((actionSelector == ISuperApp.beforeAgreementCreated.selector) || (actionSelector == ISuperApp.afterAgreementCreated.selector)) || (actionSelector == ISuperApp.beforeAgreementUpdated.selector)) || (actionSelector == ISuperApp.afterAgreementUpdated.selector)) || (actionSelector == ISuperApp.beforeAgreementTerminated.selector)) || (actionSelector == ISuperApp.afterAgreementTerminated.selector)) {
        revert HOST_AGREEMENT_CALLBACK_IS_NOT_ACTION();
    }
    _;
}
```

### parseSelector(bytes)

- **Kind**: internal
- **Source**: 2957:299:153
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/CallUtils.sol:CallUtils:parseSelector(bytes)`

```solidity
///  @dev Helper method to parse data and extract the method signature (selector).
///  Copied from: https://github.com/argentlabs/argent-contracts/
///  blob/master/contracts/modules/common/Utils.sol#L54-L60
function parseSelector(bytes memory callData) internal pure returns (bytes4 selector) {
    require(callData.length >= 4, "CallUtils: invalid callData");
    assembly {
        selector := mload(add(callData, 0x20))
    }
}
```

### isAppActive(contract ISuperApp)

- **Kind**: modifier
- **Source**: 44481:266:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:isAppActive(contract ISuperApp)`

```solidity
modifier isAppActive(ISuperApp app) {
    uint256 configWord = _appManifests[app].configWord;
    if (configWord == 0) revert HOST_NOT_A_SUPER_APP();
    if (SuperAppDefinitions.isAppJailed(configWord)) revert HOST_SUPER_APP_IS_JAILED();
    _;
}
```

### isAppJailed(uint256)

- **Kind**: internal
- **Source**: 1142:145:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperAppDefinitions:isAppJailed(uint256)`

```solidity
function isAppJailed(uint256 configWord) internal pure returns (bool) {
    return (configWord & SuperAppDefinitions.APP_JAIL_BIT) > 0;
}
```

### cleanCtx()

- **Kind**: modifier
- **Source**: 43856:130:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:cleanCtx()`

```solidity
modifier cleanCtx() {
    if (_ctxStamp != 0) revert APP_RULE(SuperAppDefinitions.APP_RULE_CTX_IS_NOT_CLEAN);
    _;
}
```

## External Calls

- **unknown::unknown**

## State Variable Reads

- **MAX_APP_CALLBACK_LEVEL** (`uint256`)
- **CALL_INFO_CALL_TYPE_SHIFT** (`uint256`)
- **_ctxStamp** (`bytes32`)
- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]

## State Variable Writes

- **_ctxStamp** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.callAppAction(contract ISuperApp,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: Superfluid._callAppAction(address,contract ISuperApp,uint256,bytes) (NodeID: 1)
      💬 Args: [msg.sender, app, 0, callData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Superfluid._updateContext(struct ISuperfluid.Context) (NodeID: 2)
    │   💬 Args: [Context({appCallbackLevel: 0, callType: ContextDefinitions.CALL_INFO_CALL_TYPE_APP_ACTION, timestamp: getNow(), msgSender: msgSender, agreementSelector: 0, userData: "", appCreditGranted: 0, appCreditWantedDeprecated: 0, appCreditUsed: 0, appAddress: address(app), appCreditToken: ISuperfluidToken(address(0))})]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: Superfluid.getNow() (NodeID: 6)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ ├─ [3] ⚙️ FUNCTION: ContextDefinitions.encodeCallInfo(uint8,uint8) (NodeID: 3)
    │ │   💬 Args: [context.appCallbackLevel, context.callType]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 4)
    │ │   💬 Args: [context.appCreditWantedDeprecated]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 5)
    │     💬 Args: [context.appCreditGranted]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Superfluid._callExternalWithReplacedCtx(address,bytes,uint256,bytes) (NodeID: 7)
    │   💬 Args: [address(app), callData, value, ctx]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: Superfluid._replacePlaceholderCtx(bytes,bytes) (NodeID: 8)
    │     💬 Args: [callData, ctx]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: CallUtils.padLength32(uint256) (NodeID: 9)
    │       💬 Args: [ctx.length]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Superfluid._isCtxValid(bytes) (NodeID: 10)
    │   💬 Args: [ctx]
    │   👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 11)
    │   💬 Args: [returnedData]
    │   👁️  Def: internal
    ├─ [2] 🔒 MODIFIER: Superfluid.isValidAppAction(bytes) (NodeID: 12)
    │   💬 Args: [callData]
    │ └─ [3] ⚙️ FUNCTION: CallUtils.parseSelector(bytes) (NodeID: 13)
    │     💬 Args: [callData]
    │     👁️  Def: internal
    ├─ [2] 🔒 MODIFIER: Superfluid.isAppActive(contract ISuperApp) (NodeID: 14)
    │   💬 Args: [app]
    │ └─ [3] ⚙️ FUNCTION: SuperAppDefinitions.isAppJailed(uint256) (NodeID: 15)
    │     💬 Args: [configWord]
    │     👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Superfluid.cleanCtx() (NodeID: 16)
        💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @notice Call app action
 @dev Main use case is calling app action in a batch call via the host
 @param callData The contextual call data
 @custom:note See "Contextless Call Proxies" above for more about contextual call data.
