# Contract: DoubleLinkedList

## Metadata

- **Name**: DoubleLinkedList
- **Type**: Contract
- **Path**: lib/V2-gov/src/utils/DoubleLinkedList.sol
- **Documentation**: @title DoubleLinkedList
   @notice Implements a double linked list where the head is defined as the null item's prev pointer
   and the tail is defined as the null item's next pointer ([tail][prev][item][next][head])

## Structs

### Item

```solidity
struct Item {
    uint256 lqty;
    uint256 offset;
    uint256 prev;
    uint256 next;
}
```

### List

```solidity
struct List {
    mapping(uint256 => Item) items;
}
```

## Errors

### IdIsZero

```solidity
error IdIsZero();
```

### ItemNotInList

```solidity
error ItemNotInList();
```

### ItemInList

```solidity
error ItemInList();
```
