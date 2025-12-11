# Function: shutdown()

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `shutdown()`
- **Visibility**: external
- **Source Range**: 41602:160:275

## Implementation

```solidity
function shutdown() external {
    _requireCallerIsBorrowerOperations();
    shutdownTime = block.timestamp;
    activePool.setShutdownFlag();
}
```

## Related Implementations

### _requireCallerIsBorrowerOperations()

- **Kind**: internal
- **Source**: 53483:184:275
- **Link**: `src/TroveManager.sol:TroveManager:_requireCallerIsBorrowerOperations()`

```solidity
function _requireCallerIsBorrowerOperations() internal view {
    if (msg.sender != address(borrowerOperations)) {
        revert CallerNotBorrowerOperations();
    }
}
```

## External Calls

- **IActivePool::setShutdownFlag()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## State Variable Writes

- **shutdownTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.shutdown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
