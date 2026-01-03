# Interface: IHintHelpers

## Metadata

- **Name**: IHintHelpers
- **Type**: Interface
- **Path**: src/Interfaces/IHintHelpers.sol

## Public/External Functions

### getApproxHint(uint256,uint256,uint256,uint256)

- **Signature**: `getApproxHint(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 87:215:78

**Signature:**
```solidity
function getApproxHint(uint256 _collIndex, uint256 _interestRate, uint256 _numTrials, uint256 _inputRandomSeed) external view returns (uint256 hintId, uint256 diff, uint256 latestRandomSeed);;
```

### predictOpenTroveUpfrontFee(uint256,uint256,uint256)

- **Signature**: `predictOpenTroveUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 308:160:78

**Signature:**
```solidity
function predictOpenTroveUpfrontFee(uint256 _collIndex, uint256 _borrowedAmount, uint256 _interestRate) external view returns (uint256);;
```

### predictAdjustInterestRateUpfrontFee(uint256,uint256,uint256)

- **Signature**: `predictAdjustInterestRateUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 474:165:78

**Signature:**
```solidity
function predictAdjustInterestRateUpfrontFee(uint256 _collIndex, uint256 _troveId, uint256 _newInterestRate) external view returns (uint256);;
```

### forcePredictAdjustInterestRateUpfrontFee(uint256,uint256,uint256)

- **Signature**: `forcePredictAdjustInterestRateUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 645:170:78

**Signature:**
```solidity
function forcePredictAdjustInterestRateUpfrontFee(uint256 _collIndex, uint256 _troveId, uint256 _newInterestRate) external view returns (uint256);;
```

### predictAdjustTroveUpfrontFee(uint256,uint256,uint256)

- **Signature**: `predictAdjustTroveUpfrontFee(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 821:155:78

**Signature:**
```solidity
function predictAdjustTroveUpfrontFee(uint256 _collIndex, uint256 _troveId, uint256 _debtIncrease) external view returns (uint256);;
```

### predictAdjustBatchInterestRateUpfrontFee(uint256,address,uint256)

- **Signature**: `predictAdjustBatchInterestRateUpfrontFee(uint256,address,uint256)`
- **Visibility**: external
- **Source Range**: 982:181:78

**Signature:**
```solidity
function predictAdjustBatchInterestRateUpfrontFee(uint256 _collIndex, address _batchAddress, uint256 _newInterestRate) external view returns (uint256);;
```

### predictJoinBatchInterestRateUpfrontFee(uint256,uint256,address)

- **Signature**: `predictJoinBatchInterestRateUpfrontFee(uint256,uint256,address)`
- **Visibility**: external
- **Source Range**: 1169:165:78

**Signature:**
```solidity
function predictJoinBatchInterestRateUpfrontFee(uint256 _collIndex, uint256 _troveId, address _batchAddress) external view returns (uint256);;
```
