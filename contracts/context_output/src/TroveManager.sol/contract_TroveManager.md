# Contract: TroveManager

## Metadata

- **Name**: TroveManager
- **Type**: Contract
- **Path**: src/TroveManager.sol

## Implements Interfaces

- **ITroveEvents** [src/Interfaces/ITroveEvents.sol/interface_ITroveEvents.md]
- **ITroveManager** [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **ILiquityBase** [src/Interfaces/ILiquityBase.sol/interface_ILiquityBase.md]

## State Variables

### activePool (inherited from LiquityBase)

```solidity
IActivePool public activePool
```

**IActivePool**: [src/Interfaces/IActivePool.sol/interface_IActivePool.md]

### defaultPool (inherited from LiquityBase)

```solidity
IDefaultPool internal defaultPool
```

**IDefaultPool**: [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

### priceFeed (inherited from LiquityBase)

```solidity
IPriceFeed internal priceFeed
```

**IPriceFeed**: [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

### troveNFT

```solidity
ITroveNFT public troveNFT
```

**ITroveNFT**: [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

### borrowerOperations

```solidity
IBorrowerOperations public borrowerOperations
```

**IBorrowerOperations**: [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

### stabilityPool

```solidity
IStabilityPool public stabilityPool
```

**IStabilityPool**: [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]

### gasPoolAddress

```solidity
address internal gasPoolAddress
```

### collSurplusPool

```solidity
ICollSurplusPool internal collSurplusPool
```

**ICollSurplusPool**: [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]

### boldToken

```solidity
IBoldToken internal boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### sortedTroves

```solidity
ISortedTroves public sortedTroves
```

**ISortedTroves**: [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

### collateralRegistry

```solidity
ICollateralRegistry internal collateralRegistry
```

**ICollateralRegistry**: [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

### WETH

```solidity
IWETH internal immutable WETH
```

**IWETH**: [src/Interfaces/IWETH.sol/interface_IWETH.md]

### CCR

```solidity
uint256 public immutable CCR
```

### MCR

```solidity
uint256 internal immutable MCR
```

### SCR

```solidity
uint256 internal immutable SCR
```

### LIQUIDATION_PENALTY_SP

```solidity
uint256 internal immutable LIQUIDATION_PENALTY_SP
```

### LIQUIDATION_PENALTY_REDISTRIBUTION

```solidity
uint256 internal immutable LIQUIDATION_PENALTY_REDISTRIBUTION
```

### debtLimit

```solidity
uint256 public debtLimit
```

### Troves

```solidity
mapping(uint256 => Trove) public Troves
```

### batches

```solidity
mapping(address => Batch) internal batches
```

### totalStakes

```solidity
uint256 internal totalStakes
```

### totalStakesSnapshot

```solidity
uint256 internal totalStakesSnapshot
```

### totalCollateralSnapshot

```solidity
uint256 internal totalCollateralSnapshot
```

### L_coll

```solidity
uint256 internal L_coll
```

### L_boldDebt

```solidity
uint256 internal L_boldDebt
```

### rewardSnapshots

```solidity
mapping(uint256 => RewardSnapshot) public rewardSnapshots
```

### TroveIds

```solidity
uint256[] internal TroveIds
```

### batchIds

```solidity
address[] public batchIds
```

### lastZombieTroveId

```solidity
uint256 public lastZombieTroveId
```

### lastCollError_Redistribution

```solidity
uint256 internal lastCollError_Redistribution
```

### lastBoldDebtError_Redistribution

```solidity
uint256 internal lastBoldDebtError_Redistribution
```

### shutdownTime

```solidity
uint256 public shutdownTime
```

## Structs

### OnSetInterestBatchManagerParams (inherited from ITroveManager)

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

### Trove

```solidity
struct Trove {
    uint256 debt;
    uint256 coll;
    uint256 stake;
    Status status;
    uint64 arrayIndex;
    uint64 lastDebtUpdateTime;
    uint64 lastInterestRateAdjTime;
    uint256 annualInterestRate;
    address interestBatchManager;
    uint256 batchDebtShares;
}
```

### Batch

```solidity
struct Batch {
    uint256 debt;
    uint256 coll;
    uint64 arrayIndex;
    uint64 lastDebtUpdateTime;
    uint64 lastInterestRateAdjTime;
    uint256 annualInterestRate;
    uint256 annualManagementFee;
    uint256 totalDebtShares;
}
```

### RewardSnapshot

```solidity
struct RewardSnapshot {
    uint256 coll;
    uint256 boldDebt;
}
```

### LiquidationValues

```solidity
struct LiquidationValues {
    uint256 collGasCompensation;
    uint256 debtToOffset;
    uint256 collToSendToSP;
    uint256 debtToRedistribute;
    uint256 collToRedistribute;
    uint256 collSurplus;
    uint256 ETHGasCompensation;
    uint256 oldWeightedRecordedDebt;
    uint256 newWeightedRecordedDebt;
}
```

### SingleRedemptionValues

```solidity
struct SingleRedemptionValues {
    uint256 troveId;
    address batchAddress;
    uint256 boldLot;
    uint256 collLot;
    uint256 collFee;
    uint256 appliedRedistBoldDebtGain;
    uint256 oldWeightedRecordedDebt;
    uint256 newWeightedRecordedDebt;
    uint256 newStake;
    bool isZombieTrove;
    LatestTroveData trove;
    LatestBatchData batch;
}
```

## Errors

### EmptyData

```solidity
error EmptyData();
```

### NothingToLiquidate

```solidity
error NothingToLiquidate();
```

### CallerNotBorrowerOperations

```solidity
error CallerNotBorrowerOperations();
```

### CallerNotCollateralRegistry

```solidity
error CallerNotCollateralRegistry();
```

### OnlyOneTroveLeft

```solidity
error OnlyOneTroveLeft();
```

### NotShutDown

```solidity
error NotShutDown();
```

### ZeroAmount

```solidity
error ZeroAmount();
```

### NotEnoughBoldBalance

```solidity
error NotEnoughBoldBalance();
```

### MinCollNotReached

```solidity
error MinCollNotReached(uint256 _coll);
```

### BatchSharesRatioTooHigh

```solidity
error BatchSharesRatioTooHigh();
```

## Events

### ActivePoolAddressChanged (inherited from LiquityBase)

```solidity
event ActivePoolAddressChanged(address _newActivePoolAddress);
```

### DefaultPoolAddressChanged (inherited from LiquityBase)

```solidity
event DefaultPoolAddressChanged(address _newDefaultPoolAddress);
```

### PriceFeedAddressChanged (inherited from LiquityBase)

```solidity
event PriceFeedAddressChanged(address _newPriceFeedAddress);
```

### Liquidation (inherited from ITroveEvents)

```solidity
event Liquidation(uint256 _debtOffsetBySP, uint256 _debtRedistributed, uint256 _boldGasCompensation, uint256 _collGasCompensation, uint256 _collSentToSP, uint256 _collRedistributed, uint256 _collSurplus, uint256 _L_ETH, uint256 _L_boldDebt, uint256 _price);
```

### Redemption (inherited from ITroveEvents)

```solidity
event Redemption(uint256 _attemptedBoldAmount, uint256 _actualBoldAmount, uint256 _ETHSent, uint256 _ETHFee, uint256 _price);
```

### TroveUpdated (inherited from ITroveEvents)

```solidity
event TroveUpdated(uint256 indexed _troveId, uint256 _debt, uint256 _coll, uint256 _stake, uint256 _annualInterestRate, uint256 _snapshotOfTotalCollRedist, uint256 _snapshotOfTotalDebtRedist);
```

### TroveOperation (inherited from ITroveEvents)

```solidity
event TroveOperation(uint256 indexed _troveId, Operation _operation, uint256 _annualInterestRate, uint256 _debtIncreaseFromRedist, uint256 _debtIncreaseFromUpfrontFee, int256 _debtChangeFromOperation, uint256 _collIncreaseFromRedist, int256 _collChangeFromOperation);
```

### RedemptionFeePaidToTrove (inherited from ITroveEvents)

```solidity
event RedemptionFeePaidToTrove(uint256 indexed _troveId, uint256 _ETHFee);
```

### BatchUpdated (inherited from ITroveEvents)

```solidity
event BatchUpdated(address indexed _interestBatchManager, BatchOperation _operation, uint256 _debt, uint256 _coll, uint256 _annualInterestRate, uint256 _annualManagementFee, uint256 _totalDebtShares, uint256 _debtIncreaseFromUpfrontFee);
```

### BatchedTroveUpdated (inherited from ITroveEvents)

```solidity
event BatchedTroveUpdated(uint256 indexed _troveId, address _interestBatchManager, uint256 _batchDebtShares, uint256 _coll, uint256 _stake, uint256 _snapshotOfTotalCollRedist, uint256 _snapshotOfTotalDebtRedist);
```

### TroveNFTAddressChanged

```solidity
event TroveNFTAddressChanged(address _newTroveNFTAddress);
```

### BorrowerOperationsAddressChanged

```solidity
event BorrowerOperationsAddressChanged(address _newBorrowerOperationsAddress);
```

### BoldTokenAddressChanged

```solidity
event BoldTokenAddressChanged(address _newBoldTokenAddress);
```

### StabilityPoolAddressChanged

```solidity
event StabilityPoolAddressChanged(address _stabilityPoolAddress);
```

### GasPoolAddressChanged

```solidity
event GasPoolAddressChanged(address _gasPoolAddress);
```

### CollSurplusPoolAddressChanged

```solidity
event CollSurplusPoolAddressChanged(address _collSurplusPoolAddress);
```

### SortedTrovesAddressChanged

```solidity
event SortedTrovesAddressChanged(address _sortedTrovesAddress);
```

### CollateralRegistryAddressChanged

```solidity
event CollateralRegistryAddressChanged(address _collateralRegistryAddress);
```

## Enums

### Status (inherited from ITroveManager)

```solidity
enum Status {
    nonExistent,
    active,
    closedByOwner,
    closedByLiquidation,
    zombie
}
```

### Operation (inherited from ITroveEvents)

```solidity
enum Operation {
    openTrove,
    closeTrove,
    adjustTrove,
    adjustTroveInterestRate,
    applyPendingDebt,
    liquidate,
    redeemCollateral,
    openTroveAndJoinBatch,
    setInterestBatchManager,
    removeFromBatch
}
```

### BatchOperation (inherited from ITroveEvents)

```solidity
enum BatchOperation {
    registerBatchManager,
    lowerBatchManagerAnnualFee,
    setBatchManagerAnnualInterestRate,
    applyBatchInterestAndFee,
    joinBatch,
    exitBatch,
    troveChange
}
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 6883:1490:275
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry) LiquityBase(_addressesRegistry);
```

### getTroveIdsCount()

- **Signature**: `getTroveIdsCount()`
- **Visibility**: external
- **Source Range**: 8403:108:275
- **Details**: [function_getTroveIdsCount.md](./function_getTroveIdsCount.md)

**Signature:**
```solidity
function getTroveIdsCount() override external view returns (uint256);
```

### getTroveFromTroveIdsArray(uint256)

- **Signature**: `getTroveFromTroveIdsArray(uint256)`
- **Visibility**: external
- **Source Range**: 8517:132:275
- **Details**: [function_getTroveFromTroveIdsArray_uint256.md](./function_getTroveFromTroveIdsArray_uint256.md)

**Signature:**
```solidity
function getTroveFromTroveIdsArray(uint256 _index) override external view returns (uint256);
```

### batchLiquidateTroves(uint256[])

- **Signature**: `batchLiquidateTroves(uint256[])`
- **Visibility**: public
- **Source Range**: 16330:2140:275
- **Details**: [function_batchLiquidateTroves_uint256[].md](./function_batchLiquidateTroves_uint256[].md)

**Signature:**
```solidity
function batchLiquidateTroves(uint256[] memory _troveArray) override public;
```

### redeemCollateral(address,uint256,uint256,uint256,uint256)

- **Signature**: `redeemCollateral(address,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 32492:4338:275
- **Details**: [function_redeemCollateral_address_uint256_uint256_uint256_uint256.md](./function_redeemCollateral_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function redeemCollateral(address _redeemer, uint256 _boldamount, uint256 _price, uint256 _redemptionRate, uint256 _maxIterations) override external returns (uint256 _redemeedAmount);
```

### urgentRedemption(uint256,uint256[],uint256)

- **Signature**: `urgentRedemption(uint256,uint256[],uint256)`
- **Visibility**: external
- **Source Range**: 38431:3165:275
- **Details**: [function_urgentRedemption_uint256_uint256[]_uint256.md](./function_urgentRedemption_uint256_uint256[]_uint256.md)

**Signature:**
```solidity
function urgentRedemption(uint256 _boldAmount, uint256[] calldata _troveIds, uint256 _minCollateral) external;
```

### shutdown()

- **Signature**: `shutdown()`
- **Visibility**: external
- **Source Range**: 41602:160:275
- **Details**: [function_shutdown.md](./function_shutdown.md)

**Signature:**
```solidity
function shutdown() external;
```

### getCurrentICR(uint256,uint256)

- **Signature**: `getCurrentICR(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 41949:270:275
- **Details**: [function_getCurrentICR_uint256_uint256.md](./function_getCurrentICR_uint256_uint256.md)

**Signature:**
```solidity
function getCurrentICR(uint256 _troveId, uint256 _price) override public view returns (uint256);
```

### getLatestTroveData(uint256)

- **Signature**: `getLatestTroveData(uint256)`
- **Visibility**: external
- **Source Range**: 45778:152:275
- **Details**: [function_getLatestTroveData_uint256.md](./function_getLatestTroveData_uint256.md)

**Signature:**
```solidity
function getLatestTroveData(uint256 _troveId) external view returns (LatestTroveData memory trove);
```

### getTroveAnnualInterestRate(uint256)

- **Signature**: `getTroveAnnualInterestRate(uint256)`
- **Visibility**: external
- **Source Range**: 45936:350:275
- **Details**: [function_getTroveAnnualInterestRate_uint256.md](./function_getTroveAnnualInterestRate_uint256.md)

**Signature:**
```solidity
function getTroveAnnualInterestRate(uint256 _troveId) external view returns (uint256);
```

### getLatestBatchData(address)

- **Signature**: `getLatestBatchData(address)`
- **Visibility**: external
- **Source Range**: 47983:162:275
- **Details**: [function_getLatestBatchData_address.md](./function_getLatestBatchData_address.md)

**Signature:**
```solidity
function getLatestBatchData(address _batchAddress) external view returns (LatestBatchData memory batch);
```

### getTroveStatus(uint256)

- **Signature**: `getTroveStatus(uint256)`
- **Visibility**: external
- **Source Range**: 52500:129:275
- **Details**: [function_getTroveStatus_uint256.md](./function_getTroveStatus_uint256.md)

**Signature:**
```solidity
function getTroveStatus(uint256 _troveId) override external view returns (Status);
```

### getUnbackedPortionPriceAndRedeemability()

- **Signature**: `getUnbackedPortionPriceAndRedeemability()`
- **Visibility**: external
- **Source Range**: 54681:584:275
- **Details**: [function_getUnbackedPortionPriceAndRedeemability.md](./function_getUnbackedPortionPriceAndRedeemability.md)

**Signature:**
```solidity
function getUnbackedPortionPriceAndRedeemability() external returns (uint256, uint256, bool);
```

### onOpenTrove(address,uint256,struct TroveChange,uint256)

- **Signature**: `onOpenTrove(address,uint256,struct TroveChange,uint256)`
- **Visibility**: external
- **Source Range**: 55340:1943:275
- **Details**: [function_onOpenTrove_address_uint256_struct_TroveChange_uint256.md](./function_onOpenTrove_address_uint256_struct_TroveChange_uint256.md)

**Signature:**
```solidity
function onOpenTrove(address _owner, uint256 _troveId, TroveChange memory _troveChange, uint256 _annualInterestRate) external;
```

### onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)

- **Signature**: `onOpenTroveAndJoinBatch(address,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 57289:2854:275
- **Details**: [function_onOpenTroveAndJoinBatch_address_uint256_struct_TroveChange_address_uint256_uint256.md](./function_onOpenTroveAndJoinBatch_address_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function onOpenTroveAndJoinBatch(address _owner, uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _batchColl, uint256 _batchDebt) external;
```

### setTroveStatusToActive(uint256)

- **Signature**: `setTroveStatusToActive(uint256)`
- **Visibility**: external
- **Source Range**: 60149:251:275
- **Details**: [function_setTroveStatusToActive_uint256.md](./function_setTroveStatusToActive_uint256.md)

**Signature:**
```solidity
function setTroveStatusToActive(uint256 _troveId) external;
```

### onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)

- **Signature**: `onAdjustTroveInterestRate(uint256,uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 60406:1591:275
- **Details**: [function_onAdjustTroveInterestRate_uint256_uint256_uint256_uint256_struct_TroveChange.md](./function_onAdjustTroveInterestRate_uint256_uint256_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function onAdjustTroveInterestRate(uint256 _troveId, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, TroveChange calldata _troveChange) external;
```

### onAdjustTrove(uint256,uint256,uint256,struct TroveChange)

- **Signature**: `onAdjustTrove(uint256,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 62003:1578:275
- **Details**: [function_onAdjustTrove_uint256_uint256_uint256_struct_TroveChange.md](./function_onAdjustTrove_uint256_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function onAdjustTrove(uint256 _troveId, uint256 _newColl, uint256 _newDebt, TroveChange calldata _troveChange) external;
```

### onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)

- **Signature**: `onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 63587:2085:275
- **Details**: [function_onCloseTrove_uint256_struct_TroveChange_address_uint256_uint256.md](./function_onCloseTrove_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function onCloseTrove(uint256 _troveId, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) override external;
```

### onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)

- **Signature**: `onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 67599:2732:275
- **Details**: [function_onAdjustTroveInsideBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256.md](./function_onAdjustTroveInsideBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256.md)

**Signature:**
```solidity
function onAdjustTroveInsideBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt) external;
```

### onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)

- **Signature**: `onApplyTroveInterest(uint256,uint256,uint256,address,uint256,uint256,struct TroveChange)`
- **Visibility**: external
- **Source Range**: 70337:2483:275
- **Details**: [function_onApplyTroveInterest_uint256_uint256_uint256_address_uint256_uint256_struct_TroveChange.md](./function_onApplyTroveInterest_uint256_uint256_uint256_address_uint256_uint256_struct_TroveChange.md)

**Signature:**
```solidity
function onApplyTroveInterest(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, TroveChange calldata _troveChange) external;
```

### onRegisterBatchManager(address,uint256,uint256)

- **Signature**: `onRegisterBatchManager(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 72826:874:275
- **Details**: [function_onRegisterBatchManager_address_uint256_uint256.md](./function_onRegisterBatchManager_address_uint256_uint256.md)

**Signature:**
```solidity
function onRegisterBatchManager(address _account, uint256 _annualInterestRate, uint256 _annualManagementFee) external;
```

### onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)

- **Signature**: `onLowerBatchManagerAnnualFee(address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 73706:946:275
- **Details**: [function_onLowerBatchManagerAnnualFee_address_uint256_uint256_uint256.md](./function_onLowerBatchManagerAnnualFee_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function onLowerBatchManagerAnnualFee(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualManagementFee) external;
```

### onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)

- **Signature**: `onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 74658:1078:275
- **Details**: [function_onSetBatchManagerAnnualInterestRate_address_uint256_uint256_uint256_uint256.md](./function_onSetBatchManagerAnnualInterestRate_address_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function onSetBatchManagerAnnualInterestRate(address _batchAddress, uint256 _newColl, uint256 _newDebt, uint256 _newAnnualInterestRate, uint256 _upfrontFee) external;
```

### onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)

- **Signature**: `onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)`
- **Visibility**: external
- **Source Range**: 75742:3104:275
- **Details**: [function_onSetInterestBatchManager_struct_ITroveManager_OnSetInterestBatchManagerParams.md](./function_onSetInterestBatchManager_struct_ITroveManager_OnSetInterestBatchManagerParams.md)

**Signature:**
```solidity
function onSetInterestBatchManager(OnSetInterestBatchManagerParams calldata _params) external;
```

### onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)

- **Signature**: `onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 83848:2770:275
- **Details**: [function_onRemoveFromBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256_uint256.md](./function_onRemoveFromBatch_uint256_uint256_uint256_struct_TroveChange_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function onRemoveFromBatch(uint256 _troveId, uint256 _newTroveColl, uint256 _newTroveDebt, TroveChange memory _troveChange, address _batchAddress, uint256 _newBatchColl, uint256 _newBatchDebt, uint256 _newAnnualInterestRate) external;
```

### getDebtLimit()

- **Signature**: `getDebtLimit()`
- **Visibility**: external
- **Source Range**: 88084:89:275
- **Details**: [function_getDebtLimit.md](./function_getDebtLimit.md)

**Signature:**
```solidity
function getDebtLimit() external view returns (uint256);
```

### setDebtLimit(uint256)

- **Signature**: `setDebtLimit(uint256)`
- **Visibility**: external
- **Source Range**: 88179:142:275
- **Details**: [function_setDebtLimit_uint256.md](./function_setDebtLimit_uint256.md)

**Signature:**
```solidity
function setDebtLimit(uint256 _newDebtLimit) external;
```

### getEntireSystemColl() (inherited from LiquityBase)

- **Signature**: `getEntireSystemColl()`
- **Visibility**: public
- **Source Range**: 1265:251:214
- **Details**: [function_getEntireSystemColl.md](./function_getEntireSystemColl.md)

**Signature:**
```solidity
function getEntireSystemColl() public view returns (uint256 entireSystemColl);
```

### getEntireSystemDebt() (inherited from LiquityBase)

- **Signature**: `getEntireSystemDebt()`
- **Visibility**: public
- **Source Range**: 1522:237:214
- **Details**: [function_getEntireSystemDebt.md](./function_getEntireSystemDebt.md)

**Signature:**
```solidity
function getEntireSystemDebt() public view returns (uint256 entireSystemDebt);
```
