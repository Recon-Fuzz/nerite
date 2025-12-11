# Function: deploy(contract ISuperfluid,contract ISuperToken,contract IPoolAdminNFT,contract IPoolMemberNFT)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperTokenFactoryDeployerLibrary.md]

## Metadata

- **Contract**: SuperTokenFactoryDeployerLibrary
- **Signature**: `deploy(contract ISuperfluid,contract ISuperToken,contract IPoolAdminNFT,contract IPoolMemberNFT)`
- **Visibility**: external
- **Source Range**: 18442:460:181

## Implementation

```solidity
function deploy(ISuperfluid host, ISuperToken superTokenLogic, IPoolAdminNFT poolAdminNFTLogic, IPoolMemberNFT poolMemberNFTLogic) external returns (SuperTokenFactory) {
    return new SuperTokenFactory(host, superTokenLogic, IConstantOutflowNFT(address(0)), IConstantInflowNFT(address(0)), poolAdminNFTLogic, poolMemberNFTLogic);
}
```

## Call Tree

```
No call tree available
```
