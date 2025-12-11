# Function: getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)`
- **Visibility**: external
- **Source Range**: 5724:1444:202

## Implementation

```solidity
function getNewApproxAvgInterestRateFromTroveChange(TroveChange calldata _troveChange) external view returns (uint256) {
    assert(_troveChange.upfrontFee == 0);
    if (shutdownTime != 0) return 0;
    uint256 newAggRecordedDebt = aggRecordedDebt;
    newAggRecordedDebt += calcPendingAggInterest();
    newAggRecordedDebt += _troveChange.appliedRedistBoldDebtGain;
    newAggRecordedDebt += _troveChange.debtIncrease;
    newAggRecordedDebt += _troveChange.batchAccruedManagementFee;
    newAggRecordedDebt -= _troveChange.debtDecrease;
    uint256 newAggWeightedDebtSum = aggWeightedDebtSum;
    newAggWeightedDebtSum += _troveChange.newWeightedRecordedDebt;
    newAggWeightedDebtSum -= _troveChange.oldWeightedRecordedDebt;
    return (newAggRecordedDebt > 0) ? (newAggWeightedDebtSum / newAggRecordedDebt) : 0;
}
```

## Related Implementations

### calcPendingAggInterest()

- **Kind**: internal
- **Source**: 4503:684:202
- **Link**: `src/ActivePool.sol:ActivePool:calcPendingAggInterest()`

```solidity
function calcPendingAggInterest() public view returns (uint256) {
    if (shutdownTime != 0) return 0;
    return Math.ceilDiv(aggWeightedDebtSum * (block.timestamp - lastAggUpdateTime), ONE_YEAR * DECIMAL_PRECISION);
}
```

### ceilDiv(uint256,uint256)

- **Kind**: internal
- **Source**: 1157:194:114
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ceilDiv(uint256,uint256)`

```solidity
///  @dev Returns the ceiling of the division of two numbers.
///  This differs from standard division with `/` in that it rounds up instead
///  of rounding down.
function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a == 0) ? 0 : (((a - 1) / b) + 1);
}
```

## State Variable Reads

- **shutdownTime** (`uint256`)
- **aggRecordedDebt** (`uint256`)
- **aggWeightedDebtSum** (`uint256`)
- **lastAggUpdateTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.getNewApproxAvgInterestRateFromTroveChange(struct TroveChange) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ActivePool.calcPendingAggInterest() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 2)
        💬 Args: [aggWeightedDebtSum * (block.timestamp - lastAggUpdateTime), ONE_YEAR * DECIMAL_PRECISION]
        👁️  Def: internal
```
