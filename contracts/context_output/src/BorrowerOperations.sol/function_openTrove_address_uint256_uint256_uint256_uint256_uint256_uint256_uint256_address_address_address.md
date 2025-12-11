# Function: openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address)`
- **Visibility**: external
- **Source Range**: 6823:1117:205

## Implementation

```solidity
function openTrove(address _owner, uint256 _ownerIndex, uint256 _collAmount, uint256 _boldAmount, uint256 _upperHint, uint256 _lowerHint, uint256 _annualInterestRate, uint256 _maxUpfrontFee, address _addManager, address _removeManager, address _receiver) override external returns (uint256) {
    _requireValidAnnualInterestRate(_annualInterestRate);
    OpenTroveVars memory vars;
    vars.troveId = _openTrove(_owner, _ownerIndex, _collAmount, _boldAmount, _annualInterestRate, address(0), 0, 0, _maxUpfrontFee, _addManager, _removeManager, _receiver, vars.change);
    troveManager.onOpenTrove(_owner, vars.troveId, vars.change, _annualInterestRate);
    sortedTroves.insert(vars.troveId, _annualInterestRate, _upperHint, _lowerHint);
    return vars.troveId;
}
```

## Related Implementations

### _requireValidAnnualInterestRate(uint256)

- **Kind**: internal
- **Source**: 58154:318:205
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

### _openTrove(address,uint256,uint256,uint256,uint256,address,uint256,uint256,uint256,address,address,address,struct TroveChange)

- **Kind**: internal
- **Source**: 9980:3416:205
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_openTrove(address,uint256,uint256,uint256,uint256,address,uint256,uint256,uint256,address,address,address,struct TroveChange)`

```solidity
function _openTrove(address _owner, uint256 _ownerIndex, uint256 _collAmount, uint256 _boldAmount, uint256 _annualInterestRate, address _interestBatchManager, uint256 _batchEntireDebt, uint256 _batchManagementAnnualFee, uint256 _maxUpfrontFee, address _addManager, address _removeManager, address _receiver, TroveChange memory _change) internal returns (uint256) {
    _requireIsNotShutDown();
    LocalVariables_openTrove memory vars;
    vars.troveManager = troveManager;
    vars.activePool = activePool;
    vars.boldToken = boldToken;
    require(troveManager.getDebtLimit() >= (troveManager.getEntireSystemDebt() + _boldAmount), "BorrowerOperations: Debt limit exceeded.");
    vars.price = _requireOraclesLive();
    vars.troveId = uint256(keccak256(abi.encode(_owner, _ownerIndex)));
    _requireTroveDoesNotExists(vars.troveManager, vars.troveId);
    _change.collIncrease = _collAmount;
    _change.debtIncrease = _boldAmount;
    _change.newWeightedRecordedDebt = (_batchEntireDebt + _change.debtIncrease) * _annualInterestRate;
    vars.avgInterestRate = vars.activePool.getNewApproxAvgInterestRateFromTroveChange(_change);
    _change.upfrontFee = _calcUpfrontFee(_change.debtIncrease, vars.avgInterestRate);
    _requireUserAcceptsUpfrontFee(_change.upfrontFee, _maxUpfrontFee);
    vars.entireDebt = _change.debtIncrease + _change.upfrontFee;
    _requireAtLeastMinDebt(vars.entireDebt);
    if (_interestBatchManager == address(0)) {
        _change.newWeightedRecordedDebt = vars.entireDebt * _annualInterestRate;
    } else {
        _change.newWeightedRecordedDebt = (_batchEntireDebt + vars.entireDebt) * _annualInterestRate;
        _change.newWeightedRecordedBatchManagementFee = (_batchEntireDebt + vars.entireDebt) * _batchManagementAnnualFee;
    }
    vars.ICR = LiquityMath._computeCR(_collAmount, vars.entireDebt, vars.price);
    _requireICRisAboveMCR(vars.ICR);
    vars.newTCR = _getNewTCRFromTroveChange(_change, vars.price);
    _requireNewTCRisAboveCCR(vars.newTCR);
    _setAddManager(vars.troveId, _addManager);
    _setRemoveManagerAndReceiver(vars.troveId, _removeManager, _receiver);
    vars.activePool.mintAggInterestAndAccountForTroveChange(_change, _interestBatchManager);
    _pullCollAndSendToActivePool(vars.activePool, _collAmount);
    vars.boldToken.mint(msg.sender, _boldAmount);
    WETH.transferFrom(msg.sender, gasPoolAddress, ETH_GAS_COMPENSATION);
    return vars.troveId;
}
```

### _requireIsNotShutDown()

- **Kind**: internal
- **Source**: 51954:128:205
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
- **Source**: 61605:266:205
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

### _requireTroveDoesNotExists(contract ITroveManager,uint256)

- **Kind**: internal
- **Source**: 53990:284:205
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireTroveDoesNotExists(contract ITroveManager,uint256)`

```solidity
function _requireTroveDoesNotExists(ITroveManager _troveManager, uint256 _troveId) internal view {
    ITroveManager.Status status = _troveManager.getTroveStatus(_troveId);
    if (status != ITroveManager.Status.nonExistent) {
        revert TroveExists();
    }
}
```

### _calcUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 47436:186:205
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_calcUpfrontFee(uint256,uint256)`

```solidity
function _calcUpfrontFee(uint256 _debt, uint256 _avgInterestRate) internal pure returns (uint256) {
    return _calcInterest(_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD);
}
```

### _calcInterest(uint256,uint256)

- **Kind**: internal
- **Source**: 2244:173:214
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:_calcInterest(uint256,uint256)`

```solidity
function _calcInterest(uint256 _weightedDebt, uint256 _period) internal pure returns (uint256) {
    return ((_weightedDebt * _period) / ONE_YEAR) / DECIMAL_PRECISION;
}
```

### _requireUserAcceptsUpfrontFee(uint256,uint256)

- **Kind**: internal
- **Source**: 55503:171:205
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
- **Source**: 57523:145:205
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireAtLeastMinDebt(uint256)`

```solidity
function _requireAtLeastMinDebt(uint256 _debt) internal pure {
    if (_debt < MIN_DEBT) {
        revert DebtBelowMin();
    }
}
```

### _computeCR(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2640:414:215
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
- **Source**: 56722:142:205
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
- **Source**: 61913:571:205
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
- **Source**: 1265:251:214
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
- **Source**: 1522:237:214
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
- **Source**: 57372:145:205
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireNewTCRisAboveCCR(uint256)`

```solidity
function _requireNewTCRisAboveCCR(uint256 _newTCR) internal view {
    if (_newTCR < CCR) {
        revert TCRBelowCCR();
    }
}
```

### _setAddManager(uint256,address)

- **Kind**: internal
- **Source**: 2271:171:209
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_setAddManager(uint256,address)`

```solidity
function _setAddManager(uint256 _troveId, address _manager) internal {
    addManagerOf[_troveId] = _manager;
    emit AddManagerUpdated(_troveId, _manager);
}
```

### _setRemoveManagerAndReceiver(uint256,address,address)

- **Kind**: internal
- **Source**: 2844:377:209
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_setRemoveManagerAndReceiver(uint256,address,address)`

```solidity
function _setRemoveManagerAndReceiver(uint256 _troveId, address _manager, address _receiver) internal {
    _requireNonZeroManagerUnlessWiping(_manager, _receiver);
    removeManagerReceiverOf[_troveId].manager = _manager;
    removeManagerReceiverOf[_troveId].receiver = _receiver;
    emit RemoveManagerAndReceiverUpdated(_troveId, _manager, _receiver);
}
```

### _requireNonZeroManagerUnlessWiping(address,address)

- **Kind**: internal
- **Source**: 3522:212:209
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_requireNonZeroManagerUnlessWiping(address,address)`

```solidity
function _requireNonZeroManagerUnlessWiping(address _manager, address _receiver) internal pure {
    if ((_manager == address(0)) && (_receiver != address(0))) {
        revert EmptyManager();
    }
}
```

### _pullCollAndSendToActivePool(contract IActivePool,uint256)

- **Kind**: internal
- **Source**: 51396:337:205
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_pullCollAndSendToActivePool(contract IActivePool,uint256)`

```solidity
function _pullCollAndSendToActivePool(IActivePool _activePool, uint256 _amount) internal {
    collToken.safeTransferFrom(msg.sender, address(_activePool), _amount);
    _activePool.accountForReceivedColl(_amount);
}
```

## External Calls

- **ITroveManager::onOpenTrove(address,uint256,struct TroveChange,uint256)**
- **ISortedTroves::insert(uint256,uint256,uint256,uint256)**
- **ITroveManager::getDebtLimit()**
- **ITroveManager::getEntireSystemDebt()**
- **IActivePool::getNewApproxAvgInterestRateFromTroveChange(struct TroveChange)**
- **IActivePool::mintAggInterestAndAccountForTroveChange(struct TroveChange,address)**
- **IBoldToken::mint(address,uint256)**
- **IWETH::transferFrom(address,address,uint256)**
- **IPriceFeed::fetchPrice()**
- **ITroveManager::getTroveStatus(uint256)**
- **IActivePool::getCollBalance()**
- **IDefaultPool::getCollBalance()**
- **IActivePool::getBoldDebt()**
- **IDefaultPool::getBoldDebt()**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **IActivePool::accountForReceivedColl(uint256)**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **gasPoolAddress** (`address`)
- **hasBeenShutDown** (`bool`)
- **MCR** (`uint256`)
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **CCR** (`uint256`)
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Writes

- **addManagerOf** (`mapping(uint256 => address)`)
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.openTrove(address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,address,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireValidAnnualInterestRate(uint256) (NodeID: 1)
  │   💬 Args: [_annualInterestRate]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._openTrove(address,uint256,uint256,uint256,uint256,address,uint256,uint256,uint256,address,address,address,struct TroveChange) (NodeID: 2)
      💬 Args: [_owner, _ownerIndex, _collAmount, _boldAmount, _annualInterestRate, address(0), 0, 0, _maxUpfrontFee, _addManager, _removeManager, _receiver, vars.change]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireOraclesLive() (NodeID: 4)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireTroveDoesNotExists(contract ITroveManager,uint256) (NodeID: 5)
    │   💬 Args: [vars.troveManager, vars.troveId]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._calcUpfrontFee(uint256,uint256) (NodeID: 6)
    │   💬 Args: [_change.debtIncrease, vars.avgInterestRate]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: LiquityBase._calcInterest(uint256,uint256) (NodeID: 7)
    │     💬 Args: [_debt * _avgInterestRate, UPFRONT_INTEREST_PERIOD]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireUserAcceptsUpfrontFee(uint256,uint256) (NodeID: 8)
    │   💬 Args: [_change.upfrontFee, _maxUpfrontFee]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireAtLeastMinDebt(uint256) (NodeID: 9)
    │   💬 Args: [vars.entireDebt]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 10)
    │   💬 Args: [_collAmount, vars.entireDebt, vars.price]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireICRisAboveMCR(uint256) (NodeID: 11)
    │   💬 Args: [vars.ICR]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 12)
    │   💬 Args: [_change, vars.price]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: LiquityBase.getEntireSystemColl() (NodeID: 13)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ ├─ [3] ⚙️ FUNCTION: LiquityBase.getEntireSystemDebt() (NodeID: 14)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 15)
    │     💬 Args: [totalColl, totalDebt, _price]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BorrowerOperations._requireNewTCRisAboveCCR(uint256) (NodeID: 16)
    │   💬 Args: [vars.newTCR]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AddRemoveManagers._setAddManager(uint256,address) (NodeID: 17)
    │   💬 Args: [vars.troveId, _addManager]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AddRemoveManagers._setRemoveManagerAndReceiver(uint256,address,address) (NodeID: 18)
    │   💬 Args: [vars.troveId, _removeManager, _receiver]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AddRemoveManagers._requireNonZeroManagerUnlessWiping(address,address) (NodeID: 19)
    │     💬 Args: [_manager, _receiver]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BorrowerOperations._pullCollAndSendToActivePool(contract IActivePool,uint256) (NodeID: 20)
        💬 Args: [vars.activePool, _collAmount]
        👁️  Def: internal
```
