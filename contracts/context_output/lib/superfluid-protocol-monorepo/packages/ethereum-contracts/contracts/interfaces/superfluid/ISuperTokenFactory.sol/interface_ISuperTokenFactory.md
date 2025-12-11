# Interface: ISuperTokenFactory

## Metadata

- **Name**: ISuperTokenFactory
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperTokenFactory.sol
- **Documentation**:  @title Super token factory interface
   @author Superfluid

## Errors

### SUPER_TOKEN_FACTORY_ALREADY_EXISTS

```solidity
error SUPER_TOKEN_FACTORY_ALREADY_EXISTS();
```

### SUPER_TOKEN_FACTORY_DOES_NOT_EXIST

```solidity
error SUPER_TOKEN_FACTORY_DOES_NOT_EXIST();
```

### SUPER_TOKEN_FACTORY_UNINITIALIZED

```solidity
error SUPER_TOKEN_FACTORY_UNINITIALIZED();
```

### SUPER_TOKEN_FACTORY_ONLY_HOST

```solidity
error SUPER_TOKEN_FACTORY_ONLY_HOST();
```

### SUPER_TOKEN_FACTORY_NON_UPGRADEABLE_IS_DEPRECATED

```solidity
error SUPER_TOKEN_FACTORY_NON_UPGRADEABLE_IS_DEPRECATED();
```

### SUPER_TOKEN_FACTORY_ZERO_ADDRESS

```solidity
error SUPER_TOKEN_FACTORY_ZERO_ADDRESS();
```

## Events

### SuperTokenLogicCreated

```solidity
///  @dev Super token logic created event
///  @param tokenLogic Token logic address
event SuperTokenLogicCreated(ISuperToken indexed tokenLogic);
```

### SuperTokenCreated

```solidity
///  @dev Super token created event
///  @param token Newly created super token address
event SuperTokenCreated(ISuperToken indexed token);
```

### CustomSuperTokenCreated

```solidity
///  @dev Custom super token created event
///  @param token Newly created custom super token address
event CustomSuperTokenCreated(ISuperToken indexed token);
```

## Enums

### Upgradability

```solidity
///  @dev Upgradability modes
enum Upgradability {
    NON_UPGRADABLE,
    SEMI_UPGRADABLE,
    FULL_UPGRADABLE
}
```

## Public/External Functions

### getHost()

- **Signature**: `getHost()`
- **Visibility**: external
- **Source Range**: 1023:55:143

**Signature:**
```solidity
///  @dev Get superfluid host contract address
function getHost() external view returns (address host);;
```

### initialize()

- **Signature**: `initialize()`
- **Visibility**: external
- **Source Range**: 1121:31:143

**Signature:**
```solidity
/// @dev Initialize the contract
function initialize() external;;
```

### getSuperTokenLogic()

- **Signature**: `getSuperTokenLogic()`
- **Visibility**: external
- **Source Range**: 1226:77:143

**Signature:**
```solidity
///  @notice Get the canonical super token logic.
function getSuperTokenLogic() external view returns (ISuperToken superToken);;
```

### createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string,address)

- **Signature**: `createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string,address)`
- **Visibility**: external
- **Source Range**: 2104:288:143

**Signature:**
```solidity
///  @notice Create new super token wrapper for the underlying ERC20 token
///  @param underlyingToken Underlying ERC20 token
///  @param underlyingDecimals Underlying token decimals
///  @param upgradability Upgradability mode
///  @param name Super token name
///  @param symbol Super token symbol
///  @param admin Admin address
///  @return superToken The deployed and initialized wrapper super token
function createERC20Wrapper(IERC20Metadata underlyingToken, uint8 underlyingDecimals, Upgradability upgradability, string calldata name, string calldata symbol, address admin) external returns (ISuperToken superToken);;
```

### createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string)

- **Signature**: `createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string)`
- **Visibility**: external
- **Source Range**: 2801:265:143

**Signature:**
```solidity
///  @notice Create new super token wrapper for the underlying ERC20 token
///  @param underlyingToken Underlying ERC20 token
///  @param underlyingDecimals Underlying token decimals
///  @param upgradability Upgradability mode
///  @param name Super token name
///  @param symbol Super token symbol
///  @return superToken The deployed and initialized wrapper super token
function createERC20Wrapper(IERC20Metadata underlyingToken, uint8 underlyingDecimals, Upgradability upgradability, string calldata name, string calldata symbol) external returns (ISuperToken superToken);;
```

### createERC20Wrapper(contract IERC20Metadata,enum ISuperTokenFactory.Upgradability,string,string,address)

- **Signature**: `createERC20Wrapper(contract IERC20Metadata,enum ISuperTokenFactory.Upgradability,string,string,address)`
- **Visibility**: external
- **Source Range**: 3450:254:143

**Signature:**
```solidity
///  @notice Create new super token wrapper for the underlying ERC20 token
///  @param underlyingToken Underlying ERC20 token
///  @param upgradability Upgradability mode
///  @param name Super token name
///  @param symbol Super token symbol
///  @param admin Admin address
///  @return superToken The deployed and initialized wrapper super token
function createERC20Wrapper(IERC20Metadata underlyingToken, Upgradability upgradability, string calldata name, string calldata symbol, address admin) external returns (ISuperToken superToken);;
```

### createERC20Wrapper(contract IERC20Metadata,enum ISuperTokenFactory.Upgradability,string,string)

- **Signature**: `createERC20Wrapper(contract IERC20Metadata,enum ISuperTokenFactory.Upgradability,string,string)`
- **Visibility**: external
- **Source Range**: 4148:231:143

**Signature:**
```solidity
///  @notice Create new super token wrapper for the underlying ERC20 token with extra token info
///  @param underlyingToken Underlying ERC20 token
///  @param upgradability Upgradability mode
///  @param name Super token name
///  @param symbol Super token symbol
///  @return superToken The deployed and initialized wrapper super token
///  NOTE:
///  - It assumes token provide the .decimals() function
function createERC20Wrapper(IERC20Metadata underlyingToken, Upgradability upgradability, string calldata name, string calldata symbol) external returns (ISuperToken superToken);;
```

### createCanonicalERC20Wrapper(contract IERC20Metadata)

- **Signature**: `createCanonicalERC20Wrapper(contract IERC20Metadata)`
- **Visibility**: external
- **Source Range**: 4708:117:143

**Signature:**
```solidity
///  @notice Creates a wrapper super token AND sets it in the canonical list OR reverts if it already exists
///  @dev salt for create2 is the keccak256 hash of abi.encode(address(_underlyingToken))
///  @param _underlyingToken Underlying ERC20 token
///  @return ISuperToken the created supertoken
function createCanonicalERC20Wrapper(IERC20Metadata _underlyingToken) external returns (ISuperToken);;
```

### computeCanonicalERC20WrapperAddress(address)

- **Signature**: `computeCanonicalERC20WrapperAddress(address)`
- **Visibility**: external
- **Source Range**: 5338:162:143

**Signature:**
```solidity
///  @notice Computes/Retrieves wrapper super token address given the underlying token address
///  @dev We return from our canonical list if it already exists, otherwise we compute it
///  @dev note that this function only computes addresses for SEMI_UPGRADABLE SuperTokens
///  @param _underlyingToken Underlying ERC20 token address
///  @return superTokenAddress Super token address
///  @return isDeployed whether the super token is deployed AND set in the canonical mapping
function computeCanonicalERC20WrapperAddress(address _underlyingToken) external view returns (address superTokenAddress, bool isDeployed);;
```

### getCanonicalERC20Wrapper(address)

- **Signature**: `getCanonicalERC20Wrapper(address)`
- **Visibility**: external
- **Source Range**: 5825:141:143

**Signature:**
```solidity
///  @notice Gets the canonical ERC20 wrapper super token address given the underlying token address
///  @dev We return the address if it exists and the zero address otherwise
///  @param _underlyingTokenAddress Underlying ERC20 token address
///  @return superTokenAddress Super token address
function getCanonicalERC20Wrapper(address _underlyingTokenAddress) external view returns (address superTokenAddress);;
```

### initializeCustomSuperToken(address)

- **Signature**: `initializeCustomSuperToken(address)`
- **Visibility**: external
- **Source Range**: 6108:98:143

**Signature:**
```solidity
///  @dev Creates a new custom super token
///  @param customSuperTokenProxy address of the custom supertoken proxy
function initializeCustomSuperToken(address customSuperTokenProxy) external;;
```
