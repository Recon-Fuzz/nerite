# Function: deploy(contract ISuperfluid,contract IPoolAdminNFT,contract IPoolMemberNFT)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperTokenDeployerLibrary.md]

## Metadata

- **Contract**: SuperTokenDeployerLibrary
- **Signature**: `deploy(contract ISuperfluid,contract IPoolAdminNFT,contract IPoolMemberNFT)`
- **Visibility**: external
- **Source Range**: 16716:366:181

## Implementation

```solidity
function deploy(ISuperfluid host, IPoolAdminNFT poolAdminNFT, IPoolMemberNFT poolMemberNFT) external returns (address) {
    return address(new SuperToken(host, IConstantOutflowNFT(address(0)), IConstantInflowNFT(address(0)), poolAdminNFT, poolMemberNFT));
}
```

## Call Tree

```
No call tree available
```
