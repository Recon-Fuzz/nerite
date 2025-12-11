# Function: mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `mintBatchManagementFeeAndAccountForChange(struct TroveChange,address)`
- **Visibility**: external
- **Source Range**: 12078:275:202

## Implementation

```solidity
function mintBatchManagementFeeAndAccountForChange(TroveChange calldata _troveChange, address _batchAddress) override external {
    _requireCallerIsTroveManager();
    _mintBatchManagementFeeAndAccountForChange(_troveChange, _batchAddress);
}
```

## Related Implementations

### _requireCallerIsTroveManager()

- **Kind**: internal
- **Source**: 15101:155:202
- **Link**: `src/ActivePool.sol:ActivePool:_requireCallerIsTroveManager()`

```solidity
function _requireCallerIsTroveManager() internal view {
    require(msg.sender == troveManagerAddress, "ActivePool: Caller is not TroveManager");
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

## External Calls

- **IBoldToken::mint(address,uint256)**

## State Variable Reads

- **troveManagerAddress** (`address`)
- **aggBatchManagementFees** (`uint256`)
- **aggWeightedBatchManagementFeeSum** (`uint256`)
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **shutdownTime** (`uint256`)
- **lastAggBatchManagementFeesUpdateTime** (`uint256`)

## State Variable Writes

- **aggRecordedDebt** (`uint256`)
- **aggBatchManagementFees** (`uint256`)
- **aggWeightedBatchManagementFeeSum** (`uint256`)
- **lastAggBatchManagementFeesUpdateTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.mintBatchManagementFeeAndAccountForChange(struct TroveChange,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ActivePool._requireCallerIsTroveManager() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ActivePool._mintBatchManagementFeeAndAccountForChange(struct TroveChange,address) (NodeID: 2)
      💬 Args: [_troveChange, _batchAddress]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ActivePool.calcPendingAggBatchManagementFee() (NodeID: 3)
        💬 Args: [no args]
        👁️  Def: public
      ├─ [3] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 4)
      │   💬 Args: [lastAggBatchManagementFeesUpdateTime, periodEnd]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 5)
          💬 Args: [aggWeightedBatchManagementFeeSum * (periodEnd - periodStart), ONE_YEAR * DECIMAL_PRECISION]
          👁️  Def: internal
```
