# Contract: MultiTroveGetter

## Metadata

- **Name**: MultiTroveGetter
- **Type**: Contract
- **Path**: src/MultiTroveGetter.sol

## Implements Interfaces

- **IMultiTroveGetter** [src/Interfaces/IMultiTroveGetter.sol/interface_IMultiTroveGetter.md]

## State Variables

### collateralRegistry

```solidity
ICollateralRegistry public immutable collateralRegistry
```

**ICollateralRegistry**: [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Structs

### CombinedTroveData (inherited from IMultiTroveGetter)

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

### DebtPerInterestRate (inherited from IMultiTroveGetter)

```solidity
struct DebtPerInterestRate {
    address interestBatchManager;
    uint256 interestRate;
    uint256 debt;
}
```

## Public/External Functions

### constructor(contract ICollateralRegistry)

- **Signature**: `constructor(contract ICollateralRegistry)`
- **Visibility**: public
- **Source Range**: 404:110:101
- **Details**: [function_constructor_contract_ICollateralRegistry.md](./function_constructor_contract_ICollateralRegistry.md)

**Signature:**
```solidity
constructor(ICollateralRegistry _collateralRegistry);
```

### getMultipleSortedTroves(uint256,int256,uint256)

- **Signature**: `getMultipleSortedTroves(uint256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 520:1329:101
- **Details**: [function_getMultipleSortedTroves_uint256_int256_uint256.md](./function_getMultipleSortedTroves_uint256_int256_uint256.md)

**Signature:**
```solidity
function getMultipleSortedTroves(uint256 _collIndex, int256 _startIdx, uint256 _count) external view returns (CombinedTroveData[] memory _troves);
```

### getDebtPerInterestRateAscending(uint256,uint256,uint256)

- **Signature**: `getDebtPerInterestRateAscending(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3839:1122:101
- **Details**: [function_getDebtPerInterestRateAscending_uint256_uint256_uint256.md](./function_getDebtPerInterestRateAscending_uint256_uint256_uint256.md)

**Signature:**
```solidity
function getDebtPerInterestRateAscending(uint256 _collIndex, uint256 _startId, uint256 _maxIterations) external view returns (DebtPerInterestRate[] memory data, uint256 currId);
```
