# Function: closeTrove(uint256)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `closeTrove(uint256)`
- **Visibility**: external
- **Source Range**: 26024:3113:205

## Implementation

```solidity
function closeTrove(uint256 _troveId) override external {
    ITroveManager troveManagerCached = troveManager;
    IActivePool activePoolCached = activePool;
    IBoldToken boldTokenCached = boldToken;
    address owner = troveNFT.ownerOf(_troveId);
    address receiver = _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(_troveId, owner);
    _requireTroveIsOpen(troveManagerCached, _troveId);
    LatestTroveData memory trove = troveManagerCached.getLatestTroveData(_troveId);
    _requireSufficientBoldBalance(boldTokenCached, msg.sender, trove.entireDebt);
    TroveChange memory troveChange;
    troveChange.appliedRedistBoldDebtGain = trove.redistBoldDebtGain;
    troveChange.appliedRedistCollGain = trove.redistCollGain;
    troveChange.collDecrease = trove.entireColl;
    troveChange.debtDecrease = trove.entireDebt;
    address batchManager = interestBatchManagerOf[_troveId];
    LatestBatchData memory batch;
    if (batchManager != address(0)) {
        batch = troveManagerCached.getLatestBatchData(batchManager);
        uint256 batchFutureDebt = batch.entireDebtWithoutRedistribution - (trove.entireDebt - trove.redistBoldDebtGain);
        troveChange.batchAccruedManagementFee = batch.accruedManagementFee;
        troveChange.oldWeightedRecordedDebt = batch.weightedRecordedDebt;
        troveChange.newWeightedRecordedDebt = batchFutureDebt * batch.annualInterestRate;
        troveChange.oldWeightedRecordedBatchManagementFee = batch.weightedRecordedBatchManagementFee;
        troveChange.newWeightedRecordedBatchManagementFee = batchFutureDebt * batch.annualManagementFee;
    } else {
        troveChange.oldWeightedRecordedDebt = trove.weightedRecordedDebt;
    }
    (uint256 price, ) = priceFeed.fetchPrice();
    uint256 newTCR = _getNewTCRFromTroveChange(troveChange, price);
    if (!hasBeenShutDown) _requireNewTCRisAboveCCR(newTCR);
    troveManagerCached.onCloseTrove(_troveId, troveChange, batchManager, batch.entireCollWithoutRedistribution, batch.entireDebtWithoutRedistribution);
    if (batchManager != address(0)) {
        interestBatchManagerOf[_troveId] = address(0);
    }
    activePoolCached.mintAggInterestAndAccountForTroveChange(troveChange, batchManager);
    WETH.transferFrom(gasPoolAddress, receiver, ETH_GAS_COMPENSATION);
    boldTokenCached.burn(msg.sender, trove.entireDebt);
    activePoolCached.sendColl(receiver, trove.entireColl);
    _wipeTroveMappings(_troveId);
}
```

## Related Implementations

### _requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address)

- **Kind**: internal
- **Source**: 4222:544:209
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

### _requireTroveIsOpen(contract ITroveManager,uint256)

- **Kind**: internal
- **Source**: 54280:314:205
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireTroveIsOpen(contract ITroveManager,uint256)`

```solidity
function _requireTroveIsOpen(ITroveManager _troveManager, uint256 _troveId) internal view {
    ITroveManager.Status status = _troveManager.getTroveStatus(_troveId);
    if ((status != ITroveManager.Status.active) && (status != ITroveManager.Status.zombie)) {
        revert TroveNotOpen();
    }
}
```

### _requireSufficientBoldBalance(contract IBoldToken,address,uint256)

- **Kind**: internal
- **Source**: 57885:263:205
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireSufficientBoldBalance(contract IBoldToken,address,uint256)`

```solidity
function _requireSufficientBoldBalance(IBoldToken _boldToken, address _borrower, uint256 _debtRepayment) internal view {
    if (_boldToken.balanceOf(_borrower) < _debtRepayment) {
        revert NotEnoughBoldBalance();
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

### _wipeTroveMappings(uint256)

- **Kind**: internal
- **Source**: 47813:208:205
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_wipeTroveMappings(uint256)`

```solidity
function _wipeTroveMappings(uint256 _troveId) internal {
    delete interestIndividualDelegateOf[_troveId];
    delete interestBatchManagerOf[_troveId];
    _wipeAddRemoveManagers(_troveId);
}
```

### _wipeAddRemoveManagers(uint256)

- **Kind**: internal
- **Source**: 3227:289:209
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:_wipeAddRemoveManagers(uint256)`

```solidity
function _wipeAddRemoveManagers(uint256 _troveId) internal {
    delete addManagerOf[_troveId];
    delete removeManagerReceiverOf[_troveId];
    emit AddManagerUpdated(_troveId, address(0));
    emit RemoveManagerAndReceiverUpdated(_troveId, address(0), address(0));
}
```

## External Calls

- **ITroveNFT::ownerOf(uint256)**
- **ITroveManager::getLatestTroveData(uint256)**
- **ITroveManager::getLatestBatchData(address)**
- **IPriceFeed::fetchPrice()**
- **ITroveManager::onCloseTrove(uint256,struct TroveChange,address,uint256,uint256)**
- **IActivePool::mintAggInterestAndAccountForTroveChange(struct TroveChange,address)**
- **IWETH::transferFrom(address,address,uint256)**
- **IBoldToken::burn(address,uint256)**
- **IActivePool::sendColl(address,uint256)**
- **ITroveManager::getTroveStatus(uint256)**
- **IBoldToken::balanceOf(address)**
- **IActivePool::getCollBalance()**
- **IDefaultPool::getCollBalance()**
- **IActivePool::getBoldDebt()**
- **IDefaultPool::getBoldDebt()**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **hasBeenShutDown** (`bool`)
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **gasPoolAddress** (`address`)
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **CCR** (`uint256`)

## State Variable Writes

- **interestBatchManagerOf** (`mapping(uint256 => address)`)
- **interestIndividualDelegateOf** (`mapping(uint256 => struct IBorrowerOperations.InterestIndividualDelegate)`)
- **addManagerOf** (`mapping(uint256 => address)`)
- **removeManagerReceiverOf** (`mapping(uint256 => struct AddRemoveManagers.RemoveManagerReceiver)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.closeTrove(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AddRemoveManagers._requireSenderIsOwnerOrRemoveManagerAndGetReceiver(uint256,address) (NodeID: 1)
  │   💬 Args: [_troveId, owner]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireTroveIsOpen(contract ITroveManager,uint256) (NodeID: 2)
  │   💬 Args: [troveManagerCached, _troveId]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireSufficientBoldBalance(contract IBoldToken,address,uint256) (NodeID: 3)
  │   💬 Args: [boldTokenCached, msg.sender, trove.entireDebt]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._getNewTCRFromTroveChange(struct TroveChange,uint256) (NodeID: 4)
  │   💬 Args: [troveChange, price]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: LiquityBase.getEntireSystemColl() (NodeID: 5)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: LiquityBase.getEntireSystemDebt() (NodeID: 6)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._computeCR(uint256,uint256,uint256) (NodeID: 7)
  │     💬 Args: [totalColl, totalDebt, _price]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireNewTCRisAboveCCR(uint256) (NodeID: 8)
  │   💬 Args: [newTCR]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._wipeTroveMappings(uint256) (NodeID: 9)
      💬 Args: [_troveId]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AddRemoveManagers._wipeAddRemoveManagers(uint256) (NodeID: 10)
        💬 Args: [_troveId]
        👁️  Def: internal
```
