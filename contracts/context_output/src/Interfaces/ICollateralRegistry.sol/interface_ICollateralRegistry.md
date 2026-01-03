# Interface: ICollateralRegistry

## Metadata

- **Name**: ICollateralRegistry
- **Type**: Interface
- **Path**: src/Interfaces/ICollateralRegistry.sol

## Public/External Functions

### baseRate()

- **Signature**: `baseRate()`
- **Visibility**: external
- **Source Range**: 237:52:75

**Signature:**
```solidity
function baseRate() external view returns (uint256);;
```

### lastFeeOperationTime()

- **Signature**: `lastFeeOperationTime()`
- **Visibility**: external
- **Source Range**: 294:64:75

**Signature:**
```solidity
function lastFeeOperationTime() external view returns (uint256);;
```

### redeemCollateral(uint256,uint256,uint256)

- **Signature**: `redeemCollateral(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 364:107:75

**Signature:**
```solidity
function redeemCollateral(uint256 _boldamount, uint256 _maxIterations, uint256 _maxFeePercentage) external;;
```

### totalCollaterals()

- **Signature**: `totalCollaterals()`
- **Visibility**: external
- **Source Range**: 491:60:75

**Signature:**
```solidity
function totalCollaterals() external view returns (uint256);;
```

### getToken(uint256)

- **Signature**: `getToken(uint256)`
- **Visibility**: external
- **Source Range**: 556:73:75

**Signature:**
```solidity
function getToken(uint256 _index) external view returns (IERC20Metadata);;
```

### getTroveManager(uint256)

- **Signature**: `getTroveManager(uint256)`
- **Visibility**: external
- **Source Range**: 634:79:75

**Signature:**
```solidity
function getTroveManager(uint256 _index) external view returns (ITroveManager);;
```

### boldToken()

- **Signature**: `boldToken()`
- **Visibility**: external
- **Source Range**: 718:56:75

**Signature:**
```solidity
function boldToken() external view returns (IBoldToken);;
```

### getRedemptionRate()

- **Signature**: `getRedemptionRate()`
- **Visibility**: external
- **Source Range**: 780:61:75

**Signature:**
```solidity
function getRedemptionRate() external view returns (uint256);;
```

### getRedemptionRateWithDecay()

- **Signature**: `getRedemptionRateWithDecay()`
- **Visibility**: external
- **Source Range**: 846:70:75

**Signature:**
```solidity
function getRedemptionRateWithDecay() external view returns (uint256);;
```

### getRedemptionRateForRedeemedAmount(uint256)

- **Signature**: `getRedemptionRateForRedeemedAmount(uint256)`
- **Visibility**: external
- **Source Range**: 921:99:75

**Signature:**
```solidity
function getRedemptionRateForRedeemedAmount(uint256 _redeemAmount) external view returns (uint256);;
```

### getRedemptionFeeWithDecay(uint256)

- **Signature**: `getRedemptionFeeWithDecay(uint256)`
- **Visibility**: external
- **Source Range**: 1026:86:75

**Signature:**
```solidity
function getRedemptionFeeWithDecay(uint256 _ETHDrawn) external view returns (uint256);;
```

### getEffectiveRedemptionFeeInBold(uint256)

- **Signature**: `getEffectiveRedemptionFeeInBold(uint256)`
- **Visibility**: external
- **Source Range**: 1117:96:75

**Signature:**
```solidity
function getEffectiveRedemptionFeeInBold(uint256 _redeemAmount) external view returns (uint256);;
```

### updateDebtLimit(uint256,uint256)

- **Signature**: `updateDebtLimit(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1219:85:75

**Signature:**
```solidity
function updateDebtLimit(uint256 _indexTroveManager, uint256 _newDebtLimit) external;;
```

### updateGovernor(address)

- **Signature**: `updateGovernor(address)`
- **Visibility**: external
- **Source Range**: 1309:55:75

**Signature:**
```solidity
function updateGovernor(address _newGovernor) external;;
```

### getDebtLimit(uint256)

- **Signature**: `getDebtLimit(uint256)`
- **Visibility**: external
- **Source Range**: 1369:82:75

**Signature:**
```solidity
function getDebtLimit(uint256 _indexTroveManager) external view returns (uint256);;
```
