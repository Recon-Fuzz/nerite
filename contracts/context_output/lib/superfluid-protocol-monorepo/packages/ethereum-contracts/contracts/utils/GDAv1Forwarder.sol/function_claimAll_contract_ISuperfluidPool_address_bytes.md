# Function: claimAll(contract ISuperfluidPool,address,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

## Metadata

- **Contract**: GDAv1Forwarder
- **Signature**: `claimAll(contract ISuperfluidPool,address,bytes)`
- **Visibility**: external
- **Source Range**: 2734:315:176

## Implementation

```solidity
///  @dev Claims all tokens from the pool.
///  @param pool The Superfluid Pool to claim from.
///  @param memberAddress The address of the member to claim for.
///  @param userData User-specific data.
function claimAll(ISuperfluidPool pool, address memberAddress, bytes memory userData) external returns (bool success) {
    bytes memory callData = abi.encodeCall(_gda.claimAll, (pool, memberAddress, new bytes(0)));
    return _forwardBatchCall(address(_gda), callData, userData);
}
```

## Related Implementations

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

- **_gda** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GDAv1Forwarder.claimAll(contract ISuperfluidPool,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ForwarderBase._forwardBatchCall(address,bytes,bytes) (NodeID: 1)
      💬 Args: [address(_gda), callData, userData]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ForwarderBase._forwardBatchCall(struct ISuperfluid.Operation[]) (NodeID: 2)
        💬 Args: [ops]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ForwarderBase._forwardBatchCallWithValue(struct ISuperfluid.Operation[],uint256) (NodeID: 3)
          💬 Args: [ops, 0]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: CallUtils.revertFromReturnedData(bytes) (NodeID: 4)
            💬 Args: [returnedData]
            👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev Claims all tokens from the pool.
 @param pool The Superfluid Pool to claim from.
 @param memberAddress The address of the member to claim for.
 @param userData User-specific data.
