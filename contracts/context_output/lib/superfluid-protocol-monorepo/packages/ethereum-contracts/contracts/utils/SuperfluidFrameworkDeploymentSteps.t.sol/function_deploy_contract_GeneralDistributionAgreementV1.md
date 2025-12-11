# Function: deploy(contract GeneralDistributionAgreementV1)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperfluidPoolLogicDeployerLibrary.md]

## Metadata

- **Contract**: SuperfluidPoolLogicDeployerLibrary
- **Signature**: `deploy(contract GeneralDistributionAgreementV1)`
- **Visibility**: external
- **Source Range**: 15909:133:181

## Implementation

```solidity
function deploy(GeneralDistributionAgreementV1 gda) external returns (SuperfluidPool) {
    return new SuperfluidPool(gda);
}
```

## Call Tree

```
No call tree available
```
