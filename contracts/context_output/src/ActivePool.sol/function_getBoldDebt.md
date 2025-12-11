# Function: getBoldDebt()

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `getBoldDebt()`
- **Visibility**: external
- **Source Range**: 7274:183:202

## Implementation

```solidity
function getBoldDebt() external view returns (uint256) {
    return ((aggRecordedDebt + calcPendingAggInterest()) + aggBatchManagementFees) + calcPendingAggBatchManagementFee();
}
```

## Related Implementations

### calcPendingAggBatchManagementFee()

- **Kind**: internal
- **Source**: 5346:372:202
- **Link**: `src/ActivePool.sol:ActivePool:calcPendingAggBatchManagementFee()`

```solidity
function calcPendingAggBatchManagementFee() public view returns (uint256) {
    uint256 periodEnd = (shutdownTime != 0) ? shutdownTime : block.timestamp;
    uint256 periodStart = Math.min(lastAggBatchManagementFeesUpdateTime, periodEnd);
    return Math.ceilDiv(aggWeightedBatchManagementFeeSum * (periodEnd - periodStart), ONE_YEAR * DECIMAL_PRECISION);
}
```

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 588:104:114
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
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

## State Variable Reads

- **aggRecordedDebt** (`uint256`)
- **aggBatchManagementFees** (`uint256`)
- **shutdownTime** (`uint256`)
- **lastAggBatchManagementFeesUpdateTime** (`uint256`)
- **aggWeightedBatchManagementFeeSum** (`uint256`)
- **aggWeightedDebtSum** (`uint256`)
- **lastAggUpdateTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.getBoldDebt() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ActivePool.calcPendingAggBatchManagementFee() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [lastAggBatchManagementFeesUpdateTime, periodEnd]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 3)
  │     💬 Args: [aggWeightedBatchManagementFeeSum * (periodEnd - periodStart), ONE_YEAR * DECIMAL_PRECISION]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ActivePool.calcPendingAggInterest() (NodeID: 4)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 5)
        💬 Args: [aggWeightedDebtSum * (block.timestamp - lastAggUpdateTime), ONE_YEAR * DECIMAL_PRECISION]
        👁️  Def: internal
```
