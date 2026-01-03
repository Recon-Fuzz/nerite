# Interface: ISortedTroves

## Metadata

- **Name**: ISortedTroves
- **Type**: Interface
- **Path**: src/Interfaces/ISortedTroves.sol

## Public/External Functions

### insert(uint256,uint256,uint256,uint256)

- **Signature**: `insert(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 227:101:88

**Signature:**
```solidity
function insert(uint256 _id, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) external;;
```

### insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)

- **Signature**: `insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 333:179:88

**Signature:**
```solidity
function insertIntoBatch(uint256 _troveId, BatchId _batchId, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) external;;
```

### remove(uint256)

- **Signature**: `remove(uint256)`
- **Visibility**: external
- **Source Range**: 518:38:88

**Signature:**
```solidity
function remove(uint256 _id) external;;
```

### removeFromBatch(uint256)

- **Signature**: `removeFromBatch(uint256)`
- **Visibility**: external
- **Source Range**: 561:47:88

**Signature:**
```solidity
function removeFromBatch(uint256 _id) external;;
```

### reInsert(uint256,uint256,uint256,uint256)

- **Signature**: `reInsert(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 614:106:88

**Signature:**
```solidity
function reInsert(uint256 _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) external;;
```

### reInsertBatch(BatchId,uint256,uint256,uint256)

- **Signature**: `reInsertBatch(BatchId,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 725:111:88

**Signature:**
```solidity
function reInsertBatch(BatchId _id, uint256 _newAnnualInterestRate, uint256 _prevId, uint256 _nextId) external;;
```

### contains(uint256)

- **Signature**: `contains(uint256)`
- **Visibility**: external
- **Source Range**: 871:60:88

**Signature:**
```solidity
function contains(uint256 _id) external view returns (bool);;
```

### isBatchedNode(uint256)

- **Signature**: `isBatchedNode(uint256)`
- **Visibility**: external
- **Source Range**: 936:65:88

**Signature:**
```solidity
function isBatchedNode(uint256 _id) external view returns (bool);;
```

### isEmptyBatch(BatchId)

- **Signature**: `isEmptyBatch(BatchId)`
- **Visibility**: external
- **Source Range**: 1006:64:88

**Signature:**
```solidity
function isEmptyBatch(BatchId _id) external view returns (bool);;
```

### isEmpty()

- **Signature**: `isEmpty()`
- **Visibility**: external
- **Source Range**: 1076:48:88

**Signature:**
```solidity
function isEmpty() external view returns (bool);;
```

### getSize()

- **Signature**: `getSize()`
- **Visibility**: external
- **Source Range**: 1129:51:88

**Signature:**
```solidity
function getSize() external view returns (uint256);;
```

### getFirst()

- **Signature**: `getFirst()`
- **Visibility**: external
- **Source Range**: 1186:52:88

**Signature:**
```solidity
function getFirst() external view returns (uint256);;
```

### getLast()

- **Signature**: `getLast()`
- **Visibility**: external
- **Source Range**: 1243:51:88

**Signature:**
```solidity
function getLast() external view returns (uint256);;
```

### getNext(uint256)

- **Signature**: `getNext(uint256)`
- **Visibility**: external
- **Source Range**: 1299:62:88

**Signature:**
```solidity
function getNext(uint256 _id) external view returns (uint256);;
```

### getPrev(uint256)

- **Signature**: `getPrev(uint256)`
- **Visibility**: external
- **Source Range**: 1366:62:88

**Signature:**
```solidity
function getPrev(uint256 _id) external view returns (uint256);;
```

### validInsertPosition(uint256,uint256,uint256)

- **Signature**: `validInsertPosition(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1434:145:88

**Signature:**
```solidity
function validInsertPosition(uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) external view returns (bool);;
```

### findInsertPosition(uint256,uint256,uint256)

- **Signature**: `findInsertPosition(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1584:156:88

**Signature:**
```solidity
function findInsertPosition(uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) external view returns (uint256, uint256);;
```

### borrowerOperationsAddress()

- **Signature**: `borrowerOperationsAddress()`
- **Visibility**: external
- **Source Range**: 1783:69:88

**Signature:**
```solidity
function borrowerOperationsAddress() external view returns (address);;
```

### troveManager()

- **Signature**: `troveManager()`
- **Visibility**: external
- **Source Range**: 1857:62:88

**Signature:**
```solidity
function troveManager() external view returns (ITroveManager);;
```

### size()

- **Signature**: `size()`
- **Visibility**: external
- **Source Range**: 1924:48:88

**Signature:**
```solidity
function size() external view returns (uint256);;
```

### nodes(uint256)

- **Signature**: `nodes(uint256)`
- **Visibility**: external
- **Source Range**: 1977:113:88

**Signature:**
```solidity
function nodes(uint256 _id) external view returns (uint256 nextId, uint256 prevId, BatchId batchId, bool exists);;
```

### batches(BatchId)

- **Signature**: `batches(BatchId)`
- **Visibility**: external
- **Source Range**: 2095:81:88

**Signature:**
```solidity
function batches(BatchId _id) external view returns (uint256 head, uint256 tail);;
```
