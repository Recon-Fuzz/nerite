# Function: sendCollToActivePool(uint256)

**Contract**: [src/DefaultPool.sol/contract_DefaultPool.md]

## Metadata

- **Contract**: DefaultPool
- **Signature**: `sendCollToActivePool(uint256)`
- **Visibility**: external
- **Source Range**: 2407:403:57

## Implementation

```solidity
function sendCollToActivePool(uint256 _amount) override external {
    _requireCallerIsTroveManager();
    uint256 newCollBalance = collBalance - _amount;
    collBalance = newCollBalance;
    emit DefaultPoolCollBalanceUpdated(newCollBalance);
    IActivePool(activePoolAddress).receiveColl(_amount);
}
```

## Related Implementations

### _requireCallerIsTroveManager()

- **Kind**: internal
- **Source**: 3791:160:57
- **Link**: `src/DefaultPool.sol:DefaultPool:_requireCallerIsTroveManager()`

```solidity
function _requireCallerIsTroveManager() internal view {
    require(msg.sender == troveManagerAddress, "DefaultPool: Caller is not the TroveManager");
}
```

## External Calls

- **IActivePool::receiveColl(uint256)**

## State Variable Reads

- **collBalance** (`uint256`)
- **activePoolAddress** (`address`)
- **troveManagerAddress** (`address`)

## State Variable Writes

- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DefaultPool.sendCollToActivePool(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DefaultPool._requireCallerIsTroveManager() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
