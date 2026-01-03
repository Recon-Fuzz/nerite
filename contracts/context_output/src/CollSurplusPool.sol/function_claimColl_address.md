# Function: claimColl(address)

**Contract**: [src/CollSurplusPool.sol/contract_CollSurplusPool.md]

## Metadata

- **Contract**: CollSurplusPool
- **Signature**: `claimColl(address)`
- **Visibility**: external
- **Source Range**: 2156:486:55

## Implementation

```solidity
function claimColl(address _account) override external {
    _requireCallerIsBorrowerOperations();
    uint256 claimableColl = balances[_account];
    require(claimableColl > 0, "CollSurplusPool: No collateral available to claim");
    balances[_account] = 0;
    emit CollBalanceUpdated(_account, 0);
    collBalance = collBalance - claimableColl;
    emit CollSent(_account, claimableColl);
    collToken.safeTransfer(_account, claimableColl);
}
```

## Related Implementations

### _requireCallerIsBorrowerOperations()

- **Kind**: internal
- **Source**: 2684:179:55
- **Link**: `src/CollSurplusPool.sol:CollSurplusPool:_requireCallerIsBorrowerOperations()`

```solidity
function _requireCallerIsBorrowerOperations() internal view {
    require(msg.sender == borrowerOperationsAddress, "CollSurplusPool: Caller is not Borrower Operations");
}
```

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **balances** (`mapping(address => uint256)`)
- **collBalance** (`uint256`)
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **borrowerOperationsAddress** (`address`)

## State Variable Writes

- **balances** (`mapping(address => uint256)`)
- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollSurplusPool.claimColl(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: CollSurplusPool._requireCallerIsBorrowerOperations() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
