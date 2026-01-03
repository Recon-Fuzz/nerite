# Function: validInsertPosition(uint256,uint256,uint256)

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `validInsertPosition(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 13522:263:122

## Implementation

```solidity
function validInsertPosition(uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) override external view returns (bool) {
    return _validInsertPosition(troveManager, _annualInterestRate, _prevId, _nextId);
}
```

## Related Implementations

### _validInsertPosition(contract ITroveManager,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 13791:913:122
- **Link**: `src/SortedTroves.sol:SortedTroves:_validInsertPosition(contract ITroveManager,uint256,uint256,uint256)`

```solidity
function _validInsertPosition(ITroveManager _troveManager, uint256 _annualInterestRate, uint256 _prevId, uint256 _nextId) internal view returns (bool) {
    BatchId prevBatchId = nodes[_prevId].batchId;
    return (((((nodes[_prevId].nextId == _nextId) && (nodes[_nextId].prevId == _prevId)) && ((prevBatchId != nodes[_nextId].batchId) || prevBatchId.isZero())) && ((_prevId == ROOT_NODE_ID) || (_troveManager.getTroveAnnualInterestRate(_prevId) >= _annualInterestRate))) && ((_nextId == ROOT_NODE_ID) || (_annualInterestRate > _troveManager.getTroveAnnualInterestRate(_nextId))));
}
```

### isZero(BatchId)

- **Kind**: free-function
- **Source**: 364:81:126
- **Link**: `src/Types/BatchId.sol:isZero(BatchId)`

```solidity
function isZero(BatchId x) pure returns (bool) {
    return x == BATCH_ID_ZERO;
}
```

## External Calls

- **ITroveManager::getTroveAnnualInterestRate(uint256)**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.validInsertPosition(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SortedTroves._validInsertPosition(contract ITroveManager,uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [troveManager, _annualInterestRate, _prevId, _nextId]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Unknown.isZero(BatchId) (NodeID: 2)
        💬 Args: [prevBatchId]
        👁️  Def: internal
```
