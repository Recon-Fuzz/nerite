# Function: deployTOGA(contract ISuperfluid,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperfluidPeripheryDeployerLibrary.md]

## Metadata

- **Contract**: SuperfluidPeripheryDeployerLibrary
- **Signature**: `deployTOGA(contract ISuperfluid,uint256)`
- **Visibility**: external
- **Source Range**: 19399:142:181

## Implementation

```solidity
function deployTOGA(ISuperfluid host, uint256 minBondDuration) external returns (TOGA) {
    return new TOGA(host, minBondDuration);
}
```

## Call Tree

```
No call tree available
```
