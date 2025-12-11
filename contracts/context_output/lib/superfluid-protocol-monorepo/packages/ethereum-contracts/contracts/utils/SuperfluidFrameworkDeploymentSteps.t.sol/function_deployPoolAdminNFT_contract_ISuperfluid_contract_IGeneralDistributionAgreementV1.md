# Function: deployPoolAdminNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperfluidPoolNFTLogicDeployerLibrary.md]

## Metadata

- **Contract**: SuperfluidPoolNFTLogicDeployerLibrary
- **Signature**: `deployPoolAdminNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)`
- **Visibility**: external
- **Source Range**: 17138:186:181

## Implementation

```solidity
function deployPoolAdminNFT(ISuperfluid host, IGeneralDistributionAgreementV1 gda) external returns (PoolAdminNFT) {
    return new PoolAdminNFT(host, gda);
}
```

## Call Tree

```
No call tree available
```
