# Function: transferOwnership(contract TestGovernance,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperfluidGovDeployerLibrary.md]

## Metadata

- **Contract**: SuperfluidGovDeployerLibrary
- **Signature**: `transferOwnership(contract TestGovernance,address)`
- **Visibility**: external
- **Source Range**: 14865:126:181

## Implementation

```solidity
function transferOwnership(TestGovernance _gov, address _newOwner) external {
    _gov.transferOwnership(_newOwner);
}
```

## External Calls

- **TestGovernance::transferOwnership(address)**

## Call Tree

```
No call tree available
```
