# Contract: AgreementLibrary

## Metadata

- **Name**: AgreementLibrary
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol
- **Documentation**:  @title Agreement Library
   @author Superfluid
   @dev Helper library for building super agreement

## Structs

### CallbackInputs

```solidity
struct CallbackInputs {
    ISuperfluidToken token;
    address account;
    bytes32 agreementId;
    bytes agreementData;
    uint256 appCreditGranted;
    int256 appCreditUsed;
    uint256 noopBit;
}
```
