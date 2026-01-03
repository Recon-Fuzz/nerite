# Interface: IMultiTroveGetter

## Metadata

- **Name**: IMultiTroveGetter
- **Type**: Interface
- **Path**: src/Interfaces/IMultiTroveGetter.sol

## Structs

### CombinedTroveData

```solidity
struct CombinedTroveData {
    uint256 id;
    uint256 debt;
    uint256 coll;
    uint256 stake;
    uint256 annualInterestRate;
    uint256 lastDebtUpdateTime;
    uint256 lastInterestRateAdjTime;
    address interestBatchManager;
    uint256 batchDebtShares;
    uint256 batchCollShares;
    uint256 snapshotETH;
    uint256 snapshotBoldDebt;
}
```

### DebtPerInterestRate

```solidity
struct DebtPerInterestRate {
    address interestBatchManager;
    uint256 interestRate;
    uint256 debt;
}
```

## Public/External Functions

### getMultipleSortedTroves(uint256,int256,uint256)

- **Signature**: `getMultipleSortedTroves(uint256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 627:170:84

**Signature:**
```solidity
function getMultipleSortedTroves(uint256 _collIndex, int256 _startIdx, uint256 _count) external view returns (CombinedTroveData[] memory _troves);;
```

### getDebtPerInterestRateAscending(uint256,uint256,uint256)

- **Signature**: `getDebtPerInterestRateAscending(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 803:196:84

**Signature:**
```solidity
function getDebtPerInterestRateAscending(uint256 _collIndex, uint256 _startId, uint256 _maxIterations) external view returns (DebtPerInterestRate[] memory, uint256 currId);;
```
