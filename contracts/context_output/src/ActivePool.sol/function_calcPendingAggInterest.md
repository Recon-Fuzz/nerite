# Function: calcPendingAggInterest()

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `calcPendingAggInterest()`
- **Visibility**: public
- **Source Range**: 4503:684:51

## Implementation

```solidity
function calcPendingAggInterest() public view returns (uint256) {
    if (shutdownTime != 0) return 0;
    return Math.ceilDiv(aggWeightedDebtSum * (block.timestamp - lastAggUpdateTime), ONE_YEAR * DECIMAL_PRECISION);
}
```

## Related Implementations

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
- **aggWeightedDebtSum** (`uint256`)
- **lastAggUpdateTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.calcPendingAggInterest() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 1)
      💬 Args: [aggWeightedDebtSum * (block.timestamp - lastAggUpdateTime), ONE_YEAR * DECIMAL_PRECISION]
      👁️  Def: internal
```
