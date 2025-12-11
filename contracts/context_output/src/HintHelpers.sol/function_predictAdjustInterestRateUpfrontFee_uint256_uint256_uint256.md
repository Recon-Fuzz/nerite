# Function: predictAdjustInterestRateUpfrontFee(uint256,uint256,uint256)

**Contract**: [src/HintHelpers.sol/contract_HintHelpers.md]

## Metadata

- **Contract**: HintHelpers
- **Signature**: `predictAdjustInterestRateUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3581:706:218

## Implementation

```solidity
function predictAdjustInterestRateUpfrontFee(uint256 _collIndex, uint256 _troveId, uint256 _newInterestRate) external view returns (uint256) {
    ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
    IActivePool activePool = troveManager.activePool();
    LatestTroveData memory trove = troveManager.getLatestTroveData(_troveId);
    if ((_newInterestRate == trove.annualInterestRate) || (block.timestamp >= (trove.lastInterestRateAdjTime + INTEREST_RATE_ADJ_COOLDOWN))) {
        return 0;
    }
    return _predictAdjustInterestRateUpfrontFee(activePool, trove, _newInterestRate);
}
```

## Related Implementations

### _predictAdjustInterestRateUpfrontFee(contract IActivePool,struct LatestTroveData,uint256)

- **Kind**: internal
- **Source**: 4798:643:218
- **Link**: `src/HintHelpers.sol:HintHelpers:_predictAdjustInterestRateUpfrontFee(contract IActivePool,struct LatestTroveData,uint256)`

```solidity
function _predictAdjustInterestRateUpfrontFee(IActivePool _activePool, LatestTroveData memory _trove, uint256 _newInterestRate) internal view returns (uint256) {
    TroveChange memory troveChange;
    troveChange.appliedRedistBoldDebtGain = _trove.redistBoldDebtGain;
    troveChange.newWeightedRecordedDebt = _trove.entireDebt * _newInterestRate;
    troveChange.oldWeightedRecordedDebt = _trove.weightedRecordedDebt;
    uint256 avgInterestRate = _activePool.getNewApproxAvgInterestRateFromTroveChange(troveChange);
    return _calcUpfrontFee(_trove.entireDebt, avgInterestRate);
}
```

### _calcUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 2703:203:218
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
- **IActivePool::getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)**

## State Variable Reads

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HintHelpers.predictAdjustInterestRateUpfrontFee(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: HintHelpers._predictAdjustInterestRateUpfrontFee(contract IActivePool,struct LatestTroveData,uint256) (NodeID: 1)
      💬 Args: [activePool, trove, _newInterestRate]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: HintHelpers._calcUpfrontFee(uint256,uint256) (NodeID: 2)
        💬 Args: [_trove.entireDebt, avgInterestRate]
        👁️  Def: internal
```
