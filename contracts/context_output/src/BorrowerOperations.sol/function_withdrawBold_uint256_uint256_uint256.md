# Function: withdrawBold(uint256,uint256,uint256)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `withdrawBold(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 14486:553:54

## Implementation

```solidity
function withdrawBold(uint256 _troveId, uint256 _boldAmount, uint256 _maxUpfrontFee) override external {
    ITroveManager troveManagerCached = troveManager;
    _requireTroveIsActive(troveManagerCached, _troveId);
    require(troveManagerCached.getDebtLimit() >= (troveManagerCached.getEntireSystemDebt() + _boldAmount), "BorrowerOperations: Debt limit exceeded.");
    TroveChange memory troveChange;
    troveChange.debtIncrease = _boldAmount;
    _adjustTrove(troveManagerCached, _troveId, troveChange, _maxUpfrontFee);
}
```

## Related Implementations

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

### _adjustTrove(contract ITroveManager,uint256,struct TroveChange,uint256)

- **Kind**: internal
- **Source**: 20153:5865:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_adjustTrove(contract ITroveManager,uint256,struct TroveChange,uint256)`

```solidity
function _adjustTrove(ITroveManager _troveManager, uint256 _troveId, TroveChange memory _troveChange, uint256 _maxUpfrontFee) internal {
    _requireIsNotShutDown();
    LocalVariables_adjustTrove memory vars;
    vars.activePool = activePool;
    vars.boldToken = boldToken;
    vars.price = _requireOraclesLive();
    vars.isBelowCriticalThreshold = _checkBelowCriticalThreshold(vars.price, CCR);
    _requireTroveIsOpen(_troveManager, _troveId);
    address owner = troveNFT.ownerOf(_troveId);
    address receiver = owner;
    if ((_troveChange.collDecrease > 0) || (_troveChange.debtIncrease > 0)) {
        receiver = _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(_troveId, owner);
    }
    if ((_troveChange.collIncrease > 0) || (_troveChange.debtDecrease > 0)) {
        _requireSenderIsOwnerOrAddManager(_troveId, owner);
    }
    vars.trove = _troveManager.getLatestTroveData(_troveId);
    if (_troveChange.debtDecrease > 0) {
        uint256 maxRepayment = (vars.trove.entireDebt > MIN_DEBT) ? (vars.trove.entireDebt - MIN_DEBT) : 0;
        if (_troveChange.debtDecrease > maxRepayment) {
            _troveChange.debtDecrease = maxRepayment;
        }
        _requireSufficientBoldBalance(vars.boldToken, msg.sender, _troveChange.debtDecrease);
    }
    _requireNonZeroAdjustment(_troveChange);
    if (_troveChange.collDecrease > 0) {
        _requireValidCollWithdrawal(vars.trove.entireColl, _troveChange.collDecrease);
    }
    vars.newColl = (vars.trove.entireColl + _troveChange.collIncrease) - _troveChange.collDecrease;
    vars.newDebt = (vars.trove.entireDebt + _troveChange.debtIncrease) - _troveChange.debtDecrease;
    address batchManager = interestBatchManagerOf[_troveId];
    bool isTroveInBatch = batchManager != address(0);
    LatestBatchData memory batch;
    uint256 batchFutureDebt;
    if (isTroveInBatch) {
        batch = _troveManager.getLatestBatchData(batchManager);
        batchFutureDebt = ((batch.entireDebtWithoutRedistribution + vars.trove.redistBoldDebtGain) + _troveChange.debtIncrease) - _troveChange.debtDecrease;
        _troveChange.appliedRedistBoldDebtGain = vars.trove.redistBoldDebtGain;
        _troveChange.appliedRedistCollGain = vars.trove.redistCollGain;
        _troveChange.batchAccruedManagementFee = batch.accruedManagementFee;
        _troveChange.oldWeightedRecordedDebt = batch.weightedRecordedDebt;
        _troveChange.newWeightedRecordedDebt = batchFutureDebt * batch.annualInterestRate;
        _troveChange.oldWeightedRecordedBatchManagementFee = batch.weightedRecordedBatchManagementFee;
        _troveChange.newWeightedRecordedBatchManagementFee = batchFutureDebt * batch.annualManagementFee;
    } else {
        _troveChange.appliedRedistBoldDebtGain = vars.trove.redistBoldDebtGain;
        _troveChange.appliedRedistCollGain = vars.trove.redistCollGain;
        _troveChange.oldWeightedRecordedDebt = vars.trove.weightedRecordedDebt;
        _troveChange.newWeightedRecordedDebt = vars.newDebt * vars.trove.annualInterestRate;
    }
    if (_troveChange.debtIncrease > 0) {
        uint256 avgInterestRate = vars.activePool.getNewApproxAvgInterestRateFromTroveChange(_troveChange);
        _troveChange.upfrontFee = _calcUpfrontFee(_troveChange.debtIncrease, avgInterestRate);
        _requireUserAcceptsUpfrontFee(_troveChange.upfrontFee, _maxUpfrontFee);
        vars.newDebt += _troveChange.upfrontFee;
        if (isTroveInBatch) {
            batchFutureDebt += _troveChange.upfrontFee;
            _troveChange.newWeightedRecordedDebt = batchFutureDebt * batch.annualInterestRate;
            _troveChange.newWeightedRecordedBatchManagementFee = batchFutureDebt * batch.annualManagementFee;
        } else {
            _troveChange.newWeightedRecordedDebt = vars.newDebt * vars.trove.annualInterestRate;
        }
    }
    _requireAtLeastMinDebt(vars.newDebt);
    vars.newICR = LiquityMath._computeCR(vars.newColl, vars.newDebt, vars.price);
    _requireValidAdjustmentInCurrentMode(_troveChange, vars);
    if (isTroveInBatch) {
        _troveManager.onAdjustTroveInsideBatch(_troveId, vars.newColl, vars.newDebt, _troveChange, batchManager, batch.entireCollWithoutRedistribution, batch.entireDebtWithoutRedistribution);
    } else {
        _troveManager.onAdjustTrove(_troveId, vars.newColl, vars.newDebt, _troveChange);
    }
    vars.activePool.mintAggInterestAndAccountForTroveChange(_troveChange, batchManager);
    _moveTokensFromAdjustment(receiver, _troveChange, vars.boldToken, vars.activePool);
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

### _checkBelowCriticalThreshold(uint256,uint256)

- **Kind**: internal
- **Source**: 2067:171:63
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:_checkBelowCriticalThreshold(uint256,uint256)`

```solidity
function _checkBelowCriticalThreshold(uint256 _price, uint256 _CCR) internal view returns (bool) {
    uint256 TCR = _getTCR(_price);
    return TCR < _CCR;
}
```

### _getTCR(uint256)

- **Kind**: internal
- **Source**: 1765:296:63
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:_getTCR(uint256)`

```solidity
function _getTCR(uint256 _price) internal view returns (uint256 TCR) {
    uint256 entireSystemColl = getEntireSystemColl();
    uint256 entireSystemDebt = getEntireSystemDebt();
    TCR = LiquityMath._computeCR(entireSystemColl, entireSystemDebt, _price);
    return TCR;
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

### _requireTroveIsOpen(contract ITroveManager,uint256)

- **Kind**: internal
- **Source**: 54280:314:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireTroveIsOpen(contract ITroveManager,uint256)`

```solidity
function _requireTroveIsOpen(ITroveManager _troveManager, uint256 _troveId) internal view {
    ITroveManager.Status status = _troveManager.getTroveStatus(_troveId);
    if ((status != ITroveManager.Status.active) && (status != ITroveManager.Status.zombie)) {
        revert TroveNotOpen();
    }
}
```

### _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)

- **Kind**: internal
- **Source**: 4222:544:58
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)`

```solidity
function _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256 _troveId, address _owner) internal view returns (address) {
    address manager = removeManagerReceiverOf[_troveId].manager;
    address receiver = removeManagerReceiverOf[_troveId].receiver;
    if ((msg.sender != _owner) && (msg.sender != manager)) {
        revert NotOwnerNorRemoveManager();
    }
    if ((receiver == address(0)) || (msg.sender != manager)) {
        return _owner;
    }
    return receiver;
}
```

### _requireSenderIsOwnerOrAddManager(uint256,address)

- **Kind**: internal
- **Source**: 3919:297:58
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireSenderIsOwnerOrAddManager(uint256,address)`

```solidity
function _requireSenderIsOwnerOrAddManager(uint256 _troveId, address _owner) internal view {
    address addManager = addManagerOf[_troveId];
    if (((msg.sender != _owner) && (addManager != address(0))) && (msg.sender != addManager)) {
        revert NotOwnerNorAddManager();
    }
}
```

### _requireSufficientBoldBalance(contract IBoldToken,address,uint256)

- **Kind**: internal
- **Source**: 57885:263:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireSufficientBoldBalance(contract IBoldToken,address,uint256)`

```solidity
function _requireSufficientBoldBalance(IBoldToken _boldToken, address _borrower, uint256 _debtRepayment) internal view {
    if (_boldToken.balanceOf(_borrower) < _debtRepayment) {
        revert NotEnoughBoldBalance();
    }
}
```

### _requireNonZeroAdjustment(struct TroveChange)

- **Kind**: internal
- **Source**: 52088:322:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireNonZeroAdjustment(struct TroveChange)`

```solidity
function _requireNonZeroAdjustment(TroveChange memory _troveChange) internal pure {
    if ((((_troveChange.collIncrease == 0) && (_troveChange.collDecrease == 0)) && (_troveChange.debtIncrease == 0)) && (_troveChange.debtDecrease == 0)) {
        revert ZeroAdjustment();
    }
}
```

### _requireValidCollWithdrawal(uint256,uint256)

- **Kind**: internal
- **Source**: 57674:205:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireValidCollWithdrawal(uint256,uint256)`

```solidity
function _requireValidCollWithdrawal(uint256 _currentColl, uint256 _collWithdrawal) internal pure {
    if (_collWithdrawal > _currentColl) {
        revert CollWithdrawalTooHigh();
    }
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

### _requireAtLeastMinDebt(uint256)

- **Kind**: internal
- **Source**: 57523:145:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireAtLeastMinDebt(uint256)`

```solidity
function _requireAtLeastMinDebt(uint256 _debt) internal pure {
    if (_debt < MIN_DEBT) {
        revert DebtBelowMin();
    }
}
```

### _requireValidAdjustmentInCurrentMode(struct TroveChange,struct BorrowerOperations.LocalVariables_adjustTrove)

- **Kind**: internal
- **Source**: 55680:1036:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireValidAdjustmentInCurrentMode(struct TroveChange,struct BorrowerOperations.LocalVariables_adjustTrove)`

```solidity
function _requireValidAdjustmentInCurrentMode(TroveChange memory _troveChange, LocalVariables_adjustTrove memory _vars) internal view {
    _requireICRisAboveMCR(_vars.newICR);
    uint256 newTCR = _getNewTCRFromTroveChange(_troveChange, _vars.price);
    if (_vars.isBelowCriticalThreshold) {
        _requireNoBorrowingUnlessNewTCRisAboveCCR(_troveChange.debtIncrease, newTCR);
        _requireDebtRepaymentGeCollWithdrawal(_troveChange, _vars.price);
    } else {
        _requireNewTCRisAboveCCR(newTCR);
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

### _requireNoBorrowingUnlessNewTCRisAboveCCR(uint256,uint256)

- **Kind**: internal
- **Source**: 56870:206:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireNoBorrowingUnlessNewTCRisAboveCCR(uint256,uint256)`

```solidity
function _requireNoBorrowingUnlessNewTCRisAboveCCR(uint256 _debtIncrease, uint256 _newTCR) internal view {
    if ((_debtIncrease > 0) && (_newTCR < CCR)) {
        revert TCRBelowCCR();
    }
}
```

### _requireDebtRepaymentGeCollWithdrawal(struct TroveChange,uint256)

- **Kind**: internal
- **Source**: 57082:284:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireDebtRepaymentGeCollWithdrawal(struct TroveChange,uint256)`

```solidity
function _requireDebtRepaymentGeCollWithdrawal(TroveChange memory _troveChange, uint256 _price) internal pure {
    if (((_troveChange.debtDecrease * DECIMAL_PRECISION) < (_troveChange.collDecrease * _price))) {
        revert RepaymentNotMatchingCollWithdrawal();
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

### _moveTokensFromAdjustment(address,struct TroveChange,contract IBoldToken,contract IActivePool)

- **Kind**: internal
- **Source**: 50355:1035:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_moveTokensFromAdjustment(address,struct TroveChange,contract IBoldToken,contract IActivePool)`

```solidity
function _moveTokensFromAdjustment(address withdrawalReceiver, TroveChange memory _troveChange, IBoldToken _boldToken, IActivePool _activePool) internal {
    require(troveManager.getDebtLimit() >= (troveManager.getEntireSystemDebt() + _troveChange.debtIncrease), "BorrowerOperations: Debt limit exceeded.");
    if (_troveChange.debtIncrease > 0) {
        _boldToken.mint(withdrawalReceiver, _troveChange.debtIncrease);
    } else if (_troveChange.debtDecrease > 0) {
        _boldToken.burn(msg.sender, _troveChange.debtDecrease);
    }
    if (_troveChange.collIncrease > 0) {
        _pullCollAndSendToActivePool(_activePool, _troveChange.collIncrease);
    } else if (_troveChange.collDecrease > 0) {
        _activePool.sendColl(withdrawalReceiver, _troveChange.collDecrease);
    }
}
```

### _pullCollAndSendToActivePool(contract IActivePool,uint256)

- **Kind**: internal
- **Source**: 51396:337:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_pullCollAndSendToActivePool(contract IActivePool,uint256)`

```solidity
function _pullCollAndSendToActivePool(IActivePool _activePool, uint256 _amount) internal {
    collToken.safeTransferFrom(msg.sender, address(_activePool), _amount);
    _activePool.accountForReceivedColl(_amount);
}
```

## External Calls

- **ITroveManager::getDebtLimit()**
- **ITroveManager::getEntireSystemDebt()**
- **ITroveManager::getTroveStatus(uint256)**
- **ITroveNFT::ownerOf(uint256)**
- **ITroveManager::getLatestTroveData(uint256)**
- **ITroveManager::getLatestBatchData(address)**
- **IActivePool::getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)**
- **ITroveManager::onAdjustTroveInsideBatch(uint256,uint256,uint256,struct TroveChange,address,uint256,uint256)**
- **ITroveManager::onAdjustTrove(uint256,uint256,uint256,struct TroveChange)**
- **IActivePool::mintAggInterestAndAccountForTroveChange(struct TroveChange,address)**
- **IPriceFeed::fetchPrice()**
- **IActivePool::getCollBalance()**
- **IDefaultPool::getCollBalance()**
- **IActivePool::getBoldDebt()**
- **IDefaultPool::getBoldDebt()**
- **IBoldToken::balanceOf(address)**
- **IBoldToken::mint(address,uint256)**
- **IBoldToken::burn(address,uint256)**
- **IActivePool::sendColl(address,uint256)**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **IActivePool::accountForReceivedColl(uint256)**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **CCR** (`uint256`)
- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **hasBeenShutDown** (`bool`)
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)
- **addManagerOf** (`mapping(uint256 => address)`)
- **MCR** (`uint256`)
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.withdrawBold(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsActive(contract ITroveManager,uint256) (NodeID: 1)
  │   💬 Args: [troveManagerCached, _troveId]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._adjustTrove(contract ITroveManager,uint256,struct TroveChange,uint256) (NodeID: 2)
      💬 Args: [troveManagerCached, _troveId, troveChange, _maxUpfrontFee]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireOraclesLive() (NodeID: 4)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityBase._checkBelowCriticalThreshold(uint256,uint256) (NodeID: 5)
    │   💬 Args: [vars.price, CCR]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: LiquityBase._getTCR(uint256) (NodeID: 6)
    │     💬 Args: [_price]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: LiquityBase.getEntireSystemColl() (NodeID: 7)
    │   │   💬 Args: [no args]
    │   │   👁️  Def: public
    │   ├─ [4] ⚙️ FUNCTION: LiquityBase.getEntireSystemDebt() (NodeID: 8)
    │   │   💬 Args: [no args]
    │   │   👁️  Def: public
    │   └─ [4] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 9)
    │       💬 Args: [entireSystemColl, entireSystemDebt, _price]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsOpen(contract ITroveManager,uint256) (NodeID: 10)
    │   💬 Args: [_troveManager, _troveId]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 11)
    │   💬 Args: [_troveId, owner]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrAddManager(uint256,address) (NodeID: 12)
    │   💬 Args: [_troveId, owner]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireSufficientBoldBalance(contract IBoldToken,address,uint256) (NodeID: 13)
    │   💬 Args: [vars.boldToken, msg.sender, _troveChange.debtDecrease]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireNonZeroAdjustment(struct TroveChange) (NodeID: 14)
    │   💬 Args: [_troveChange]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireValidCollWithdrawal(uint256,uint256) (NodeID: 15)
    │   💬 Args: [vars.trove.entireColl, _troveChange.collDecrease]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._calcUpfrontFee(uint256,uint256) (NodeID: 16)
    │   💬 Args: [_troveChange.debtIncrease, avgInterestRate]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 17)
    │     💬 Args: [_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireUserAcceptsUpfrontFee(uint256,uint256) (NodeID: 18)
    │   💬 Args: [_troveChange.upfrontFee, _maxUpfrontFee]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireAtLeastMinDebt(uint256) (NodeID: 19)
    │   💬 Args: [vars.newDebt]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 20)
    │   💬 Args: [vars.newColl, vars.newDebt, vars.price]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireValidAdjustmentInCurrentMode(struct TroveChange,struct BorrowerOperations.LocalVariables_adjustTrove) (NodeID: 21)
    │   💬 Args: [_troveChange, vars]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCR(uint256) (NodeID: 22)
    │ │   💬 Args: [_vars.newICR]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 23)
    │ │   💬 Args: [_troveChange, _vars.price]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: LiquityBase.getEntireSystemColl() (NodeID: 24)
    │ │ │   💬 Args: [no args]
    │ │ │   👁️  Def: public
    │ │ ├─ [4] ⚙️ FUNCTION: LiquityBase.getEntireSystemDebt() (NodeID: 25)
    │ │ │   💬 Args: [no args]
    │ │ │   👁️  Def: public
    │ │ └─ [4] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 26)
    │ │     💬 Args: [totalColl, totalDebt, _price]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireNoBorrowingUnlessNewTCRisAboveCCR(uint256,uint256) (NodeID: 27)
    │ │   💬 Args: [_troveChange.debtIncrease, newTCR]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BorrowerOperations._requireDebtRepaymentGeCollWithdrawal(struct TroveChange,uint256) (NodeID: 28)
    │ │   💬 Args: [_troveChange, _vars.price]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BorrowerOperations._requireNewTCRisAboveCCR(uint256) (NodeID: 29)
    │     💬 Args: [newTCR]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BorrowerOperations._moveTokensFromAdjustment(address,struct TroveChange,contract IBoldToken,contract IActivePool) (NodeID: 30)
        💬 Args: [receiver, _troveChange, vars.boldToken, vars.activePool]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: BorrowerOperations._pullCollAndSendToActivePool(contract IActivePool,uint256) (NodeID: 31)
          💬 Args: [_activePool, _troveChange.collIncrease]
          👁️  Def: internal
```
