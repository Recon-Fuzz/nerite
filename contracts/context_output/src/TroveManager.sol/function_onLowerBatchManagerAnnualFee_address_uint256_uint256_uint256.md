# Function: onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 73706:946:124

## Implementation

```solidity
function onLowerBatchManagerAnnualFee(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualManagementFee) external {
    _requireCallerIsBorrowerOperations();
    batches[_batchAddress].coll = _newColl;
    batches[_batchAddress].debt = _newDebt;
    batches[_batchAddress].annualManagementFee = _newAnnualManagementFee;
    batches[_batchAddress].lastDebtUpdateTime = uint64(block.timestamp);
    emit BatchUpdated({_interestBatchManager: _batchAddress, _operation: BatchOperation.lowerBatchManagerAnnualFee, _debt: _newDebt, _coll: _newColl, _annualInterestRate: batches[_batchAddress].annualInterestRate, _annualManagementFee: _newAnnualManagementFee, _totalDebtShares: batches[_batchAddress].totalDebtShares, _debtIncreaseFromUpfrontFee: 0});
}
```

## Related Implementations

### _requireCallerIsBorrowerOperations()

- **Kind**: internal
- **Source**: 53483:184:124
- **Link**: `src/TroveManager.sol:TroveManager:_requireCallerIsBorrowerOperations()`

```solidity
function _requireCallerIsBorrowerOperations() internal view {
    if (msg.sender != address(borrowerOperations)) {
        revert CallerNotBorrowerOperations();
    }
}
```

## State Variable Reads

- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## State Variable Writes

- **batches** (`mapping(address => struct TroveManager.Batch)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
