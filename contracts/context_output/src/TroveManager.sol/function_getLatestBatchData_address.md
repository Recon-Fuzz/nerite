# Function: getLatestBatchData(address)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `getLatestBatchData(address)`
- **Visibility**: external
- **Source Range**: 47983:162:275

## Implementation

```solidity
function getLatestBatchData(address _batchAddress) external view returns (LatestBatchData memory batch) {
    _getLatestBatchData(_batchAddress, batch);
}
```

## Related Implementations

### _getLatestBatchData(address,struct LatestBatchData)

- **Kind**: internal
- **Source**: 46668:1309:275
- **Link**: `src/TroveManager.sol:TroveManager:_getLatestBatchData(address,struct LatestBatchData)`

```solidity
function _getLatestBatchData(address _batchAddress, LatestBatchData memory latestBatchData) internal view {
    Batch memory batch = batches[_batchAddress];
    latestBatchData.recordedDebt = batch.debt;
    latestBatchData.annualInterestRate = batch.annualInterestRate;
    latestBatchData.weightedRecordedDebt = latestBatchData.recordedDebt * latestBatchData.annualInterestRate;
    uint256 period = _getInterestPeriod(batch.lastDebtUpdateTime);
    latestBatchData.accruedInterest = _calcInterest(latestBatchData.weightedRecordedDebt, period);
    latestBatchData.annualManagementFee = batch.annualManagementFee;
    latestBatchData.weightedRecordedBatchManagementFee = latestBatchData.recordedDebt * latestBatchData.annualManagementFee;
    latestBatchData.accruedManagementFee = _calcInterest(latestBatchData.weightedRecordedBatchManagementFee, period);
    latestBatchData.entireDebtWithoutRedistribution = (latestBatchData.recordedDebt + latestBatchData.accruedInterest) + latestBatchData.accruedManagementFee;
    latestBatchData.entireCollWithoutRedistribution = batch.coll;
    latestBatchData.lastDebtUpdateTime = batch.lastDebtUpdateTime;
    latestBatchData.lastInterestRateAdjTime = batch.lastInterestRateAdjTime;
}
```

### _getInterestPeriod(uint256)

- **Kind**: internal
- **Source**: 52678:755:275
- **Link**: `src/TroveManager.sol:TroveManager:_getInterestPeriod(uint256)`

```solidity
function _getInterestPeriod(uint256 _lastDebtUpdateTime) internal view returns (uint256) {
    if (shutdownTime == 0) {
        return block.timestamp - _lastDebtUpdateTime;
    } else if ((shutdownTime > 0) && (_lastDebtUpdateTime < shutdownTime)) {
        return shutdownTime - _lastDebtUpdateTime;
    } else {
        return 0;
    }
}
```

### _calcInterest(uint256,uint256)

- **Kind**: internal
- **Source**: 2244:173:214
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:_calcInterest(uint256,uint256)`

```solidity
function _calcInterest(uint256 _weightedDebt, uint256 _period) internal pure returns (uint256) {
    return ((_weightedDebt * _period) / ONE_YEAR) / DECIMAL_PRECISION;
}
```

## State Variable Reads

- **batches** (`mapping(address => struct TroveManager.Batch)`)
- **shutdownTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.getLatestBatchData(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._getLatestBatchData(address,struct LatestBatchData) (NodeID: 1)
      💬 Args: [_batchAddress, batch]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: TroveManager._getInterestPeriod(uint256) (NodeID: 2)
    │   💬 Args: [batch.lastDebtUpdateTime]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 3)
    │   💬 Args: [latestBatchData.weightedRecordedDebt, period]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 4)
        💬 Args: [latestBatchData.weightedRecordedBatchManagementFee, period]
        👁️  Def: internal
```
