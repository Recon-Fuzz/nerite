# Function: onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)

**Contract**: [lib/V2-gov/src/BribeInitiative.sol/contract_BribeInitiative.md]

## Metadata

- **Contract**: BribeInitiative
- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 8401:937:21

## Implementation

```solidity
function onAfterAllocateLQTY(uint256 _currentEpoch, address _user, IGovernance.UserState calldata, IGovernance.Allocation calldata _allocation, IGovernance.InitiativeState calldata _initiativeState) virtual external onlyGovernance() {
    uint256 mostRecentUserEpoch = lqtyAllocationByUserAtEpoch[_user].getHead();
    uint256 mostRecentTotalEpoch = totalLQTYAllocationByEpoch.getHead();
    _setTotalLQTYAllocationByEpoch(_currentEpoch, _initiativeState.voteLQTY, _initiativeState.voteOffset, mostRecentTotalEpoch != _currentEpoch);
    _setLQTYAllocationByUserAtEpoch(_user, _currentEpoch, _allocation.voteLQTY, _allocation.voteOffset, mostRecentUserEpoch != _currentEpoch);
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

### _setTotalLQTYAllocationByEpoch(uint256,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 6933:443:21
- **Link**: `lib/V2-gov/src/BribeInitiative.sol:BribeInitiative:_setTotalLQTYAllocationByEpoch(uint256,uint256,uint256,bool)`

```solidity
function _setTotalLQTYAllocationByEpoch(uint256 _epoch, uint256 _lqty, uint256 _offset, bool _insert) private {
    if (_insert) {
        totalLQTYAllocationByEpoch.insert(_epoch, _lqty, _offset, 0);
    } else {
        totalLQTYAllocationByEpoch.items[_epoch].lqty = _lqty;
        totalLQTYAllocationByEpoch.items[_epoch].offset = _offset;
    }
    emit ModifyTotalLQTYAllocation(_epoch, _lqty, _offset);
}
```

### insert(struct DoubleLinkedList.List,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 3585:498:34
- **Link**: `lib/V2-gov/src/utils/DoubleLinkedList.sol:DoubleLinkedList:insert(struct DoubleLinkedList.List,uint256,uint256,uint256,uint256)`

```solidity
/// @notice Inserts an item with `id` in the list before item `next`
///  - if `next` is 0, the item is inserted at the start (head) of the list
///  @dev This function should not be called with an `id` that is already in the list.
///  @param list Linked list which contains the next item and into which the new item will be inserted
///  @param id Id of the item to insert
///  @param lqty amount of LQTY
///  @param offset associated with the LQTY amount
///  @param next Id of the item which should follow item `id`
function insert(List storage list, uint256 id, uint256 lqty, uint256 offset, uint256 next) internal {
    if (contains(list, id)) revert ItemInList();
    if ((next != 0) && (!contains(list, next))) revert ItemNotInList();
    uint256 prev = list.items[next].prev;
    list.items[prev].next = id;
    list.items[next].prev = id;
    list.items[id].prev = prev;
    list.items[id].next = next;
    list.items[id].lqty = lqty;
    list.items[id].offset = offset;
}
```

### contains(struct DoubleLinkedList.List,uint256)

- **Kind**: internal
- **Source**: 2810:224:34
- **Link**: `lib/V2-gov/src/utils/DoubleLinkedList.sol:DoubleLinkedList:contains(struct DoubleLinkedList.List,uint256)`

```solidity
/// @notice Returns whether the list contains item `id`
///  @param list Linked list which should contain the item
///  @param id Id of the item to check
///  @return _ True if the list contains the item, false otherwise
function contains(List storage list, uint256 id) internal view returns (bool) {
    if (id == 0) revert IdIsZero();
    return (((list.items[id].prev != 0) || (list.items[id].next != 0)) || (list.items[0].next == id));
}
```

### _setLQTYAllocationByUserAtEpoch(address,uint256,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 7382:531:21
- **Link**: `lib/V2-gov/src/BribeInitiative.sol:BribeInitiative:_setLQTYAllocationByUserAtEpoch(address,uint256,uint256,uint256,bool)`

```solidity
function _setLQTYAllocationByUserAtEpoch(address _user, uint256 _epoch, uint256 _lqty, uint256 _offset, bool _insert) private {
    if (_insert) {
        lqtyAllocationByUserAtEpoch[_user].insert(_epoch, _lqty, _offset, 0);
    } else {
        lqtyAllocationByUserAtEpoch[_user].items[_epoch].lqty = _lqty;
        lqtyAllocationByUserAtEpoch[_user].items[_epoch].offset = _offset;
    }
    emit ModifyLQTYAllocation(_user, _epoch, _lqty, _offset);
}
```

### onlyGovernance()

- **Kind**: modifier
- **Source**: 1897:131:21
- **Link**: `lib/V2-gov/src/BribeInitiative.sol:BribeInitiative:onlyGovernance()`

```solidity
modifier onlyGovernance() {
    require(msg.sender == address(governance), "BribeInitiative: invalid-sender");
    _;
}
```

## State Variable Reads

- **lqtyAllocationByUserAtEpoch** (`mapping(address => struct DoubleLinkedList.List)`)
- **totalLQTYAllocationByEpoch** (`struct DoubleLinkedList.List`)
- **governance** (`contract IGovernance`) [lib/V2-gov/src/interfaces/IGovernance.sol/interface_IGovernance.md]

## State Variable Writes

- **totalLQTYAllocationByEpoch** (`struct DoubleLinkedList.List`)
- **lqtyAllocationByUserAtEpoch** (`mapping(address => struct DoubleLinkedList.List)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: DoubleLinkedList.getHead(struct DoubleLinkedList.List) (NodeID: 1)
  │   💬 Args: [lqtyAllocationByUserAtEpoch[_user]]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DoubleLinkedList.getHead(struct DoubleLinkedList.List) (NodeID: 2)
  │   💬 Args: [totalLQTYAllocationByEpoch]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiative._setTotalLQTYAllocationByEpoch(uint256,uint256,uint256,bool) (NodeID: 3)
  │   💬 Args: [_currentEpoch, _initiativeState.voteLQTY, _initiativeState.voteOffset, mostRecentTotalEpoch != _currentEpoch]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: DoubleLinkedList.insert(struct DoubleLinkedList.List,uint256,uint256,uint256,uint256) (NodeID: 4)
  │     💬 Args: [totalLQTYAllocationByEpoch, _epoch, _lqty, _offset, 0]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: DoubleLinkedList.contains(struct DoubleLinkedList.List,uint256) (NodeID: 5)
  │   │   💬 Args: [list, id]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: DoubleLinkedList.contains(struct DoubleLinkedList.List,uint256) (NodeID: 6)
  │       💬 Args: [list, next]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiative._setLQTYAllocationByUserAtEpoch(address,uint256,uint256,uint256,bool) (NodeID: 7)
  │   💬 Args: [_user, _currentEpoch, _allocation.voteLQTY, _allocation.voteOffset, mostRecentUserEpoch != _currentEpoch]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: DoubleLinkedList.insert(struct DoubleLinkedList.List,uint256,uint256,uint256,uint256) (NodeID: 8)
  │     💬 Args: [lqtyAllocationByUserAtEpoch[_user], _epoch, _lqty, _offset, 0]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: DoubleLinkedList.contains(struct DoubleLinkedList.List,uint256) (NodeID: 9)
  │   │   💬 Args: [list, id]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: DoubleLinkedList.contains(struct DoubleLinkedList.List,uint256) (NodeID: 10)
  │       💬 Args: [list, next]
  │       👁️  Def: internal
  └─ [1] 🔒 MODIFIER: BribeInitiative.onlyGovernance() (NodeID: 11)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

@notice Callback hook that is called by Governance after the LQTY allocation is updated by a user
 @param _currentEpoch Epoch at which the LQTY allocation is updated
 @param _user Address of the user that updated their LQTY allocation
 @param _userState User state
 @param _allocation Allocation state from user to initiative
 @param _initiativeState Initiative state
