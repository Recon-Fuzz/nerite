# Function: getDebtLimit()

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `getDebtLimit()`
- **Visibility**: external
- **Source Range**: 88084:89:124

## Implementation

```solidity
function getDebtLimit() external view returns (uint256) {
    return debtLimit;
}
```

## State Variable Reads

- **debtLimit** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.getDebtLimit() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
