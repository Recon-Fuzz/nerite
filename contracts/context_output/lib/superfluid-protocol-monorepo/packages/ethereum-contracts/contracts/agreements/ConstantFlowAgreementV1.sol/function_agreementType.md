# Function: agreementType()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `agreementType()`
- **Visibility**: external
- **Source Range**: 1897:161:131
- **Inherited From**: IConstantFlowAgreementV1

## Implementation

```solidity
/// @dev ISuperAgreement.agreementType implementation
function agreementType() override external pure returns (bytes32) {
    return keccak256("org.superfluid-finance.agreements.ConstantFlowAgreement.v1");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IConstantFlowAgreementV1.agreementType() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@dev ISuperAgreement.agreementType implementation

### Interface Documentation

 @dev Get the type of the agreement class
