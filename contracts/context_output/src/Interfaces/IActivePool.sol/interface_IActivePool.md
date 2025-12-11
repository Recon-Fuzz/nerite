# Interface: IActivePool

## Metadata

- **Name**: IActivePool
- **Type**: Interface
- **Path**: src/Interfaces/IActivePool.sol

## Public/External Functions

### defaultPoolAddress()

- **Signature**: `defaultPoolAddress()`
- **Visibility**: external
- **Source Range**: 191:62:219

**Signature:**
```solidity
function defaultPoolAddress() external view returns (address);;
```

### borrowerOperationsAddress()

- **Signature**: `borrowerOperationsAddress()`
- **Visibility**: external
- **Source Range**: 258:69:219

**Signature:**
```solidity
function borrowerOperationsAddress() external view returns (address);;
```

### troveManagerAddress()

- **Signature**: `troveManagerAddress()`
- **Visibility**: external
- **Source Range**: 332:63:219

**Signature:**
```solidity
function troveManagerAddress() external view returns (address);;
```

### interestRouter()

- **Signature**: `interestRouter()`
- **Visibility**: external
- **Source Range**: 400:66:219

**Signature:**
```solidity
function interestRouter() external view returns (IInterestRouter);;
```

### stabilityPool()

- **Signature**: `stabilityPool()`
- **Visibility**: external
- **Source Range**: 583:70:219

**Signature:**
```solidity
function stabilityPool() external view returns (IBoldRewardsReceiver);;
```

### getCollBalance()

- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 659:58:219

**Signature:**
```solidity
function getCollBalance() external view returns (uint256);;
```

### getBoldDebt()

- **Signature**: `getBoldDebt()`
- **Visibility**: external
- **Source Range**: 722:55:219

**Signature:**
```solidity
function getBoldDebt() external view returns (uint256);;
```

### lastAggUpdateTime()

- **Signature**: `lastAggUpdateTime()`
- **Visibility**: external
- **Source Range**: 782:61:219

**Signature:**
```solidity
function lastAggUpdateTime() external view returns (uint256);;
```

### aggRecordedDebt()

- **Signature**: `aggRecordedDebt()`
- **Visibility**: external
- **Source Range**: 848:59:219

**Signature:**
```solidity
function aggRecordedDebt() external view returns (uint256);;
```

### aggWeightedDebtSum()

- **Signature**: `aggWeightedDebtSum()`
- **Visibility**: external
- **Source Range**: 912:62:219

**Signature:**
```solidity
function aggWeightedDebtSum() external view returns (uint256);;
```

### aggBatchManagementFees()

- **Signature**: `aggBatchManagementFees()`
- **Visibility**: external
- **Source Range**: 979:66:219

**Signature:**
```solidity
function aggBatchManagementFees() external view returns (uint256);;
```

### aggWeightedBatchManagementFeeSum()

- **Signature**: `aggWeightedBatchManagementFeeSum()`
- **Visibility**: external
- **Source Range**: 1050:76:219

**Signature:**
```solidity
function aggWeightedBatchManagementFeeSum() external view returns (uint256);;
```

### calcPendingAggInterest()

- **Signature**: `calcPendingAggInterest()`
- **Visibility**: external
- **Source Range**: 1131:66:219

**Signature:**
```solidity
function calcPendingAggInterest() external view returns (uint256);;
```

### calcPendingSPYield()

- **Signature**: `calcPendingSPYield()`
- **Visibility**: external
- **Source Range**: 1202:62:219

**Signature:**
```solidity
function calcPendingSPYield() external view returns (uint256);;
```

### calcPendingAggBatchManagementFee()

- **Signature**: `calcPendingAggBatchManagementFee()`
- **Visibility**: external
- **Source Range**: 1269:76:219

**Signature:**
```solidity
function calcPendingAggBatchManagementFee() external view returns (uint256);;
```

### getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)

- **Signature**: `getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)`
- **Visibility**: external
- **Source Range**: 1350:143:219

**Signature:**
```solidity
function getNewApproxAvgInterestRateFromTroveChange(TroveChange calldata _troveChange) external view returns (uint256);;
```

### mintAggInterest()

- **Signature**: `mintAggInterest()`
- **Visibility**: external
- **Source Range**: 1499:36:219

**Signature:**
```solidity
function mintAggInterest() external;;
```

### mintAggInterestAndAccountForTroveChange(struct TroveChange,address)

- **Signature**: `mintAggInterestAndAccountForTroveChange(struct TroveChange,address)`
- **Visibility**: external
- **Source Range**: 1540:124:219

**Signature:**
```solidity
function mintAggInterestAndAccountForTroveChange(TroveChange calldata _troveChange, address _batchManager) external;;
```

### mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)

- **Signature**: `mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)`
- **Visibility**: external
- **Source Range**: 1669:126:219

**Signature:**
```solidity
function mintBatchManagementFeeAndAccountForChange(TroveChange calldata _troveChange, address _batchAddress) external;;
```

### setShutdownFlag()

- **Signature**: `setShutdownFlag()`
- **Visibility**: external
- **Source Range**: 1801:36:219

**Signature:**
```solidity
function setShutdownFlag() external;;
```

### hasBeenShutDown()

- **Signature**: `hasBeenShutDown()`
- **Visibility**: external
- **Source Range**: 1842:56:219

**Signature:**
```solidity
function hasBeenShutDown() external view returns (bool);;
```

### shutdownTime()

- **Signature**: `shutdownTime()`
- **Visibility**: external
- **Source Range**: 1903:56:219

**Signature:**
```solidity
function shutdownTime() external view returns (uint256);;
```

### sendColl(address,uint256)

- **Signature**: `sendColl(address,uint256)`
- **Visibility**: external
- **Source Range**: 1965:62:219

**Signature:**
```solidity
function sendColl(address _account, uint256 _amount) external;;
```

### sendCollToDefaultPool(uint256)

- **Signature**: `sendCollToDefaultPool(uint256)`
- **Visibility**: external
- **Source Range**: 2032:57:219

**Signature:**
```solidity
function sendCollToDefaultPool(uint256 _amount) external;;
```

### receiveColl(uint256)

- **Signature**: `receiveColl(uint256)`
- **Visibility**: external
- **Source Range**: 2094:47:219

**Signature:**
```solidity
function receiveColl(uint256 _amount) external;;
```

### accountForReceivedColl(uint256)

- **Signature**: `accountForReceivedColl(uint256)`
- **Visibility**: external
- **Source Range**: 2146:58:219

**Signature:**
```solidity
function accountForReceivedColl(uint256 _amount) external;;
```
