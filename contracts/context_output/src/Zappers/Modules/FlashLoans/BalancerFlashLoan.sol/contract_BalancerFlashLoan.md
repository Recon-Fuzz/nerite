# Contract: BalancerFlashLoan

## Metadata

- **Name**: BalancerFlashLoan
- **Type**: Contract
- **Path**: src/Zappers/Modules/FlashLoans/BalancerFlashLoan.sol

## Implements Interfaces

- **IFlashLoanProvider** [src/Zappers/Interfaces/IFlashLoanProvider.sol/interface_IFlashLoanProvider.md]
- **IFlashLoanRecipient** [src/Zappers/Modules/FlashLoans/Balancer/vault/IFlashLoanRecipient.sol/interface_IFlashLoanRecipient.md]

## State Variables

### vault

```solidity
IVault private constant vault = IVault(0xBA12222222228d8Ba445958a75a0704d566BF2C8)
```

**IVault**: [src/Zappers/Modules/FlashLoans/Balancer/vault/IVault.sol/interface_IVault.md]

### receiver

```solidity
IFlashLoanReceiver public receiver
```

**IFlashLoanReceiver**: [src/Zappers/Interfaces/IFlashLoanReceiver.sol/interface_IFlashLoanReceiver.md]

## Enums

### Operation (inherited from IFlashLoanProvider)

```solidity
enum Operation {
    OpenTrove,
    CloseTrove,
    LeverUpTrove,
    LeverDownTrove
}
```

## Public/External Functions

### makeFlashLoan(contract IERC20,uint256,enum IFlashLoanProvider.Operation,bytes)

- **Signature**: `makeFlashLoan(contract IERC20,uint256,enum IFlashLoanProvider.Operation,bytes)`
- **Visibility**: external
- **Source Range**: 609:1663:159
- **Details**: [function_makeFlashLoan_contract_IERC20_uint256_enum_IFlashLoanProvider_Operation_bytes.md](./function_makeFlashLoan_contract_IERC20_uint256_enum_IFlashLoanProvider_Operation_bytes.md)

**Signature:**
```solidity
function makeFlashLoan(IERC20 _token, uint256 _amount, Operation _operation, bytes calldata _params) external;
```

### receiveFlashLoan(contract IERC20[],uint256[],uint256[],bytes)

- **Signature**: `receiveFlashLoan(contract IERC20[],uint256[],uint256[],bytes)`
- **Visibility**: external
- **Source Range**: 2278:3705:159
- **Details**: [function_receiveFlashLoan_contract_IERC20[]_uint256[]_uint256[]_bytes.md](./function_receiveFlashLoan_contract_IERC20[]_uint256[]_uint256[]_bytes.md)

**Signature:**
```solidity
function receiveFlashLoan(IERC20[] calldata tokens, uint256[] calldata amounts, uint256[] calldata feeAmounts, bytes calldata userData) override external;
```
