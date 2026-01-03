# Function: predictAdjustBatchInterestRateUpfrontFee(uint256,address,uint256)

**Contract**: [src/HintHelpers.sol/contract_HintHelpers.md]

## Metadata

- **Contract**: HintHelpers
- **Signature**: `predictAdjustBatchInterestRateUpfrontFee(uint256,address,uint256)`
- **Visibility**: external
- **Source Range**: 6995:1118:67

## Implementation

```solidity
function predictAdjustBatchInterestRateUpfrontFee(uint256 _collIndex, address _batchAddress, uint256 _newInterestRate) external view returns (uint256) {
    ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
    IActivePool activePool = troveManager.activePool();
    LatestBatchData memory batch = troveManager.getLatestBatchData(_batchAddress);
    if ((_newInterestRate == batch.annualInterestRate) || (block.timestamp >= (batch.lastInterestRateAdjTime + INTEREST_RATE_ADJ_COOLDOWN))) {
        return 0;
    }
    TroveChange memory troveChange;
    troveChange.batchAccruedManagementFee = batch.accruedManagementFee;
    troveChange.newWeightedRecordedDebt = batch.entireDebtWithoutRedistribution * _newInterestRate;
    troveChange.oldWeightedRecordedDebt = batch.weightedRecordedDebt;
    uint256 avgInterestRate = activePool.getNewApproxAvgInterestRateFromTroveChange(troveChange);
    return _calcUpfrontFee(batch.entireDebtWithoutRedistribution, avgInterestRate);
}
```

## Related Implementations

### _calcUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 2703:203:67
- **Link**: `src/HintHelpers.sol:HintHelpers:_calcUpfrontFee(uint256,uint256)`

```solidity
function _calcUpfrontFee(uint256 _debt, uint256 _avgInterestRate) internal pure returns (uint256) {
    return (((_debt * _avgInterestRate) * UPFRONT_INTEREST_PERIOD) / ONE_YEAR) / DECIMAL_PRECISION;
}
```

## External Calls

- **ICollateralRegistry::getTroveManager(uint256)**
- **ITroveManager::activePool()**
- **ITroveManager::getLatestBatchData(address)**
- **IActivePool::getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)**

## State Variable Reads

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HintHelpers.predictAdjustBatchInterestRateUpfrontFee(uint256,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: HintHelpers._calcUpfrontFee(uint256,uint256) (NodeID: 1)
      💬 Args: [batch.entireDebtWithoutRedistribution, avgInterestRate]
      👁️  Def: internal
```
