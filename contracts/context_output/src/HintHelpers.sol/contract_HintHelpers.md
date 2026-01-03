# Contract: HintHelpers

## Metadata

- **Name**: HintHelpers
- **Type**: Contract
- **Path**: src/HintHelpers.sol

## Implements Interfaces

- **IHintHelpers** [src/Interfaces/IHintHelpers.sol/interface_IHintHelpers.md]

## State Variables

### NAME

```solidity
string public constant NAME = "HintHelpers"
```

### collateralRegistry

```solidity
ICollateralRegistry public immutable collateralRegistry
```

**ICollateralRegistry**: [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Public/External Functions

### constructor(contract ICollateralRegistry)

- **Signature**: `constructor(contract ICollateralRegistry)`
- **Visibility**: public
- **Source Range**: 386:110:67
- **Details**: [function_constructor_contract_ICollateralRegistry.md](./function_constructor_contract_ICollateralRegistry.md)

**Signature:**
```solidity
constructor(ICollateralRegistry _collateralRegistry);
```

### getApproxHint(uint256,uint256,uint256,uint256)

- **Signature**: `getApproxHint(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1102:1595:67
- **Details**: [function_getApproxHint_uint256_uint256_uint256_uint256.md](./function_getApproxHint_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function getApproxHint(uint256 _collIndex, uint256 _interestRate, uint256 _numTrials, uint256 _inputRandomSeed) external view returns (uint256 hintId, uint256 diff, uint256 latestRandomSeed);
```

### predictOpenTroveUpfrontFee(uint256,uint256,uint256)

- **Signature**: `predictOpenTroveUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2912:663:67
- **Details**: [function_predictOpenTroveUpfrontFee_uint256_uint256_uint256.md](./function_predictOpenTroveUpfrontFee_uint256_uint256_uint256.md)

**Signature:**
```solidity
function predictOpenTroveUpfrontFee(uint256 _collIndex, uint256 _borrowedAmount, uint256 _interestRate) external view returns (uint256);
```

### predictAdjustInterestRateUpfrontFee(uint256,uint256,uint256)

- **Signature**: `predictAdjustInterestRateUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3581:706:67
- **Details**: [function_predictAdjustInterestRateUpfrontFee_uint256_uint256_uint256.md](./function_predictAdjustInterestRateUpfrontFee_uint256_uint256_uint256.md)

**Signature:**
```solidity
function predictAdjustInterestRateUpfrontFee(uint256 _collIndex, uint256 _troveId, uint256 _newInterestRate) external view returns (uint256);
```

### forcePredictAdjustInterestRateUpfrontFee(uint256,uint256,uint256)

- **Signature**: `forcePredictAdjustInterestRateUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4293:499:67
- **Details**: [function_forcePredictAdjustInterestRateUpfrontFee_uint256_uint256_uint256.md](./function_forcePredictAdjustInterestRateUpfrontFee_uint256_uint256_uint256.md)

**Signature:**
```solidity
function forcePredictAdjustInterestRateUpfrontFee(uint256 _collIndex, uint256 _troveId, uint256 _newInterestRate) external view returns (uint256);
```

### predictAdjustTroveUpfrontFee(uint256,uint256,uint256)

- **Signature**: `predictAdjustTroveUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5447:1542:67
- **Details**: [function_predictAdjustTroveUpfrontFee_uint256_uint256_uint256.md](./function_predictAdjustTroveUpfrontFee_uint256_uint256_uint256.md)

**Signature:**
```solidity
function predictAdjustTroveUpfrontFee(uint256 _collIndex, uint256 _troveId, uint256 _debtIncrease) external view returns (uint256);
```

### predictAdjustBatchInterestRateUpfrontFee(uint256,address,uint256)

- **Signature**: `predictAdjustBatchInterestRateUpfrontFee(uint256,address,uint256)`
- **Visibility**: external
- **Source Range**: 6995:1118:67
- **Details**: [function_predictAdjustBatchInterestRateUpfrontFee_uint256_address_uint256.md](./function_predictAdjustBatchInterestRateUpfrontFee_uint256_address_uint256.md)

**Signature:**
```solidity
function predictAdjustBatchInterestRateUpfrontFee(uint256 _collIndex, address _batchAddress, uint256 _newInterestRate) external view returns (uint256);
```

### predictOpenTroveAndJoinBatchUpfrontFee(uint256,uint256,address)

- **Signature**: `predictOpenTroveAndJoinBatchUpfrontFee(uint256,uint256,address)`
- **Visibility**: external
- **Source Range**: 8119:959:67
- **Details**: [function_predictOpenTroveAndJoinBatchUpfrontFee_uint256_uint256_address.md](./function_predictOpenTroveAndJoinBatchUpfrontFee_uint256_uint256_address.md)

**Signature:**
```solidity
function predictOpenTroveAndJoinBatchUpfrontFee(uint256 _collIndex, uint256 _borrowedAmount, address _batchAddress) external view returns (uint256);
```

### predictJoinBatchInterestRateUpfrontFee(uint256,uint256,address)

- **Signature**: `predictJoinBatchInterestRateUpfrontFee(uint256,uint256,address)`
- **Visibility**: external
- **Source Range**: 9084:1147:67
- **Details**: [function_predictJoinBatchInterestRateUpfrontFee_uint256_uint256_address.md](./function_predictJoinBatchInterestRateUpfrontFee_uint256_uint256_address.md)

**Signature:**
```solidity
function predictJoinBatchInterestRateUpfrontFee(uint256 _collIndex, uint256 _troveId, address _batchAddress) external view returns (uint256);
```

### predictRemoveFromBatchUpfrontFee(uint256,uint256,uint256)

- **Signature**: `predictRemoveFromBatchUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 10237:1429:67
- **Details**: [function_predictRemoveFromBatchUpfrontFee_uint256_uint256_uint256.md](./function_predictRemoveFromBatchUpfrontFee_uint256_uint256_uint256.md)

**Signature:**
```solidity
function predictRemoveFromBatchUpfrontFee(uint256 _collIndex, uint256 _troveId, uint256 _newInterestRate) external view returns (uint256);
```
