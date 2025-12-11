# Function: deploySuperfluidLoader(contract IResolver)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperfluidPeripheryDeployerLibrary.md]

## Metadata

- **Contract**: SuperfluidPeripheryDeployerLibrary
- **Signature**: `deploySuperfluidLoader(contract IResolver)`
- **Visibility**: external
- **Source Range**: 19103:142:181

## Implementation

```solidity
function deploySuperfluidLoader(IResolver resolver) external returns (SuperfluidLoader) {
    return new SuperfluidLoader(resolver);
}
```

## Call Tree

```
No call tree available
```
