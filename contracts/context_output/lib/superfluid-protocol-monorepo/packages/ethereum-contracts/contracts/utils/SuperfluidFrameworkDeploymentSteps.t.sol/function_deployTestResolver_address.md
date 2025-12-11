# Function: deployTestResolver(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperfluidPeripheryDeployerLibrary.md]

## Metadata

- **Contract**: SuperfluidPeripheryDeployerLibrary
- **Signature**: `deployTestResolver(address)`
- **Visibility**: external
- **Source Range**: 18955:142:181

## Implementation

```solidity
function deployTestResolver(address additionalAdmin) external returns (TestResolver) {
    return new TestResolver(additionalAdmin);
}
```

## Call Tree

```
No call tree available
```
