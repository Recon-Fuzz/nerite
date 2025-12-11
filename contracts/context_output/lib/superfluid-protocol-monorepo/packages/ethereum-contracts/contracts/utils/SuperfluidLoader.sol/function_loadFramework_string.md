# Function: loadFramework(string)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidLoader.sol/contract_SuperfluidLoader.md]

## Metadata

- **Contract**: SuperfluidLoader
- **Signature**: `loadFramework(string)`
- **Visibility**: external
- **Source Range**: 1082:878:182

## Implementation

```solidity
///  @dev Load framework objects
///  @param releaseVersion Protocol release version of the deployment
function loadFramework(string calldata releaseVersion) external view returns (Framework memory result) {
    result.superfluid = ISuperfluid(_resolver.get(string.concat("Superfluid.", releaseVersion)));
    result.superTokenFactory = result.superfluid.getSuperTokenFactory();
    result.agreementCFAv1 = result.superfluid.getAgreementClass(keccak256("org.superfluid-finance.agreements.ConstantFlowAgreement.v1"));
    result.agreementIDAv1 = result.superfluid.getAgreementClass(keccak256("org.superfluid-finance.agreements.InstantDistributionAgreement.v1"));
    result.agreementGDAv1 = result.superfluid.getAgreementClass(keccak256("org.superfluid-finance.agreements.GeneralDistributionAgreement.v1"));
}
```

## External Calls

- **IResolver::get(string)**
- **ISuperfluid::getSuperTokenFactory()**
- **ISuperfluid::getAgreementClass(bytes32)**

## State Variable Reads

- **_resolver** (`contract IResolver`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/utils/IResolver.sol/interface_IResolver.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidLoader.loadFramework(string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @dev Load framework objects
 @param releaseVersion Protocol release version of the deployment
