# Function: sendColl(address,uint256)

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `sendColl(address,uint256)`
- **Visibility**: external
- **Source Range**: 7498:211:202

## Implementation

```solidity
function sendColl(address _account, uint256 _amount) override external {
    _requireCallerIsBOorTroveMorSP();
    _accountForSendColl(_amount);
    collToken.safeTransfer(_account, _amount);
}
```

## Related Implementations

### _requireCallerIsBOorTroveMorSP()

- **Kind**: internal
- **Source**: 14238:335:202
- **Link**: `src/ActivePool.sol:ActivePool:_requireCallerIsBOorTroveMorSP()`

```solidity
function _requireCallerIsBOorTroveMorSP() internal view {
    require(((msg.sender == borrowerOperationsAddress) || (msg.sender == troveManagerAddress)) || (msg.sender == address(stabilityPool)), "ActivePool: Caller is neither BorrowerOperations nor TroveManager nor StabilityPool");
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

- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **borrowerOperationsAddress** (`address`)
- **troveManagerAddress** (`address`)
- **stabilityPool** (`contract IBoldRewardsReceiver`) [src/Interfaces/IBoldRewardsReceiver.sol/interface_IBoldRewardsReceiver.md]
- **collBalance** (`uint256`)

## State Variable Writes

- **collBalance** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.sendColl(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ActivePool._requireCallerIsBOorTroveMorSP() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ActivePool._accountForSendColl(uint256) (NodeID: 2)
      💬 Args: [_amount]
      👁️  Def: internal
```
