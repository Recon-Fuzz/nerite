# Function: deployNativeAssetSuperToken(string,string)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.t.sol/contract_SuperfluidFrameworkDeployer.md]

## Metadata

- **Contract**: SuperfluidFrameworkDeployer
- **Signature**: `deployNativeAssetSuperToken(string,string)`
- **Visibility**: external
- **Source Range**: 2925:691:180

## Implementation

```solidity
/// @notice Deploys a Native Asset Super Token and lists it in the resolver
///  @dev e.g. ETHx, MATICx, AVAXx, etc. The underlying is the Native Asset.
///  @param _name The token name
///  @param _symbol The super token symbol
///  @return nativeAssetSuperToken
function deployNativeAssetSuperToken(string calldata _name, string calldata _symbol) external requiresSuperTokenFactory() deploySuperTokenRequires1820() returns (ISETH nativeAssetSuperToken) {
    SETHProxy sethProxy = TokenDeployerLibrary.deploySETHProxy();
    nativeAssetSuperToken = ISETH(address(sethProxy));
    superTokenFactory.initializeCustomSuperToken(address(sethProxy));
    nativeAssetSuperToken.initialize(IERC20(address(0)), 18, _name, _symbol);
    string memory superTokenKey = string.concat(RESOLVER_BASE_SUPER_TOKEN_KEY, _symbol);
    _handleResolverList(true, superTokenKey, address(nativeAssetSuperToken));
}
```

## Related Implementations

### deploySETHProxy()

- **Kind**: internal
- **Source**: 18180:95:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:TokenDeployerLibrary:deploySETHProxy()`

```solidity
function deploySETHProxy() external returns (SETHProxy) {
    return new SETHProxy();
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
- **ISETH::initialize(contract IERC20,uint8,string,string)**
- **TestResolver::set(string,address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidFrameworkDeployer.deployNativeAssetSuperToken(string,string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TokenDeployerLibrary.deploySETHProxy() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidFrameworkDeployer._handleResolverList(bool,string,address) (NodeID: 2)
  │   💬 Args: [true, superTokenKey, address(nativeAssetSuperToken)]
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

@notice Deploys a Native Asset Super Token and lists it in the resolver
 @dev e.g. ETHx, MATICx, AVAXx, etc. The underlying is the Native Asset.
 @param _name The token name
 @param _symbol The super token symbol
 @return nativeAssetSuperToken
