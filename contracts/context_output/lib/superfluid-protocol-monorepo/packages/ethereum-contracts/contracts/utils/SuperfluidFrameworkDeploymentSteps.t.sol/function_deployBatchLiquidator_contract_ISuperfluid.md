# Function: deployBatchLiquidator(contract ISuperfluid)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperfluidPeripheryDeployerLibrary.md]

## Metadata

- **Contract**: SuperfluidPeripheryDeployerLibrary
- **Signature**: `deployBatchLiquidator(contract ISuperfluid)`
- **Visibility**: external
- **Source Range**: 19251:142:181

## Implementation

```solidity
function deployBatchLiquidator(ISuperfluid host) external returns (BatchLiquidator) {
    return new BatchLiquidator(address(host));
}
```

## Call Tree

```
No call tree available
```
