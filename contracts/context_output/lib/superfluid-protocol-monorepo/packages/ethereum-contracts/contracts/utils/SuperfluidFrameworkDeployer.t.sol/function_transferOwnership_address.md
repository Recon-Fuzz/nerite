# Function: transferOwnership(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.t.sol/contract_SuperfluidFrameworkDeployer.md]

## Metadata

- **Contract**: SuperfluidFrameworkDeployer
- **Signature**: `transferOwnership(address)`
- **Visibility**: public
- **Source Range**: 5462:111:181
- **Inherited From**: SuperfluidFrameworkDeploymentSteps

## Implementation

```solidity
/// @notice Transfer ownership of the TestGovernance contract
///  @dev This function allows you to transfer ownership of TestGovernance when testing
///  @param newOwner the new owner of the TestGovernance contract
function transferOwnership(address newOwner) public {
    testGovernance.transferOwnership(newOwner);
}
```

## External Calls

- **TestGovernance::transferOwnership(address)**

## State Variable Reads

- **testGovernance** (`contract TestGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidFrameworkDeploymentSteps.transferOwnership(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Transfer ownership of the TestGovernance contract
 @dev This function allows you to transfer ownership of TestGovernance when testing
 @param newOwner the new owner of the TestGovernance contract
