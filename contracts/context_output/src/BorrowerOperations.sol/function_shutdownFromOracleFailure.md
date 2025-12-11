# Function: shutdownFromOracleFailure()

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `shutdownFromOracleFailure()`
- **Visibility**: external
- **Source Range**: 49039:316:205

## Implementation

```solidity
function shutdownFromOracleFailure() external {
    _requireCallerIsPriceFeed();
    if (hasBeenShutDown) return;
    _applyShutdown();
}
```

## Related Implementations

### _requireCallerIsPriceFeed()

- **Kind**: internal
- **Source**: 61442:157:205
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireCallerIsPriceFeed()`

```solidity
function _requireCallerIsPriceFeed() internal view {
    if (msg.sender != address(priceFeed)) {
        revert CallerNotPriceFeed();
    }
}
```

### _applyShutdown()

- **Kind**: internal
- **Source**: 49361:145:205
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_applyShutdown()`

```solidity
function _applyShutdown() internal {
    activePool.mintAggInterest();
    hasBeenShutDown = true;
    troveManager.shutdown();
}
```

## External Calls

- **IActivePool::mintAggInterest()**
- **ITroveManager::shutdown()**

## State Variable Reads

- **hasBeenShutDown** (`bool`)
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

## State Variable Writes

- **hasBeenShutDown** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.shutdownFromOracleFailure() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireCallerIsPriceFeed() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._applyShutdown() (NodeID: 2)
      💬 Args: [no args]
      👁️  Def: internal
```
