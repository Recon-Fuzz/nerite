# Function: deployPoolMemberNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperfluidPoolNFTLogicDeployerLibrary.md]

## Metadata

- **Contract**: SuperfluidPoolNFTLogicDeployerLibrary
- **Signature**: `deployPoolMemberNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)`
- **Visibility**: external
- **Source Range**: 17330:189:181

## Implementation

```solidity
function deployPoolMemberNFT(ISuperfluid host, IGeneralDistributionAgreementV1 gda) external returns (PoolMemberNFT) {
    return new PoolMemberNFT(host, gda);
}
```

## Call Tree

```
No call tree available
```
