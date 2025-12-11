# Function: mintAggInterestAndAccountForTroveChange(struct TroveChange,address)

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `mintAggInterestAndAccountForTroveChange(struct TroveChange,address)`
- **Visibility**: external
- **Source Range**: 9797:1417:202

## Implementation

```solidity
function mintAggInterestAndAccountForTroveChange(TroveChange calldata _troveChange, address _batchAddress) external {
    _requireCallerIsBOorTroveM();
    if (_batchAddress != address(0)) {
        _mintBatchManagementFeeAndAccountForChange(_troveChange, _batchAddress);
    }
    uint256 newAggRecordedDebt = aggRecordedDebt;
    newAggRecordedDebt += _mintAggInterest(_troveChange.upfrontFee);
    newAggRecordedDebt += _troveChange.appliedRedistBoldDebtGain;
    newAggRecordedDebt += _troveChange.debtIncrease;
    newAggRecordedDebt -= _troveChange.debtDecrease;
    aggRecordedDebt = newAggRecordedDebt;
    uint256 newAggWeightedDebtSum = aggWeightedDebtSum;
    newAggWeightedDebtSum += _troveChange.newWeightedRecordedDebt;
    newAggWeightedDebtSum -= _troveChange.oldWeightedRecordedDebt;
    aggWeightedDebtSum = newAggWeightedDebtSum;
}
```

## Related Implementations

### _requireCallerIsBOorTroveM()

- **Kind**: internal
- **Source**: 14838:257:202
- **Link**: `src/ActivePool.sol:ActivePool:_requireCallerIsBOorTroveM()`

```solidity
function _requireCallerIsBOorTroveM() internal view {
    require((msg.sender == borrowerOperationsAddress) || (msg.sender == troveManagerAddress), "ActivePool: Caller is neither BorrowerOperations nor TroveManager");
}
```

### _mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)

- **Kind**: internal
- **Source**: 12359:1313:202
- **Link**: `src/ActivePool.sol:ActivePool:_mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)`

```solidity
function _mintBatchManagementFeeAndAccountForChange(TroveChange memory _troveChange, address _batchAddress) internal {
    aggRecordedDebt += _troveChange.batchAccruedManagementFee;
    uint256 newAggBatchManagementFees = aggBatchManagementFees;
    newAggBatchManagementFees += calcPendingAggBatchManagementFee();
    newAggBatchManagementFees -= _troveChange.batchAccruedManagementFee;
    aggBatchManagementFees = newAggBatchManagementFees;
    uint256 newAggWeightedBatchManagementFeeSum = aggWeightedBatchManagementFeeSum;
    newAggWeightedBatchManagementFeeSum += _troveChange.newWeightedRecordedBatchManagementFee;
    newAggWeightedBatchManagementFeeSum -= _troveChange.oldWeightedRecordedBatchManagementFee;
    aggWeightedBatchManagementFeeSum = newAggWeightedBatchManagementFeeSum;
    if (_troveChange.batchAccruedManagementFee > 0) {
        boldToken.mint(_batchAddress, _troveChange.batchAccruedManagementFee);
    }
    lastAggBatchManagementFeesUpdateTime = block.timestamp;
}
```

### calcPendingAggBatchManagementFee()

- **Kind**: internal
- **Source**: 5346:372:202
- **Link**: `src/ActivePool.sol:ActivePool:calcPendingAggBatchManagementFee()`

```solidity
function calcPendingAggBatchManagementFee() public view returns (uint256) {
    uint256 periodEnd = (shutdownTime != 0) ? shutdownTime : block.timestamp;
    uint256 periodStart = Math.min(lastAggBatchManagementFeesUpdateTime, periodEnd);
    return Math.ceilDiv(aggWeightedBatchManagementFeeSum * (periodEnd - periodStart), ONE_YEAR * DECIMAL_PRECISION);
}
```

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 588:104:114
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
}
```

### ceilDiv(uint256,uint256)

- **Kind**: internal
- **Source**: 1157:194:114
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ceilDiv(uint256,uint256)`

```solidity
///  @dev Returns the ceiling of the division of two numbers.
///  This differs from standard division with `/` in that it rounds up instead
///  of rounding down.
function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a == 0) ? 0 : (((a - 1) / b) + 1);
}
```

### _mintAggInterest(uint256)

- **Kind**: internal
- **Source**: 11360:712:202
- **Link**: `src/ActivePool.sol:ActivePool:_mintAggInterest(uint256)`

```solidity
function _mintAggInterest(uint256 _upfrontFee) internal returns (uint256 mintedAmount) {
    mintedAmount = calcPendingAggInterest() + _upfrontFee;
    if (mintedAmount > 0) {
        uint256 spYield = (SP_YIELD_SPLIT * mintedAmount) / DECIMAL_PRECISION;
        uint256 remainderToLPs = mintedAmount - spYield;
        boldToken.mint(address(interestRouter), remainderToLPs);
        if (spYield > 0) {
            boldToken.mint(address(stabilityPool), spYield);
            stabilityPool.triggerBoldRewards(spYield);
        }
    }
    lastAggUpdateTime = block.timestamp;
}
```

### calcPendingAggInterest()

- **Kind**: internal
- **Source**: 4503:684:202
- **Link**: `src/ActivePool.sol:ActivePool:calcPendingAggInterest()`

```solidity
function calcPendingAggInterest() public view returns (uint256) {
    if (shutdownTime != 0) return 0;
    return Math.ceilDiv(aggWeightedDebtSum * (block.timestamp - lastAggUpdateTime), ONE_YEAR * DECIMAL_PRECISION);
}
```

## External Calls

- **IBoldToken::mint(address,uint256)**
- **IBoldRewardsReceiver::triggerBoldRewards(uint256)**

## State Variable Reads

- **aggRecordedDebt** (`uint256`)
- **aggWeightedDebtSum** (`uint256`)
- **borrowerOperationsAddress** (`address`)
- **troveManagerAddress** (`address`)
- **aggBatchManagementFees** (`uint256`)
- **aggWeightedBatchManagementFeeSum** (`uint256`)
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **shutdownTime** (`uint256`)
- **lastAggBatchManagementFeesUpdateTime** (`uint256`)
- **interestRouter** (`contract IInterestRouter`) [src/Interfaces/IInterestRouter.sol/interface_IInterestRouter.md]
- **stabilityPool** (`contract IBoldRewardsReceiver`) [src/Interfaces/IBoldRewardsReceiver.sol/interface_IBoldRewardsReceiver.md]
- **lastAggUpdateTime** (`uint256`)

## State Variable Writes

- **aggRecordedDebt** (`uint256`)
- **aggWeightedDebtSum** (`uint256`)
- **aggBatchManagementFees** (`uint256`)
- **aggWeightedBatchManagementFeeSum** (`uint256`)
- **lastAggBatchManagementFeesUpdateTime** (`uint256`)
- **lastAggUpdateTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.mintAggInterestAndAccountForTroveChange(struct TroveChange,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ActivePool._requireCallerIsBOorTroveM() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActivePool._mintBatchManagementFeeAndAccountForChange(struct TroveChange,address) (NodeID: 2)
  │   💬 Args: [_troveChange, _batchAddress]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ActivePool.calcPendingAggBatchManagementFee() (NodeID: 3)
  │     💬 Args: [no args]
  │     👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 4)
  │   │   💬 Args: [lastAggBatchManagementFeesUpdateTime, periodEnd]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 5)
  │       💬 Args: [aggWeightedBatchManagementFeeSum * (periodEnd - periodStart), ONE_YEAR * DECIMAL_PRECISION]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ActivePool._mintAggInterest(uint256) (NodeID: 6)
      💬 Args: [_troveChange.upfrontFee]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ActivePool.calcPendingAggInterest() (NodeID: 7)
        💬 Args: [no args]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 8)
          💬 Args: [aggWeightedDebtSum * (block.timestamp - lastAggUpdateTime), ONE_YEAR * DECIMAL_PRECISION]
          👁️  Def: internal
```
