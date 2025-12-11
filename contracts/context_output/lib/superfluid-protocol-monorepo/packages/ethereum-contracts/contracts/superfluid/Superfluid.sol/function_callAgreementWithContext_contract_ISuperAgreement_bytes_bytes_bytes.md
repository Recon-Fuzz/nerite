# Function: callAgreementWithContext(contract ISuperAgreement,bytes,bytes,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `callAgreementWithContext(contract ISuperAgreement,bytes,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 26715:1210:163

## Implementation

```solidity
function callAgreementWithContext(ISuperAgreement agreementClass, bytes calldata callData, bytes calldata userData, bytes calldata ctx) override external requireValidCtx(ctx) isAgreement(agreementClass) returns (bytes memory newCtx, bytes memory returnedData) {
    Context memory context = decodeCtx(ctx);
    if (context.appAddress != msg.sender) revert HOST_CALL_AGREEMENT_WITH_CTX_FROM_WRONG_ADDRESS();
    address oldSender = context.msgSender;
    context.msgSender = msg.sender;
    context.userData = userData;
    newCtx = _updateContext(context);
    bool success;
    (success, returnedData) = _callExternalWithReplacedCtx(address(agreementClass), callData, 0, newCtx);
    if (success) {
        (newCtx) = abi.decode(returnedData, (bytes));
        assert(_isCtxValid(newCtx));
        context = decodeCtx(newCtx);
        context.msgSender = oldSender;
        newCtx = _updateContext(context);
    } else {
        CallUtils.revertFromReturnedData(returnedData);
    }
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

### requireValidCtx(bytes)

- **Kind**: modifier
- **Source**: 43595:155:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:requireValidCtx(bytes)`

```solidity
modifier requireValidCtx(bytes memory ctx) {
    if (!_isCtxValid(ctx)) revert APP_RULE(SuperAppDefinitions.APP_RULE_CTX_IS_READONLY);
    _;
}
```

## External Calls

- **unknown::unknown**
- **ISuperAgreement::agreementType()**

## State Variable Reads

- **CALL_INFO_APP_LEVEL_MASK** (`uint256`)
- **CALL_INFO_CALL_TYPE_MASK** (`uint256`)
- **CALL_INFO_CALL_TYPE_SHIFT** (`uint256`)
- **MAX_APP_CALLBACK_LEVEL** (`uint256`)
- **_ctxStamp** (`bytes32`)
- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)
- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]

## State Variable Writes

- **_ctxStamp** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.callAgreementWithContext(contract ISuperAgreement,bytes,bytes,bytes) (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: Superfluid._updateContext(struct ISuperfluid.Context) (NodeID: 4)
  │   💬 Args: [context]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: ContextDefinitions.encodeCallInfo(uint8,uint8) (NodeID: 5)
  │ │   💬 Args: [context.appCallbackLevel, context.callType]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 6)
  │ │   💬 Args: [context.appCreditWantedDeprecated]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 7)
  │     💬 Args: [context.appCreditGranted]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Superfluid._callExternalWithReplacedCtx(address,bytes,uint256,bytes) (NodeID: 8)
  │   💬 Args: [address(agreementClass), callData, 0, newCtx]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: Superfluid._replacePlaceholderCtx(bytes,bytes) (NodeID: 9)
  │     💬 Args: [callData, ctx]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: CallUtils.padLength32(uint256) (NodeID: 10)
  │       💬 Args: [ctx.length]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Superfluid._isCtxValid(bytes) (NodeID: 11)
  │   💬 Args: [newCtx]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: Superfluid.decodeCtx(bytes) (NodeID: 12)
  │   💬 Args: [newCtx]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Superfluid._decodeCtx(bytes) (NodeID: 13)
  │     💬 Args: [ctx]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: ContextDefinitions.decodeCallInfo(uint256) (NodeID: 14)
  │       💬 Args: [callInfo]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Superfluid._updateContext(struct ISuperfluid.Context) (NodeID: 15)
  │   💬 Args: [context]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: ContextDefinitions.encodeCallInfo(uint8,uint8) (NodeID: 16)
  │ │   💬 Args: [context.appCallbackLevel, context.callType]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 17)
  │ │   💬 Args: [context.appCreditWantedDeprecated]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 18)
  │     💬 Args: [context.appCreditGranted]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 19)
  │   💬 Args: [returnedData]
  │   👁️  Def: internal
  ├─ [1] 🔒 MODIFIER: Superfluid.isAgreement(contract ISuperAgreement) (NodeID: 20)
  │   💬 Args: [agreementClass]
  │ └─ [2] ⚙️ FUNCTION: Superfluid.isAgreementClassListed(contract ISuperAgreement) (NodeID: 21)
  │     💬 Args: [agreementClass]
  │     👁️  Def: public
  └─ [1] 🔒 MODIFIER: Superfluid.requireValidCtx(bytes) (NodeID: 22)
      💬 Args: [ctx]
    └─ [2] ⚙️ FUNCTION: Superfluid._isCtxValid(bytes) (NodeID: 23)
        💬 Args: [ctx]
        👁️  Def: private
```
