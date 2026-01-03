# Function: setShutdownFlag()

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `setShutdownFlag()`
- **Visibility**: external
- **Source Range**: 13703:123:51

## Implementation

```solidity
function setShutdownFlag() external {
    _requireCallerIsTroveManager();
    shutdownTime = block.timestamp;
}
```

## Related Implementations

### _requireCallerIsTroveManager()

- **Kind**: internal
- **Source**: 15101:155:51
- **Link**: `src/ActivePool.sol:ActivePool:_requireCallerIsTroveManager()`

```solidity
function _requireCallerIsTroveManager() internal view {
    require(msg.sender == troveManagerAddress, "ActivePool: Caller is not TroveManager");
}
```

## State Variable Reads

- **troveManagerAddress** (`address`)

## State Variable Writes

- **shutdownTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.setShutdownFlag() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ActivePool._requireCallerIsTroveManager() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
