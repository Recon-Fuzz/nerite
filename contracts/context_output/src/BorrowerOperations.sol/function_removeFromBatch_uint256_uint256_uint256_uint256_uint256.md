# Function: removeFromBatch(uint256,uint256,uint256,uint256,uint256)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `removeFromBatch(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 42572:3029:54

## Implementation

```solidity
function removeFromBatch(uint256 _troveId, uint256 _newAnnualInterestRate, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) override public {
    _requireIsNotShutDown();
    LocalVariables_removeFromBatch memory vars;
    vars.troveManager = troveManager;
    vars.sortedTroves = sortedTroves;
    _requireTroveIsActive(vars.troveManager, _troveId);
    _requireCallerIsBorrower(_troveId);
    _requireValidAnnualInterestRate(_newAnnualInterestRate);
    vars.batchManager = _requireIsInBatch(_troveId);
    delete interestBatchManagerOf[_troveId];
    vars.sortedTroves.removeFromBatch(_troveId);
    vars.sortedTroves.insert(_troveId, _newAnnualInterestRate, _upperHint, _lowerHint);
    vars.trove = vars.troveManager.getLatestTroveData(_troveId);
    vars.batch = vars.troveManager.getLatestBatchData(vars.batchManager);
    uint256 batchFutureDebt = vars.batch.entireDebtWithoutRedistribution - (vars.trove.entireDebt - vars.trove.redistBoldDebtGain);
    TroveChange memory batchChange;
    batchChange.appliedRedistBoldDebtGain = vars.trove.redistBoldDebtGain;
    batchChange.appliedRedistCollGain = vars.trove.redistCollGain;
    batchChange.batchAccruedManagementFee = vars.batch.accruedManagementFee;
    batchChange.oldWeightedRecordedDebt = vars.batch.weightedRecordedDebt;
    batchChange.newWeightedRecordedDebt = (batchFutureDebt * vars.batch.annualInterestRate) + (vars.trove.entireDebt * _newAnnualInterestRate);
    if ((vars.batch.annualInterestRate != _newAnnualInterestRate) && (block.timestamp < (vars.trove.lastInterestRateAdjTime + INTEREST_RATE_ADJ_COOLDOWN))) {
        vars.trove.entireDebt = _applyUpfrontFee(vars.trove.entireColl, vars.trove.entireDebt, batchChange, _maxUpfrontFee);
    }
    batchChange.newWeightedRecordedDebt = (batchFutureDebt * vars.batch.annualInterestRate) + (vars.trove.entireDebt * _newAnnualInterestRate);
    batchChange.oldWeightedRecordedBatchManagementFee = vars.batch.weightedRecordedBatchManagementFee;
    batchChange.newWeightedRecordedBatchManagementFee = batchFutureDebt * vars.batch.annualManagementFee;
    activePool.mintAggInterestAndAccountForTroveChange(batchChange, vars.batchManager);
    vars.troveManager.onRemoveFromBatch(_troveId, vars.trove.entireColl, vars.trove.entireDebt, batchChange, vars.batchManager, vars.batch.entireCollWithoutRedistribution, vars.batch.entireDebtWithoutRedistribution, _newAnnualInterestRate);
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

### _requireTroveIsActive(contract ITroveManager,uint256)

- **Kind**: internal
- **Source**: 54600:277:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireTroveIsActive(contract ITroveManager,uint256)`

```solidity
function _requireTroveIsActive(ITroveManager _troveManager, uint256 _troveId) internal view {
    ITroveManager.Status status = _troveManager.getTroveStatus(_troveId);
    if (status != ITroveManager.Status.active) {
        revert TroveNotActive();
    }
}
```

### _requireCallerIsBorrower(uint256)

- **Kind**: internal
- **Source**: 3740:173:58
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireCallerIsBorrower(uint256)`

```solidity
function _requireCallerIsBorrower(uint256 _troveId) internal view {
    if (msg.sender != troveNFT.ownerOf(_troveId)) {
        revert NotBorrower();
    }
}
```

### _requireValidAnnualInterestRate(uint256)

- **Kind**: internal
- **Source**: 58154:318:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireValidAnnualInterestRate(uint256)`

```solidity
function _requireValidAnnualInterestRate(uint256 _annualInterestRate) internal pure {
    if (_annualInterestRate < MIN_ANNUAL_INTEREST_RATE) {
        revert InterestRateTooLow();
    }
    if (_annualInterestRate > MAX_ANNUAL_INTEREST_RATE) {
        revert InterestRateTooHigh();
    }
}
```

### _requireIsInBatch(uint256)

- **Kind**: internal
- **Source**: 53715:269:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireIsInBatch(uint256)`

```solidity
function _requireIsInBatch(uint256 _troveId) internal view returns (address) {
    address batchManager = interestBatchManagerOf[_troveId];
    if (batchManager == address(0)) {
        revert TroveNotInBatch();
    }
    return batchManager;
}
```

### _applyUpfrontFee(uint256,uint256,struct TroveChange,uint256)

- **Kind**: internal
- **Source**: 46337:1093:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_applyUpfrontFee(uint256,uint256,struct TroveChange,uint256)`

```solidity
function _applyUpfrontFee(uint256 _troveEntireColl, uint256 _troveEntireDebt, TroveChange memory _troveChange, uint256 _maxUpfrontFee) internal returns (uint256) {
    uint256 price = _requireOraclesLive();
    uint256 avgInterestRate = activePool.getNewApproxAvgInterestRateFromTroveChange(_troveChange);
    _troveChange.upfrontFee = _calcUpfrontFee(_troveEntireDebt, avgInterestRate);
    _requireUserAcceptsUpfrontFee(_troveChange.upfrontFee, _maxUpfrontFee);
    _troveEntireDebt += _troveChange.upfrontFee;
    uint256 newICR = LiquityMath._computeCR(_troveEntireColl, _troveEntireDebt, price);
    _requireICRisAboveMCR(newICR);
    uint256 newTCR = _getNewTCRFromTroveChange(_troveChange, price);
    _requireNewTCRisAboveCCR(newTCR);
    return _troveEntireDebt;
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

### _requireICRisAboveMCR(uint256)

- **Kind**: internal
- **Source**: 56722:142:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireICRisAboveMCR(uint256)`

```solidity
function _requireICRisAboveMCR(uint256 _newICR) internal view {
    if (_newICR < MCR) {
        revert ICRBelowMCR();
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

- **ISortedTroves::removeFromBatch(uint256)**
- **ISortedTroves::insert(uint256,uint256,uint256,uint256)**
- **ITroveManager::getLatestTroveData(uint256)**
- **ITroveManager::getLatestBatchData(address)**
- **IActivePool::mintAggInterestAndAccountForTroveChange(struct TroveChange,address)**
- **ITroveManager::onRemoveFromBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256,uint256)**
- **ITroveManager::getTroveStatus(uint256)**
- **ITroveNFT::ownerOf(uint256)**
- **IActivePool::getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)**
- **IPriceFeed::fetchPrice()**
- **IActivePool::getCollBalance()**
- **IDefaultPool::getCollBalance()**
- **IActivePool::getBoldDebt()**
- **IDefaultPool::getBoldDebt()**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **hasBeenShutDown** (`bool`)
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]
- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **MCR** (`uint256`)
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **CCR** (`uint256`)

## State Variable Writes

- **interestBatchManagerOf** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.removeFromBatch(uint256,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsActive(contract ITroveManager,uint256) (NodeID: 2)
  │   💬 Args: [vars.troveManager, _troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 3)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireValidAnnualInterestRate(uint256) (NodeID: 4)
  │   💬 Args: [_newAnnualInterestRate]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireIsInBatch(uint256) (NodeID: 5)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._applyUpfrontFee(uint256,uint256,struct TroveChange,uint256) (NodeID: 6)
      💬 Args: [vars.trove.entireColl, vars.trove.entireDebt, batchChange, _maxUpfrontFee]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireOraclesLive() (NodeID: 7)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._calcUpfrontFee(uint256,uint256) (NodeID: 8)
    │   💬 Args: [_troveEntireDebt, avgInterestRate]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 9)
    │     💬 Args: [_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireUserAcceptsUpfrontFee(uint256,uint256) (NodeID: 10)
    │   💬 Args: [_troveChange.upfrontFee, _maxUpfrontFee]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 11)
    │   💬 Args: [_troveEntireColl, _troveEntireDebt, price]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCR(uint256) (NodeID: 12)
    │   💬 Args: [newICR]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 13)
    │   💬 Args: [_troveChange, price]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: LiquityBase.getEntireSystemColl() (NodeID: 14)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ ├─ [3] ⚙️ FUNCTION: LiquityBase.getEntireSystemDebt() (NodeID: 15)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 16)
    │     💬 Args: [totalColl, totalDebt, _price]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BorrowerOperations._requireNewTCRisAboveCCR(uint256) (NodeID: 17)
        💬 Args: [newTCR]
        👁️  Def: internal
```
