# Function: receiveColl(uint256)

**Contract**: [src/DefaultPool.sol/contract_DefaultPool.md]

## Metadata

- **Contract**: DefaultPool
- **Signature**: `receiveColl(uint256)`
- **Visibility**: external
- **Source Range**: 2816:365:57

## Implementation

```solidity
function receiveColl(uint256 _amount) external {
    _requireCallerIsActivePool();
    uint256 newCollBalance = collBalance + _amount;
    collBalance = newCollBalance;
    collToken.safeTransferFrom(msg.sender, address(this), _amount);
    emit DefaultPoolCollBalanceUpdated(newCollBalance);
}
```

## Related Implementations

### _requireCallerIsActivePool()

- **Kind**: internal
- **Source**: 3631:154:57
- **Link**: `src/DefaultPool.sol:DefaultPool:_requireCallerIsActivePool()`

```solidity
function _requireCallerIsActivePool() internal view {
    require(msg.sender == activePoolAddress, "DefaultPool: Caller is not the ActivePool");
}
```

## External Calls

- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**

## State Variable Reads

- **collBalance** (`uint256`)
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **activePoolAddress** (`address`)

## State Variable Writes

- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DefaultPool.receiveColl(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DefaultPool._requireCallerIsActivePool() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
