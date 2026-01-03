# Contract: SortedTroves

## Metadata

- **Name**: SortedTroves
- **Type**: Contract
- **Path**: src/SortedTroves.sol

## Implements Interfaces

- **ISortedTroves** [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

## State Variables

### NAME

```solidity
string public constant NAME = "SortedTroves"
```

### UNINITIALIZED_ID

```solidity
uint256 internal constant UNINITIALIZED_ID = 0
```

### BAD_HINT

```solidity
uint256 internal constant BAD_HINT = 0
```

### borrowerOperationsAddress

```solidity
address public immutable borrowerOperationsAddress
```

### troveManager

```solidity
ITroveManager public immutable troveManager
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### size

```solidity
uint256 public size
```

### nodes

```solidity
mapping(uint256 => Node) public nodes
```

### batches

```solidity
mapping(BatchId => Batch) public batches
```

## Structs

### Node

```solidity
struct Node {
    uint256 nextId;
    uint256 prevId;
    BatchId batchId;
    bool exists;
}
```

### Batch

```solidity
struct Batch {
    uint256 head;
    uint256 tail;
}
```

### Position

```solidity
struct Position {
    uint256 prevId;
    uint256 nextId;
}
```

## Events

### TroveManagerAddressChanged

```solidity
event TroveManagerAddressChanged(address _troveManagerAddress);
```

### BorrowerOperationsAddressChanged

```solidity
event BorrowerOperationsAddressChanged(address _borrowerOperationsAddress);
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 2988:552:122
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry);
```

### insert(uint256,uint256,uint256,uint256)

- **Signature**: `insert(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5044:468:122
- **Details**: [function_insert_uint256_uint256_uint256_uint256.md](./function_insert_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function insert(uint256 _id, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) override external;
```

### remove(uint256)

- **Signature**: `remove(uint256)`
- **Visibility**: external
- **Source Range**: 6185:347:122
- **Details**: [function_remove_uint256.md](./function_remove_uint256.md)

**Signature:**
```solidity
function remove(uint256 _id) override external;
```

### reInsert(uint256,uint256,uint256,uint256)

- **Signature**: `reInsert(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 7748:445:122
- **Details**: [function_reInsert_uint256_uint256_uint256_uint256.md](./function_reInsert_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function reInsert(uint256 _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) override external;
```

### insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)

- **Signature**: `insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 8582:1162:122
- **Details**: [function_insertIntoBatch_uint256_BatchId_uint256_uint256_uint256.md](./function_insertIntoBatch_uint256_BatchId_uint256_uint256_uint256.md)

**Signature:**
```solidity
function insertIntoBatch(uint256 _troveId, BatchId _batchId, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) override external;
```

### removeFromBatch(uint256)

- **Signature**: `removeFromBatch(uint256)`
- **Visibility**: external
- **Source Range**: 9843:768:122
- **Details**: [function_removeFromBatch_uint256.md](./function_removeFromBatch_uint256.md)

**Signature:**
```solidity
function removeFromBatch(uint256 _id) override external;
```

### reInsertBatch(BatchId,uint256,uint256,uint256)

- **Signature**: `reInsertBatch(BatchId,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 10976:440:122
- **Details**: [function_reInsertBatch_BatchId_uint256_uint256_uint256.md](./function_reInsertBatch_BatchId_uint256_uint256_uint256.md)

**Signature:**
```solidity
function reInsertBatch(BatchId _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) override external;
```

### contains(uint256)

- **Signature**: `contains(uint256)`
- **Visibility**: public
- **Source Range**: 11484:108:122
- **Details**: [function_contains_uint256.md](./function_contains_uint256.md)

**Signature:**
```solidity
function contains(uint256 _id) override public view returns (bool);
```

### isBatchedNode(uint256)

- **Signature**: `isBatchedNode(uint256)`
- **Visibility**: public
- **Source Range**: 11668:126:122
- **Details**: [function_isBatchedNode_uint256.md](./function_isBatchedNode_uint256.md)

**Signature:**
```solidity
function isBatchedNode(uint256 _id) override public view returns (bool);
```

### isEmptyBatch(BatchId)

- **Signature**: `isEmptyBatch(BatchId)`
- **Visibility**: external
- **Source Range**: 11800:134:122
- **Details**: [function_isEmptyBatch_BatchId.md](./function_isEmptyBatch_BatchId.md)

**Signature:**
```solidity
function isEmptyBatch(BatchId _id) override external view returns (bool);
```

### isEmpty()

- **Signature**: `isEmpty()`
- **Visibility**: external
- **Source Range**: 11995:90:122
- **Details**: [function_isEmpty.md](./function_isEmpty.md)

**Signature:**
```solidity
function isEmpty() override external view returns (bool);
```

### getSize()

- **Signature**: `getSize()`
- **Visibility**: external
- **Source Range**: 12155:88:122
- **Details**: [function_getSize.md](./function_getSize.md)

**Signature:**
```solidity
function getSize() override external view returns (uint256);
```

### getFirst()

- **Signature**: `getFirst()`
- **Visibility**: external
- **Source Range**: 12356:111:122
- **Details**: [function_getFirst.md](./function_getFirst.md)

**Signature:**
```solidity
function getFirst() override external view returns (uint256);
```

### getLast()

- **Signature**: `getLast()`
- **Visibility**: external
- **Source Range**: 12580:110:122
- **Details**: [function_getLast.md](./function_getLast.md)

**Signature:**
```solidity
function getLast() override external view returns (uint256);
```

### getNext(uint256)

- **Signature**: `getNext(uint256)`
- **Visibility**: external
- **Source Range**: 12833:112:122
- **Details**: [function_getNext_uint256.md](./function_getNext_uint256.md)

**Signature:**
```solidity
function getNext(uint256 _id) override external view returns (uint256);
```

### getPrev(uint256)

- **Signature**: `getPrev(uint256)`
- **Visibility**: external
- **Source Range**: 13091:112:122
- **Details**: [function_getPrev_uint256.md](./function_getPrev_uint256.md)

**Signature:**
```solidity
function getPrev(uint256 _id) override external view returns (uint256);
```

### validInsertPosition(uint256,uint256,uint256)

- **Signature**: `validInsertPosition(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 13522:263:122
- **Details**: [function_validInsertPosition_uint256_uint256_uint256.md](./function_validInsertPosition_uint256_uint256_uint256.md)

**Signature:**
```solidity
function validInsertPosition(uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) override external view returns (bool);
```

### findInsertPosition(uint256,uint256,uint256)

- **Signature**: `findInsertPosition(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 18564:273:122
- **Details**: [function_findInsertPosition_uint256_uint256_uint256.md](./function_findInsertPosition_uint256_uint256_uint256.md)

**Signature:**
```solidity
function findInsertPosition(uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) override external view returns (uint256, uint256);
```
