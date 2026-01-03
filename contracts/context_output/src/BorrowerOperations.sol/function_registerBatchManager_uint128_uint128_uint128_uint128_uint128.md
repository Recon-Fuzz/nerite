# Function: registerBatchManager(uint128,uint128,uint128,uint128,uint128)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `registerBatchManager(uint128,uint128,uint128,uint128,uint128)`
- **Visibility**: external
- **Source Range**: 33383:1271:54

## Implementation

```solidity
function registerBatchManager(uint128 _minInterestRate, uint128 _maxInterestRate, uint128 _currentInterestRate, uint128 _annualManagementFee, uint128 _minInterestRateChangePeriod) external {
    _requireIsNotShutDown();
    _requireNonExistentInterestBatchManager(msg.sender);
    _requireValidAnnualInterestRate(_minInterestRate);
    _requireValidAnnualInterestRate(_maxInterestRate);
    _requireOrderedRange(_minInterestRate, _maxInterestRate);
    _requireInterestRateInRange(_currentInterestRate, _minInterestRate, _maxInterestRate);
    if (_annualManagementFee > MAX_ANNUAL_BATCH_MANAGEMENT_FEE) revert AnnualManagementFeeTooHigh();
    if (_minInterestRateChangePeriod < MIN_INTEREST_RATE_CHANGE_PERIOD) revert MinInterestRateChangePeriodTooLow();
    interestBatchManagers[msg.sender] = InterestBatchManager(_minInterestRate, _maxInterestRate, _minInterestRateChangePeriod);
    troveManager.onRegisterBatchManager(msg.sender, _currentInterestRate, _annualManagementFee);
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

### _requireNonExistentInterestBatchManager(address)

- **Kind**: internal
- **Source**: 60747:246:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireNonExistentInterestBatchManager(address)`

```solidity
function _requireNonExistentInterestBatchManager(address _interestBatchManagerAddress) internal view {
    if (interestBatchManagers[_interestBatchManagerAddress].maxInterestRate > 0) {
        revert BatchManagerExists();
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

### _requireOrderedRange(uint256,uint256)

- **Kind**: internal
- **Source**: 58745:172:54
- **Link**: `src/BorrowerOperations.sol:BorrowerOperations:_requireOrderedRange(uint256,uint256)`

```solidity
function _requireOrderedRange(uint256 _minInterestRate, uint256 _maxInterestRate) internal pure {
    if (_minInterestRate >= _maxInterestRate) revert MinGeMax();
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

## External Calls

- **ITroveManager::onRegisterBatchManager(address,uint256,uint256)**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **hasBeenShutDown** (`bool`)
- **interestBatchManagers** (`mapping(address => struct IBorrowerOperations.InterestBatchManager)`)

## State Variable Writes

- **interestBatchManagers** (`mapping(address => struct IBorrowerOperations.InterestBatchManager)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.registerBatchManager(uint128,uint128,uint128,uint128,uint128) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireIsNotShutDown() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireNonExistentInterestBatchManager(address) (NodeID: 2)
  │   💬 Args: [msg.sender]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireValidAnnualInterestRate(uint256) (NodeID: 3)
  │   💬 Args: [_minInterestRate]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireValidAnnualInterestRate(uint256) (NodeID: 4)
  │   💬 Args: [_maxInterestRate]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BorrowerOperations._requireOrderedRange(uint256,uint256) (NodeID: 5)
  │   💬 Args: [_minInterestRate, _maxInterestRate]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BorrowerOperations._requireInterestRateInRange(uint256,uint256,uint256) (NodeID: 6)
      💬 Args: [_currentInterestRate, _minInterestRate, _maxInterestRate]
      👁️  Def: internal
```
