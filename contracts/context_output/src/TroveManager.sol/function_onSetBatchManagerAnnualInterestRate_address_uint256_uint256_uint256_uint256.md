# Function: onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 74658:1078:275

## Implementation

```solidity
function onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) external {
    _requireCallerIsBorrowerOperations();
    batches[_batchAddress].coll = _newColl;
    batches[_batchAddress].debt = _newDebt;
    batches[_batchAddress].annualInterestRate = _newAnnualInterestRate;
    batches[_batchAddress].lastDebtUpdateTime = uint64(block.timestamp);
    batches[_batchAddress].lastInterestRateAdjTime = uint64(block.timestamp);
    emit BatchUpdated({_interestBatchManager: _batchAddress, _operation: BatchOperation.setBatchManagerAnnualInterestRate, _debt: _newDebt, _coll: _newColl, _annualInterestRate: _newAnnualInterestRate, _annualManagementFee: batches[_batchAddress].annualManagementFee, _totalDebtShares: batches[_batchAddress].totalDebtShares, _debtIncreaseFromUpfrontFee: _upfrontFee});
}
```

## Related Implementations

### _requireCallerIsBorrowerOperations()

- **Kind**: internal
- **Source**: 53483:184:275
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
┌─ [0] ⚙️ FUNCTION: TroveManager.onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
