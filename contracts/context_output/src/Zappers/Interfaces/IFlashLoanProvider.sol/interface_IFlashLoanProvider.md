# Interface: IFlashLoanProvider

## Metadata

- **Name**: IFlashLoanProvider
- **Type**: Interface
- **Path**: src/Zappers/Interfaces/IFlashLoanProvider.sol

## Enums

### Operation

```solidity
enum Operation {
    OpenTrove,
    CloseTrove,
    LeverUpTrove,
    LeverDownTrove
}
```

## Public/External Functions

### receiver()

- **Signature**: `receiver()`
- **Visibility**: external
- **Source Range**: 339:63:286

**Signature:**
```solidity
function receiver() external view returns (IFlashLoanReceiver);;
```

### makeFlashLoan(contract IERC20,uint256,enum IFlashLoanProvider.Operation,bytes)

- **Signature**: `makeFlashLoan(contract IERC20,uint256,enum IFlashLoanProvider.Operation,bytes)`
- **Visibility**: external
- **Source Range**: 408:111:286

**Signature:**
```solidity
function makeFlashLoan(IERC20 _token, uint256 _amount, Operation _operation, bytes calldata userData) external;;
```
