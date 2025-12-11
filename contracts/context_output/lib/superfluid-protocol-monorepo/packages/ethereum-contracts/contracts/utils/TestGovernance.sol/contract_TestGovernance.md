# Contract: TestGovernance

## Metadata

- **Name**: TestGovernance
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol
- **Documentation**:  @title Test governance contract
   @author Superfluid
   @dev A initializable version of the governance for testing purpose

## Implements Interfaces

- **ISuperfluidGovernance** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol/interface_ISuperfluidGovernance.md]

## State Variables

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### _configs (inherited from SuperfluidGovernanceBase)

```solidity
mapping(address => mapping(address => mapping(bytes32 => Value))) internal _configs
```

### _host

```solidity
ISuperfluid private _host
```

**ISuperfluid**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Structs

### Value (inherited from SuperfluidGovernanceBase)

```solidity
struct Value {
    bool set;
    uint256 value;
}
```

## Errors

### SF_GOV_INVALID_LIQUIDATION_OR_PATRICIAN_PERIOD (inherited from ISuperfluidGovernance)

```solidity
error SF_GOV_INVALID_LIQUIDATION_OR_PATRICIAN_PERIOD();
```

### SF_GOV_MUST_BE_CONTRACT (inherited from ISuperfluidGovernance)

```solidity
error SF_GOV_MUST_BE_CONTRACT();
```

## Events

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

### ConfigChanged (inherited from SuperfluidGovernanceBase)

```solidity
event ConfigChanged(ISuperfluid indexed host, ISuperfluidToken indexed superToken, bytes32 key, bool isKeySet, uint256 value);
```

### RewardAddressChanged (inherited from SuperfluidGovernanceBase)

```solidity
event RewardAddressChanged(ISuperfluid indexed host, ISuperfluidToken indexed superToken, bool isKeySet, address rewardAddress);
```

### CFAv1LiquidationPeriodChanged (inherited from SuperfluidGovernanceBase)

```solidity
event CFAv1LiquidationPeriodChanged(ISuperfluid indexed host, ISuperfluidToken indexed superToken, bool isKeySet, uint256 liquidationPeriod);
```

### PPPConfigurationChanged (inherited from SuperfluidGovernanceBase)

```solidity
event PPPConfigurationChanged(ISuperfluid indexed host, ISuperfluidToken indexed superToken, bool isKeySet, uint256 liquidationPeriod, uint256 patricianPeriod);
```

### SuperTokenMinimumDepositChanged (inherited from SuperfluidGovernanceBase)

```solidity
event SuperTokenMinimumDepositChanged(ISuperfluid indexed host, ISuperfluidToken indexed superToken, bool isKeySet, uint256 minimumDeposit);
```

### TrustedForwarderChanged (inherited from SuperfluidGovernanceBase)

```solidity
event TrustedForwarderChanged(ISuperfluid indexed host, ISuperfluidToken indexed superToken, bool isKeySet, address forwarder, bool enabled);
```

### AppRegistrationKeyChanged (inherited from SuperfluidGovernanceBase)

```solidity
event AppRegistrationKeyChanged(ISuperfluid indexed host, address indexed deployer, string appRegistrationKey, uint256 expirationTs);
```

### AppFactoryAuthorizationChanged (inherited from SuperfluidGovernanceBase)

```solidity
event AppFactoryAuthorizationChanged(ISuperfluid indexed host, address indexed factory, bool authorized);
```

## Public/External Functions

### initialize(contract ISuperfluid,address,uint256,uint256,address[])

- **Signature**: `initialize(contract ISuperfluid,address,uint256,uint256,address[])`
- **Visibility**: external
- **Source Range**: 552:717:184
- **Details**: [function_initialize_contract_ISuperfluid_address_uint256_uint256_address[].md](./function_initialize_contract_ISuperfluid_address_uint256_uint256_address[].md)

**Signature:**
```solidity
function initialize(ISuperfluid host, address rewardAddress, uint256 liquidationPeriod, uint256 patricianPeriod, address[] calldata trustedForwarders) external;
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1201:85:71
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address);
```

### renounceOwnership() (inherited from Ownable)

- **Signature**: `renounceOwnership()`
- **Visibility**: public
- **Source Range**: 1824:101:71
- **Details**: [function_renounceOwnership.md](./function_renounceOwnership.md)

**Signature:**
```solidity
///  @dev Leaves the contract without owner. It will not be possible to call
///  `onlyOwner` functions. Can only be called by the current owner.
///  NOTE: Renouncing ownership will leave the contract without an owner,
///  thereby disabling any functionality that is only available to the owner.
function renounceOwnership() virtual public onlyOwner();
```

### transferOwnership(address) (inherited from Ownable)

- **Signature**: `transferOwnership(address)`
- **Visibility**: public
- **Source Range**: 2074:198:71
- **Details**: [function_transferOwnership_address.md](./function_transferOwnership_address.md)

**Signature:**
```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`).
///  Can only be called by the current owner.
function transferOwnership(address newOwner) virtual public onlyOwner();
```

### replaceGovernance(contract ISuperfluid,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `replaceGovernance(contract ISuperfluid,address)`
- **Visibility**: external
- **Source Range**: 1397:212:130
- **Details**: [function_replaceGovernance_contract_ISuperfluid_address.md](./function_replaceGovernance_contract_ISuperfluid_address.md)

**Signature:**
```solidity
/// NOTE: Whenever modifying the storage layout here it is important to update the validateStorageLayout
///  function in its respective mock contract to ensure that it doesn't break anything or lead to unexpected
///  behaviors/layout when upgrading
function replaceGovernance(ISuperfluid host, address newGov) override external onlyAuthorized(host);
```

### registerAgreementClass(contract ISuperfluid,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `registerAgreementClass(contract ISuperfluid,address)`
- **Visibility**: external
- **Source Range**: 1615:232:130
- **Details**: [function_registerAgreementClass_contract_ISuperfluid_address.md](./function_registerAgreementClass_contract_ISuperfluid_address.md)

**Signature:**
```solidity
function registerAgreementClass(ISuperfluid host, address agreementClass) override external onlyAuthorized(host);
```

### updateContracts(contract ISuperfluid,address,address[],address,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `updateContracts(contract ISuperfluid,address,address[],address,address)`
- **Visibility**: external
- **Source Range**: 1853:1344:130
- **Details**: [function_updateContracts_contract_ISuperfluid_address_address[]_address_address.md](./function_updateContracts_contract_ISuperfluid_address_address[]_address_address.md)

**Signature:**
```solidity
function updateContracts(ISuperfluid host, address hostNewLogic, address[] calldata agreementClassNewLogics, address superTokenFactoryNewLogic, address poolBeaconNewLogic) override external onlyAuthorized(host);
```

### batchUpdateSuperTokenLogic(contract ISuperfluid,contract ISuperToken[]) (inherited from SuperfluidGovernanceBase)

- **Signature**: `batchUpdateSuperTokenLogic(contract ISuperfluid,contract ISuperToken[])`
- **Visibility**: external
- **Source Range**: 3203:297:130
- **Details**: [function_batchUpdateSuperTokenLogic_contract_ISuperfluid_contract_ISuperToken[].md](./function_batchUpdateSuperTokenLogic_contract_ISuperfluid_contract_ISuperToken[].md)

**Signature:**
```solidity
function batchUpdateSuperTokenLogic(ISuperfluid host, ISuperToken[] calldata tokens) override external onlyAuthorized(host);
```

### batchUpdateSuperTokenLogic(contract ISuperfluid,contract ISuperToken[],address[]) (inherited from SuperfluidGovernanceBase)

- **Signature**: `batchUpdateSuperTokenLogic(contract ISuperfluid,contract ISuperToken[],address[])`
- **Visibility**: external
- **Source Range**: 3506:394:130
- **Details**: [function_batchUpdateSuperTokenLogic_contract_ISuperfluid_contract_ISuperToken[]_address[].md](./function_batchUpdateSuperTokenLogic_contract_ISuperfluid_contract_ISuperToken[]_address[].md)

**Signature:**
```solidity
function batchUpdateSuperTokenLogic(ISuperfluid host, ISuperToken[] calldata tokens, address[] calldata tokenLogics) override external onlyAuthorized(host);
```

### batchUpdateSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperToken[],uint256[]) (inherited from SuperfluidGovernanceBase)

- **Signature**: `batchUpdateSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperToken[],uint256[])`
- **Visibility**: external
- **Source Range**: 3906:443:130
- **Details**: [function_batchUpdateSuperTokenMinimumDeposit_contract_ISuperfluid_contract_ISuperToken[]_uint256[].md](./function_batchUpdateSuperTokenMinimumDeposit_contract_ISuperfluid_contract_ISuperToken[]_uint256[].md)

**Signature:**
```solidity
function batchUpdateSuperTokenMinimumDeposit(ISuperfluid host, ISuperToken[] calldata tokens, uint256[] calldata minimumDeposits) external;
```

### changeSuperTokenAdmin(contract ISuperfluid,contract ISuperToken,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `changeSuperTokenAdmin(contract ISuperfluid,contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 4355:196:130
- **Details**: [function_changeSuperTokenAdmin_contract_ISuperfluid_contract_ISuperToken_address.md](./function_changeSuperTokenAdmin_contract_ISuperfluid_contract_ISuperToken_address.md)

**Signature:**
```solidity
function changeSuperTokenAdmin(ISuperfluid host, ISuperToken token, address newAdmin) external onlyAuthorized(host);
```

### batchChangeSuperTokenAdmin(contract ISuperfluid,contract ISuperToken[],address[]) (inherited from SuperfluidGovernanceBase)

- **Signature**: `batchChangeSuperTokenAdmin(contract ISuperfluid,contract ISuperToken[],address[])`
- **Visibility**: external
- **Source Range**: 4557:345:130
- **Details**: [function_batchChangeSuperTokenAdmin_contract_ISuperfluid_contract_ISuperToken[]_address[].md](./function_batchChangeSuperTokenAdmin_contract_ISuperfluid_contract_ISuperToken[]_address[].md)

**Signature:**
```solidity
function batchChangeSuperTokenAdmin(ISuperfluid host, ISuperToken[] calldata token, address[] calldata newAdmins) external onlyAuthorized(host);
```

### setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,address)`
- **Visibility**: external
- **Source Range**: 5075:219:130
- **Details**: [function_setConfig_contract_ISuperfluid_contract_ISuperfluidToken_bytes32_address.md](./function_setConfig_contract_ISuperfluid_contract_ISuperfluidToken_bytes32_address.md)

**Signature:**
```solidity
function setConfig(ISuperfluid host, ISuperfluidToken superToken, bytes32 key, address value) override external;
```

### setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256) (inherited from SuperfluidGovernanceBase)

- **Signature**: `setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 5300:219:130
- **Details**: [function_setConfig_contract_ISuperfluid_contract_ISuperfluidToken_bytes32_uint256.md](./function_setConfig_contract_ISuperfluid_contract_ISuperfluidToken_bytes32_uint256.md)

**Signature:**
```solidity
function setConfig(ISuperfluid host, ISuperfluidToken superToken, bytes32 key, uint256 value) override external;
```

### clearConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32) (inherited from SuperfluidGovernanceBase)

- **Signature**: `clearConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32)`
- **Visibility**: external
- **Source Range**: 5525:193:130
- **Details**: [function_clearConfig_contract_ISuperfluid_contract_ISuperfluidToken_bytes32.md](./function_clearConfig_contract_ISuperfluid_contract_ISuperfluidToken_bytes32.md)

**Signature:**
```solidity
function clearConfig(ISuperfluid host, ISuperfluidToken superToken, bytes32 key) override external;
```

### getConfigAsAddress(contract ISuperfluid,contract ISuperfluidToken,bytes32) (inherited from SuperfluidGovernanceBase)

- **Signature**: `getConfigAsAddress(contract ISuperfluid,contract ISuperfluidToken,bytes32)`
- **Visibility**: public
- **Source Range**: 6753:441:130
- **Details**: [function_getConfigAsAddress_contract_ISuperfluid_contract_ISuperfluidToken_bytes32.md](./function_getConfigAsAddress_contract_ISuperfluid_contract_ISuperfluidToken_bytes32.md)

**Signature:**
```solidity
function getConfigAsAddress(ISuperfluid host, ISuperfluidToken superToken, bytes32 key) override public view returns (address value);
```

### getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32) (inherited from SuperfluidGovernanceBase)

- **Signature**: `getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)`
- **Visibility**: public
- **Source Range**: 7200:424:130
- **Details**: [function_getConfigAsUint256_contract_ISuperfluid_contract_ISuperfluidToken_bytes32.md](./function_getConfigAsUint256_contract_ISuperfluid_contract_ISuperfluidToken_bytes32.md)

**Signature:**
```solidity
function getConfigAsUint256(ISuperfluid host, ISuperfluidToken superToken, bytes32 key) override public view returns (uint256 period);
```

### getRewardAddress(contract ISuperfluid,contract ISuperfluidToken) (inherited from SuperfluidGovernanceBase)

- **Signature**: `getRewardAddress(contract ISuperfluid,contract ISuperfluidToken)`
- **Visibility**: external
- **Source Range**: 8042:298:130
- **Details**: [function_getRewardAddress_contract_ISuperfluid_contract_ISuperfluidToken.md](./function_getRewardAddress_contract_ISuperfluid_contract_ISuperfluidToken.md)

**Signature:**
```solidity
function getRewardAddress(ISuperfluid host, ISuperfluidToken superToken) external view returns (address);
```

### setRewardAddress(contract ISuperfluid,contract ISuperfluidToken,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `setRewardAddress(contract ISuperfluid,contract ISuperfluidToken,address)`
- **Visibility**: public
- **Source Range**: 8346:382:130
- **Details**: [function_setRewardAddress_contract_ISuperfluid_contract_ISuperfluidToken_address.md](./function_setRewardAddress_contract_ISuperfluid_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
function setRewardAddress(ISuperfluid host, ISuperfluidToken superToken, address rewardAddress) public;
```

### clearRewardAddress(contract ISuperfluid,contract ISuperfluidToken) (inherited from SuperfluidGovernanceBase)

- **Signature**: `clearRewardAddress(contract ISuperfluid,contract ISuperfluidToken)`
- **Visibility**: external
- **Source Range**: 8734:328:130
- **Details**: [function_clearRewardAddress_contract_ISuperfluid_contract_ISuperfluidToken.md](./function_clearRewardAddress_contract_ISuperfluid_contract_ISuperfluidToken.md)

**Signature:**
```solidity
function clearRewardAddress(ISuperfluid host, ISuperfluidToken superToken) external;
```

### getPPPConfig(contract ISuperfluid,contract ISuperfluidToken) (inherited from SuperfluidGovernanceBase)

- **Signature**: `getPPPConfig(contract ISuperfluid,contract ISuperfluidToken)`
- **Visibility**: external
- **Source Range**: 9596:458:130
- **Details**: [function_getPPPConfig_contract_ISuperfluid_contract_ISuperfluidToken.md](./function_getPPPConfig_contract_ISuperfluid_contract_ISuperfluidToken.md)

**Signature:**
```solidity
function getPPPConfig(ISuperfluid host, ISuperfluidToken superToken) external view returns (uint256 liquidationPeriod, uint256 patricianPeriod);
```

### setPPPConfig(contract ISuperfluid,contract ISuperfluidToken,uint256,uint256) (inherited from SuperfluidGovernanceBase)

- **Signature**: `setPPPConfig(contract ISuperfluid,contract ISuperfluidToken,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 10060:767:130
- **Details**: [function_setPPPConfig_contract_ISuperfluid_contract_ISuperfluidToken_uint256_uint256.md](./function_setPPPConfig_contract_ISuperfluid_contract_ISuperfluidToken_uint256_uint256.md)

**Signature:**
```solidity
function setPPPConfig(ISuperfluid host, ISuperfluidToken superToken, uint256 liquidationPeriod, uint256 patricianPeriod) public;
```

### clearPPPConfig(contract ISuperfluid,contract ISuperfluidToken) (inherited from SuperfluidGovernanceBase)

- **Signature**: `clearPPPConfig(contract ISuperfluid,contract ISuperfluidToken)`
- **Visibility**: external
- **Source Range**: 10833:280:130
- **Details**: [function_clearPPPConfig_contract_ISuperfluid_contract_ISuperfluidToken.md](./function_clearPPPConfig_contract_ISuperfluid_contract_ISuperfluidToken.md)

**Signature:**
```solidity
function clearPPPConfig(ISuperfluid host, ISuperfluidToken superToken) external;
```

### getSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperfluidToken) (inherited from SuperfluidGovernanceBase)

- **Signature**: `getSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperfluidToken)`
- **Visibility**: external
- **Source Range**: 11332:296:130
- **Details**: [function_getSuperTokenMinimumDeposit_contract_ISuperfluid_contract_ISuperfluidToken.md](./function_getSuperTokenMinimumDeposit_contract_ISuperfluid_contract_ISuperfluidToken.md)

**Signature:**
```solidity
function getSuperTokenMinimumDeposit(ISuperfluid host, ISuperfluidToken superToken) external view returns (uint256 value);
```

### setSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperfluidToken,uint256) (inherited from SuperfluidGovernanceBase)

- **Signature**: `setSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperfluidToken,uint256)`
- **Visibility**: public
- **Source Range**: 11634:337:130
- **Details**: [function_setSuperTokenMinimumDeposit_contract_ISuperfluid_contract_ISuperfluidToken_uint256.md](./function_setSuperTokenMinimumDeposit_contract_ISuperfluid_contract_ISuperfluidToken_uint256.md)

**Signature:**
```solidity
function setSuperTokenMinimumDeposit(ISuperfluid host, ISuperfluidToken superToken, uint256 value) public;
```

### clearSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperToken) (inherited from SuperfluidGovernanceBase)

- **Signature**: `clearSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperToken)`
- **Visibility**: external
- **Source Range**: 11977:305:130
- **Details**: [function_clearSuperTokenMinimumDeposit_contract_ISuperfluid_contract_ISuperToken.md](./function_clearSuperTokenMinimumDeposit_contract_ISuperfluid_contract_ISuperToken.md)

**Signature:**
```solidity
function clearSuperTokenMinimumDeposit(ISuperfluid host, ISuperToken superToken) external;
```

### isTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `isTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 12500:332:130
- **Details**: [function_isTrustedForwarder_contract_ISuperfluid_contract_ISuperfluidToken_address.md](./function_isTrustedForwarder_contract_ISuperfluid_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
function isTrustedForwarder(ISuperfluid host, ISuperfluidToken superToken, address forwarder) external view returns (bool);
```

### enableTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `enableTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address)`
- **Visibility**: public
- **Source Range**: 12838:380:130
- **Details**: [function_enableTrustedForwarder_contract_ISuperfluid_contract_ISuperfluidToken_address.md](./function_enableTrustedForwarder_contract_ISuperfluid_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
function enableTrustedForwarder(ISuperfluid host, ISuperfluidToken superToken, address forwarder) public;
```

### disableTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `disableTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 13224:371:130
- **Details**: [function_disableTrustedForwarder_contract_ISuperfluid_contract_ISuperfluidToken_address.md](./function_disableTrustedForwarder_contract_ISuperfluid_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
function disableTrustedForwarder(ISuperfluid host, ISuperfluidToken superToken, address forwarder) external;
```

### verifyAppRegistrationKey(contract ISuperfluid,address,string) (inherited from SuperfluidGovernanceBase)

- **Signature**: `verifyAppRegistrationKey(contract ISuperfluid,address,string)`
- **Visibility**: external
- **Source Range**: 13812:617:130
- **Details**: [function_verifyAppRegistrationKey_contract_ISuperfluid_address_string.md](./function_verifyAppRegistrationKey_contract_ISuperfluid_address_string.md)

**Signature:**
```solidity
function verifyAppRegistrationKey(ISuperfluid host, address deployer, string memory registrationKey) external view returns (bool validNow, uint256 expirationTs);
```

### setAppRegistrationKey(contract ISuperfluid,address,string,uint256) (inherited from SuperfluidGovernanceBase)

- **Signature**: `setAppRegistrationKey(contract ISuperfluid,address,string,uint256)`
- **Visibility**: external
- **Source Range**: 14435:500:130
- **Details**: [function_setAppRegistrationKey_contract_ISuperfluid_address_string_uint256.md](./function_setAppRegistrationKey_contract_ISuperfluid_address_string_uint256.md)

**Signature:**
```solidity
function setAppRegistrationKey(ISuperfluid host, address deployer, string memory registrationKey, uint256 expirationTs) external;
```

### clearAppRegistrationKey(contract ISuperfluid,address,string) (inherited from SuperfluidGovernanceBase)

- **Signature**: `clearAppRegistrationKey(contract ISuperfluid,address,string)`
- **Visibility**: external
- **Source Range**: 14941:449:130
- **Details**: [function_clearAppRegistrationKey_contract_ISuperfluid_address_string.md](./function_clearAppRegistrationKey_contract_ISuperfluid_address_string.md)

**Signature:**
```solidity
function clearAppRegistrationKey(ISuperfluid host, address deployer, string memory registrationKey) external;
```

### isAuthorizedAppFactory(contract ISuperfluid,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `isAuthorizedAppFactory(contract ISuperfluid,address)`
- **Visibility**: external
- **Source Range**: 15653:307:130
- **Details**: [function_isAuthorizedAppFactory_contract_ISuperfluid_address.md](./function_isAuthorizedAppFactory_contract_ISuperfluid_address.md)

**Signature:**
```solidity
///  @dev tells if the given factory is authorized to register apps
function isAuthorizedAppFactory(ISuperfluid host, address factory) external view returns (bool);
```

### authorizeAppFactory(contract ISuperfluid,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `authorizeAppFactory(contract ISuperfluid,address)`
- **Visibility**: external
- **Source Range**: 16125:581:130
- **Details**: [function_authorizeAppFactory_contract_ISuperfluid_address.md](./function_authorizeAppFactory_contract_ISuperfluid_address.md)

**Signature:**
```solidity
///  @dev allows the given factory to register new apps without requiring onetime keys
///  @param factory must be an initialized contract
function authorizeAppFactory(ISuperfluid host, address factory) external;
```

### unauthorizeAppFactory(contract ISuperfluid,address) (inherited from SuperfluidGovernanceBase)

- **Signature**: `unauthorizeAppFactory(contract ISuperfluid,address)`
- **Visibility**: external
- **Source Range**: 16866:327:130
- **Details**: [function_unauthorizeAppFactory_contract_ISuperfluid_address.md](./function_unauthorizeAppFactory_contract_ISuperfluid_address.md)

**Signature:**
```solidity
///  @dev withdraws authorization from a factory to register new apps.
///  Doesn't affect apps previously registered by the factory.
function unauthorizeAppFactory(ISuperfluid host, address factory) external;
```
