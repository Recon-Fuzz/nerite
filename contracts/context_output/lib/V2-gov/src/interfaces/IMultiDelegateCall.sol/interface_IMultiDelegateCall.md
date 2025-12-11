# Interface: IMultiDelegateCall

## Metadata

- **Name**: IMultiDelegateCall
- **Type**: Interface
- **Path**: lib/V2-gov/src/interfaces/IMultiDelegateCall.sol

## Public/External Functions

### multiDelegateCall(bytes[])

- **Signature**: `multiDelegateCall(bytes[])`
- **Visibility**: external
- **Source Range**: 335:99:31

**Signature:**
```solidity
/// @notice Call multiple functions of the contract while preserving `msg.sender`
///  @param inputs Function calls to perform, encoded using `abi.encodeCall()` or equivalent
///  @return returnValues Raw data returned by each call
function multiDelegateCall(bytes[] calldata inputs) external returns (bytes[] memory returnValues);;
```
