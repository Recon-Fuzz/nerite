# Function: switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 45607:724:54

## Implementation

```solidity
function switchBatchManager(uint256 _troveId, uint256 _removeUpperHint, uint256 _removeLowerHint, address _newBatchManager, uint256 _addUpperHint, uint256 _addLowerHint, uint256 _maxUpfrontFee) override external {
    address oldBatchManager = _requireIsInBatch(_troveId);
    _requireNewInterestBatchManager(oldBatchManager, _newBatchManager);
    LatestBatchData memory oldBatch = troveManager.getLatestBatchData(oldBatchManager);
    removeFromBatch(_troveId, oldBatch.annualInterestRate, _removeUpperHint, _removeLowerHint, 0);
    setInterestBatchManager(_troveId, _newBatchManager, _addUpperHint, _addLowerHint, _maxUpfrontFee);
}
```

## Related Implementations

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

### _requireNewInterestBatchManager(address,address)

- **Kind**: internal
- **Source**: 60999:265:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireNewInterestBatchManager(address,address)`

```solidity
function _requireNewInterestBatchManager(address _oldBatchManagerAddress, address _newBatchManagerAddress) internal pure {
    if (_oldBatchManagerAddress == _newBatchManagerAddress) {
        revert BatchManagerNotNew();
    }
}
```

### removeFromBatch(uint256,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 42572:3029:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:removeFromBatch(uint256,uint256,uint256,uint256,uint256)`

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

### setInterestBatchManager(uint256,address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 39117:3449:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:setInterestBatchManager(uint256,address,uint256,uint256,uint256)`

```solidity
function setInterestBatchManager(uint256 _troveId, address _newBatchManager, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) override public {
    _requireIsNotShutDown();
    LocalVariables_setInterestBatchManager memory vars;
    vars.troveManager = troveManager;
    vars.activePool = activePool;
    vars.sortedTroves = sortedTroves;
    _requireTroveIsActive(vars.troveManager, _troveId);
    _requireCallerIsBorrower(_troveId);
    _requireValidInterestBatchManager(_newBatchManager);
    _requireIsNotInBatch(_troveId);
    interestBatchManagerOf[_troveId] = _newBatchManager;
    if (interestIndividualDelegateOf[_troveId].account != address(0)) delete interestIndividualDelegateOf[_troveId];
    vars.trove = vars.troveManager.getLatestTroveData(_troveId);
    vars.newBatch = vars.troveManager.getLatestBatchData(_newBatchManager);
    TroveChange memory newBatchTroveChange;
    newBatchTroveChange.appliedRedistBoldDebtGain = vars.trove.redistBoldDebtGain;
    newBatchTroveChange.appliedRedistCollGain = vars.trove.redistCollGain;
    newBatchTroveChange.batchAccruedManagementFee = vars.newBatch.accruedManagementFee;
    newBatchTroveChange.oldWeightedRecordedDebt = vars.newBatch.weightedRecordedDebt + vars.trove.weightedRecordedDebt;
    newBatchTroveChange.newWeightedRecordedDebt = (vars.newBatch.entireDebtWithoutRedistribution + vars.trove.entireDebt) * vars.newBatch.annualInterestRate;
    vars.trove.entireDebt = _applyUpfrontFee(vars.trove.entireColl, vars.trove.entireDebt, newBatchTroveChange, _maxUpfrontFee);
    newBatchTroveChange.newWeightedRecordedDebt = (vars.newBatch.entireDebtWithoutRedistribution + vars.trove.entireDebt) * vars.newBatch.annualInterestRate;
    newBatchTroveChange.oldWeightedRecordedBatchManagementFee = vars.newBatch.weightedRecordedBatchManagementFee;
    newBatchTroveChange.newWeightedRecordedBatchManagementFee = (vars.newBatch.entireDebtWithoutRedistribution + vars.trove.entireDebt) * vars.newBatch.annualManagementFee;
    vars.activePool.mintAggInterestAndAccountForTroveChange(newBatchTroveChange, _newBatchManager);
    vars.troveManager.onSetInterestBatchManager(ITroveManager.OnSetInterestBatchManagerParams({troveId: _troveId, troveColl: vars.trove.entireColl, troveDebt: vars.trove.entireDebt, troveChange: newBatchTroveChange, newBatchAddress: _newBatchManager, newBatchColl: vars.newBatch.entireCollWithoutRedistribution, newBatchDebt: vars.newBatch.entireDebtWithoutRedistribution}));
    vars.sortedTroves.remove(_troveId);
    vars.sortedTroves.insertIntoBatch(_troveId, BatchId.wrap(_newBatchManager), vars.newBatch.annualInterestRate, _upperHint, _lowerHint);
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

### _requireIsNotInBatch(uint256)

- **Kind**: internal
- **Source**: 53533:176:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireIsNotInBatch(uint256)`

```solidity
function _requireIsNotInBatch(uint256 _troveId) internal view {
    if (interestBatchManagerOf[_troveId] != address(0)) {
        revert TroveInBatch();
    }
}
```

## External Calls

- **ITroveManager::getLatestBatchData(address)**
- **ISortedTroves::removeFromBatch(uint256)**
- **ISortedTroves::insert(uint256,uint256,uint256,uint256)**
- **ITroveManager::getLatestTroveData(uint256)**
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
- **ITroveManager::onSetInterestBatchManager(struct ITroveManager.OnSetInterestBatchManagerParams)**
- **ISortedTroves::remove(uint256)**
- **ISortedTroves::insertIntoBatch(uint256,BatchId,uint256,uint256,uint256)**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **hasBeenShutDown** (`bool`)
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]
- **MCR** (`uint256`)
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **CCR** (`uint256`)
- **interestIndividualDelegateOf** (`mapping(uint256 => struct IBorrowerOperations.InterestIndividualDelegate)`)
- **interestBatchManagers** (`mapping(address => struct IBorrowerOperations.InterestBatchManager)`)

## State Variable Writes

- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **interestIndividualDelegateOf** (`mapping(uint256 => struct IBorrowerOperations.InterestIndividualDelegate)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.switchBatchManager(uint256,uint256,uint256,address,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireIsInBatch(uint256) (NodeID: 1)
  │   💬 Args: [_troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireNewInterestBatchManager(address,address) (NodeID: 2)
  │   💬 Args: [oldBatchManager, _newBatchManager]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations.removeFromBatch(uint256,uint256,uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [_troveId, oldBatch.annualInterestRate, _removeUpperHint, _removeLowerHint, 0]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 4)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsActive(contract ITroveManager,uint256) (NodeID: 5)
  │ │   💬 Args: [vars.troveManager, _troveId]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 6)
  │ │   💬 Args: [_troveId]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireValidAnnualInterestRate(uint256) (NodeID: 7)
  │ │   💬 Args: [_newAnnualInterestRate]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireIsInBatch(uint256) (NodeID: 8)
  │ │   💬 Args: [_troveId]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BorrowerOperations._applyUpfrontFee(uint256,uint256,struct TroveChange,uint256) (NodeID: 9)
  │     💬 Args: [vars.trove.entireColl, vars.trove.entireDebt, batchChange, _maxUpfrontFee]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireOraclesLive() (NodeID: 10)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BorrowerOperations._calcUpfrontFee(uint256,uint256) (NodeID: 11)
  │   │   💬 Args: [_troveEntireDebt, avgInterestRate]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 12)
  │   │     💬 Args: [_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireUserAcceptsUpfrontFee(uint256,uint256) (NodeID: 13)
  │   │   💬 Args: [_troveChange.upfrontFee, _maxUpfrontFee]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 14)
  │   │   💬 Args: [_troveEntireColl, _troveEntireDebt, price]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCR(uint256) (NodeID: 15)
  │   │   💬 Args: [newICR]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 16)
  │   │   💬 Args: [_troveChange, price]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: LiquityBase.getEntireSystemColl() (NodeID: 17)
  │   │ │   💬 Args: [no args]
  │   │ │   👁️  Def: public
  │   │ ├─ [4] ⚙️ FUNCTION: LiquityBase.getEntireSystemDebt() (NodeID: 18)
  │   │ │   💬 Args: [no args]
  │   │ │   👁️  Def: public
  │   │ └─ [4] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 19)
  │   │     💬 Args: [totalColl, totalDebt, _price]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: BorrowerOperations._requireNewTCRisAboveCCR(uint256) (NodeID: 20)
  │       💬 Args: [newTCR]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations.setInterestBatchManager(uint256,address,uint256,uint256,uint256) (NodeID: 21)
      💬 Args: [_troveId, _newBatchManager, _addUpperHint, _addLowerHint, _maxUpfrontFee]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 22)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsActive(contract ITroveManager,uint256) (NodeID: 23)
    │   💬 Args: [vars.troveManager, _troveId]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AddRemoveManagers._requireCallerIsBorrower(uint256) (NodeID: 24)
    │   💬 Args: [_troveId]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireValidInterestBatchManager(address) (NodeID: 25)
    │   💬 Args: [_newBatchManager]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireIsNotInBatch(uint256) (NodeID: 26)
    │   💬 Args: [_troveId]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BorrowerOperations._applyUpfrontFee(uint256,uint256,struct TroveChange,uint256) (NodeID: 27)
        💬 Args: [vars.trove.entireColl, vars.trove.entireDebt, newBatchTroveChange, _maxUpfrontFee]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireOraclesLive() (NodeID: 28)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._calcUpfrontFee(uint256,uint256) (NodeID: 29)
      │   💬 Args: [_troveEntireDebt, avgInterestRate]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 30)
      │     💬 Args: [_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireUserAcceptsUpfrontFee(uint256,uint256) (NodeID: 31)
      │   💬 Args: [_troveChange.upfrontFee, _maxUpfrontFee]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 32)
      │   💬 Args: [_troveEntireColl, _troveEntireDebt, price]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCR(uint256) (NodeID: 33)
      │   💬 Args: [newICR]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 34)
      │   💬 Args: [_troveChange, price]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: LiquityBase.getEntireSystemColl() (NodeID: 35)
      │ │   💬 Args: [no args]
      │ │   👁️  Def: public
      │ ├─ [4] ⚙️ FUNCTION: LiquityBase.getEntireSystemDebt() (NodeID: 36)
      │ │   💬 Args: [no args]
      │ │   👁️  Def: public
      │ └─ [4] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 37)
      │     💬 Args: [totalColl, totalDebt, _price]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: BorrowerOperations._requireNewTCRisAboveCCR(uint256) (NodeID: 38)
          💬 Args: [newTCR]
          👁️  Def: internal
```
