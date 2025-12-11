# Function: accountSurplus(address,uint256)

**Contract**: [src/CollSurplusPool.sol/contract_CollSurplusPool.md]

## Metadata

- **Contract**: CollSurplusPool
- **Signature**: `accountSurplus(address,uint256)`
- **Visibility**: external
- **Source Range**: 1827:323:206

## Implementation

```solidity
function accountSurplus(address _account, uint256 _amount) override external {
    _requireCallerIsTroveManager();
    uint256 newAmount = balances[_account] + _amount;
    balances[_account] = newAmount;
    collBalance = collBalance + _amount;
    emit CollBalanceUpdated(_account, newAmount);
}
```

## Related Implementations

### _requireCallerIsTroveManager()

- **Kind**: internal
- **Source**: 2869:160:206
- **Link**: `src/CollSurplusPool.sol:CollSurplusPool:_requireCallerIsTroveManager()`

```solidity
function _requireCallerIsTroveManager() internal view {
    require(msg.sender == troveManagerAddress, "CollSurplusPool: Caller is not TroveManager");
}
```

## State Variable Reads

- **balances** (`mapping(address => uint256)`)
- **collBalance** (`uint256`)
- **troveManagerAddress** (`address`)

## State Variable Writes

- **balances** (`mapping(address => uint256)`)
- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollSurplusPool.accountSurplus(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: CollSurplusPool._requireCallerIsTroveManager() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
