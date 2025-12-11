# Contract: SuperTokenFactory

## Metadata

- **Name**: SuperTokenFactory
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol

## Implements Interfaces

- **ISuperTokenFactory** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperTokenFactory.sol/interface_ISuperTokenFactory.md]

## State Variables

### _initialized (inherited from Initializable)

```solidity
///  @dev Indicates that the contract has been initialized.
///  @custom:oz-retyped-from bool
uint8 private _initialized
```

### _initializing (inherited from Initializable)

```solidity
///  @dev Indicates that the contract is in the process of being initialized.
bool private _initializing
```

### _SUPER_TOKEN_LOGIC (inherited from SuperTokenFactoryBase)

```solidity
ISuperToken public immutable _SUPER_TOKEN_LOGIC
```

**ISuperToken**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

### _host (inherited from SuperTokenFactoryBase)

```solidity
ISuperfluid internal immutable _host
```

**ISuperfluid**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

### CONSTANT_OUTFLOW_NFT_LOGIC (inherited from SuperTokenFactoryBase)

```solidity
IConstantOutflowNFT public immutable CONSTANT_OUTFLOW_NFT_LOGIC
```

**IConstantOutflowNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/interface_IConstantOutflowNFT.md]

### CONSTANT_INFLOW_NFT_LOGIC (inherited from SuperTokenFactoryBase)

```solidity
IConstantInflowNFT public immutable CONSTANT_INFLOW_NFT_LOGIC
```

**IConstantInflowNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/interface_IConstantInflowNFT.md]

### POOL_ADMIN_NFT_LOGIC (inherited from SuperTokenFactoryBase)

```solidity
IPoolAdminNFT public immutable POOL_ADMIN_NFT_LOGIC
```

**IPoolAdminNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolAdminNFT.sol/interface_IPoolAdminNFT.md]

### POOL_MEMBER_NFT_LOGIC (inherited from SuperTokenFactoryBase)

```solidity
IPoolMemberNFT public immutable POOL_MEMBER_NFT_LOGIC
```

**IPoolMemberNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolMemberNFT.sol/interface_IPoolMemberNFT.md]

### _superTokenLogicDeprecated (inherited from SuperTokenFactoryBase)

```solidity
ISuperToken internal _superTokenLogicDeprecated
```

**ISuperToken**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

### _canonicalWrapperSuperTokens (inherited from SuperTokenFactoryBase)

```solidity
/// @notice A mapping from underlying token addresses to canonical wrapper super token addresses
///  @dev Reasoning: (1) provide backwards compatibility for existing listed wrapper super tokens
///  @dev (2) prevent address retrieval issues if we ever choose to modify the bytecode of the UUPSProxy contract
///  @dev NOTE: address(0) key points to the NativeAssetSuperToken on the network.
mapping(address => address) internal _canonicalWrapperSuperTokens
```

## Structs

### InitializeData (inherited from SuperTokenFactoryBase)

```solidity
struct InitializeData {
    address underlyingToken;
    address superToken;
}
```

## Errors

### SUPER_TOKEN_FACTORY_ALREADY_EXISTS (inherited from ISuperTokenFactory)

```solidity
error SUPER_TOKEN_FACTORY_ALREADY_EXISTS();
```

### SUPER_TOKEN_FACTORY_DOES_NOT_EXIST (inherited from ISuperTokenFactory)

```solidity
error SUPER_TOKEN_FACTORY_DOES_NOT_EXIST();
```

### SUPER_TOKEN_FACTORY_UNINITIALIZED (inherited from ISuperTokenFactory)

```solidity
error SUPER_TOKEN_FACTORY_UNINITIALIZED();
```

### SUPER_TOKEN_FACTORY_ONLY_HOST (inherited from ISuperTokenFactory)

```solidity
error SUPER_TOKEN_FACTORY_ONLY_HOST();
```

### SUPER_TOKEN_FACTORY_NON_UPGRADEABLE_IS_DEPRECATED (inherited from ISuperTokenFactory)

```solidity
error SUPER_TOKEN_FACTORY_NON_UPGRADEABLE_IS_DEPRECATED();
```

### SUPER_TOKEN_FACTORY_ZERO_ADDRESS (inherited from ISuperTokenFactory)

```solidity
error SUPER_TOKEN_FACTORY_ZERO_ADDRESS();
```

### SUPER_TOKEN_FACTORY_ONLY_GOVERNANCE_OWNER (inherited from SuperTokenFactoryBase)

```solidity
/// NOTE: Whenever modifying the storage layout here it is important to update the validateStorageLayout
///  function in its respective mock contract to ensure that it doesn't break anything or lead to unexpected
///  behaviors/layout when upgrading
error SUPER_TOKEN_FACTORY_ONLY_GOVERNANCE_OWNER();
```

## Events

### Initialized (inherited from Initializable)

```solidity
///  @dev Triggered when the contract has been initialized or reinitialized.
event Initialized(uint8 version);
```

### CodeUpdated (inherited from UUPSProxiable)

```solidity
event CodeUpdated(bytes32 uuid, address codeAddress);
```

### SuperTokenLogicCreated (inherited from ISuperTokenFactory)

```solidity
///  @dev Super token logic created event
///  @param tokenLogic Token logic address
event SuperTokenLogicCreated(ISuperToken indexed tokenLogic);
```

### SuperTokenCreated (inherited from ISuperTokenFactory)

```solidity
///  @dev Super token created event
///  @param token Newly created super token address
event SuperTokenCreated(ISuperToken indexed token);
```

### CustomSuperTokenCreated (inherited from ISuperTokenFactory)

```solidity
///  @dev Custom super token created event
///  @param token Newly created custom super token address
event CustomSuperTokenCreated(ISuperToken indexed token);
```

## Enums

### Upgradability (inherited from ISuperTokenFactory)

```solidity
///  @dev Upgradability modes
enum Upgradability {
    NON_UPGRADABLE,
    SEMI_UPGRADABLE,
    FULL_UPGRADABLE
}
```

## Public/External Functions

### constructor(contract ISuperfluid,contract ISuperToken,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT)

- **Signature**: `constructor(contract ISuperfluid,contract ISuperToken,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT)`
- **Visibility**: public
- **Source Range**: 15074:547:162
- **Details**: [function_constructor_contract_ISuperfluid_contract_ISuperToken_contract_IConstantOutflowNFT_contract_IConstantInflowNFT_contract_IPoolAdminNFT_contract_IPoolMemberNFT.md](./function_constructor_contract_ISuperfluid_contract_ISuperToken_contract_IConstantOutflowNFT_contract_IConstantInflowNFT_contract_IPoolAdminNFT_contract_IPoolMemberNFT.md)

**Signature:**
```solidity
constructor(ISuperfluid host, ISuperToken superTokenLogic, IConstantOutflowNFT constantOutflowNFTLogic, IConstantInflowNFT constantInflowNFTLogic, IPoolAdminNFT poolAdminNFTLogic, IPoolMemberNFT poolMemberNFTLogic) SuperTokenFactoryBase(host,superTokenLogic,constantOutflowNFTLogic,constantInflowNFTLogic,poolAdminNFTLogic,poolMemberNFTLogic);
```

### getCodeAddress() (inherited from UUPSProxiable)

- **Signature**: `getCodeAddress()`
- **Visibility**: public
- **Source Range**: 401:122:169
- **Details**: [function_getCodeAddress.md](./function_getCodeAddress.md)

**Signature:**
```solidity
///  @dev Get current implementation code address.
function getCodeAddress() public view returns (address codeAddress);
```

### castrate() (inherited from UUPSProxiable)

- **Signature**: `castrate()`
- **Visibility**: external
- **Source Range**: 694:44:169
- **Details**: [function_castrate.md](./function_castrate.md)

**Signature:**
```solidity
function castrate() external initializer();
```

### getHost() (inherited from SuperTokenFactoryBase)

- **Signature**: `getHost()`
- **Visibility**: external
- **Source Range**: 4558:146:162
- **Details**: [function_getHost.md](./function_getHost.md)

**Signature:**
```solidity
/// @inheritdoc ISuperTokenFactory
function getHost() override(ISuperTokenFactory) external view returns (address host);
```

### initialize() (inherited from SuperTokenFactoryBase)

- **Signature**: `initialize()`
- **Visibility**: external
- **Source Range**: 4929:167:162
- **Details**: [function_initialize.md](./function_initialize.md)

**Signature:**
```solidity
/// @inheritdoc ISuperTokenFactory
function initialize() override external initializer();
```

### proxiableUUID() (inherited from SuperTokenFactoryBase)

- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 5102:166:162
- **Details**: [function_proxiableUUID.md](./function_proxiableUUID.md)

**Signature:**
```solidity
function proxiableUUID() override public pure returns (bytes32);
```

### updateCode(address) (inherited from SuperTokenFactoryBase)

- **Signature**: `updateCode(address)`
- **Visibility**: external
- **Source Range**: 5505:1032:162
- **Details**: [function_updateCode_address.md](./function_updateCode_address.md)

**Signature:**
```solidity
/// @notice Updates the logic contract for the SuperTokenFactory
///  @dev This function updates the logic contract for the SuperTokenFactory
///  @param newAddress the new address of the SuperTokenFactory logic contract
function updateCode(address newAddress) override external;
```

### getSuperTokenLogic() (inherited from SuperTokenFactoryBase)

- **Signature**: `getSuperTokenLogic()`
- **Visibility**: external
- **Source Range**: 6767:137:162
- **Details**: [function_getSuperTokenLogic.md](./function_getSuperTokenLogic.md)

**Signature:**
```solidity
/// @inheritdoc ISuperTokenFactory
function getSuperTokenLogic() override external view returns (ISuperToken);
```

### createCanonicalERC20Wrapper(contract IERC20Metadata) (inherited from SuperTokenFactoryBase)

- **Signature**: `createCanonicalERC20Wrapper(contract IERC20Metadata)`
- **Visibility**: external
- **Source Range**: 6949:2052:162
- **Details**: [function_createCanonicalERC20Wrapper_contract_IERC20Metadata.md](./function_createCanonicalERC20Wrapper_contract_IERC20Metadata.md)

**Signature:**
```solidity
/// @inheritdoc ISuperTokenFactory
function createCanonicalERC20Wrapper(IERC20Metadata _underlyingToken) external returns (ISuperToken);
```

### createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string,address) (inherited from SuperTokenFactoryBase)

- **Signature**: `createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string,address)`
- **Visibility**: public
- **Source Range**: 9007:1306:162
- **Details**: [function_createERC20Wrapper_contract_IERC20Metadata_uint8_enum_ISuperTokenFactory_Upgradability_string_string_address.md](./function_createERC20Wrapper_contract_IERC20Metadata_uint8_enum_ISuperTokenFactory_Upgradability_string_string_address.md)

**Signature:**
```solidity
function createERC20Wrapper(IERC20Metadata underlyingToken, uint8 underlyingDecimals, Upgradability upgradability, string calldata name, string calldata symbol, address admin) override public returns (ISuperToken superToken);
```

### createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string) (inherited from SuperTokenFactoryBase)

- **Signature**: `createERC20Wrapper(contract IERC20Metadata,uint8,enum ISuperTokenFactory.Upgradability,string,string)`
- **Visibility**: external
- **Source Range**: 10358:480:162
- **Details**: [function_createERC20Wrapper_contract_IERC20Metadata_uint8_enum_ISuperTokenFactory_Upgradability_string_string.md](./function_createERC20Wrapper_contract_IERC20Metadata_uint8_enum_ISuperTokenFactory_Upgradability_string_string.md)

**Signature:**
```solidity
/// @inheritdoc ISuperTokenFactory
function createERC20Wrapper(IERC20Metadata underlyingToken, uint8 underlyingDecimals, Upgradability upgradability, string calldata name, string calldata symbol) override external returns (ISuperToken superToken);
```

### createERC20Wrapper(contract IERC20Metadata,enum ISuperTokenFactory.Upgradability,string,string,address) (inherited from SuperTokenFactoryBase)

- **Signature**: `createERC20Wrapper(contract IERC20Metadata,enum ISuperTokenFactory.Upgradability,string,string,address)`
- **Visibility**: external
- **Source Range**: 10883:472:162
- **Details**: [function_createERC20Wrapper_contract_IERC20Metadata_enum_ISuperTokenFactory_Upgradability_string_string_address.md](./function_createERC20Wrapper_contract_IERC20Metadata_enum_ISuperTokenFactory_Upgradability_string_string_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperTokenFactory
function createERC20Wrapper(IERC20Metadata underlyingToken, Upgradability upgradability, string calldata name, string calldata symbol, address admin) override external returns (ISuperToken superToken);
```

### createERC20Wrapper(contract IERC20Metadata,enum ISuperTokenFactory.Upgradability,string,string) (inherited from SuperTokenFactoryBase)

- **Signature**: `createERC20Wrapper(contract IERC20Metadata,enum ISuperTokenFactory.Upgradability,string,string)`
- **Visibility**: external
- **Source Range**: 11400:454:162
- **Details**: [function_createERC20Wrapper_contract_IERC20Metadata_enum_ISuperTokenFactory_Upgradability_string_string.md](./function_createERC20Wrapper_contract_IERC20Metadata_enum_ISuperTokenFactory_Upgradability_string_string.md)

**Signature:**
```solidity
/// @inheritdoc ISuperTokenFactory
function createERC20Wrapper(IERC20Metadata underlyingToken, Upgradability upgradability, string calldata name, string calldata symbol) override external returns (ISuperToken superToken);
```

### initializeCustomSuperToken(address) (inherited from SuperTokenFactoryBase)

- **Signature**: `initializeCustomSuperToken(address)`
- **Visibility**: external
- **Source Range**: 11899:454:162
- **Details**: [function_initializeCustomSuperToken_address.md](./function_initializeCustomSuperToken_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperTokenFactory
function initializeCustomSuperToken(address customSuperTokenProxy) override external;
```

### computeCanonicalERC20WrapperAddress(address) (inherited from SuperTokenFactoryBase)

- **Signature**: `computeCanonicalERC20WrapperAddress(address)`
- **Visibility**: external
- **Source Range**: 12398:1033:162
- **Details**: [function_computeCanonicalERC20WrapperAddress_address.md](./function_computeCanonicalERC20WrapperAddress_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperTokenFactory
function computeCanonicalERC20WrapperAddress(address _underlyingToken) external view returns (address superTokenAddress, bool isDeployed);
```

### getCanonicalERC20Wrapper(address) (inherited from SuperTokenFactoryBase)

- **Signature**: `getCanonicalERC20Wrapper(address)`
- **Visibility**: external
- **Source Range**: 13476:257:162
- **Details**: [function_getCanonicalERC20Wrapper_address.md](./function_getCanonicalERC20Wrapper_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperTokenFactory
function getCanonicalERC20Wrapper(address _underlyingTokenAddress) external view returns (address superTokenAddress);
```

### initializeCanonicalWrapperSuperTokens(struct SuperTokenFactoryBase.InitializeData[]) (inherited from SuperTokenFactoryBase)

- **Signature**: `initializeCanonicalWrapperSuperTokens(struct SuperTokenFactoryBase.InitializeData[])`
- **Visibility**: external
- **Source Range**: 13988:789:162
- **Details**: [function_initializeCanonicalWrapperSuperTokens_struct_SuperTokenFactoryBase_InitializeData[].md](./function_initializeCanonicalWrapperSuperTokens_struct_SuperTokenFactoryBase_InitializeData[].md)

**Signature:**
```solidity
/// @notice Initializes list of canonical wrapper super tokens.
///  @dev Note that this should also be kind of a throwaway function which will be executed only once.
///  @param _data an array of canonical wrappper super tokens to be set
function initializeCanonicalWrapperSuperTokens(InitializeData[] calldata _data) virtual external;
```
