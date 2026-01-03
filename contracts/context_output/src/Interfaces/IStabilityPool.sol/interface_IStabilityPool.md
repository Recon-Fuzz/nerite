# Interface: IStabilityPool

## Metadata

- **Name**: IStabilityPool
- **Type**: Interface
- **Path**: src/Interfaces/IStabilityPool.sol

## Implements Interfaces

- **IBoldRewardsReceiver** [src/Interfaces/IBoldRewardsReceiver.sol/interface_IBoldRewardsReceiver.md]
- **ILiquityBase** [src/Interfaces/ILiquityBase.sol/interface_ILiquityBase.md]

## Public/External Functions

### boldToken()

- **Signature**: `boldToken()`
- **Visibility**: external
- **Source Range**: 1534:56:89

**Signature:**
```solidity
function boldToken() external view returns (IBoldToken);;
```

### troveManager()

- **Signature**: `troveManager()`
- **Visibility**: external
- **Source Range**: 1595:62:89

**Signature:**
```solidity
function troveManager() external view returns (ITroveManager);;
```

### provideToSP(uint256,bool)

- **Signature**: `provideToSP(uint256,bool)`
- **Visibility**: external
- **Source Range**: 1913:62:89

**Signature:**
```solidity
function provideToSP(uint256 _amount, bool _doClaim) external;;
```

### withdrawFromSP(uint256,bool)

- **Signature**: `withdrawFromSP(uint256,bool)`
- **Visibility**: external
- **Source Range**: 2335:64:89

**Signature:**
```solidity
function withdrawFromSP(uint256 _amount, bool doClaim) external;;
```

### claimAllCollGains()

- **Signature**: `claimAllCollGains()`
- **Visibility**: external
- **Source Range**: 2405:38:89

**Signature:**
```solidity
function claimAllCollGains() external;;
```

### offset(uint256,uint256)

- **Signature**: `offset(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2781:55:89

**Signature:**
```solidity
function offset(uint256 _debt, uint256 _coll) external;;
```

### deposits(address)

- **Signature**: `deposits(address)`
- **Visibility**: external
- **Source Range**: 2842:83:89

**Signature:**
```solidity
function deposits(address _depositor) external view returns (uint256 initialValue);;
```

### stashedColl(address)

- **Signature**: `stashedColl(address)`
- **Visibility**: external
- **Source Range**: 2930:73:89

**Signature:**
```solidity
function stashedColl(address _depositor) external view returns (uint256);;
```

### getCollBalance()

- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 3208:58:89

**Signature:**
```solidity
function getCollBalance() external view returns (uint256);;
```

### getTotalBoldDeposits()

- **Signature**: `getTotalBoldDeposits()`
- **Visibility**: external
- **Source Range**: 3393:64:89

**Signature:**
```solidity
function getTotalBoldDeposits() external view returns (uint256);;
```

### getYieldGainsOwed()

- **Signature**: `getYieldGainsOwed()`
- **Visibility**: external
- **Source Range**: 3463:61:89

**Signature:**
```solidity
function getYieldGainsOwed() external view returns (uint256);;
```

### getYieldGainsPending()

- **Signature**: `getYieldGainsPending()`
- **Visibility**: external
- **Source Range**: 3529:64:89

**Signature:**
```solidity
function getYieldGainsPending() external view returns (uint256);;
```

### getDepositorCollGain(address)

- **Signature**: `getDepositorCollGain(address)`
- **Visibility**: external
- **Source Range**: 3705:82:89

**Signature:**
```solidity
function getDepositorCollGain(address _depositor) external view returns (uint256);;
```

### getDepositorYieldGain(address)

- **Signature**: `getDepositorYieldGain(address)`
- **Visibility**: external
- **Source Range**: 3905:83:89

**Signature:**
```solidity
function getDepositorYieldGain(address _depositor) external view returns (uint256);;
```

### getDepositorYieldGainWithPending(address)

- **Signature**: `getDepositorYieldGainWithPending(address)`
- **Visibility**: external
- **Source Range**: 4091:94:89

**Signature:**
```solidity
function getDepositorYieldGainWithPending(address _depositor) external view returns (uint256);;
```

### getCompoundedBoldDeposit(address)

- **Signature**: `getCompoundedBoldDeposit(address)`
- **Visibility**: external
- **Source Range**: 4251:86:89

**Signature:**
```solidity
function getCompoundedBoldDeposit(address _depositor) external view returns (uint256);;
```

### epochToScaleToS(uint128,uint128)

- **Signature**: `epochToScaleToS(uint128,uint128)`
- **Visibility**: external
- **Source Range**: 4343:89:89

**Signature:**
```solidity
function epochToScaleToS(uint128 _epoch, uint128 _scale) external view returns (uint256);;
```

### epochToScaleToB(uint128,uint128)

- **Signature**: `epochToScaleToB(uint128,uint128)`
- **Visibility**: external
- **Source Range**: 4438:89:89

**Signature:**
```solidity
function epochToScaleToB(uint128 _epoch, uint128 _scale) external view returns (uint256);;
```

### P()

- **Signature**: `P()`
- **Visibility**: external
- **Source Range**: 4533:45:89

**Signature:**
```solidity
function P() external view returns (uint256);;
```

### currentScale()

- **Signature**: `currentScale()`
- **Visibility**: external
- **Source Range**: 4583:56:89

**Signature:**
```solidity
function currentScale() external view returns (uint128);;
```

### currentEpoch()

- **Signature**: `currentEpoch()`
- **Visibility**: external
- **Source Range**: 4644:56:89

**Signature:**
```solidity
function currentEpoch() external view returns (uint128);;
```

### activePool() (inherited from ILiquityBase)

- **Signature**: `activePool()`
- **Visibility**: external
- **Source Range**: 172:58:82

**Signature:**
```solidity
function activePool() external view returns (IActivePool);;
```

### getEntireSystemDebt() (inherited from ILiquityBase)

- **Signature**: `getEntireSystemDebt()`
- **Visibility**: external
- **Source Range**: 235:63:82

**Signature:**
```solidity
function getEntireSystemDebt() external view returns (uint256);;
```

### getEntireSystemColl() (inherited from ILiquityBase)

- **Signature**: `getEntireSystemColl()`
- **Visibility**: external
- **Source Range**: 303:63:82

**Signature:**
```solidity
function getEntireSystemColl() external view returns (uint256);;
```

### triggerBoldRewards(uint256) (inherited from IBoldRewardsReceiver)

- **Signature**: `triggerBoldRewards(uint256)`
- **Visibility**: external
- **Source Range**: 95:57:71

**Signature:**
```solidity
function triggerBoldRewards(uint256 _boldYield) external;;
```
