# Interface: ITroveManager

## Metadata

- **Name**: ITroveManager
- **Type**: Interface
- **Path**: src/Interfaces/ITroveManager.sol

## Implements Interfaces

- **ILiquityBase** [src/Interfaces/ILiquityBase.sol/interface_ILiquityBase.md]

## Structs

### OnSetInterestBatchManagerParams

```solidity
struct OnSetInterestBatchManagerParams {
    uint256 troveId;
    uint256 troveColl;
    uint256 troveDebt;
    TroveChange troveChange;
    address newBatchAddress;
    uint256 newBatchColl;
    uint256 newBatchDebt;
}
```

## Enums

### Status

```solidity
enum Status {
    nonExistent,
    active,
    closedByOwner,
    closedByLiquidation,
    zombie
}
```

## Public/External Functions

### shutdownTime()

- **Signature**: `shutdownTime()`
- **Visibility**: external
- **Source Range**: 540:56:94

**Signature:**
```solidity
function shutdownTime() external view returns (uint256);;
```

### troveNFT()

- **Signature**: `troveNFT()`
- **Visibility**: external
- **Source Range**: 602:54:94

**Signature:**
```solidity
function troveNFT() external view returns (ITroveNFT);;
```

### stabilityPool()

- **Signature**: `stabilityPool()`
- **Visibility**: external
- **Source Range**: 661:64:94

**Signature:**
```solidity
function stabilityPool() external view returns (IStabilityPool);;
```

### sortedTroves()

- **Signature**: `sortedTroves()`
- **Visibility**: external
- **Source Range**: 793:62:94

**Signature:**
```solidity
function sortedTroves() external view returns (ISortedTroves);;
```

### borrowerOperations()

- **Signature**: `borrowerOperations()`
- **Visibility**: external
- **Source Range**: 860:74:94

**Signature:**
```solidity
function borrowerOperations() external view returns (IBorrowerOperations);;
```

### Troves(uint256)

- **Signature**: `Troves(uint256)`
- **Visibility**: external
- **Source Range**: 940:425:94

**Signature:**
```solidity
function Troves(uint256 _id) external view returns (uint256 debt, uint256 coll, uint256 stake, Status status, uint64 arrayIndex, uint64 lastDebtUpdateTime, uint64 lastInterestRateAdjTime, uint256 annualInterestRate, address interestBatchManager, uint256 batchDebtShares);;
```

### rewardSnapshots(uint256)

- **Signature**: `rewardSnapshots(uint256)`
- **Visibility**: external
- **Source Range**: 1371:93:94

**Signature:**
```solidity
function rewardSnapshots(uint256 _id) external view returns (uint256 coll, uint256 boldDebt);;
```

### getTroveIdsCount()

- **Signature**: `getTroveIdsCount()`
- **Visibility**: external
- **Source Range**: 1470:60:94

**Signature:**
```solidity
function getTroveIdsCount() external view returns (uint256);;
```

### getTroveFromTroveIdsArray(uint256)

- **Signature**: `getTroveFromTroveIdsArray(uint256)`
- **Visibility**: external
- **Source Range**: 1536:83:94

**Signature:**
```solidity
function getTroveFromTroveIdsArray(uint256 _index) external view returns (uint256);;
```

### getCurrentICR(uint256,uint256)

- **Signature**: `getCurrentICR(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1625:89:94

**Signature:**
```solidity
function getCurrentICR(uint256 _troveId, uint256 _price) external view returns (uint256);;
```

### lastZombieTroveId()

- **Signature**: `lastZombieTroveId()`
- **Visibility**: external
- **Source Range**: 1720:61:94

**Signature:**
```solidity
function lastZombieTroveId() external view returns (uint256);;
```

### batchLiquidateTroves(uint256[])

- **Signature**: `batchLiquidateTroves(uint256[])`
- **Visibility**: external
- **Source Range**: 1787:71:94

**Signature:**
```solidity
function batchLiquidateTroves(uint256[] calldata _troveArray) external;;
```

### redeemCollateral(address,uint256,uint256,uint256,uint256)

- **Signature**: `redeemCollateral(address,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1864:218:94

**Signature:**
```solidity
function redeemCollateral(address _sender, uint256 _boldAmount, uint256 _price, uint256 _redemptionRate, uint256 _maxIterations) external returns (uint256 _redemeedAmount);;
```

### shutdown()

- **Signature**: `shutdown()`
- **Visibility**: external
- **Source Range**: 2088:29:94

**Signature:**
```solidity
function shutdown() external;;
```

### urgentRedemption(uint256,uint256[],uint256)

- **Signature**: `urgentRedemption(uint256,uint256[],uint256)`
- **Visibility**: external
- **Source Range**: 2122:110:94

**Signature:**
```solidity
function urgentRedemption(uint256 _boldAmount, uint256[] calldata _troveIds, uint256 _minCollateral) external;;
```

### getUnbackedPortionPriceAndRedeemability()

- **Signature**: `getUnbackedPortionPriceAndRedeemability()`
- **Visibility**: external
- **Source Range**: 2238:93:94

**Signature:**
```solidity
function getUnbackedPortionPriceAndRedeemability() external returns (uint256, uint256, bool);;
```

### getLatestTroveData(uint256)

- **Signature**: `getLatestTroveData(uint256)`
- **Visibility**: external
- **Source Range**: 2337:93:94

**Signature:**
```solidity
function getLatestTroveData(uint256 _troveId) external view returns (LatestTroveData memory);;
```

### getTroveAnnualInterestRate(uint256)

- **Signature**: `getTroveAnnualInterestRate(uint256)`
- **Visibility**: external
- **Source Range**: 2435:86:94

**Signature:**
```solidity
function getTroveAnnualInterestRate(uint256 _troveId) external view returns (uint256);;
```

### getTroveStatus(uint256)

- **Signature**: `getTroveStatus(uint256)`
- **Visibility**: external
- **Source Range**: 2527:73:94

**Signature:**
```solidity
function getTroveStatus(uint256 _troveId) external view returns (Status);;
```

### getLatestBatchData(address)

- **Signature**: `getLatestBatchData(address)`
- **Visibility**: external
- **Source Range**: 2606:98:94

**Signature:**
```solidity
function getLatestBatchData(address _batchAddress) external view returns (LatestBatchData memory);;
```

### onOpenTrove(address,uint256,struct TroveChange,uint256)

- **Signature**: `onOpenTrove(address,uint256,struct TroveChange,uint256)`
- **Visibility**: external
- **Source Range**: 2773:134:94

**Signature:**
```solidity
function onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) external;;
```

### onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)

- **Signature**: `onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2912:226:94

**Signature:**
```solidity
function onOpenTroveAndJoinBatch(address _owner, uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _batchColl, uint256 _batchDebt) external;;
```

### setTroveStatusToActive(uint256)

- **Signature**: `setTroveStatusToActive(uint256)`
- **Visibility**: external
- **Source Range**: 3185:59:94

**Signature:**
```solidity
function setTroveStatusToActive(uint256 _troveId) external;;
```

### onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)

- **Signature**: `onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 3250:211:94

**Signature:**
```solidity
function onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange calldata _troveChange) external;;
```

### onAdjustTrove(uint256,uint256,uint256,struct TroveChange)

- **Signature**: `onAdjustTrove(uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 3467:129:94

**Signature:**
```solidity
function onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange calldata _troveChange) external;;
```

### onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)

- **Signature**: `onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3602:271:94

**Signature:**
```solidity
function onAdjustTroveInsideBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) external;;
```

### onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)

- **Signature**: `onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 3879:269:94

**Signature:**
```solidity
function onApplyTroveInterest(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, TroveChange calldata _troveChange) external;;
```

### onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)

- **Signature**: `onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4154:306:94

**Signature:**
```solidity
function onCloseTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) external;;
```

### onRegisterBatchManager(address,uint256,uint256)

- **Signature**: `onRegisterBatchManager(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4487:113:94

**Signature:**
```solidity
function onRegisterBatchManager(address _batchAddress, uint256 _annualInterestRate, uint256 _annualFee) external;;
```

### onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)

- **Signature**: `onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4605:177:94

**Signature:**
```solidity
function onLowerBatchManagerAnnualFee(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualManagementFee) external;;
```

### onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)

- **Signature**: `onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4787:244:94

**Signature:**
```solidity
function onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) external;;
```

### onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)

- **Signature**: `onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)`
- **Visibility**: external
- **Source Range**: 5462:94:94

**Signature:**
```solidity
function onSetInterestBatchManager(OnSetInterestBatchManagerParams calldata _params) external;;
```

### onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)

- **Signature**: `onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5561:429:94

**Signature:**
```solidity
function onRemoveFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, uint256 _newAnnualInterestRate) external;;
```

### setDebtLimit(uint256)

- **Signature**: `setDebtLimit(uint256)`
- **Visibility**: external
- **Source Range**: 5996:54:94

**Signature:**
```solidity
function setDebtLimit(uint256 _newDebtLimit) external;;
```

### getDebtLimit()

- **Signature**: `getDebtLimit()`
- **Visibility**: external
- **Source Range**: 6055:56:94

**Signature:**
```solidity
function getDebtLimit() external view returns (uint256);;
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
