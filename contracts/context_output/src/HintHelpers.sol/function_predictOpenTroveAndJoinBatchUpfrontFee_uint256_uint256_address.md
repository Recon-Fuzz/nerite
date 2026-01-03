# Function: predictOpenTroveAndJoinBatchUpfrontFee(uint256,uint256,address)

**Contract**: [src/HintHelpers.sol/contract_HintHelpers.md]

## Metadata

- **Contract**: HintHelpers
- **Signature**: `predictOpenTroveAndJoinBatchUpfrontFee(uint256,uint256,address)`
- **Visibility**: external
- **Source Range**: 8119:959:67

## Implementation

```solidity
function predictOpenTroveAndJoinBatchUpfrontFee(uint256 _collIndex, uint256 _borrowedAmount, address _batchAddress) external view returns (uint256) {
    ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
    IActivePool activePool = troveManager.activePool();
    LatestBatchData memory batch = troveManager.getLatestBatchData(_batchAddress);
    TroveChange memory openTrove;
    openTrove.debtIncrease = _borrowedAmount;
    openTrove.batchAccruedManagementFee = batch.accruedManagementFee;
    openTrove.oldWeightedRecordedDebt = batch.weightedRecordedDebt;
    openTrove.newWeightedRecordedDebt = (batch.entireDebtWithoutRedistribution + _borrowedAmount) * batch.annualInterestRate;
    uint256 avgInterestRate = activePool.getNewApproxAvgInterestRateFromTroveChange(openTrove);
    return _calcUpfrontFee(_borrowedAmount, avgInterestRate);
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
┌─ [0] ⚙️ FUNCTION: HintHelpers.predictOpenTroveAndJoinBatchUpfrontFee(uint256,uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: HintHelpers._calcUpfrontFee(uint256,uint256) (NodeID: 1)
      💬 Args: [_borrowedAmount, avgInterestRate]
      👁️  Def: internal
```
