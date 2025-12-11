# Function: deploy(contract ISuperfluid,contract SuperfluidUpgradeableBeacon)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperfluidGDAv1DeployerLibrary.md]

## Metadata

- **Contract**: SuperfluidGDAv1DeployerLibrary
- **Signature**: `deploy(contract ISuperfluid,contract SuperfluidUpgradeableBeacon)`
- **Visibility**: external
- **Source Range**: 16091:249:181

## Implementation

```solidity
function deploy(ISuperfluid host, SuperfluidUpgradeableBeacon superfluidPoolBeacon) external returns (GeneralDistributionAgreementV1 gdaV1Logic) {
    gdaV1Logic = new GeneralDistributionAgreementV1(host, superfluidPoolBeacon);
}
```

## Call Tree

```
No call tree available
```
