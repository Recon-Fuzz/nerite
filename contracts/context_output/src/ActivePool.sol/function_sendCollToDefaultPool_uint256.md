# Function: sendCollToDefaultPool(uint256)

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `sendCollToDefaultPool(uint256)`
- **Visibility**: external
- **Source Range**: 7715:216:202

## Implementation

```solidity
function sendCollToDefaultPool(uint256 _amount) override external {
    _requireCallerIsTroveManager();
    _accountForSendColl(_amount);
    IDefaultPool(defaultPoolAddress).receiveColl(_amount);
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

### _accountForSendColl(uint256)

- **Kind**: internal
- **Source**: 7937:215:202
- **Link**: `src/ActivePool.sol:ActivePool:_accountForSendColl(uint256)`

```solidity
function _accountForSendColl(uint256 _amount) internal {
    uint256 newCollBalance = collBalance - _amount;
    collBalance = newCollBalance;
    emit ActivePoolCollBalanceUpdated(newCollBalance);
}
```

## External Calls

- **IDefaultPool::receiveColl(uint256)**

## State Variable Reads

- **defaultPoolAddress** (`address`)
- **troveManagerAddress** (`address`)
- **collBalance** (`uint256`)

## State Variable Writes

- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.sendCollToDefaultPool(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ActivePool._requireCallerIsTroveManager() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ActivePool._accountForSendColl(uint256) (NodeID: 2)
      💬 Args: [_amount]
      👁️  Def: internal
```
