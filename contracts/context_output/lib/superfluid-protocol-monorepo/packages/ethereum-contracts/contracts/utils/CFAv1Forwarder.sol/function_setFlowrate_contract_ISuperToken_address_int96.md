# Function: setFlowrate(contract ISuperToken,address,int96)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]

## Metadata

- **Contract**: CFAv1Forwarder
- **Signature**: `setFlowrate(contract ISuperToken,address,int96)`
- **Visibility**: external
- **Source Range**: 1896:176:173

## Implementation

```solidity
///  @notice Sets the given flowrate between msg.sender and a given receiver.
///  If there's no pre-existing flow and `flowrate` non-zero, a new flow is created.
///  If there's an existing flow and `flowrate` non-zero, the flowrate of that flow is updated.
///  If there's an existing flow and `flowrate` zero, the flow is deleted.
///  If the existing and given flowrate are equal, no action is taken.
///  On creation of a flow, a "buffer" amount is automatically detracted from the sender account's available balance.
///  If the sender account is solvent when the flow is deleted, this buffer is redeemed to it.
///  @param token Super token address
///  @param receiver The receiver of the flow
///  @param flowrate The wanted flowrate in wad/second. Only positive values are valid here.
///  @return bool
function setFlowrate(ISuperToken token, address receiver, int96 flowrate) external returns (bool) {
    return _setFlowrateFrom(token, msg.sender, receiver, flowrate);
}
```

## Related Implementations

### _setFlowrateFrom(contract ISuperToken,address,address,int96)

- **Kind**: internal
- **Source**: 12621:885:173
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol:CFAv1Forwarder:_setFlowrateFrom(contract ISuperToken,address,address,int96)`

```solidity
function _setFlowrateFrom(ISuperToken token, address sender, address receiver, int96 flowrate) internal returns (bool) {
    (, int96 prevFlowRate, , ) = _cfa.getFlow(token, sender, receiver);
    if (flowrate > 0) {
        if (prevFlowRate == 0) {
            return _createFlow(token, sender, receiver, flowrate, new bytes(0));
        } else if (prevFlowRate != flowrate) {
            return _updateFlow(token, sender, receiver, flowrate, new bytes(0));
        }
        return true;
    } else if (flowrate == 0) {
        if (prevFlowRate > 0) {
            return _deleteFlow(token, sender, receiver, new bytes(0));
        }
        return true;
    } else {
        revert CFA_FWD_INVALID_FLOW_RATE();
    }
}
```

### _createFlow(contract ISuperToken,address,address,int96,bytes)

- **Kind**: internal
- **Source**: 13512:866:173
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol:CFAv1Forwarder:_createFlow(contract ISuperToken,address,address,int96,bytes)`

```solidity
function _createFlow(ISuperToken token, address sender, address receiver, int96 flowrate, bytes memory userData) internal returns (bool) {
    bytes memory cfaCallData = (sender == msg.sender) ? abi.encodeCall(_cfa.createFlow, (token, receiver, flowrate, new bytes(0))) : abi.encodeCall(_cfa.createFlowByOperator, (token, sender, receiver, flowrate, new bytes(0)));
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

### _updateFlow(contract ISuperToken,address,address,int96,bytes)

- **Kind**: internal
- **Source**: 14384:866:173
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol:CFAv1Forwarder:_updateFlow(contract ISuperToken,address,address,int96,bytes)`

```solidity
function _updateFlow(ISuperToken token, address sender, address receiver, int96 flowrate, bytes memory userData) internal returns (bool) {
    bytes memory cfaCallData = (sender == msg.sender) ? abi.encodeCall(_cfa.updateFlow, (token, receiver, flowrate, new bytes(0))) : abi.encodeCall(_cfa.updateFlowByOperator, (token, sender, receiver, flowrate, new bytes(0)));
    return _forwardBatchCall(address(_cfa), cfaCallData, userData);
}
```

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

## External Calls

- **IConstantFlowAgreementV1::getFlow(contract ISuperfluidToken,address,address)**
- **unknown::unknown**

## State Variable Reads

- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CFAv1Forwarder.setFlowrate(contract ISuperToken,address,int96) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: CFAv1Forwarder._setFlowrateFrom(contract ISuperToken,address,address,int96) (NodeID: 1)
      💬 Args: [token, msg.sender, receiver, flowrate]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: CFAv1Forwarder._createFlow(contract ISuperToken,address,address,int96,bytes) (NodeID: 2)
    │   💬 Args: [token, sender, receiver, flowrate, new bytes(0)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ForwarderBase._forwardBatchCall(address,bytes,bytes) (NodeID: 3)
    │     💬 Args: [address(_cfa), cfaCallData, userData]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: ForwarderBase._forwardBatchCall(struct ISuperfluid.Operation[]) (NodeID: 4)
    │       💬 Args: [ops]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: ForwarderBase._forwardBatchCallWithValue(struct ISuperfluid.Operation[],uint256) (NodeID: 5)
    │         💬 Args: [ops, 0]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 6)
    │           💬 Args: [returnedData]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: CFAv1Forwarder._updateFlow(contract ISuperToken,address,address,int96,bytes) (NodeID: 7)
    │   💬 Args: [token, sender, receiver, flowrate, new bytes(0)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ForwarderBase._forwardBatchCall(address,bytes,bytes) (NodeID: 8)
    │     💬 Args: [address(_cfa), cfaCallData, userData]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: ForwarderBase._forwardBatchCall(struct ISuperfluid.Operation[]) (NodeID: 9)
    │       💬 Args: [ops]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: ForwarderBase._forwardBatchCallWithValue(struct ISuperfluid.Operation[],uint256) (NodeID: 10)
    │         💬 Args: [ops, 0]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 11)
    │           💬 Args: [returnedData]
    │           👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: CFAv1Forwarder._deleteFlow(contract ISuperToken,address,address,bytes) (NodeID: 12)
        💬 Args: [token, sender, receiver, new bytes(0)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ForwarderBase._forwardBatchCall(address,bytes,bytes) (NodeID: 13)
          💬 Args: [address(_cfa), cfaCallData, userData]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: ForwarderBase._forwardBatchCall(struct ISuperfluid.Operation[]) (NodeID: 14)
            💬 Args: [ops]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: ForwarderBase._forwardBatchCallWithValue(struct ISuperfluid.Operation[],uint256) (NodeID: 15)
              💬 Args: [ops, 0]
              👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 16)
                💬 Args: [returnedData]
                👁️  Def: internal
```

## Documentation

### Function Documentation

 @notice Sets the given flowrate between msg.sender and a given receiver.
 If there's no pre-existing flow and `flowrate` non-zero, a new flow is created.
 If there's an existing flow and `flowrate` non-zero, the flowrate of that flow is updated.
 If there's an existing flow and `flowrate` zero, the flow is deleted.
 If the existing and given flowrate are equal, no action is taken.
 On creation of a flow, a "buffer" amount is automatically detracted from the sender account's available balance.
 If the sender account is solvent when the flow is deleted, this buffer is redeemed to it.
 @param token Super token address
 @param receiver The receiver of the flow
 @param flowrate The wanted flowrate in wad/second. Only positive values are valid here.
 @return bool
