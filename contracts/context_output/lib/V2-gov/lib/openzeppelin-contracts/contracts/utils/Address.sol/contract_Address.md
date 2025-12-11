# Contract: Address

## Metadata

- **Name**: Address
- **Type**: Contract
- **Path**: lib/V2-gov/lib/openzeppelin-contracts/contracts/utils/Address.sol
- **Documentation**:  @dev Collection of functions related to the address type

## Errors

### AddressInsufficientBalance

```solidity
///  @dev The ETH balance of the account is not enough to perform the operation.
error AddressInsufficientBalance(address account);
```

### AddressEmptyCode

```solidity
///  @dev There's no code at `target` (it is not a contract).
error AddressEmptyCode(address target);
```

### FailedInnerCall

```solidity
///  @dev A call to an address target failed. The target may have reverted.
error FailedInnerCall();
```
