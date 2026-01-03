# Function: predictRemoveFromBatchUpfrontFee(uint256,uint256,uint256)

**Contract**: [src/HintHelpers.sol/contract_HintHelpers.md]

## Metadata

- **Contract**: HintHelpers
- **Signature**: `predictRemoveFromBatchUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 10237:1429:67

## Implementation

```solidity
function predictRemoveFromBatchUpfrontFee(uint256 _collIndex, uint256 _troveId, uint256 _newInterestRate) external view returns (uint256) {
    ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
    IActivePool activePool = troveManager.activePool();
    LatestTroveData memory trove = troveManager.getLatestTroveData(_troveId);
    (, , , , , , , , address batchManager, ) = troveManager.Troves(_troveId);
    LatestBatchData memory batch = troveManager.getLatestBatchData(batchManager);
    if ((_newInterestRate == batch.annualInterestRate) || (block.timestamp >= (trove.lastInterestRateAdjTime + INTEREST_RATE_ADJ_COOLDOWN))) {
        return 0;
    }
    TroveChange memory troveChange;
    troveChange.appliedRedistBoldDebtGain = trove.redistBoldDebtGain;
    troveChange.batchAccruedManagementFee = batch.accruedManagementFee;
    troveChange.oldWeightedRecordedDebt = batch.weightedRecordedDebt;
    troveChange.newWeightedRecordedDebt = ((batch.entireDebtWithoutRedistribution - (trove.entireDebt - trove.redistBoldDebtGain)) * batch.annualInterestRate) + (trove.entireDebt * _newInterestRate);
    uint256 avgInterestRate = activePool.getNewApproxAvgInterestRateFromTroveChange(troveChange);
    return _calcUpfrontFee(trove.entireDebt, avgInterestRate);
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
┌─ [0] ⚙️ FUNCTION: HintHelpers.predictRemoveFromBatchUpfrontFee(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: HintHelpers._calcUpfrontFee(uint256,uint256) (NodeID: 1)
      💬 Args: [trove.entireDebt, avgInterestRate]
      👁️  Def: internal
```
