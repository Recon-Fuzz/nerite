# Function: getMostRecentTotalEpoch()

**Contract**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

## Metadata

- **Contract**: CurveV2GaugeRewards
- **Signature**: `getMostRecentTotalEpoch()`
- **Visibility**: external
- **Source Range**: 8206:189:21
- **Inherited From**: BribeInitiative

## Implementation

```solidity
/// @inheritdoc IBribeInitiative
function getMostRecentTotalEpoch() external view returns (uint256) {
    uint256 mostRecentTotalEpoch = totalLQTYAllocationByEpoch.getHead();
    return mostRecentTotalEpoch;
}
```

## Related Implementations

### getHead(struct DoubleLinkedList.List)

- **Kind**: internal
- **Source**: 713:110:34
- **Link**: `lib/V2-gov/src/utils/DoubleLinkedList.sol:DoubleLinkedList:getHead(struct DoubleLinkedList.List)`

```solidity
/// @notice Returns the head item id of the list
///  @param list Linked list which contains the item
///  @return _ Id of the head item
function getHead(List storage list) internal view returns (uint256) {
    return list.items[0].prev;
}
```

## State Variable Reads

- **totalLQTYAllocationByEpoch** (`struct DoubleLinkedList.List`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.getMostRecentTotalEpoch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DoubleLinkedList.getHead(struct DoubleLinkedList.List) (NodeID: 1)
      💬 Args: [totalLQTYAllocationByEpoch]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IBribeInitiative

### Interface Documentation

@notice Return the last recorded epoch for the system
