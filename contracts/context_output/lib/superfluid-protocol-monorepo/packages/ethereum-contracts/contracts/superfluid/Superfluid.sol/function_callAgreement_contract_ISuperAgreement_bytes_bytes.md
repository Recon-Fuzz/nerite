# Function: callAgreement(contract ISuperAgreement,bytes,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `callAgreement(contract ISuperAgreement,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 24700:290:163

## Implementation

```solidity
function callAgreement(ISuperAgreement agreementClass, bytes memory callData, bytes memory userData) override external returns (bytes memory returnedData) {
    return _callAgreement(msg.sender, agreementClass, callData, userData);
}
```

## Related Implementations

### _callAgreement(address,contract ISuperAgreement,bytes,bytes)

- **Kind**: internal
- **Source**: 23485:1209:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_callAgreement(address,contract ISuperAgreement,bytes,bytes)`

```solidity
function _callAgreement(address msgSender, ISuperAgreement agreementClass, bytes memory callData, bytes memory userData) internal cleanCtx() isAgreement(agreementClass) returns (bytes memory returnedData) {
    bytes4 agreementSelector = CallUtils.parseSelector(callData);
    bytes memory ctx = _updateContext(Context({appCallbackLevel: 0, callType: ContextDefinitions.CALL_INFO_CALL_TYPE_AGREEMENT, timestamp: getNow(), msgSender: msgSender, agreementSelector: agreementSelector, userData: userData, appCreditGranted: 0, appCreditWantedDeprecated: 0, appCreditUsed: 0, appAddress: address(0), appCreditToken: ISuperfluidToken(address(0))}));
    bool success;
    (success, returnedData) = _callExternalWithReplacedCtx(address(agreementClass), callData, 0, ctx);
    if (!success) {
        CallUtils.revertFromReturnedData(returnedData);
    }
    _ctxStamp = 0;
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

### isAgreement(contract ISuperAgreement)

- **Kind**: modifier
- **Source**: 43992:185:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:isAgreement(contract ISuperAgreement)`

```solidity
modifier isAgreement(ISuperAgreement agreementClass) {
    if (!isAgreementClassListed(agreementClass)) {
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
- **ISuperAgreement::agreementType()**

## State Variable Reads

- **MAX_APP_CALLBACK_LEVEL** (`uint256`)
- **CALL_INFO_CALL_TYPE_SHIFT** (`uint256`)
- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)
- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]
- **_ctxStamp** (`bytes32`)

## State Variable Writes

- **_ctxStamp** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.callAgreement(contract ISuperAgreement,bytes,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: Superfluid._callAgreement(address,contract ISuperAgreement,bytes,bytes) (NodeID: 1)
      💬 Args: [msg.sender, agreementClass, callData, userData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: CallUtils.parseSelector(bytes) (NodeID: 2)
    │   💬 Args: [callData]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Superfluid._updateContext(struct ISuperfluid.Context) (NodeID: 3)
    │   💬 Args: [Context({appCallbackLevel: 0, callType: ContextDefinitions.CALL_INFO_CALL_TYPE_AGREEMENT, timestamp: getNow(), msgSender: msgSender, agreementSelector: agreementSelector, userData: userData, appCreditGranted: 0, appCreditWantedDeprecated: 0, appCreditUsed: 0, appAddress: address(0), appCreditToken: ISuperfluidToken(address(0))})]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: Superfluid.getNow() (NodeID: 7)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ ├─ [3] ⚙️ FUNCTION: ContextDefinitions.encodeCallInfo(uint8,uint8) (NodeID: 4)
    │ │   💬 Args: [context.appCallbackLevel, context.callType]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 5)
    │ │   💬 Args: [context.appCreditWantedDeprecated]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 6)
    │     💬 Args: [context.appCreditGranted]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Superfluid._callExternalWithReplacedCtx(address,bytes,uint256,bytes) (NodeID: 8)
    │   💬 Args: [address(agreementClass), callData, 0, ctx]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: Superfluid._replacePlaceholderCtx(bytes,bytes) (NodeID: 9)
    │     💬 Args: [callData, ctx]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: CallUtils.padLength32(uint256) (NodeID: 10)
    │       💬 Args: [ctx.length]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 11)
    │   💬 Args: [returnedData]
    │   👁️  Def: internal
    ├─ [2] 🔒 MODIFIER: Superfluid.isAgreement(contract ISuperAgreement) (NodeID: 12)
    │   💬 Args: [agreementClass]
    │ └─ [3] ⚙️ FUNCTION: Superfluid.isAgreementClassListed(contract ISuperAgreement) (NodeID: 13)
    │     💬 Args: [agreementClass]
    │     👁️  Def: public
    └─ [2] 🔒 MODIFIER: Superfluid.cleanCtx() (NodeID: 14)
        💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @dev Call agreement function
 @param agreementClass The agreement address you are calling
 @param callData The contextual call data with placeholder ctx
 @param userData Extra user data being sent to the super app callbacks
