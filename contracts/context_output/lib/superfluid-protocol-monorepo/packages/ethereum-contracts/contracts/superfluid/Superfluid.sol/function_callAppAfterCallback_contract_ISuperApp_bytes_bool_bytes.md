# Function: callAppAfterCallback(contract ISuperApp,bytes,bool,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `callAppAfterCallback(contract ISuperApp,bytes,bool,bytes)`
- **Visibility**: external
- **Source Range**: 19771:1335:163

## Implementation

```solidity
function callAppAfterCallback(ISuperApp app, bytes calldata callData, bool isTermination, bytes calldata ctx) override external onlyAgreement() assertValidCtx(ctx) returns (bytes memory newCtx) {
    (bool success, bytes memory returnedData) = _callCallback(app, false, isTermination, callData, ctx);
    if (success) {
        if (CallUtils.isValidAbiEncodedBytes(returnedData)) {
            newCtx = abi.decode(returnedData, (bytes));
            if (!_isCtxValid(newCtx)) {
                if (!isTermination) {
                    revert APP_RULE(SuperAppDefinitions.APP_RULE_CTX_IS_READONLY);
                } else {
                    newCtx = ctx;
                    _jailApp(app, SuperAppDefinitions.APP_RULE_CTX_IS_READONLY);
                }
            }
        } else {
            if (!isTermination) {
                revert APP_RULE(SuperAppDefinitions.APP_RULE_CTX_IS_MALFORMATED);
            } else {
                newCtx = ctx;
                _jailApp(app, SuperAppDefinitions.APP_RULE_CTX_IS_MALFORMATED);
            }
        }
    } else {
        newCtx = ctx;
    }
}
```

## Related Implementations

### _callCallback(contract ISuperApp,bool,bool,bytes,bytes)

- **Kind**: internal
- **Source**: 40463:1332:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_callCallback(contract ISuperApp,bool,bool,bytes,bytes)`

```solidity
function _callCallback(ISuperApp app, bool isStaticall, bool isTermination, bytes memory callData, bytes memory ctx) private returns (bool success, bytes memory returnedData) {
    assert(address(app) != address(0));
    callData = _replacePlaceholderCtx(callData, ctx);
    uint256 callbackGasLimit = CALLBACK_GAS_LIMIT;
    bool insufficientCallbackGasProvided;
    (success, insufficientCallbackGasProvided, returnedData) = isStaticall ? CallbackUtils.staticCall(address(app), callData, callbackGasLimit) : CallbackUtils.externalCall(address(app), callData, callbackGasLimit);
    if (!success) {
        if (!insufficientCallbackGasProvided) {
            if (!isTermination) {
                CallUtils.revertFromReturnedData(returnedData);
            } else {
                _jailApp(app, SuperAppDefinitions.APP_RULE_NO_REVERT_ON_TERMINATION_CALLBACK);
            }
        } else {
            revert HOST_NEED_MORE_GAS();
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

### staticCall(address,bytes,uint256)

- **Kind**: internal
- **Source**: 3338:540:154
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/CallbackUtils.sol:CallbackUtils:staticCall(address,bytes,uint256)`

```solidity
/// Make a staticcall to the target with a callback gas limit.
function staticCall(address target, bytes memory callData, uint256 callbackGasLimit) internal view returns (bool success, bool insufficientCallbackGasProvided, bytes memory returnedData) {
    uint256 gasLeftBefore = gasleft();
    (success, returnedData) = address(target).staticcall{gas: callbackGasLimit}(callData);
    if (!success) {
        if (gasleft() <= (gasLeftBefore / EIP150_MAGIC_N)) insufficientCallbackGasProvided = true;
    }
}
```

### externalCall(address,bytes,uint256)

- **Kind**: internal
- **Source**: 2734:531:154
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/CallbackUtils.sol:CallbackUtils:externalCall(address,bytes,uint256)`

```solidity
/// Make a call to the target with a callback gas limit.
function externalCall(address target, bytes memory callData, uint256 callbackGasLimit) internal returns (bool success, bool insufficientCallbackGasProvided, bytes memory returnedData) {
    uint256 gasLeftBefore = gasleft();
    (success, returnedData) = address(target).call{gas: callbackGasLimit}(callData);
    if (!success) {
        if (gasleft() <= (gasLeftBefore / EIP150_MAGIC_N)) insufficientCallbackGasProvided = true;
    }
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

### _jailApp(contract ISuperApp,uint256)

- **Kind**: internal
- **Source**: 36692:289:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_jailApp(contract ISuperApp,uint256)`

```solidity
function _jailApp(ISuperApp app, uint256 reason) internal {
    if ((_appManifests[app].configWord & SuperAppDefinitions.APP_JAIL_BIT) == 0) {
        _appManifests[app].configWord |= SuperAppDefinitions.APP_JAIL_BIT;
        emit Jail(app, reason);
    }
}
```

### isValidAbiEncodedBytes(bytes)

- **Kind**: internal
- **Source**: 3801:527:153
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/CallUtils.sol:CallUtils:isValidAbiEncodedBytes(bytes)`

```solidity
///  @dev Validate if the data is encoded correctly with abi.encode(bytesData)
///  Expected ABI Encode Layout:
///  | word 1      | word 2           | word 3           | the rest...
///  | data length | bytesData offset | bytesData length | bytesData + padLength32 zeros |
function isValidAbiEncodedBytes(bytes memory data) internal pure returns (bool) {
    if (data.length < 64) return false;
    uint bytesOffset;
    uint bytesLen;
    assembly {
        bytesOffset := mload(add(data, 32))
    }
    if (bytesOffset != 32) return false;
    assembly {
        bytesLen := mload(add(data, 64))
    }
    return data.length == (64 + padLength32(bytesLen));
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

- **unknown::unknown**
- **ISuperAgreement::agreementType()**

## State Variable Reads

- **CALLBACK_GAS_LIMIT** (`uint64`)
- **EIP150_MAGIC_N** (`uint256`)
- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]
- **_ctxStamp** (`bytes32`)
- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)
- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]

## State Variable Writes

- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.callAppAfterCallback(contract ISuperApp,bytes,bool,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Superfluid._callCallback(contract ISuperApp,bool,bool,bytes,bytes) (NodeID: 1)
  │   💬 Args: [app, false, isTermination, callData, ctx]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: Superfluid._replacePlaceholderCtx(bytes,bytes) (NodeID: 2)
  │ │   💬 Args: [callData, ctx]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: CallUtils.padLength32(uint256) (NodeID: 3)
  │ │     💬 Args: [ctx.length]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CallbackUtils.staticCall(address,bytes,uint256) (NodeID: 4)
  │ │   💬 Args: [address(app), callData, callbackGasLimit]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CallbackUtils.externalCall(address,bytes,uint256) (NodeID: 5)
  │ │   💬 Args: [address(app), callData, callbackGasLimit]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 6)
  │ │   💬 Args: [returnedData]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Superfluid._jailApp(contract ISuperApp,uint256) (NodeID: 7)
  │     💬 Args: [app, SuperAppDefinitions.APP_RULE_NO_REVERT_ON_TERMINATION_CALLBACK]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CallUtils.isValidAbiEncodedBytes(bytes) (NodeID: 8)
  │   💬 Args: [returnedData]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: CallUtils.padLength32(uint256) (NodeID: 9)
  │     💬 Args: [bytesLen]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Superfluid._isCtxValid(bytes) (NodeID: 10)
  │   💬 Args: [newCtx]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: Superfluid._jailApp(contract ISuperApp,uint256) (NodeID: 11)
  │   💬 Args: [app, SuperAppDefinitions.APP_RULE_CTX_IS_READONLY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Superfluid._jailApp(contract ISuperApp,uint256) (NodeID: 12)
  │   💬 Args: [app, SuperAppDefinitions.APP_RULE_CTX_IS_MALFORMATED]
  │   👁️  Def: internal
  ├─ [1] 🔒 MODIFIER: Superfluid.assertValidCtx(bytes) (NodeID: 13)
  │   💬 Args: [ctx]
  │ └─ [2] ⚙️ FUNCTION: Superfluid._isCtxValid(bytes) (NodeID: 14)
  │     💬 Args: [ctx]
  │     👁️  Def: private
  └─ [1] 🔒 MODIFIER: Superfluid.onlyAgreement() (NodeID: 15)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Superfluid.isAgreementClassListed(contract ISuperAgreement) (NodeID: 16)
        💬 Args: [ISuperAgreement(msg.sender)]
        👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev (For agreements) Call the app after callback
 @param  app               The super app.
 @param  callData          The call data sending to the super app.
 @param  isTermination     Is it a termination callback?
 @param  ctx               Current ctx, it will be validated.
 @return newCtx            The current context of the transaction.
