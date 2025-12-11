# Contract: SuperfluidFrameworkDeployer

## Metadata

- **Name**: SuperfluidFrameworkDeployer
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.t.sol
- **Documentation**: @title Superfluid Framework Deployer
   @dev This deployer should only be used for local testing environments.
        Notes:
        - ERC1820 must be deployed as a prerequisite to using this contract.
        - Some test frameworks may have difficulties in tuning its maximum contract code size limit. Using deployment
          steps contract solves this issue.

## State Variables

### DEFAULT_NON_UPGRADEABLE (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
bool public constant DEFAULT_NON_UPGRADEABLE = false
```

### DEFAULT_APP_WHITELISTING_ENABLED (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
bool public constant DEFAULT_APP_WHITELISTING_ENABLED = false
```

### DEFAULT_REWARD_ADDRESS (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
address public constant DEFAULT_REWARD_ADDRESS = address(69)
```

### DEFAULT_LIQUIDATION_PERIOD (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
uint256 public constant DEFAULT_LIQUIDATION_PERIOD = 4 hours
```

### DEFAULT_PATRICIAN_PERIOD (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
uint256 public constant DEFAULT_PATRICIAN_PERIOD = 30 minutes
```

### DEFAULT_TOGA_MIN_BOND_DURATION (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
uint256 public constant DEFAULT_TOGA_MIN_BOND_DURATION = 1 weeks
```

### RESOLVER_BASE_SUPER_TOKEN_KEY (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
string public constant RESOLVER_BASE_SUPER_TOKEN_KEY = "supertokens.test."
```

### RESOLVER_BASE_TOKEN_KEY (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
string public constant RESOLVER_BASE_TOKEN_KEY = "tokens.test."
```

### currentStep (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
uint8 private currentStep
```

### testGovernance (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
TestGovernance internal testGovernance
```

**TestGovernance**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

### host (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
Superfluid internal host
```

**Superfluid**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

### cfaV1 (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
ConstantFlowAgreementV1 internal cfaV1
```

**ConstantFlowAgreementV1**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

### idaV1 (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
InstantDistributionAgreementV1 internal idaV1
```

**InstantDistributionAgreementV1**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

### gdaV1 (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
GeneralDistributionAgreementV1 internal gdaV1
```

**GeneralDistributionAgreementV1**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

### poolAdminNFT (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
PoolAdminNFT internal poolAdminNFT
```

**PoolAdminNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

### poolMemberNFT (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
PoolMemberNFT internal poolMemberNFT
```

**PoolMemberNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

### superTokenLogic (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
ISuperToken internal superTokenLogic
```

**ISuperToken**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

### superTokenFactory (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
SuperTokenFactory internal superTokenFactory
```

**SuperTokenFactory**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

### cfaV1Forwarder (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
CFAv1Forwarder internal cfaV1Forwarder
```

**CFAv1Forwarder**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]

### gdaV1Forwarder (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
GDAv1Forwarder internal gdaV1Forwarder
```

**GDAv1Forwarder**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

### macroForwarder (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
MacroForwarder internal macroForwarder
```

**MacroForwarder**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/MacroForwarder.sol/contract_MacroForwarder.md]

### testResolver (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
TestResolver internal testResolver
```

**TestResolver**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol/contract_TestResolver.md]

### superfluidLoader (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
SuperfluidLoader internal superfluidLoader
```

**SuperfluidLoader**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidLoader.sol/contract_SuperfluidLoader.md]

### batchLiquidator (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
BatchLiquidator internal batchLiquidator
```

**BatchLiquidator**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/BatchLiquidator.sol/contract_BatchLiquidator.md]

### toga (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
TOGA internal toga
```

**TOGA**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]

## Structs

### Framework (inherited from SuperfluidFrameworkDeploymentSteps)

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

### DEPLOY_TOGA_REQUIRES_1820 (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
error DEPLOY_TOGA_REQUIRES_1820();
```

### DEPLOY_SUPER_TOKEN_REQUIRES_1820 (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
error DEPLOY_SUPER_TOKEN_REQUIRES_1820();
```

### DEPLOY_SUPER_TOKEN_REQUIRES_DEPLOY_SUPER_TOKEN_CONTRACTS (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
error DEPLOY_SUPER_TOKEN_REQUIRES_DEPLOY_SUPER_TOKEN_CONTRACTS();
```

### RESOLVER_LIST_REQUIRES_DEPLOY_PERIPHERALS (inherited from SuperfluidFrameworkDeploymentSteps)

```solidity
error RESOLVER_LIST_REQUIRES_DEPLOY_PERIPHERALS();
```

## Public/External Functions

### deployTestFramework()

- **Signature**: `deployTestFramework()`
- **Visibility**: external
- **Source Range**: 1440:173:180
- **Details**: [function_deployTestFramework.md](./function_deployTestFramework.md)

**Signature:**
```solidity
/// @notice Deploys the Superfluid Framework (Test)
///  @dev This uses default configurations for the framework.
///  NOTE: ERC1820 must be deployed as a prerequisite before calling this function.
function deployTestFramework() external;
```

### deployWrapperSuperToken(string,string,uint8,uint256,address)

- **Signature**: `deployWrapperSuperToken(string,string,uint8,uint256,address)`
- **Visibility**: external
- **Source Range**: 2165:474:180
- **Details**: [function_deployWrapperSuperToken_string_string_uint8_uint256_address.md](./function_deployWrapperSuperToken_string_string_uint8_uint256_address.md)

**Signature:**
```solidity
/// @notice Deploys an ERC20 and a Wrapper Super Token for the ERC20 and lists both in the resolver
///  @dev SuperToken name and symbol format: `Super ${_underlyingSymbol}` and `${_underlyingSymbol}x`, respectively
///  @param _underlyingName The underlying token name
///  @param _underlyingSymbol The token symbol
///  @param _decimals The token decimals
///  @param _mintLimit The mint limit of the underlying token
///  @param _admin The admin address for the Super Token
///  @return underlyingToken and superToken
function deployWrapperSuperToken(string calldata _underlyingName, string calldata _underlyingSymbol, uint8 _decimals, uint256 _mintLimit, address _admin) external requiresSuperTokenFactory() deploySuperTokenRequires1820() returns (TestToken underlyingToken, SuperToken superToken);
```

### deployNativeAssetSuperToken(string,string)

- **Signature**: `deployNativeAssetSuperToken(string,string)`
- **Visibility**: external
- **Source Range**: 2925:691:180
- **Details**: [function_deployNativeAssetSuperToken_string_string.md](./function_deployNativeAssetSuperToken_string_string.md)

**Signature:**
```solidity
/// @notice Deploys a Native Asset Super Token and lists it in the resolver
///  @dev e.g. ETHx, MATICx, AVAXx, etc. The underlying is the Native Asset.
///  @param _name The token name
///  @param _symbol The super token symbol
///  @return nativeAssetSuperToken
function deployNativeAssetSuperToken(string calldata _name, string calldata _symbol) external requiresSuperTokenFactory() deploySuperTokenRequires1820() returns (ISETH nativeAssetSuperToken);
```

### deployPureSuperToken(string,string,uint256)

- **Signature**: `deployPureSuperToken(string,string,uint256)`
- **Visibility**: external
- **Source Range**: 3991:794:180
- **Details**: [function_deployPureSuperToken_string_string_uint256.md](./function_deployPureSuperToken_string_string_uint256.md)

**Signature:**
```solidity
/// @notice Deploys a Pure Super Token and lists it in the resolver
///  @dev We specify the initial supply (because non-downgradeable) on creation and send it to the deployer
///  @param _name The token name
///  @param _symbol The token symbol
///  @param _initialSupply The initial token supply of the pure super token
///  @return pureSuperToken
function deployPureSuperToken(string calldata _name, string calldata _symbol, uint256 _initialSupply) external requiresSuperTokenFactory() deploySuperTokenRequires1820() returns (IPureSuperToken pureSuperToken);
```

### getFramework() (inherited from SuperfluidFrameworkDeploymentSteps)

- **Signature**: `getFramework()`
- **Visibility**: external
- **Source Range**: 4582:648:181
- **Details**: [function_getFramework.md](./function_getFramework.md)

**Signature:**
```solidity
/// @notice Fetches the framework contracts
function getFramework() external view returns (Framework memory sf);
```

### transferOwnership(address) (inherited from SuperfluidFrameworkDeploymentSteps)

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

### getNumSteps() (inherited from SuperfluidFrameworkDeploymentSteps)

- **Signature**: `getNumSteps()`
- **Visibility**: public
- **Source Range**: 5579:76:181
- **Details**: [function_getNumSteps.md](./function_getNumSteps.md)

**Signature:**
```solidity
function getNumSteps() public pure returns (uint8);
```

### executeStep(uint8) (inherited from SuperfluidFrameworkDeploymentSteps)

- **Signature**: `executeStep(uint8)`
- **Visibility**: public
- **Source Range**: 5661:8777:181
- **Details**: [function_executeStep_uint8.md](./function_executeStep_uint8.md)

**Signature:**
```solidity
function executeStep(uint8 step) public;
```
