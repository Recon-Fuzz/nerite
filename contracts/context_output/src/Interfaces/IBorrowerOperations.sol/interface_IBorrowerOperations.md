# Interface: IBorrowerOperations

## Metadata

- **Name**: IBorrowerOperations
- **Type**: Interface
- **Path**: src/Interfaces/IBorrowerOperations.sol

## Implements Interfaces

- **IAddRemoveManagers** [src/Interfaces/IAddRemoveManagers.sol/interface_IAddRemoveManagers.md]
- **ILiquityBase** [src/Interfaces/ILiquityBase.sol/interface_ILiquityBase.md]

## Structs

### OpenTroveAndJoinInterestBatchManagerParams

```solidity
struct OpenTroveAndJoinInterestBatchManagerParams {
    address owner;
    uint256 ownerIndex;
    uint256 collAmount;
    uint256 boldAmount;
    uint256 upperHint;
    uint256 lowerHint;
    address interestBatchManager;
    uint256 maxUpfrontFee;
    address addManager;
    address removeManager;
    address receiver;
}
```

### InterestIndividualDelegate

```solidity
struct InterestIndividualDelegate {
    address account;
    uint128 minInterestRate;
    uint128 maxInterestRate;
    uint256 minInterestRateChangePeriod;
}
```

### InterestBatchManager

```solidity
struct InterestBatchManager {
    uint128 minInterestRate;
    uint128 maxInterestRate;
    uint256 minInterestRateChangePeriod;
}
```

## Public/External Functions

### CCR()

- **Signature**: `CCR()`
- **Visibility**: external
- **Source Range**: 380:47:73

**Signature:**
```solidity
function CCR() external view returns (uint256);;
```

### MCR()

- **Signature**: `MCR()`
- **Visibility**: external
- **Source Range**: 432:47:73

**Signature:**
```solidity
function MCR() external view returns (uint256);;
```

### SCR()

- **Signature**: `SCR()`
- **Visibility**: external
- **Source Range**: 484:47:73

**Signature:**
```solidity
function SCR() external view returns (uint256);;
```

### openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)

- **Signature**: `openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)`
- **Visibility**: external
- **Source Range**: 537:375:73

**Signature:**
```solidity
function openTrove(address _owner, uint256 _ownerIndex, uint256 _ETHAmount, uint256 _boldAmount, uint256 _upperHint, uint256 _lowerHint, uint256 _annualInterestRate, uint256 _maxUpfrontFee, address _addManager, address _removeManager, address _receiver) external returns (uint256);;
```

### openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams)

- **Signature**: `openTroveAndJoinInterestBatchManager(struct IBorrowerOperations.OpenTroveAndJoinInterestBatchManagerParams)`
- **Visibility**: external
- **Source Range**: 1296:150:73

**Signature:**
```solidity
function openTroveAndJoinInterestBatchManager(OpenTroveAndJoinInterestBatchManagerParams calldata _params) external returns (uint256);;
```

### addColl(uint256,uint256)

- **Signature**: `addColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1452:64:73

**Signature:**
```solidity
function addColl(uint256 _troveId, uint256 _ETHAmount) external;;
```

### withdrawColl(uint256,uint256)

- **Signature**: `withdrawColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1522:66:73

**Signature:**
```solidity
function withdrawColl(uint256 _troveId, uint256 _amount) external;;
```

### withdrawBold(uint256,uint256,uint256)

- **Signature**: `withdrawBold(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1594:90:73

**Signature:**
```solidity
function withdrawBold(uint256 _troveId, uint256 _amount, uint256 _maxUpfrontFee) external;;
```

### repayBold(uint256,uint256)

- **Signature**: `repayBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1690:63:73

**Signature:**
```solidity
function repayBold(uint256 _troveId, uint256 _amount) external;;
```

### closeTrove(uint256)

- **Signature**: `closeTrove(uint256)`
- **Visibility**: external
- **Source Range**: 1759:47:73

**Signature:**
```solidity
function closeTrove(uint256 _troveId) external;;
```

### adjustTrove(uint256,uint256,bool,uint256,bool,uint256)

- **Signature**: `adjustTrove(uint256,uint256,bool,uint256,bool,uint256)`
- **Visibility**: external
- **Source Range**: 1812:211:73

**Signature:**
```solidity
function adjustTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _debtChange, bool isDebtIncrease, uint256 _maxUpfrontFee) external;;
```

### adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)

- **Signature**: `adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2029:274:73

**Signature:**
```solidity
function adjustZombieTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) external;;
```

### adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)

- **Signature**: `adjustTroveInterestRate(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2309:202:73

**Signature:**
```solidity
function adjustTroveInterestRate(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) external;;
```

### applyPendingDebt(uint256,uint256,uint256)

- **Signature**: `applyPendingDebt(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2517:93:73

**Signature:**
```solidity
function applyPendingDebt(uint256 _troveId, uint256 _lowerHint, uint256 _upperHint) external;;
```

### onLiquidateTrove(uint256)

- **Signature**: `onLiquidateTrove(uint256)`
- **Visibility**: external
- **Source Range**: 2616:53:73

**Signature:**
```solidity
function onLiquidateTrove(uint256 _troveId) external;;
```

### claimCollateral()

- **Signature**: `claimCollateral()`
- **Visibility**: external
- **Source Range**: 2675:36:73

**Signature:**
```solidity
function claimCollateral() external;;
```

### hasBeenShutDown()

- **Signature**: `hasBeenShutDown()`
- **Visibility**: external
- **Source Range**: 2717:56:73

**Signature:**
```solidity
function hasBeenShutDown() external view returns (bool);;
```

### shutdown()

- **Signature**: `shutdown()`
- **Visibility**: external
- **Source Range**: 2778:29:73

**Signature:**
```solidity
function shutdown() external;;
```

### shutdownFromOracleFailure()

- **Signature**: `shutdownFromOracleFailure()`
- **Visibility**: external
- **Source Range**: 2812:46:73

**Signature:**
```solidity
function shutdownFromOracleFailure() external;;
```

### checkBatchManagerExists(address)

- **Signature**: `checkBatchManagerExists(address)`
- **Visibility**: external
- **Source Range**: 2864:86:73

**Signature:**
```solidity
function checkBatchManagerExists(address _batchMananger) external view returns (bool);;
```

### getInterestIndividualDelegateOf(uint256)

- **Signature**: `getInterestIndividualDelegateOf(uint256)`
- **Visibility**: external
- **Source Range**: 3174:141:73

**Signature:**
```solidity
function getInterestIndividualDelegateOf(uint256 _troveId) external view returns (InterestIndividualDelegate memory);;
```

### setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256)

- **Signature**: `setInterestIndividualDelegate(uint256,address,uint128,uint128,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3320:408:73

**Signature:**
```solidity
function setInterestIndividualDelegate(uint256 _troveId, address _delegate, uint128 _minInterestRate, uint128 _maxInterestRate, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee, uint256 _minInterestRateChangePeriod) external;;
```

### removeInterestIndividualDelegate(uint256)

- **Signature**: `removeInterestIndividualDelegate(uint256)`
- **Visibility**: external
- **Source Range**: 3733:69:73

**Signature:**
```solidity
function removeInterestIndividualDelegate(uint256 _troveId) external;;
```

### registerBatchManager(uint128,uint128,uint128,uint128,uint128)

- **Signature**: `registerBatchManager(uint128,uint128,uint128,uint128,uint128)`
- **Visibility**: external
- **Source Range**: 3981:214:73

**Signature:**
```solidity
function registerBatchManager(uint128 minInterestRate, uint128 maxInterestRate, uint128 currentInterestRate, uint128 fee, uint128 minInterestRateChangePeriod) external;;
```

### lowerBatchManagementFee(uint256)

- **Signature**: `lowerBatchManagementFee(uint256)`
- **Visibility**: external
- **Source Range**: 4200:65:73

**Signature:**
```solidity
function lowerBatchManagementFee(uint256 _newAnnualFee) external;;
```

### setBatchManagerAnnualInterestRate(uint128,uint256,uint256,uint256)

- **Signature**: `setBatchManagerAnnualInterestRate(uint128,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4270:186:73

**Signature:**
```solidity
function setBatchManagerAnnualInterestRate(uint128 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) external;;
```

### interestBatchManagerOf(uint256)

- **Signature**: `interestBatchManagerOf(uint256)`
- **Visibility**: external
- **Source Range**: 4461:82:73

**Signature:**
```solidity
function interestBatchManagerOf(uint256 _troveId) external view returns (address);;
```

### getInterestBatchManager(address)

- **Signature**: `getInterestBatchManager(address)`
- **Visibility**: external
- **Source Range**: 4548:103:73

**Signature:**
```solidity
function getInterestBatchManager(address _account) external view returns (InterestBatchManager memory);;
```

### setInterestBatchManager(uint256,address,uint256,uint256,uint256)

- **Signature**: `setInterestBatchManager(uint256,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4656:196:73

**Signature:**
```solidity
function setInterestBatchManager(uint256 _troveId, address _newBatchManager, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) external;;
```

### removeFromBatch(uint256,uint256,uint256,uint256,uint256)

- **Signature**: `removeFromBatch(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4857:194:73

**Signature:**
```solidity
function removeFromBatch(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) external;;
```

### switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)

- **Signature**: `switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5056:265:73

**Signature:**
```solidity
function switchBatchManager(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, address _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) external;;
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

### setAddManager(uint256,address) (inherited from IAddRemoveManagers)

- **Signature**: `setAddManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 93:68:69

**Signature:**
```solidity
function setAddManager(uint256 _troveId, address _manager) external;;
```

### setRemoveManager(uint256,address) (inherited from IAddRemoveManagers)

- **Signature**: `setRemoveManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 166:71:69

**Signature:**
```solidity
function setRemoveManager(uint256 _troveId, address _manager) external;;
```

### setRemoveManagerWithReceiver(uint256,address,address) (inherited from IAddRemoveManagers)

- **Signature**: `setRemoveManagerWithReceiver(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 242:102:69

**Signature:**
```solidity
function setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) external;;
```

### addManagerOf(uint256) (inherited from IAddRemoveManagers)

- **Signature**: `addManagerOf(uint256)`
- **Visibility**: external
- **Source Range**: 349:72:69

**Signature:**
```solidity
function addManagerOf(uint256 _troveId) external view returns (address);;
```

### removeManagerReceiverOf(uint256) (inherited from IAddRemoveManagers)

- **Signature**: `removeManagerReceiverOf(uint256)`
- **Visibility**: external
- **Source Range**: 426:92:69

**Signature:**
```solidity
function removeManagerReceiverOf(uint256 _troveId) external view returns (address, address);;
```
