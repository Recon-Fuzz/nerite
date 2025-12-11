# Function: updateGovernor(address)

**Contract**: [src/CollateralRegistry.sol/contract_CollateralRegistry.md]

## Metadata

- **Contract**: CollateralRegistry
- **Signature**: `updateGovernor(address)`
- **Visibility**: external
- **Source Range**: 14471:108:207

## Implementation

```solidity
function updateGovernor(address _newGovernor) external onlyGovernor() {
    governor = _newGovernor;
}
```

## Related Implementations

### onlyGovernor()

- **Kind**: modifier
- **Source**: 14585:143:207
- **Link**: `src/CollateralRegistry.sol:CollateralRegistry:onlyGovernor()`

```solidity
modifier onlyGovernor() {
    require(msg.sender == governor, "CollateralRegistry: Only governor can call this function");
    _;
}
```

## State Variable Reads

- **governor** (`address`)

## State Variable Writes

- **governor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollateralRegistry.updateGovernor(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: CollateralRegistry.onlyGovernor() (NodeID: 1)
      💬 Args: [no args]
```
