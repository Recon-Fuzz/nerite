# Contract: StabilityPool

## Metadata

- **Name**: StabilityPool
- **Type**: Contract
- **Path**: src/StabilityPool.sol

## Implements Interfaces

- **IStabilityPoolEvents** [src/Interfaces/IStabilityPoolEvents.sol/interface_IStabilityPoolEvents.md]
- **IStabilityPool** [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **IBoldRewardsReceiver** [src/Interfaces/IBoldRewardsReceiver.sol/interface_IBoldRewardsReceiver.md]
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

### NAME

```solidity
string public constant NAME = "StabilityPool"
```

### collToken

```solidity
IERC20 public immutable collToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### troveManager

```solidity
ITroveManager public immutable troveManager
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### boldToken

```solidity
IBoldToken public immutable boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### collBalance

```solidity
uint256 internal collBalance
```

### totalBoldDeposits

```solidity
uint256 internal totalBoldDeposits
```

### yieldGainsOwed

```solidity
uint256 internal yieldGainsOwed
```

### yieldGainsPending

```solidity
uint256 internal yieldGainsPending
```

### deposits

```solidity
mapping(address => Deposit) public deposits
```

### depositSnapshots

```solidity
mapping(address => Snapshots) public depositSnapshots
```

### stashedColl

```solidity
mapping(address => uint256) public stashedColl
```

### P

```solidity
uint256 public P = DECIMAL_PRECISION
```

### SCALE_FACTOR

```solidity
uint256 public constant SCALE_FACTOR = 1e9
```

### currentScale

```solidity
uint128 public currentScale
```

### currentEpoch

```solidity
uint128 public currentEpoch
```

### epochToScaleToS

```solidity
mapping(uint128 => mapping(uint128 => uint256)) public epochToScaleToS
```

### epochToScaleToB

```solidity
mapping(uint128 => mapping(uint128 => uint256)) public epochToScaleToB
```

### lastCollError_Offset

```solidity
uint256 public lastCollError_Offset
```

### lastBoldLossErrorByP_Offset

```solidity
uint256 public lastBoldLossErrorByP_Offset
```

### lastBoldLossError_TotalDeposits

```solidity
uint256 public lastBoldLossError_TotalDeposits
```

### lastYieldError

```solidity
uint256 public lastYieldError
```

## Structs

### Deposit

```solidity
struct Deposit {
    uint256 initialValue;
}
```

### Snapshots

```solidity
struct Snapshots {
    uint256 S;
    uint256 P;
    uint256 B;
    uint128 scale;
    uint128 epoch;
}
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

### StabilityPoolCollBalanceUpdated (inherited from IStabilityPoolEvents)

```solidity
event StabilityPoolCollBalanceUpdated(uint256 _newBalance);
```

### StabilityPoolBoldBalanceUpdated (inherited from IStabilityPoolEvents)

```solidity
event StabilityPoolBoldBalanceUpdated(uint256 _newBalance);
```

### P_Updated (inherited from IStabilityPoolEvents)

```solidity
event P_Updated(uint256 _P);
```

### S_Updated (inherited from IStabilityPoolEvents)

```solidity
event S_Updated(uint256 _S, uint128 _epoch, uint128 _scale);
```

### B_Updated (inherited from IStabilityPoolEvents)

```solidity
event B_Updated(uint256 _B, uint128 _epoch, uint128 _scale);
```

### EpochUpdated (inherited from IStabilityPoolEvents)

```solidity
event EpochUpdated(uint128 _currentEpoch);
```

### ScaleUpdated (inherited from IStabilityPoolEvents)

```solidity
event ScaleUpdated(uint128 _currentScale);
```

### DepositUpdated (inherited from IStabilityPoolEvents)

```solidity
event DepositUpdated(address indexed _depositor, uint256 _newDeposit, uint256 _stashedColl, uint256 _snapshotP, uint256 _snapshotS, uint256 _snapshotB, uint256 _snapshotScale, uint256 _snapshotEpoch);
```

### DepositOperation (inherited from IStabilityPoolEvents)

```solidity
event DepositOperation(address indexed _depositor, Operation _operation, uint256 _depositLossSinceLastOperation, int256 _depositChange, uint256 _yieldGainSinceLastOperation, uint256 _yieldGainClaimed, uint256 _ethGainSinceLastOperation, uint256 _ethGainClaimed);
```

### TroveManagerAddressChanged

```solidity
event TroveManagerAddressChanged(address _newTroveManagerAddress);
```

### BoldTokenAddressChanged

```solidity
event BoldTokenAddressChanged(address _newBoldTokenAddress);
```

## Enums

### Operation (inherited from IStabilityPoolEvents)

```solidity
enum Operation {
    provideToSP,
    withdrawFromSP,
    claimAllCollGains
}
```

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 10353:375:274
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry) LiquityBase(_addressesRegistry);
```

### getCollBalance()

- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 10808:102:274
- **Details**: [function_getCollBalance.md](./function_getCollBalance.md)

**Signature:**
```solidity
function getCollBalance() override external view returns (uint256);
```

### getTotalBoldDeposits()

- **Signature**: `getTotalBoldDeposits()`
- **Visibility**: external
- **Source Range**: 10916:114:274
- **Details**: [function_getTotalBoldDeposits.md](./function_getTotalBoldDeposits.md)

**Signature:**
```solidity
function getTotalBoldDeposits() override external view returns (uint256);
```

### getYieldGainsOwed()

- **Signature**: `getYieldGainsOwed()`
- **Visibility**: external
- **Source Range**: 11036:108:274
- **Details**: [function_getYieldGainsOwed.md](./function_getYieldGainsOwed.md)

**Signature:**
```solidity
function getYieldGainsOwed() override external view returns (uint256);
```

### getYieldGainsPending()

- **Signature**: `getYieldGainsPending()`
- **Visibility**: external
- **Source Range**: 11150:114:274
- **Details**: [function_getYieldGainsPending.md](./function_getYieldGainsPending.md)

**Signature:**
```solidity
function getYieldGainsPending() override external view returns (uint256);
```

### provideToSP(uint256,bool)

- **Signature**: `provideToSP(uint256,bool)`
- **Visibility**: external
- **Source Range**: 11565:1582:274
- **Details**: [function_provideToSP_uint256_bool.md](./function_provideToSP_uint256_bool.md)

**Signature:**
```solidity
function provideToSP(uint256 _topUp, bool _doClaim) override external;
```

### withdrawFromSP(uint256,bool)

- **Signature**: `withdrawFromSP(uint256,bool)`
- **Visibility**: external
- **Source Range**: 13936:1708:274
- **Details**: [function_withdrawFromSP_uint256_bool.md](./function_withdrawFromSP_uint256_bool.md)

**Signature:**
```solidity
function withdrawFromSP(uint256 _amount, bool _doClaim) override external;
```

### claimAllCollGains()

- **Signature**: `claimAllCollGains()`
- **Visibility**: external
- **Source Range**: 16227:474:274
- **Details**: [function_claimAllCollGains.md](./function_claimAllCollGains.md)

**Signature:**
```solidity
function claimAllCollGains() external;
```

### triggerBoldRewards(uint256)

- **Signature**: `triggerBoldRewards(uint256)`
- **Visibility**: external
- **Source Range**: 16745:212:274
- **Details**: [function_triggerBoldRewards_uint256.md](./function_triggerBoldRewards_uint256.md)

**Signature:**
```solidity
function triggerBoldRewards(uint256 _boldYield) external;
```

### offset(uint256,uint256)

- **Signature**: `offset(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 19209:414:274
- **Details**: [function_offset_uint256_uint256.md](./function_offset_uint256_uint256.md)

**Signature:**
```solidity
function offset(uint256 _debtToOffset, uint256 _collToAdd) override external;
```

### getDepositorCollGain(address)

- **Signature**: `getDepositorCollGain(address)`
- **Visibility**: public
- **Source Range**: 28005:1111:274
- **Details**: [function_getDepositorCollGain_address.md](./function_getDepositorCollGain_address.md)

**Signature:**
```solidity
function getDepositorCollGain(address _depositor) override public view returns (uint256);
```

### getDepositorYieldGain(address)

- **Signature**: `getDepositorYieldGain(address)`
- **Visibility**: public
- **Source Range**: 29122:1117:274
- **Details**: [function_getDepositorYieldGain_address.md](./function_getDepositorYieldGain_address.md)

**Signature:**
```solidity
function getDepositorYieldGain(address _depositor) override public view returns (uint256);
```

### getDepositorYieldGainWithPending(address)

- **Signature**: `getDepositorYieldGainWithPending(address)`
- **Visibility**: external
- **Source Range**: 30245:1552:274
- **Details**: [function_getDepositorYieldGainWithPending_address.md](./function_getDepositorYieldGainWithPending_address.md)

**Signature:**
```solidity
function getDepositorYieldGainWithPending(address _depositor) override external view returns (uint256);
```

### getCompoundedBoldDeposit(address)

- **Signature**: `getCompoundedBoldDeposit(address)`
- **Visibility**: public
- **Source Range**: 32042:411:274
- **Details**: [function_getCompoundedBoldDeposit_address.md](./function_getCompoundedBoldDeposit_address.md)

**Signature:**
```solidity
function getCompoundedBoldDeposit(address _depositor) override public view returns (uint256);
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
