# Function: deployPureSuperToken(string,string,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.t.sol/contract_SuperfluidFrameworkDeployer.md]

## Metadata

- **Contract**: SuperfluidFrameworkDeployer
- **Signature**: `deployPureSuperToken(string,string,uint256)`
- **Visibility**: external
- **Source Range**: 3991:794:180

## Implementation

```solidity
/// @notice Deploys a Pure Super Token and lists it in the resolver
///  @dev We specify the initial supply (because non-downgradeable) on creation and send it to the deployer
///  @param _name The token name
///  @param _symbol The token symbol
///  @param _initialSupply The initial token supply of the pure super token
///  @return pureSuperToken
function deployPureSuperToken(string calldata _name, string calldata _symbol, uint256 _initialSupply) external requiresSuperTokenFactory() deploySuperTokenRequires1820() returns (IPureSuperToken pureSuperToken) {
    PureSuperToken pureSuperTokenProxy = TokenDeployerLibrary.deployPureSuperToken();
    superTokenFactory.initializeCustomSuperToken(address(pureSuperTokenProxy));
    pureSuperTokenProxy.initialize(_name, _symbol, _initialSupply);
    pureSuperToken = IPureSuperToken(address(pureSuperTokenProxy));
    _handleResolverList(true, string.concat(RESOLVER_BASE_SUPER_TOKEN_KEY, _symbol), address(pureSuperToken));
    pureSuperToken.transfer(msg.sender, _initialSupply);
}
```

## Related Implementations

### deployPureSuperToken()

- **Kind**: internal
- **Source**: 18281:110:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:TokenDeployerLibrary:deployPureSuperToken()`

```solidity
function deployPureSuperToken() external returns (PureSuperToken) {
    return new PureSuperToken();
}
```

### _handleResolverList(bool,string,address)

- **Kind**: internal
- **Source**: 4791:350:180
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.t.sol:SuperfluidFrameworkDeployer:_handleResolverList(bool,string,address)`

```solidity
function _handleResolverList(bool _listOnResolver, string memory _resolverKey, address _superTokenAddress) internal {
    if (address(testResolver) == address(0)) revert RESOLVER_LIST_REQUIRES_DEPLOY_PERIPHERALS();
    if (_listOnResolver) {
        testResolver.set(_resolverKey, address(_superTokenAddress));
    }
}
```

### deploySuperTokenRequires1820()

- **Kind**: modifier
- **Source**: 6741:133:180
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.t.sol:SuperfluidFrameworkDeployer:deploySuperTokenRequires1820()`

```solidity
modifier deploySuperTokenRequires1820() {
    if (!_is1820Deployed()) revert DEPLOY_SUPER_TOKEN_REQUIRES_1820();
    _;
}
```

### _is1820Deployed()

- **Kind**: internal
- **Source**: 14444:228:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidFrameworkDeploymentSteps:_is1820Deployed()`

```solidity
function _is1820Deployed() internal view returns (bool) {
    uint256 codeSize;
    assembly {
        codeSize := extcodesize(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24)
    }
    return codeSize != 0;
}
```

### requiresSuperTokenFactory()

- **Kind**: modifier
- **Source**: 6559:176:180
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.t.sol:SuperfluidFrameworkDeployer:requiresSuperTokenFactory()`

```solidity
modifier requiresSuperTokenFactory() {
    if (address(superTokenFactory) == address(0)) revert DEPLOY_SUPER_TOKEN_REQUIRES_DEPLOY_SUPER_TOKEN_CONTRACTS();
    _;
}
```

## External Calls

- **SuperTokenFactory::initializeCustomSuperToken(address)**
- **PureSuperToken::initialize(string,string,uint256)**
- **IPureSuperToken::transfer(address,uint256)**
- **TestResolver::set(string,address)**

## Native Transfers

- **pureSuperToken** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidFrameworkDeployer.deployPureSuperToken(string,string,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TokenDeployerLibrary.deployPureSuperToken() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidFrameworkDeployer._handleResolverList(bool,string,address) (NodeID: 2)
  │   💬 Args: [true, string.concat(RESOLVER_BASE_SUPER_TOKEN_KEY, _symbol), address(pureSuperToken)]
  │   👁️  Def: internal
  ├─ [1] 🔒 MODIFIER: SuperfluidFrameworkDeployer.deploySuperTokenRequires1820() (NodeID: 3)
  │   💬 Args: [no args]
  │ └─ [2] ⚙️ FUNCTION: SuperfluidFrameworkDeploymentSteps._is1820Deployed() (NodeID: 4)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: SuperfluidFrameworkDeployer.requiresSuperTokenFactory() (NodeID: 5)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@notice Deploys a Pure Super Token and lists it in the resolver
 @dev We specify the initial supply (because non-downgradeable) on creation and send it to the deployer
 @param _name The token name
 @param _symbol The token symbol
 @param _initialSupply The initial token supply of the pure super token
 @return pureSuperToken
