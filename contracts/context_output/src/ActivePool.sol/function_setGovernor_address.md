# Function: setGovernor(address)

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `setGovernor(address)`
- **Visibility**: external
- **Source Range**: 15389:99:202

## Implementation

```solidity
function setGovernor(address _governor) external onlyGovernor() {
    governor = _governor;
}
```

## Related Implementations

### onlyGovernor()

- **Kind**: modifier
- **Source**: 15262:121:202
- **Link**: `src/ActivePool.sol:ActivePool:onlyGovernor()`

```solidity
modifier onlyGovernor() {
    require(msg.sender == governor, "ActivePool: Caller is not Governor");
    _;
}
```

## State Variable Reads

- **governor** (`address`)

## State Variable Writes

- **governor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.setGovernor(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: ActivePool.onlyGovernor() (NodeID: 1)
      💬 Args: [no args]
```
