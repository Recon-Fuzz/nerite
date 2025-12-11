# Contract: GasPool

## Metadata

- **Name**: GasPool
- **Type**: Contract
- **Path**: src/GasPool.sol
- **Documentation**:  The purpose of this contract is to hold WETH tokens for gas compensation:
   https://github.com/liquity/bold/?tab=readme-ov-file#liquidation-gas-compensation
   When a borrower opens a trove, an additional amount of WETH is pulled,
   and sent to this contract.
   When a borrower closes their active trove, this gas compensation is refunded
   When a trove is liquidated, this gas compensation is paid to liquidator

## Public/External Functions

### constructor(contract IAddressesRegistry)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 710:534:217
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry);
```
