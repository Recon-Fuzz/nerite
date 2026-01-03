# Function: predictAdjustTroveUpfrontFee(uint256,uint256,uint256)

**Contract**: [src/HintHelpers.sol/contract_HintHelpers.md]

## Metadata

- **Contract**: HintHelpers
- **Signature**: `predictAdjustTroveUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5447:1542:67

## Implementation

```solidity
function predictAdjustTroveUpfrontFee(uint256 _collIndex, uint256 _troveId, uint256 _debtIncrease) external view returns (uint256) {
    if (_debtIncrease == 0) return 0;
    ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
    IActivePool activePool = troveManager.activePool();
    LatestTroveData memory trove = troveManager.getLatestTroveData(_troveId);
    (, , , , , , , , address batchManager, ) = troveManager.Troves(_troveId);
    TroveChange memory troveChange;
    troveChange.appliedRedistBoldDebtGain = trove.redistBoldDebtGain;
    troveChange.debtIncrease = _debtIncrease;
    if (batchManager == address(0)) {
        troveChange.newWeightedRecordedDebt = (trove.entireDebt + _debtIncrease) * trove.annualInterestRate;
        troveChange.oldWeightedRecordedDebt = trove.weightedRecordedDebt;
    } else {
        LatestBatchData memory batch = troveManager.getLatestBatchData(batchManager);
        troveChange.batchAccruedManagementFee = batch.accruedManagementFee;
        troveChange.newWeightedRecordedDebt = ((batch.entireDebtWithoutRedistribution + trove.redistBoldDebtGain) + _debtIncrease) * batch.annualInterestRate;
        troveChange.oldWeightedRecordedDebt = batch.weightedRecordedDebt;
    }
    uint256 avgInterestRate = activePool.getNewApproxAvgInterestRateFromTroveChange(troveChange);
    return _calcUpfrontFee(_debtIncrease, avgInterestRate);
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
- **ITroveManager::getLatestTroveData(uint256)**
- **ITroveManager::Troves(uint256)**
- **ITroveManager::getLatestBatchData(address)**
- **IActivePool::getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)**

## State Variable Reads

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HintHelpers.predictAdjustTroveUpfrontFee(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: HintHelpers._calcUpfrontFee(uint256,uint256) (NodeID: 1)
      💬 Args: [_debtIncrease, avgInterestRate]
      👁️  Def: internal
```
