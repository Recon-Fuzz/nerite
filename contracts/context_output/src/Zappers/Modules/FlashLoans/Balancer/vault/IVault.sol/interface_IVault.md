# Interface: IVault

## Metadata

- **Name**: IVault
- **Type**: Interface
- **Path**: src/Zappers/Modules/FlashLoans/Balancer/vault/IVault.sol
- **Documentation**:  @dev Full external interface for the Vault core contract - no external or public methods exist in the contract that
   don't override one of these declarations.

## Events

### FlashLoan

```solidity
///  @dev Emitted for each individual flash loan performed by `flashLoan`.
event FlashLoan(IFlashLoanRecipient indexed recipient, IERC20 indexed token, uint256 amount, uint256 feeAmount);
```

## Public/External Functions

### flashLoan(contract IFlashLoanRecipient,contract IERC20[],uint256[],bytes)

- **Signature**: `flashLoan(contract IFlashLoanRecipient,contract IERC20[],uint256[],bytes)`
- **Visibility**: external
- **Source Range**: 1648:170:158

**Signature:**
```solidity
///  @dev Performs a 'flash loan', sending tokens to `recipient`, executing the `receiveFlashLoan` hook on it,
///  and then reverting unless the tokens plus a proportional protocol fee have been returned.
///  The `tokens` and `amounts` arrays must have the same length, and each entry in these indicates the loan amount
///  for each token contract. `tokens` must be sorted in ascending order.
///  The 'userData' field is ignored by the Vault, and forwarded as-is to `recipient` as part of the
///  `receiveFlashLoan` call.
///  Emits `FlashLoan` events.
function flashLoan(IFlashLoanRecipient recipient, IERC20[] memory tokens, uint256[] memory amounts, bytes memory userData) external;;
```
