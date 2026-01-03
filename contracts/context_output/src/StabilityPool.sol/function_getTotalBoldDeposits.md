# Function: getTotalBoldDeposits()

**Contract**: [src/StabilityPool.sol/contract_StabilityPool.md]

## Metadata

- **Contract**: StabilityPool
- **Signature**: `getTotalBoldDeposits()`
- **Visibility**: external
- **Source Range**: 10916:114:123

## Implementation

```solidity
function getTotalBoldDeposits() override external view returns (uint256) {
    return totalBoldDeposits;
}
```

## State Variable Reads

- **totalBoldDeposits** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StabilityPool.getTotalBoldDeposits() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
