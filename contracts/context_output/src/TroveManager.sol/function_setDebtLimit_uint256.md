# Function: setDebtLimit(uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `setDebtLimit(uint256)`
- **Visibility**: external
- **Source Range**: 88179:142:275

## Implementation

```solidity
function setDebtLimit(uint256 _newDebtLimit) external {
    _requireCallerIsCollateralRegistry();
    debtLimit = _newDebtLimit;
}
```

## Related Implementations

### _requireCallerIsCollateralRegistry()

- **Kind**: internal
- **Source**: 53673:184:275
- **Link**: `src/TroveManager.sol:TroveManager:_requireCallerIsCollateralRegistry()`

```solidity
function _requireCallerIsCollateralRegistry() internal view {
    if (msg.sender != address(collateralRegistry)) {
        revert CallerNotCollateralRegistry();
    }
}
```

## State Variable Reads

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## State Variable Writes

- **debtLimit** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.setDebtLimit(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsCollateralRegistry() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
