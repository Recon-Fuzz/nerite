# Function: deployWrapperSuperToken(string,string,uint8,uint256,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.t.sol/contract_SuperfluidFrameworkDeployer.md]

## Metadata

- **Contract**: SuperfluidFrameworkDeployer
- **Signature**: `deployWrapperSuperToken(string,string,uint8,uint256,address)`
- **Visibility**: external
- **Source Range**: 2165:474:180

## Implementation

```solidity
/// @notice Deploys an ERC20 and a Wrapper Super Token for the ERC20 and lists both in the resolver
///  @dev SuperToken name and symbol format: `Super ${_underlyingSymbol}` and `${_underlyingSymbol}x`, respectively
///  @param _underlyingName The underlying token name
///  @param _underlyingSymbol The token symbol
///  @param _decimals The token decimals
///  @param _mintLimit The mint limit of the underlying token
///  @param _admin The admin address for the Super Token
///  @return underlyingToken and superToken
function deployWrapperSuperToken(string calldata _underlyingName, string calldata _underlyingSymbol, uint8 _decimals, uint256 _mintLimit, address _admin) external requiresSuperTokenFactory() deploySuperTokenRequires1820() returns (TestToken underlyingToken, SuperToken superToken) {
    return _deployWrapperSuperToken(_underlyingName, _underlyingSymbol, _decimals, _mintLimit, _admin);
}
```

## Related Implementations

### _deployWrapperSuperToken(string,string,uint8,uint256,address)

- **Kind**: internal
- **Source**: 5147:1406:180
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.t.sol:SuperfluidFrameworkDeployer:_deployWrapperSuperToken(string,string,uint8,uint256,address)`

```solidity
function _deployWrapperSuperToken(string calldata _underlyingName, string calldata _underlyingSymbol, uint8 _decimals, uint256 _mintLimit, address _admin) internal returns (TestToken underlyingToken, SuperToken superToken) {
    underlyingToken = TokenDeployerLibrary.deployTestToken(_underlyingName, _underlyingSymbol, _decimals, _mintLimit);
    string memory superTokenSymbol = string.concat(_underlyingSymbol, "x");
    superToken = SuperToken(address(superTokenFactory.createERC20Wrapper(IERC20Metadata(address(underlyingToken)), underlyingToken.decimals(), ISuperTokenFactory.Upgradability.SEMI_UPGRADABLE, string.concat("Super ", _underlyingSymbol), superTokenSymbol, _admin)));
    string memory underlyingTokenKey = string.concat(RESOLVER_BASE_TOKEN_KEY, underlyingToken.symbol());
    _handleResolverList(true, underlyingTokenKey, address(underlyingToken));
    string memory superTokenKey = string.concat(RESOLVER_BASE_SUPER_TOKEN_KEY, superToken.symbol());
    _handleResolverList(true, superTokenKey, address(superToken));
}
```

### deployTestToken(string,string,uint8,uint256)

- **Kind**: internal
- **Source**: 17881:293:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:TokenDeployerLibrary:deployTestToken(string,string,uint8,uint256)`

```solidity
function deployTestToken(string calldata _underlyingName, string calldata _underlyingSymbol, uint8 _decimals, uint256 _mintLimit) external returns (TestToken) {
    return new TestToken(_underlyingName, _underlyingSymbol, _decimals, _mintLimit);
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

- **SuperTokenFactory::createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string,address)**
- **TestToken::decimals()**
- **TestToken::symbol()**
- **SuperToken::symbol()**
- **TestResolver::set(string,address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidFrameworkDeployer.deployWrapperSuperToken(string,string,uint8,uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidFrameworkDeployer._deployWrapperSuperToken(string,string,uint8,uint256,address) (NodeID: 1)
  │   💬 Args: [_underlyingName, _underlyingSymbol, _decimals, _mintLimit, _admin]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TokenDeployerLibrary.deployTestToken(string,string,uint8,uint256) (NodeID: 2)
  │ │   💬 Args: [_underlyingName, _underlyingSymbol, _decimals, _mintLimit]
  │ │   👁️  Def: external
  │ ├─ [2] ⚙️ FUNCTION: SuperfluidFrameworkDeployer._handleResolverList(bool,string,address) (NodeID: 3)
  │ │   💬 Args: [true, underlyingTokenKey, address(underlyingToken)]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperfluidFrameworkDeployer._handleResolverList(bool,string,address) (NodeID: 4)
  │     💬 Args: [true, superTokenKey, address(superToken)]
  │     👁️  Def: internal
  ├─ [1] 🔒 MODIFIER: SuperfluidFrameworkDeployer.deploySuperTokenRequires1820() (NodeID: 5)
  │   💬 Args: [no args]
  │ └─ [2] ⚙️ FUNCTION: SuperfluidFrameworkDeploymentSteps._is1820Deployed() (NodeID: 6)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: SuperfluidFrameworkDeployer.requiresSuperTokenFactory() (NodeID: 7)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@notice Deploys an ERC20 and a Wrapper Super Token for the ERC20 and lists both in the resolver
 @dev SuperToken name and symbol format: `Super ${_underlyingSymbol}` and `${_underlyingSymbol}x`, respectively
 @param _underlyingName The underlying token name
 @param _underlyingSymbol The token symbol
 @param _decimals The token decimals
 @param _mintLimit The mint limit of the underlying token
 @param _admin The admin address for the Super Token
 @return underlyingToken and superToken
