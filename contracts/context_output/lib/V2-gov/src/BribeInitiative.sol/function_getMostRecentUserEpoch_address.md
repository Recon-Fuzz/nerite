# Function: getMostRecentUserEpoch(address)

**Contract**: [lib/V2-gov/src/BribeInitiative.sol/contract_BribeInitiative.md]

## Metadata

- **Contract**: BribeInitiative
- **Signature**: `getMostRecentUserEpoch(address)`
- **Visibility**: external
- **Source Range**: 7956:207:21

## Implementation

```solidity
/// @inheritdoc IBribeInitiative
function getMostRecentUserEpoch(address _user) external view returns (uint256) {
    uint256 mostRecentUserEpoch = lqtyAllocationByUserAtEpoch[_user].getHead();
    return mostRecentUserEpoch;
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

- **lqtyAllocationByUserAtEpoch** (`mapping(address => struct DoubleLinkedList.List)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.getMostRecentUserEpoch(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DoubleLinkedList.getHead(struct DoubleLinkedList.List) (NodeID: 1)
      💬 Args: [lqtyAllocationByUserAtEpoch[_user]]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IBribeInitiative

### Interface Documentation

@notice Given a user address return the last recorded epoch for their allocation
