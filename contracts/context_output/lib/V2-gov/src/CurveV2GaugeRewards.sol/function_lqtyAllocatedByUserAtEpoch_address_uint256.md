# Function: lqtyAllocatedByUserAtEpoch(address,uint256)

**Contract**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

## Metadata

- **Contract**: CurveV2GaugeRewards
- **Signature**: `lqtyAllocatedByUserAtEpoch(address,uint256)`
- **Visibility**: external
- **Source Range**: 2326:278:21
- **Inherited From**: BribeInitiative

## Implementation

```solidity
/// @inheritdoc IBribeInitiative
function lqtyAllocatedByUserAtEpoch(address _user, uint256 _epoch) external view returns (uint256, uint256) {
    return (lqtyAllocationByUserAtEpoch[_user].items[_epoch].lqty, lqtyAllocationByUserAtEpoch[_user].items[_epoch].offset);
}
```

## State Variable Reads

- **lqtyAllocationByUserAtEpoch** (`mapping(address => struct DoubleLinkedList.List)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.lqtyAllocatedByUserAtEpoch(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IBribeInitiative

### Interface Documentation

@notice LQTY allocated by a user to the initiative at a given epoch
         Voting power can be calculated as `lqtyAllocated * timestamp - offset`
 @param _user Address of the user
 @param _epoch Epoch at which the LQTY was allocated by the user
 @return lqtyAllocated LQTY allocated by the user
 @return offset Voting power offset
