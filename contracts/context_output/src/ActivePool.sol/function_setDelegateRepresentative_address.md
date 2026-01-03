# Function: setDelegateRepresentative(address)

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `setDelegateRepresentative(address)`
- **Visibility**: external
- **Source Range**: 15494:155:51

## Implementation

```solidity
function setDelegateRepresentative(address _delegateRepresentative) external onlyGovernor() {
    delegateRepresentative = _delegateRepresentative;
}
```

## Related Implementations

### onlyGovernor()

- **Kind**: modifier
- **Source**: 15262:121:51
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

- **delegateRepresentative** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.setDelegateRepresentative(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: ActivePool.onlyGovernor() (NodeID: 1)
      💬 Args: [no args]
```
