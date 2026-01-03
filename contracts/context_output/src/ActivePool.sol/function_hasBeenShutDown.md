# Function: hasBeenShutDown()

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `hasBeenShutDown()`
- **Visibility**: external
- **Source Range**: 13832:97:51

## Implementation

```solidity
function hasBeenShutDown() external view returns (bool) {
    return shutdownTime != 0;
}
```

## State Variable Reads

- **shutdownTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.hasBeenShutDown() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
