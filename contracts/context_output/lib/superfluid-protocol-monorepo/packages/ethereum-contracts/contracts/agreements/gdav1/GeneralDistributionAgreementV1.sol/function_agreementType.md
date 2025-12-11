# Function: agreementType()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `agreementType()`
- **Visibility**: external
- **Source Range**: 3054:168:133
- **Inherited From**: IGeneralDistributionAgreementV1

## Implementation

```solidity
/// @dev ISuperAgreement.agreementType implementation
function agreementType() override external pure returns (bytes32) {
    return keccak256("org.superfluid-finance.agreements.GeneralDistributionAgreement.v1");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IGeneralDistributionAgreementV1.agreementType() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@dev ISuperAgreement.agreementType implementation

### Interface Documentation

 @dev Get the type of the agreement class
