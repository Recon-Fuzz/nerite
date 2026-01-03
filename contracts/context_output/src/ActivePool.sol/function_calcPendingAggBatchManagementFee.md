# Function: calcPendingAggBatchManagementFee()

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `calcPendingAggBatchManagementFee()`
- **Visibility**: public
- **Source Range**: 5346:372:51

## Implementation

```solidity
function calcPendingAggBatchManagementFee() public view returns (uint256) {
    uint256 periodEnd = (shutdownTime != 0) ? shutdownTime : block.timestamp;
    uint256 periodStart = Math.min(lastAggBatchManagementFeesUpdateTime, periodEnd);
    return Math.ceilDiv(aggWeightedBatchManagementFeeSum * (periodEnd - periodStart), ONE_YEAR * DECIMAL_PRECISION);
}
```

## Related Implementations

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 588:104:29
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
}
```

### ceilDiv(uint256,uint256)

- **Kind**: internal
- **Source**: 1157:194:29
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
- **lastAggBatchManagementFeesUpdateTime** (`uint256`)
- **aggWeightedBatchManagementFeeSum** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.calcPendingAggBatchManagementFee() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 1)
  │   💬 Args: [lastAggBatchManagementFeesUpdateTime, periodEnd]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 2)
      💬 Args: [aggWeightedBatchManagementFeeSum * (periodEnd - periodStart), ONE_YEAR * DECIMAL_PRECISION]
      👁️  Def: internal
```
