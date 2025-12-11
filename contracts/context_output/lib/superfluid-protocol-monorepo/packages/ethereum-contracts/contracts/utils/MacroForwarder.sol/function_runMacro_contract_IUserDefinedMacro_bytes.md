# Function: runMacro(contract IUserDefinedMacro,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/MacroForwarder.sol/contract_MacroForwarder.md]

## Metadata

- **Contract**: MacroForwarder
- **Signature**: `runMacro(contract IUserDefinedMacro,bytes)`
- **Visibility**: external
- **Source Range**: 1301:334:177

## Implementation

```solidity
///  @dev Run the macro defined by the provided macro contract and params.
///  @param  m      Target macro.
///  @param  params Parameters to run the macro.
///  If value (native coins) is provided, it is forwarded.
function runMacro(IUserDefinedMacro m, bytes calldata params) external payable returns (bool) {
    ISuperfluid.Operation[] memory operations = buildBatchOperations(m, params);
    bool retVal = _forwardBatchCallWithValue(operations, msg.value);
    m.postCheck(_host, params, msg.sender);
    return retVal;
}
```

## Related Implementations

### buildBatchOperations(contract IUserDefinedMacro,bytes)

- **Kind**: internal
- **Source**: 825:229:177
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/MacroForwarder.sol:MacroForwarder:buildBatchOperations(contract IUserDefinedMacro,bytes)`

```solidity
///  @dev A convenience view wrapper for building the batch operations using a macro.
///  @param  m          Target macro.
///  @param  params     Parameters to simulate the macro.
///  @return operations Operations returned by the macro after the simulation.
function buildBatchOperations(IUserDefinedMacro m, bytes calldata params) public view returns (ISuperfluid.Operation[] memory operations) {
    operations = m.buildBatchOperations(_host, params, msg.sender);
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

- **IUserDefinedMacro::postCheck(contract ISuperfluid,bytes,address)**
- **IUserDefinedMacro::buildBatchOperations(contract ISuperfluid,bytes,address)**
- **unknown::unknown**

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MacroForwarder.runMacro(contract IUserDefinedMacro,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: MacroForwarder.buildBatchOperations(contract IUserDefinedMacro,bytes) (NodeID: 1)
  │   💬 Args: [m, params]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ForwarderBase._forwardBatchCallWithValue(struct ISuperfluid.Operation[],uint256) (NodeID: 2)
      💬 Args: [operations, msg.value]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 3)
        💬 Args: [returnedData]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev Run the macro defined by the provided macro contract and params.
 @param  m      Target macro.
 @param  params Parameters to run the macro.
 If value (native coins) is provided, it is forwarded.
