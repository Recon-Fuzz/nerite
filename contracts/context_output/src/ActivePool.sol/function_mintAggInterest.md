# Function: mintAggInterest()

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `mintAggInterest()`
- **Visibility**: external
- **Source Range**: 11220:134:202

## Implementation

```solidity
function mintAggInterest() override external {
    _requireCallerIsBOorSP();
    aggRecordedDebt += _mintAggInterest(0);
}
```

## Related Implementations

### _requireCallerIsBOorSP()

- **Kind**: internal
- **Source**: 14579:253:202
- **Link**: `src/ActivePool.sol:ActivePool:_requireCallerIsBOorSP()`

```solidity
function _requireCallerIsBOorSP() internal view {
    require((msg.sender == borrowerOperationsAddress) || (msg.sender == address(stabilityPool)), "ActivePool: Caller is not BorrowerOperations nor StabilityPool");
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
- **IBoldRewardsReceiver::triggerBoldRewards(uint256)**

## State Variable Reads

- **borrowerOperationsAddress** (`address`)
- **stabilityPool** (`contract IBoldRewardsReceiver`) [src/Interfaces/IBoldRewardsReceiver.sol/interface_IBoldRewardsReceiver.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **interestRouter** (`contract IInterestRouter`) [src/Interfaces/IInterestRouter.sol/interface_IInterestRouter.md]
- **shutdownTime** (`uint256`)
- **aggWeightedDebtSum** (`uint256`)
- **lastAggUpdateTime** (`uint256`)

## State Variable Writes

- **aggRecordedDebt** (`uint256`)
- **lastAggUpdateTime** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.mintAggInterest() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ActivePool._requireCallerIsBOorSP() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ActivePool._mintAggInterest(uint256) (NodeID: 2)
      💬 Args: [0]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ActivePool.calcPendingAggInterest() (NodeID: 3)
        💬 Args: [no args]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: Math.ceilDiv(uint256,uint256) (NodeID: 4)
          💬 Args: [aggWeightedDebtSum * (block.timestamp - lastAggUpdateTime), ONE_YEAR * DECIMAL_PRECISION]
          👁️  Def: internal
```
