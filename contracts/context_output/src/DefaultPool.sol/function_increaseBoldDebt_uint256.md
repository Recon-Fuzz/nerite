# Function: increaseBoldDebt(uint256)

**Contract**: [src/DefaultPool.sol/contract_DefaultPool.md]

## Metadata

- **Contract**: DefaultPool
- **Signature**: `increaseBoldDebt(uint256)`
- **Visibility**: external
- **Source Range**: 3187:198:57

## Implementation

```solidity
function increaseBoldDebt(uint256 _amount) override external {
    _requireCallerIsTroveManager();
    BoldDebt = BoldDebt + _amount;
    emit DefaultPoolBoldDebtUpdated(BoldDebt);
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

## State Variable Reads

- **BoldDebt** (`uint256`)
- **troveManagerAddress** (`address`)

## State Variable Writes

- **BoldDebt** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DefaultPool.increaseBoldDebt(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DefaultPool._requireCallerIsTroveManager() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
