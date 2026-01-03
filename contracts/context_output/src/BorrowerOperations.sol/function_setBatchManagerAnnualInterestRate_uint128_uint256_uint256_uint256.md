# Function: setBatchManagerAnnualInterestRate(uint128,uint256,uint256,uint256)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `setBatchManagerAnnualInterestRate(uint128,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 36020:3091:54

## Implementation

```solidity
function setBatchManagerAnnualInterestRate(uint128 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) external {
    _requireIsNotShutDown();
    _requireValidInterestBatchManager(msg.sender);
    _requireInterestRateInBatchManagerRange(msg.sender, _newAnnualInterestRate);
    ITroveManager troveManagerCached = troveManager;
    IActivePool activePoolCached = activePool;
    LatestBatchData memory batch = troveManagerCached.getLatestBatchData(msg.sender);
    _requireBatchInterestRateChangePeriodPassed(msg.sender, uint256(batch.lastInterestRateAdjTime));
    uint256 newDebt = batch.entireDebtWithoutRedistribution;
    TroveChange memory batchChange;
    batchChange.batchAccruedManagementFee = batch.accruedManagementFee;
    batchChange.oldWeightedRecordedDebt = batch.weightedRecordedDebt;
    batchChange.newWeightedRecordedDebt = newDebt * _newAnnualInterestRate;
    batchChange.oldWeightedRecordedBatchManagementFee = batch.weightedRecordedBatchManagementFee;
    batchChange.newWeightedRecordedBatchManagementFee = newDebt * batch.annualManagementFee;
    if ((batch.annualInterestRate != _newAnnualInterestRate) && (block.timestamp < (batch.lastInterestRateAdjTime + INTEREST_RATE_ADJ_COOLDOWN))) {
        uint256 price = _requireOraclesLive();
        uint256 avgInterestRate = activePoolCached.getNewApproxAvgInterestRateFromTroveChange(batchChange);
        batchChange.upfrontFee = _calcUpfrontFee(newDebt, avgInterestRate);
        _requireUserAcceptsUpfrontFee(batchChange.upfrontFee, _maxUpfrontFee);
        newDebt += batchChange.upfrontFee;
        batchChange.newWeightedRecordedDebt = newDebt * _newAnnualInterestRate;
        batchChange.newWeightedRecordedBatchManagementFee = newDebt * batch.annualManagementFee;
        uint256 newTCR = _getNewTCRFromTroveChange(batchChange, price);
        _requireNewTCRisAboveCCR(newTCR);
    }
    activePoolCached.mintAggInterestAndAccountForTroveChange(batchChange, msg.sender);
    if (!sortedTroves.isEmptyBatch(BatchId.wrap(msg.sender))) {
        sortedTroves.reInsertBatch(BatchId.wrap(msg.sender), _newAnnualInterestRate, _upperHint, _lowerHint);
    }
    troveManagerCached.onSetBatchManagerAnnualInterestRate(msg.sender, batch.entireCollWithoutRedistribution, newDebt, _newAnnualInterestRate, batchChange.upfrontFee);
}
```

## Related Implementations

### _requireIsNotShutDown()

- **Kind**: internal
- **Source**: 51954:128:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireIsNotShutDown()`

```solidity
function _requireIsNotShutDown() internal view {
    if (hasBeenShutDown) {
        revert IsShutDown();
    }
}
```

### _requireValidInterestBatchManager(address)

- **Kind**: internal
- **Source**: 60491:250:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireValidInterestBatchManager(address)`

```solidity
function _requireValidInterestBatchManager(address _interestBatchManagerAddress) internal view {
    if (interestBatchManagers[_interestBatchManagerAddress].maxInterestRate == 0) {
        revert InvalidInterestBatchManager();
    }
}
```

### _requireInterestRateInBatchManagerRange(address,uint256)

- **Kind**: internal
- **Source**: 58923:425:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireInterestRateInBatchManagerRange(address,uint256)`

```solidity
function _requireInterestRateInBatchManagerRange(address _interestBatchManagerAddress, uint256 _annualInterestRate) internal view {
    InterestBatchManager memory interestBatchManager = interestBatchManagers[_interestBatchManagerAddress];
    _requireInterestRateInRange(_annualInterestRate, interestBatchManager.minInterestRate, interestBatchManager.maxInterestRate);
}
```

### _requireInterestRateInRange(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 59354:316:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireInterestRateInRange(uint256,uint256,uint256)`

```solidity
function _requireInterestRateInRange(uint256 _annualInterestRate, uint256 _minInterestRate, uint256 _maxInterestRate) internal pure {
    if ((_minInterestRate > _annualInterestRate) || (_annualInterestRate > _maxInterestRate)) {
        revert InterestNotInRange();
    }
}
```

### _requireBatchInterestRateChangePeriodPassed(address,uint256)

- **Kind**: internal
- **Source**: 59676:469:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireBatchInterestRateChangePeriodPassed(address,uint256)`

```solidity
function _requireBatchInterestRateChangePeriodPassed(address _interestBatchManagerAddress, uint256 _lastInterestRateAdjTime) internal view {
    InterestBatchManager memory interestBatchManager = interestBatchManagers[_interestBatchManagerAddress];
    if (block.timestamp < (_lastInterestRateAdjTime + uint256(interestBatchManager.minInterestRateChangePeriod))) {
        revert BatchInterestRateChangePeriodNotPassed();
    }
}
```

### _requireOraclesLive()

- **Kind**: internal
- **Source**: 61605:266:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireOraclesLive()`

```solidity
function _requireOraclesLive() internal returns (uint256) {
    (uint256 price, bool newOracleFailureDetected) = priceFeed.fetchPrice();
    if (newOracleFailureDetected) {
        revert NewOracleFailureDetected();
    }
    return price;
}
```

### _calcUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 47436:186:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_calcUpfrontFee(uint256,uint256)`

```solidity
function _calcUpfrontFee(uint256 _debt, uint256 _avgInterestRate) internal pure returns (uint256) {
    return _calcInterest(_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD);
}
```

### _calcInterest(uint256,uint256)

- **Kind**: internal
- **Source**: 2244:173:63
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:_calcInterest(uint256,uint256)`

```solidity
function _calcInterest(uint256 _weightedDebt, uint256 _period) internal pure returns (uint256) {
    return ((_weightedDebt * _period) / ONE_YEAR) / DECIMAL_PRECISION;
}
```

### _requireUserAcceptsUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 55503:171:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireUserAcceptsUpfrontFee(uint256,uint256)`

```solidity
function _requireUserAcceptsUpfrontFee(uint256 _fee, uint256 _maxFee) internal pure {
    if (_fee > _maxFee) {
        revert UpfrontFeeTooHigh();
    }
}
```

### _getNewTCRFromTroveChange(struct TroveChange,uint256)

- **Kind**: internal
- **Source**: 61913:571:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_getNewTCRFromTroveChange(struct TroveChange,uint256)`

```solidity
function _getNewTCRFromTroveChange(TroveChange memory _troveChange, uint256 _price) internal view returns (uint256 newTCR) {
    uint256 totalColl = getEntireSystemColl();
    totalColl += _troveChange.collIncrease;
    totalColl -= _troveChange.collDecrease;
    uint256 totalDebt = getEntireSystemDebt();
    totalDebt += _troveChange.debtIncrease;
    totalDebt += _troveChange.upfrontFee;
    totalDebt -= _troveChange.debtDecrease;
    newTCR = LiquityMath._computeCR(totalColl, totalDebt, _price);
}
```

### getEntireSystemColl()

- **Kind**: internal
- **Source**: 1265:251:63
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:getEntireSystemColl()`

```solidity
function getEntireSystemColl() public view returns (uint256 entireSystemColl) {
    uint256 activeColl = activePool.getCollBalance();
    uint256 liquidatedColl = defaultPool.getCollBalance();
    return activeColl + liquidatedColl;
}
```

### getEntireSystemDebt()

- **Kind**: internal
- **Source**: 1522:237:63
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:getEntireSystemDebt()`

```solidity
function getEntireSystemDebt() public view returns (uint256 entireSystemDebt) {
    uint256 activeDebt = activePool.getBoldDebt();
    uint256 closedDebt = defaultPool.getBoldDebt();
    return activeDebt + closedDebt;
}
```

### _computeCR(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2640:414:64
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_computeCR(uint256,uint256,uint256)`

```solidity
function _computeCR(uint256 _coll, uint256 _debt, uint256 _price) internal pure returns (uint256) {
    if (_debt > 0) {
        uint256 newCollRatio = (_coll * _price) / _debt;
        return newCollRatio;
    } else {
        return (2 ** 256) - 1;
    }
}
```

### _requireNewTCRisAboveCCR(uint256)

- **Kind**: internal
- **Source**: 57372:145:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireNewTCRisAboveCCR(uint256)`

```solidity
function _requireNewTCRisAboveCCR(uint256 _newTCR) internal view {
    if (_newTCR < CCR) {
        revert TCRBelowCCR();
    }
}
```

## External Calls

- **ITroveManager::getLatestBatchData(address)**
- **IActivePool::getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)**
- **IActivePool::mintAggInterestAndAccountForTroveChange(struct TroveChange,address)**
- **ISortedTroves::isEmptyBatch(BatchId)**
- **ISortedTroves::reInsertBatch(BatchId,uint256,uint256,uint256)**
- **ITroveManager::onSetBatchManagerAnnualInterestRate(address,uint256,uint256,uint256,uint256)**
- **IPriceFeed::fetchPrice()**
- **IActivePool::getCollBalance()**
- **IDefaultPool::getCollBalance()**
- **IActivePool::getBoldDebt()**
- **IDefaultPool::getBoldDebt()**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **hasBeenShutDown** (`bool`)
- **interestBatchManagers** (`mapping(address => struct IBorrowerOperations.InterestBatchManager)`)
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **CCR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.setBatchManagerAnnualInterestRate(uint128,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireValidInterestBatchManager(address) (NodeID: 2)
  │   💬 Args: [msg.sender]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireInterestRateInBatchManagerRange(address,uint256) (NodeID: 3)
  │   💬 Args: [msg.sender, _newAnnualInterestRate]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BorrowerOperations._requireInterestRateInRange(uint256,uint256,uint256) (NodeID: 4)
  │     💬 Args: [_annualInterestRate, interestBatchManager.minInterestRate, interestBatchManager.maxInterestRate]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireBatchInterestRateChangePeriodPassed(address,uint256) (NodeID: 5)
  │   💬 Args: [msg.sender, uint256(batch.lastInterestRateAdjTime)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireOraclesLive() (NodeID: 6)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._calcUpfrontFee(uint256,uint256) (NodeID: 7)
  │   💬 Args: [newDebt, avgInterestRate]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 8)
  │     💬 Args: [_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireUserAcceptsUpfrontFee(uint256,uint256) (NodeID: 9)
  │   💬 Args: [batchChange.upfrontFee, _maxUpfrontFee]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 10)
  │   💬 Args: [batchChange, price]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: LiquityBase.getEntireSystemColl() (NodeID: 11)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: LiquityBase.getEntireSystemDebt() (NodeID: 12)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 13)
  │     💬 Args: [totalColl, totalDebt, _price]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._requireNewTCRisAboveCCR(uint256) (NodeID: 14)
      💬 Args: [newTCR]
      👁️  Def: internal
```
