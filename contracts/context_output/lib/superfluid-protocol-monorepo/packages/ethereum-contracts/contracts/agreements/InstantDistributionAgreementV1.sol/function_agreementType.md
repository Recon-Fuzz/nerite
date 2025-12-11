# Function: agreementType()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `agreementType()`
- **Visibility**: external
- **Source Range**: 2717:168:132
- **Inherited From**: IInstantDistributionAgreementV1

## Implementation

```solidity
/// @dev ISuperAgreement.agreementType implementation
function agreementType() override external pure returns (bytes32) {
    return keccak256("org.superfluid-finance.agreements.InstantDistributionAgreement.v1");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IInstantDistributionAgreementV1.agreementType() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@dev ISuperAgreement.agreementType implementation

### Interface Documentation

 @dev Get the type of the agreement class
