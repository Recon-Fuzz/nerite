# Function: accountForReceivedColl(uint256)

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `accountForReceivedColl(uint256)`
- **Visibility**: public
- **Source Range**: 8433:165:51

## Implementation

```solidity
function accountForReceivedColl(uint256 _amount) public {
    _requireCallerIsBorrowerOperationsOrDefaultPool();
    _accountForReceivedColl(_amount);
}
```

## Related Implementations

### _requireCallerIsBorrowerOperationsOrDefaultPool()

- **Kind**: internal
- **Source**: 13971:261:51
- **Link**: `src/ActivePool.sol:ActivePool:_requireCallerIsBorrowerOperationsOrDefaultPool()`

```solidity
function _requireCallerIsBorrowerOperationsOrDefaultPool() internal view {
    require((msg.sender == borrowerOperationsAddress) || (msg.sender == defaultPoolAddress), "ActivePool: Caller is neither BO nor Default Pool");
}
```

### _accountForReceivedColl(uint256)

- **Kind**: internal
- **Source**: 8604:220:51
- **Link**: `src/ActivePool.sol:ActivePool:_accountForReceivedColl(uint256)`

```solidity
function _accountForReceivedColl(uint256 _amount) internal {
    uint256 newCollBalance = collBalance + _amount;
    collBalance = newCollBalance;
    emit ActivePoolCollBalanceUpdated(newCollBalance);
}
```

## State Variable Reads

- **borrowerOperationsAddress** (`address`)
- **defaultPoolAddress** (`address`)
- **collBalance** (`uint256`)

## State Variable Writes

- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.accountForReceivedColl(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActivePool._requireCallerIsBorrowerOperationsOrDefaultPool() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ActivePool._accountForReceivedColl(uint256) (NodeID: 2)
      💬 Args: [_amount]
      👁️  Def: internal
```
