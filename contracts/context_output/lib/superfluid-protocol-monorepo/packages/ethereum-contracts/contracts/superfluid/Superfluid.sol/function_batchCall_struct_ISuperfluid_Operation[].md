# Function: batchCall(struct ISuperfluid.Operation[])

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `batchCall(struct ISuperfluid.Operation[])`
- **Visibility**: external
- **Source Range**: 35429:162:163

## Implementation

```solidity
/// @dev ISuperfluid.batchCall implementation
function batchCall(Operation[] calldata operations) override external payable {
    _batchCall(payable(msg.sender), operations);
}
```

## Related Implementations

### _batchCall(address payable,struct ISuperfluid.Operation[])

- **Kind**: internal
- **Source**: 29541:5832:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_batchCall(address payable,struct ISuperfluid.Operation[])`

```solidity
function _batchCall(address payable msgSender, Operation[] calldata operations) internal {
    for (uint256 i = 0; i < operations.length; ++i) {
        uint32 operationType = operations[i].operationType;
        if (operationType == BatchOperation.OPERATION_TYPE_ERC20_APPROVE) {
            (address spender, uint256 amount) = abi.decode(operations[i].data, (address, uint256));
            ISuperToken(operations[i].target).operationApprove(msgSender, spender, amount);
        } else if (operationType == BatchOperation.OPERATION_TYPE_ERC20_TRANSFER_FROM) {
            (address sender, address receiver, uint256 amount) = abi.decode(operations[i].data, (address, address, uint256));
            ISuperToken(operations[i].target).operationTransferFrom(msgSender, sender, receiver, amount);
        } else if (operationType == BatchOperation.OPERATION_TYPE_ERC777_SEND) {
            (address recipient, uint256 amount, bytes memory userData) = abi.decode(operations[i].data, (address, uint256, bytes));
            ISuperToken(operations[i].target).operationSend(msgSender, recipient, amount, userData);
        } else if (operationType == BatchOperation.OPERATION_TYPE_ERC20_INCREASE_ALLOWANCE) {
            (address spender, uint256 addedValue) = abi.decode(operations[i].data, (address, uint256));
            ISuperToken(operations[i].target).operationIncreaseAllowance(msgSender, spender, addedValue);
        } else if (operationType == BatchOperation.OPERATION_TYPE_ERC20_DECREASE_ALLOWANCE) {
            (address spender, uint256 subtractedValue) = abi.decode(operations[i].data, (address, uint256));
            ISuperToken(operations[i].target).operationDecreaseAllowance(msgSender, spender, subtractedValue);
        } else if (operationType == BatchOperation.OPERATION_TYPE_SUPERTOKEN_UPGRADE) {
            ISuperToken(operations[i].target).operationUpgrade(msgSender, abi.decode(operations[i].data, (uint256)));
        } else if (operationType == BatchOperation.OPERATION_TYPE_SUPERTOKEN_DOWNGRADE) {
            ISuperToken(operations[i].target).operationDowngrade(msgSender, abi.decode(operations[i].data, (uint256)));
        } else if (operationType == BatchOperation.OPERATION_TYPE_SUPERTOKEN_UPGRADE_TO) {
            (address to, uint256 amount) = abi.decode(operations[i].data, (address, uint256));
            ISuperToken(operations[i].target).operationUpgradeTo(msgSender, to, amount);
        } else if (operationType == BatchOperation.OPERATION_TYPE_SUPERTOKEN_DOWNGRADE_TO) {
            (address to, uint256 amount) = abi.decode(operations[i].data, (address, uint256));
            ISuperToken(operations[i].target).operationDowngradeTo(msgSender, to, amount);
        } else if (operationType == BatchOperation.OPERATION_TYPE_SUPERFLUID_CALL_AGREEMENT) {
            (bytes memory callData, bytes memory userData) = abi.decode(operations[i].data, (bytes, bytes));
            _callAgreement(msgSender, ISuperAgreement(operations[i].target), callData, userData);
        } else if (operationType == BatchOperation.OPERATION_TYPE_SUPERFLUID_CALL_APP_ACTION) {
            _callAppAction(msgSender, ISuperApp(operations[i].target), address(this).balance, operations[i].data);
        } else if (operationType == BatchOperation.OPERATION_TYPE_SIMPLE_FORWARD_CALL) {
            (bool success, bytes memory returnData) = SIMPLE_FORWARDER.forwardCall{value: address(this).balance}(operations[i].target, operations[i].data);
            if (!success) {
                CallUtils.revertFromReturnedData(returnData);
            }
        } else if (operationType == BatchOperation.OPERATION_TYPE_ERC2771_FORWARD_CALL) {
            (bool success, bytes memory returnData) = _ERC2771_FORWARDER.forward2771Call{value: address(this).balance}(operations[i].target, msgSender, operations[i].data);
            if (!success) {
                CallUtils.revertFromReturnedData(returnData);
            }
        } else {
            revert HOST_UNKNOWN_BATCH_CALL_OPERATION_TYPE();
        }
    }
    if (address(this).balance != 0) {
        msgSender.transfer(address(this).balance);
    }
}
```

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

### _isCtxValid(bytes)

- **Kind**: internal
- **Source**: 39285:137:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_isCtxValid(bytes)`

```solidity
function _isCtxValid(bytes memory ctx) private view returns (bool) {
    return (ctx.length != 0) && (keccak256(ctx) == _ctxStamp);
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

## External Calls

- **ISuperToken::operationApprove(address,address,uint256)**
- **ISuperToken::operationTransferFrom(address,address,address,uint256)**
- **ISuperToken::operationSend(address,address,uint256,bytes)**
- **ISuperToken::operationIncreaseAllowance(address,address,uint256)**
- **ISuperToken::operationDecreaseAllowance(address,address,uint256)**
- **ISuperToken::operationUpgrade(address,uint256)**
- **ISuperToken::operationDowngrade(address,uint256)**
- **ISuperToken::operationUpgradeTo(address,address,uint256)**
- **ISuperToken::operationDowngradeTo(address,address,uint256)**
- **unknown::unknown**
- **ISuperAgreement::agreementType()**

## State Variable Reads

- **SIMPLE_FORWARDER** (`contract SimpleForwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SimpleForwarder.sol/contract_SimpleForwarder.md]
- **_ERC2771_FORWARDER** (`contract ERC2771Forwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/ERC2771Forwarder.sol/contract_ERC2771Forwarder.md]
- **MAX_APP_CALLBACK_LEVEL** (`uint256`)
- **CALL_INFO_CALL_TYPE_SHIFT** (`uint256`)
- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)
- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]
- **_ctxStamp** (`bytes32`)
- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]

## State Variable Writes

- **_ctxStamp** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.batchCall(struct ISuperfluid.Operation[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: Superfluid._batchCall(address payable,struct ISuperfluid.Operation[]) (NodeID: 1)
      💬 Args: [payable(msg.sender), operations]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Superfluid._callAgreement(address,contract ISuperAgreement,bytes,bytes) (NodeID: 2)
    │   💬 Args: [msgSender, ISuperAgreement(operations[i].target), callData, userData]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: CallUtils.parseSelector(bytes) (NodeID: 3)
    │ │   💬 Args: [callData]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Superfluid._updateContext(struct ISuperfluid.Context) (NodeID: 4)
    │ │   💬 Args: [Context({appCallbackLevel: 0, callType: ContextDefinitions.CALL_INFO_CALL_TYPE_AGREEMENT, timestamp: getNow(), msgSender: msgSender, agreementSelector: agreementSelector, userData: userData, appCreditGranted: 0, appCreditWantedDeprecated: 0, appCreditUsed: 0, appAddress: address(0), appCreditToken: ISuperfluidToken(address(0))})]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: Superfluid.getNow() (NodeID: 8)
    │ │ │   💬 Args: [no args]
    │ │ │   👁️  Def: public
    │ │ ├─ [4] ⚙️ FUNCTION: ContextDefinitions.encodeCallInfo(uint8,uint8) (NodeID: 5)
    │ │ │   💬 Args: [context.appCallbackLevel, context.callType]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 6)
    │ │ │   💬 Args: [context.appCreditWantedDeprecated]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 7)
    │ │     💬 Args: [context.appCreditGranted]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Superfluid._callExternalWithReplacedCtx(address,bytes,uint256,bytes) (NodeID: 9)
    │ │   💬 Args: [address(agreementClass), callData, 0, ctx]
    │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: Superfluid._replacePlaceholderCtx(bytes,bytes) (NodeID: 10)
    │ │     💬 Args: [callData, ctx]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: CallUtils.padLength32(uint256) (NodeID: 11)
    │ │       💬 Args: [ctx.length]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 12)
    │ │   💬 Args: [returnedData]
    │ │   👁️  Def: internal
    │ ├─ [3] 🔒 MODIFIER: Superfluid.isAgreement(contract ISuperAgreement) (NodeID: 13)
    │ │   💬 Args: [ISuperAgreement(operations[i].target)]
    │ │ └─ [4] ⚙️ FUNCTION: Superfluid.isAgreementClassListed(contract ISuperAgreement) (NodeID: 14)
    │ │     💬 Args: [ISuperAgreement(operations[i].target)]
    │ │     👁️  Def: public
    │ └─ [3] 🔒 MODIFIER: Superfluid.cleanCtx() (NodeID: 15)
    │     💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: Superfluid._callAppAction(address,contract ISuperApp,uint256,bytes) (NodeID: 16)
    │   💬 Args: [msgSender, ISuperApp(operations[i].target), address(this).balance, operations[i].data]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Superfluid._updateContext(struct ISuperfluid.Context) (NodeID: 17)
    │ │   💬 Args: [Context({appCallbackLevel: 0, callType: ContextDefinitions.CALL_INFO_CALL_TYPE_APP_ACTION, timestamp: getNow(), msgSender: msgSender, agreementSelector: 0, userData: "", appCreditGranted: 0, appCreditWantedDeprecated: 0, appCreditUsed: 0, appAddress: address(app), appCreditToken: ISuperfluidToken(address(0))})]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: Superfluid.getNow() (NodeID: 21)
    │ │ │   💬 Args: [no args]
    │ │ │   👁️  Def: public
    │ │ ├─ [4] ⚙️ FUNCTION: ContextDefinitions.encodeCallInfo(uint8,uint8) (NodeID: 18)
    │ │ │   💬 Args: [context.appCallbackLevel, context.callType]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 19)
    │ │ │   💬 Args: [context.appCreditWantedDeprecated]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 20)
    │ │     💬 Args: [context.appCreditGranted]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Superfluid._callExternalWithReplacedCtx(address,bytes,uint256,bytes) (NodeID: 22)
    │ │   💬 Args: [address(app), callData, value, ctx]
    │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: Superfluid._replacePlaceholderCtx(bytes,bytes) (NodeID: 23)
    │ │     💬 Args: [callData, ctx]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: CallUtils.padLength32(uint256) (NodeID: 24)
    │ │       💬 Args: [ctx.length]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Superfluid._isCtxValid(bytes) (NodeID: 25)
    │ │   💬 Args: [ctx]
    │ │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 26)
    │ │   💬 Args: [returnedData]
    │ │   👁️  Def: internal
    │ ├─ [3] 🔒 MODIFIER: Superfluid.isValidAppAction(bytes) (NodeID: 27)
    │ │   💬 Args: [operations[i].data]
    │ │ └─ [4] ⚙️ FUNCTION: CallUtils.parseSelector(bytes) (NodeID: 28)
    │ │     💬 Args: [operations[i].data]
    │ │     👁️  Def: internal
    │ ├─ [3] 🔒 MODIFIER: Superfluid.isAppActive(contract ISuperApp) (NodeID: 29)
    │ │   💬 Args: [ISuperApp(operations[i].target)]
    │ │ └─ [4] ⚙️ FUNCTION: SuperAppDefinitions.isAppJailed(uint256) (NodeID: 30)
    │ │     💬 Args: [configWord]
    │ │     👁️  Def: internal
    │ └─ [3] 🔒 MODIFIER: Superfluid.cleanCtx() (NodeID: 31)
    │     💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 32)
    │   💬 Args: [returnData]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 33)
        💬 Args: [returnData]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev ISuperfluid.batchCall implementation

### Interface Documentation

 @dev Batch call function
 @param operations Array of batch operations
 NOTE: `batchCall` is `payable, because there's limited support for sending
 native tokens to batch operation targets.
 If value is > 0, the whole amount is sent to the first operation matching any of:
 - OPERATION_TYPE_SUPERFLUID_CALL_APP_ACTION
 - OPERATION_TYPE_SIMPLE_FORWARD_CALL
 - OPERATION_TYPE_ERC2771_FORWARD_CALL
 If the first such operation does not allow receiving native tokens,
 the transaction will revert.
 It's currently not possible to send native tokens to multiple operations, or to
 any but the first operation of one of the above mentioned types.
 If no such operation is included, the native tokens will be sent back to the sender.
