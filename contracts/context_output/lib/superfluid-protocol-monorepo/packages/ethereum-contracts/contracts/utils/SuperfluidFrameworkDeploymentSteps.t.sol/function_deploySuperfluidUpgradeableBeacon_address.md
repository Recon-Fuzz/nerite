# Function: deploySuperfluidUpgradeableBeacon(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_ProxyDeployerLibrary.md]

## Metadata

- **Contract**: ProxyDeployerLibrary
- **Signature**: `deploySuperfluidUpgradeableBeacon(address)`
- **Visibility**: external
- **Source Range**: 17659:183:181

## Implementation

```solidity
function deploySuperfluidUpgradeableBeacon(address logicContract) external returns (SuperfluidUpgradeableBeacon) {
    return new SuperfluidUpgradeableBeacon(logicContract);
}
```

## Call Tree

```
No call tree available
```
