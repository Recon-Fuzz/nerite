# Contract: SuperfluidFrameworkDeploymentSteps

## Metadata

- **Name**: SuperfluidFrameworkDeploymentSteps
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol
- **Documentation**: @title Superfluid Framework Deployment Steps
   @author Superfluid
   @notice A contract which splits framework deployment into steps.
   @dev This was necessary because of the contract size limit of the deployed contract
        which is an issue when deploying the original framework with Hardhat.
   https://github.com/NomicFoundation/hardhat/issues/3404#issuecomment-1346849400

## State Variables

### DEFAULT_NON_UPGRADEABLE

```solidity
bool public constant DEFAULT_NON_UPGRADEABLE = false
```

### DEFAULT_APP_WHITELISTING_ENABLED

```solidity
bool public constant DEFAULT_APP_WHITELISTING_ENABLED = false
```

### DEFAULT_REWARD_ADDRESS

```solidity
address public constant DEFAULT_REWARD_ADDRESS = address(69)
```

### DEFAULT_LIQUIDATION_PERIOD

```solidity
uint256 public constant DEFAULT_LIQUIDATION_PERIOD = 4 hours
```

### DEFAULT_PATRICIAN_PERIOD

```solidity
uint256 public constant DEFAULT_PATRICIAN_PERIOD = 30 minutes
```

### DEFAULT_TOGA_MIN_BOND_DURATION

```solidity
uint256 public constant DEFAULT_TOGA_MIN_BOND_DURATION = 1 weeks
```

### RESOLVER_BASE_SUPER_TOKEN_KEY

```solidity
string public constant RESOLVER_BASE_SUPER_TOKEN_KEY = "supertokens.test."
```

### RESOLVER_BASE_TOKEN_KEY

```solidity
string public constant RESOLVER_BASE_TOKEN_KEY = "tokens.test."
```

### currentStep

```solidity
uint8 private currentStep
```

### testGovernance

```solidity
TestGovernance internal testGovernance
```

**TestGovernance**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

### host

```solidity
Superfluid internal host
```

**Superfluid**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

### cfaV1

```solidity
ConstantFlowAgreementV1 internal cfaV1
```

**ConstantFlowAgreementV1**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

### idaV1

```solidity
InstantDistributionAgreementV1 internal idaV1
```

**InstantDistributionAgreementV1**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

### gdaV1

```solidity
GeneralDistributionAgreementV1 internal gdaV1
```

**GeneralDistributionAgreementV1**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

### poolAdminNFT

```solidity
PoolAdminNFT internal poolAdminNFT
```

**PoolAdminNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

### poolMemberNFT

```solidity
PoolMemberNFT internal poolMemberNFT
```

**PoolMemberNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

### superTokenLogic

```solidity
ISuperToken internal superTokenLogic
```

**ISuperToken**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

### superTokenFactory

```solidity
SuperTokenFactory internal superTokenFactory
```

**SuperTokenFactory**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

### cfaV1Forwarder

```solidity
CFAv1Forwarder internal cfaV1Forwarder
```

**CFAv1Forwarder**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]

### gdaV1Forwarder

```solidity
GDAv1Forwarder internal gdaV1Forwarder
```

**GDAv1Forwarder**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

### macroForwarder

```solidity
MacroForwarder internal macroForwarder
```

**MacroForwarder**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/MacroForwarder.sol/contract_MacroForwarder.md]

### testResolver

```solidity
TestResolver internal testResolver
```

**TestResolver**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol/contract_TestResolver.md]

### superfluidLoader

```solidity
SuperfluidLoader internal superfluidLoader
```

**SuperfluidLoader**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidLoader.sol/contract_SuperfluidLoader.md]

### batchLiquidator

```solidity
BatchLiquidator internal batchLiquidator
```

**BatchLiquidator**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/BatchLiquidator.sol/contract_BatchLiquidator.md]

### toga

```solidity
TOGA internal toga
```

**TOGA**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]

## Structs

### Framework

```solidity
struct Framework {
    TestGovernance governance;
    Superfluid host;
    ConstantFlowAgreementV1 cfa;
    InstantDistributionAgreementV1 ida;
    GeneralDistributionAgreementV1 gda;
    SuperTokenFactory superTokenFactory;
    ISuperToken superTokenLogic;
    TestResolver resolver;
    SuperfluidLoader superfluidLoader;
    CFAv1Forwarder cfaV1Forwarder;
    GDAv1Forwarder gdaV1Forwarder;
    MacroForwarder macroForwarder;
    BatchLiquidator batchLiquidator;
    TOGA toga;
}
```

## Errors

### DEPLOY_TOGA_REQUIRES_1820

```solidity
error DEPLOY_TOGA_REQUIRES_1820();
```

### DEPLOY_SUPER_TOKEN_REQUIRES_1820

```solidity
error DEPLOY_SUPER_TOKEN_REQUIRES_1820();
```

### DEPLOY_SUPER_TOKEN_REQUIRES_DEPLOY_SUPER_TOKEN_CONTRACTS

```solidity
error DEPLOY_SUPER_TOKEN_REQUIRES_DEPLOY_SUPER_TOKEN_CONTRACTS();
```

### RESOLVER_LIST_REQUIRES_DEPLOY_PERIPHERALS

```solidity
error RESOLVER_LIST_REQUIRES_DEPLOY_PERIPHERALS();
```

## Public/External Functions

### getFramework()

- **Signature**: `getFramework()`
- **Visibility**: external
- **Source Range**: 4582:648:181
- **Details**: [function_getFramework.md](./function_getFramework.md)

**Signature:**
```solidity
/// @notice Fetches the framework contracts
function getFramework() external view returns (Framework memory sf);
```

### transferOwnership(address)

- **Signature**: `transferOwnership(address)`
- **Visibility**: public
- **Source Range**: 5462:111:181
- **Details**: [function_transferOwnership_address.md](./function_transferOwnership_address.md)

**Signature:**
```solidity
/// @notice Transfer ownership of the TestGovernance contract
///  @dev This function allows you to transfer ownership of TestGovernance when testing
///  @param newOwner the new owner of the TestGovernance contract
function transferOwnership(address newOwner) public;
```

### getNumSteps()

- **Signature**: `getNumSteps()`
- **Visibility**: public
- **Source Range**: 5579:76:181
- **Details**: [function_getNumSteps.md](./function_getNumSteps.md)

**Signature:**
```solidity
function getNumSteps() public pure returns (uint8);
```

### executeStep(uint8)

- **Signature**: `executeStep(uint8)`
- **Visibility**: public
- **Source Range**: 5661:8777:181
- **Details**: [function_executeStep_uint8.md](./function_executeStep_uint8.md)

**Signature:**
```solidity
function executeStep(uint8 step) public;
```
