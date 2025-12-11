# Function: onRegisterBatchManager(address,uint256,uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `onRegisterBatchManager(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 72826:874:275

## Implementation

```solidity
function onRegisterBatchManager(address _account, uint256 _annualInterestRate, uint256 _annualManagementFee) external {
    _requireCallerIsBorrowerOperations();
    batches[_account].arrayIndex = uint64(batchIds.length);
    batches[_account].annualInterestRate = _annualInterestRate;
    batches[_account].annualManagementFee = _annualManagementFee;
    batches[_account].lastInterestRateAdjTime = uint64(block.timestamp);
    batchIds.push(_account);
    emit BatchUpdated({_interestBatchManager: _account, _operation: BatchOperation.registerBatchManager, _debt: 0, _coll: 0, _annualInterestRate: _annualInterestRate, _annualManagementFee: _annualManagementFee, _totalDebtShares: 0, _debtIncreaseFromUpfrontFee: 0});
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

- **batchIds** (`address[]`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## State Variable Writes

- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **batchIds** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.onRegisterBatchManager(address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
