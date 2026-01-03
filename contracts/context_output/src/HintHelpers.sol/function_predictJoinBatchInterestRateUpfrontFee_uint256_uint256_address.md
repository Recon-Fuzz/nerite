# Function: predictJoinBatchInterestRateUpfrontFee(uint256,uint256,address)

**Contract**: [src/HintHelpers.sol/contract_HintHelpers.md]

## Metadata

- **Contract**: HintHelpers
- **Signature**: `predictJoinBatchInterestRateUpfrontFee(uint256,uint256,address)`
- **Visibility**: external
- **Source Range**: 9084:1147:67

## Implementation

```solidity
function predictJoinBatchInterestRateUpfrontFee(uint256 _collIndex, uint256 _troveId, address _batchAddress) external view returns (uint256) {
    ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
    IActivePool activePool = troveManager.activePool();
    LatestTroveData memory trove = troveManager.getLatestTroveData(_troveId);
    LatestBatchData memory batch = troveManager.getLatestBatchData(_batchAddress);
    TroveChange memory newBatchTroveChange;
    newBatchTroveChange.appliedRedistBoldDebtGain = trove.redistBoldDebtGain;
    newBatchTroveChange.batchAccruedManagementFee = batch.accruedManagementFee;
    newBatchTroveChange.oldWeightedRecordedDebt = batch.weightedRecordedDebt + trove.weightedRecordedDebt;
    newBatchTroveChange.newWeightedRecordedDebt = (batch.entireDebtWithoutRedistribution + trove.entireDebt) * batch.annualInterestRate;
    uint256 avgInterestRate = activePool.getNewApproxAvgInterestRateFromTroveChange(newBatchTroveChange);
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
- **ITroveManager::getLatestBatchData(address)**
- **IActivePool::getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)**

## State Variable Reads

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HintHelpers.predictJoinBatchInterestRateUpfrontFee(uint256,uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: HintHelpers._calcUpfrontFee(uint256,uint256) (NodeID: 1)
      💬 Args: [trove.entireDebt, avgInterestRate]
      👁️  Def: internal
```
