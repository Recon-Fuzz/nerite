# Contract: SuperfluidGovDeployerLibrary

## Metadata

- **Name**: SuperfluidGovDeployerLibrary
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol

## Public/External Functions

### deployTestGovernance()

- **Signature**: `deployTestGovernance()`
- **Visibility**: external
- **Source Range**: 14749:110:181
- **Details**: [function_deployTestGovernance.md](./function_deployTestGovernance.md)

**Signature:**
```solidity
function deployTestGovernance() external returns (TestGovernance);
```

### transferOwnership(contract TestGovernance,address)

- **Signature**: `transferOwnership(contract TestGovernance,address)`
- **Visibility**: external
- **Source Range**: 14865:126:181
- **Details**: [function_transferOwnership_contract_TestGovernance_address.md](./function_transferOwnership_contract_TestGovernance_address.md)

**Signature:**
```solidity
function transferOwnership(TestGovernance _gov, address _newOwner) external;
```
