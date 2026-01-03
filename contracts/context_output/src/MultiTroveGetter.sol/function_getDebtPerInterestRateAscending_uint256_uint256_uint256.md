# Function: getDebtPerInterestRateAscending(uint256,uint256,uint256)

**Contract**: [src/MultiTroveGetter.sol/contract_MultiTroveGetter.md]

## Metadata

- **Contract**: MultiTroveGetter
- **Signature**: `getDebtPerInterestRateAscending(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3839:1122:101

## Implementation

```solidity
function getDebtPerInterestRateAscending(uint256 _collIndex, uint256 _startId, uint256 _maxIterations) external view returns (DebtPerInterestRate[] memory data, uint256 currId) {
    ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
    require(address(troveManager) != address(0), "Invalid collateral index");
    ISortedTroves sortedTroves = troveManager.sortedTroves();
    assert(address(sortedTroves) != address(0));
    data = new DebtPerInterestRate[](_maxIterations);
    currId = (_startId == 0) ? sortedTroves.getLast() : _startId;
    for (uint256 i = 0; i < _maxIterations; ++i) {
        if (currId == 0) break;
        (, uint256 prevId, BatchId interestBatchManager, ) = sortedTroves.nodes(currId);
        LatestTroveData memory trove = troveManager.getLatestTroveData(currId);
        data[i].interestBatchManager = BatchId.unwrap(interestBatchManager);
        data[i].interestRate = trove.annualInterestRate;
        data[i].debt = trove.entireDebt;
        currId = prevId;
    }
}
```

## External Calls

- **ICollateralRegistry::getTroveManager(uint256)**
- **ITroveManager::sortedTroves()**
- **ISortedTroves::getLast()**
- **ISortedTroves::nodes(uint256)**
- **ITroveManager::getLatestTroveData(uint256)**

## State Variable Reads

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MultiTroveGetter.getDebtPerInterestRateAscending(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
