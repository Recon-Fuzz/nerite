# Function: multiDelegateCall(bytes[])

**Contract**: [lib/V2-gov/src/utils/MultiDelegateCall.sol/contract_MultiDelegateCall.md]

## Metadata

- **Contract**: MultiDelegateCall
- **Signature**: `multiDelegateCall(bytes[])`
- **Visibility**: external
- **Source Range**: 226:698:36

## Implementation

```solidity
/// @inheritdoc IMultiDelegateCall
function multiDelegateCall(bytes[] calldata inputs) external returns (bytes[] memory returnValues) {
    returnValues = new bytes[](inputs.length);
    for (uint256 i; i < inputs.length; ++i) {
        (bool success, bytes memory returnData) = address(this).delegatecall(inputs[i]);
        if (!success) {
            assembly {
                revert(add(32, returnData), mload(returnData))
            }
        }
        returnValues[i] = returnData;
    }
}
```

## External Calls

- **address::delegatecall(bytes calldata)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MultiDelegateCall.multiDelegateCall(bytes[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IMultiDelegateCall

### Interface Documentation

@notice Call multiple functions of the contract while preserving `msg.sender`
 @param inputs Function calls to perform, encoded using `abi.encodeCall()` or equivalent
 @return returnValues Raw data returned by each call
