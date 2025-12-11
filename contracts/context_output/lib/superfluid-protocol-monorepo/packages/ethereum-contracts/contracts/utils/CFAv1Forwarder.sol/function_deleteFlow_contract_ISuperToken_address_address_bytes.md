# Function: deleteFlow(contract ISuperToken,address,address,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]

## Metadata

- **Contract**: CFAv1Forwarder
- **Signature**: `deleteFlow(contract ISuperToken,address,address,bytes)`
- **Visibility**: external
- **Source Range**: 8924:240:173

## Implementation

```solidity
///  @notice Low-level wrapper of deleteFlow/deleteFlowByOperator.
///  If msg.sender isn't the same as sender address, msg.sender needs to have permission
///  to delete flows on behalf of the given sender account.
///  @param token Super token address
///  @param sender Sender address of the flow
///  @param receiver Receiver address of the flow
///  @param userData (optional) User data to be set. Should be set to zero if not needed.
///  @return bool
function deleteFlow(ISuperToken token, address sender, address receiver, bytes memory userData) external returns (bool) {
    return _deleteFlow(token, sender, receiver, userData);
}
```

## Related Implementations

### _deleteFlow(contract ISuperToken,address,address,bytes)

- **Kind**: internal
- **Source**: 15256:836:173
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol:CFAv1Forwarder:_deleteFlow(contract ISuperToken,address,address,bytes)`

```solidity
function _deleteFlow(ISuperToken token, address sender, address receiver, bytes memory userData) internal returns (bool) {
    bytes memory cfaCallData = ((sender == msg.sender) || (receiver == msg.sender)) ? abi.encodeCall(_cfa.deleteFlow, (token, sender, receiver, new bytes(0))) : abi.encodeCall(_cfa.deleteFlowByOperator, (token, sender, receiver, new bytes(0)));
    return _forwardBatchCall(address(_cfa), cfaCallData, userData);
}
```

### _forwardBatchCall(address,bytes,bytes)

- **Kind**: internal
- **Source**: 438:468:175
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/ForwarderBase.sol:ForwarderBase:_forwardBatchCall(address,bytes,bytes)`

```solidity
function _forwardBatchCall(address target, bytes memory callData, bytes memory userData) internal returns (bool) {
    ISuperfluid.Operation[] memory ops = new ISuperfluid.Operation[](1);
    ops[0] = ISuperfluid.Operation(BatchOperation.OPERATION_TYPE_SUPERFLUID_CALL_AGREEMENT, address(target), abi.encode(callData, userData));
    return _forwardBatchCall(ops);
}
```

### _forwardBatchCall(struct ISuperfluid.Operation[])

- **Kind**: internal
- **Source**: 912:145:175
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/ForwarderBase.sol:ForwarderBase:_forwardBatchCall(struct ISuperfluid.Operation[])`

```solidity
function _forwardBatchCall(ISuperfluid.Operation[] memory ops) internal returns (bool) {
    return _forwardBatchCallWithValue(ops, 0);
}
```

### _forwardBatchCallWithValue(struct ISuperfluid.Operation[],uint256)

- **Kind**: internal
- **Source**: 1063:731:175
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/ForwarderBase.sol:ForwarderBase:_forwardBatchCallWithValue(struct ISuperfluid.Operation[],uint256)`

```solidity
function _forwardBatchCallWithValue(ISuperfluid.Operation[] memory ops, uint256 valueToForward) internal returns (bool) {
    bytes memory fwBatchCallData = abi.encodeCall(_host.forwardBatchCall, (ops));
    (bool success, bytes memory returnedData) = address(_host).call{value: valueToForward}(abi.encodePacked(fwBatchCallData, msg.sender));
    if (!success) {
        CallUtils.revertFromReturnedData(returnedData);
    }
    return true;
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

## External Calls

- **unknown::unknown**

## State Variable Reads

- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CFAv1Forwarder.deleteFlow(contract ISuperToken,address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: CFAv1Forwarder._deleteFlow(contract ISuperToken,address,address,bytes) (NodeID: 1)
      💬 Args: [token, sender, receiver, userData]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ForwarderBase._forwardBatchCall(address,bytes,bytes) (NodeID: 2)
        💬 Args: [address(_cfa), cfaCallData, userData]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ForwarderBase._forwardBatchCall(struct ISuperfluid.Operation[]) (NodeID: 3)
          💬 Args: [ops]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: ForwarderBase._forwardBatchCallWithValue(struct ISuperfluid.Operation[],uint256) (NodeID: 4)
            💬 Args: [ops, 0]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 5)
              💬 Args: [returnedData]
              👁️  Def: internal
```

## Documentation

### Function Documentation

 @notice Low-level wrapper of deleteFlow/deleteFlowByOperator.
 If msg.sender isn't the same as sender address, msg.sender needs to have permission
 to delete flows on behalf of the given sender account.
 @param token Super token address
 @param sender Sender address of the flow
 @param receiver Receiver address of the flow
 @param userData (optional) User data to be set. Should be set to zero if not needed.
 @return bool
