# Function: createERC20Wrapper(contract IERC20Metadata,enum ISuperTokenFactory.Upgradability,string,string)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

## Metadata

- **Contract**: SuperTokenFactory
- **Signature**: `createERC20Wrapper(contract IERC20Metadata,enum ISuperTokenFactory.Upgradability,string,string)`
- **Visibility**: external
- **Source Range**: 11400:454:162
- **Inherited From**: SuperTokenFactoryBase

## Implementation

```solidity
/// @inheritdoc ISuperTokenFactory
function createERC20Wrapper(IERC20Metadata underlyingToken, Upgradability upgradability, string calldata name, string calldata symbol) override external returns (ISuperToken superToken) {
    return createERC20Wrapper(underlyingToken, underlyingToken.decimals(), upgradability, name, symbol, address(0));
}
```

## Related Implementations

### createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string,address)

- **Kind**: internal
- **Source**: 9007:1306:162
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol:SuperTokenFactoryBase:createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string,address)`

```solidity
function createERC20Wrapper(IERC20Metadata underlyingToken, uint8 underlyingDecimals, Upgradability upgradability, string calldata name, string calldata symbol, address admin) override public returns (ISuperToken superToken) {
    if (address(underlyingToken) == address(0)) {
        revert SUPER_TOKEN_FACTORY_ZERO_ADDRESS();
    }
    if (upgradability == Upgradability.NON_UPGRADABLE) {
        revert SUPER_TOKEN_FACTORY_NON_UPGRADEABLE_IS_DEPRECATED();
    } else if (upgradability == Upgradability.SEMI_UPGRADABLE) {
        UUPSProxy proxy = new UUPSProxy();
        proxy.initializeProxy(address(_SUPER_TOKEN_LOGIC));
        superToken = ISuperToken(address(proxy));
    } else {
        FullUpgradableSuperTokenProxy proxy = new FullUpgradableSuperTokenProxy();
        proxy.initialize();
        superToken = ISuperToken(address(proxy));
    }
    superToken.initializeWithAdmin(underlyingToken, underlyingDecimals, name, symbol, admin);
    emit SuperTokenCreated(superToken);
}
```

## External Calls

- **IERC20Metadata::decimals()**
- **UUPSProxy::initializeProxy(address)**
- **FullUpgradableSuperTokenProxy::initialize()**
- **ISuperToken::initializeWithAdmin(contract IERC20,uint8,string,string,address)**

## State Variable Reads

- **_SUPER_TOKEN_LOGIC** (`contract ISuperToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperTokenFactoryBase.createERC20Wrapper(contract IERC20Metadata,enum ISuperTokenFactory.Upgradability,string,string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperTokenFactoryBase.createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string,address) (NodeID: 1)
      💬 Args: [underlyingToken, underlyingToken.decimals(), upgradability, name, symbol, address(0)]
      👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc ISuperTokenFactory

### Interface Documentation

 @notice Create new super token wrapper for the underlying ERC20 token with extra token info
 @param underlyingToken Underlying ERC20 token
 @param upgradability Upgradability mode
 @param name Super token name
 @param symbol Super token symbol
 @return superToken The deployed and initialized wrapper super token
 NOTE:
 - It assumes token provide the .decimals() function
