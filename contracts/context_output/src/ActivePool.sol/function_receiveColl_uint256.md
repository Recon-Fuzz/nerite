# Function: receiveColl(uint256)

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `receiveColl(uint256)`
- **Visibility**: external
- **Source Range**: 8158:269:51

## Implementation

```solidity
function receiveColl(uint256 _amount) external {
    _requireCallerIsBorrowerOperationsOrDefaultPool();
    _accountForReceivedColl(_amount);
    collToken.safeTransferFrom(msg.sender, address(this), _amount);
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

## External Calls

- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **borrowerOperationsAddress** (`address`)
- **defaultPoolAddress** (`address`)
- **collBalance** (`uint256`)

## State Variable Writes

- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.receiveColl(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ActivePool._requireCallerIsBorrowerOperationsOrDefaultPool() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ActivePool._accountForReceivedColl(uint256) (NodeID: 2)
      💬 Args: [_amount]
      👁️  Def: internal
```
