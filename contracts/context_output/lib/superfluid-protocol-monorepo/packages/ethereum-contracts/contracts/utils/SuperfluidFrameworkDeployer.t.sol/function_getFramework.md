# Function: getFramework()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.t.sol/contract_SuperfluidFrameworkDeployer.md]

## Metadata

- **Contract**: SuperfluidFrameworkDeployer
- **Signature**: `getFramework()`
- **Visibility**: external
- **Source Range**: 4582:648:181
- **Inherited From**: SuperfluidFrameworkDeploymentSteps

## Implementation

```solidity
/// @notice Fetches the framework contracts
function getFramework() external view returns (Framework memory sf) {
    sf = Framework({governance: testGovernance, host: host, cfa: cfaV1, ida: idaV1, gda: gdaV1, superTokenFactory: superTokenFactory, superTokenLogic: superTokenLogic, resolver: testResolver, superfluidLoader: superfluidLoader, cfaV1Forwarder: cfaV1Forwarder, gdaV1Forwarder: gdaV1Forwarder, macroForwarder: macroForwarder, batchLiquidator: batchLiquidator, toga: toga});
    return sf;
}
```

## State Variable Reads

- **testGovernance** (`contract TestGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]
- **host** (`contract Superfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]
- **cfaV1** (`contract ConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]
- **idaV1** (`contract InstantDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]
- **gdaV1** (`contract GeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]
- **superTokenFactory** (`contract SuperTokenFactory`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]
- **superTokenLogic** (`contract ISuperToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]
- **testResolver** (`contract TestResolver`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol/contract_TestResolver.md]
- **superfluidLoader** (`contract SuperfluidLoader`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidLoader.sol/contract_SuperfluidLoader.md]
- **cfaV1Forwarder** (`contract CFAv1Forwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]
- **gdaV1Forwarder** (`contract GDAv1Forwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]
- **macroForwarder** (`contract MacroForwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/MacroForwarder.sol/contract_MacroForwarder.md]
- **batchLiquidator** (`contract BatchLiquidator`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/BatchLiquidator.sol/contract_BatchLiquidator.md]
- **toga** (`contract TOGA`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidFrameworkDeploymentSteps.getFramework() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Fetches the framework contracts
