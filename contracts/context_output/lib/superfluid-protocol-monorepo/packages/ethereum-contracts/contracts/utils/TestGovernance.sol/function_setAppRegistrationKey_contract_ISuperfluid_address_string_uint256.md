# Function: setAppRegistrationKey(contract ISuperfluid,address,string,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `setAppRegistrationKey(contract ISuperfluid,address,string,uint256)`
- **Visibility**: external
- **Source Range**: 14435:500:130
- **Inherited From**: SuperfluidGovernanceBase

## Implementation

```solidity
function setAppRegistrationKey(ISuperfluid host, address deployer, string memory registrationKey, uint256 expirationTs) external {
    bytes32 configKey = SuperfluidGovernanceConfigs.getAppRegistrationConfigKey(deployer, registrationKey);
    _setConfig(host, ISuperfluidToken(address(0)), configKey, expirationTs);
    emit AppRegistrationKeyChanged(host, deployer, registrationKey, expirationTs);
}
```

## Related Implementations

### getAppRegistrationConfigKey(address,string)

- **Kind**: internal
- **Source**: 11297:308:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperfluidGovernanceConfigs:getAppRegistrationConfigKey(address,string)`

```solidity
function getAppRegistrationConfigKey(address deployer, string memory registrationKey) internal pure returns (bytes32) {
    return keccak256(abi.encode("org.superfluid-finance.superfluid.appWhiteListing.registrationKey", deployer, registrationKey));
}
```

### _setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256)

- **Kind**: internal
- **Source**: 6100:334:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:_setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256)`

```solidity
function _setConfig(ISuperfluid host, ISuperfluidToken superToken, bytes32 key, uint256 value) internal onlyAuthorized(host) {
    emit ConfigChanged(host, superToken, key, true, value);
    _configs[address(host)][address(superToken)][key] = Value(true, value);
}
```

### onlyAuthorized(contract ISuperfluid)

- **Kind**: modifier
- **Source**: 17371:94:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:onlyAuthorized(contract ISuperfluid)`

```solidity
modifier onlyAuthorized(ISuperfluid host) {
    _requireAuthorised(host);
    _;
}
```

### _requireAuthorised(contract ISuperfluid)

- **Kind**: internal
- **Source**: 1275:160:184
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol:TestGovernance:_requireAuthorised(contract ISuperfluid)`

```solidity
function _requireAuthorised(ISuperfluid host) override internal view {
    assert(host == _host);
    assert(owner() == _msgSender());
}
```

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:104
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### owner()

- **Kind**: internal
- **Source**: 1201:85:71
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:owner()`

```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address) {
    return _owner;
}
```

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_owner** (`address`)

## State Variable Writes

- **_configs** (`mapping(address => mapping(address => mapping(bytes32 => struct SuperfluidGovernanceBase.Value)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidGovernanceBase.setAppRegistrationKey(contract ISuperfluid,address,string,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.getAppRegistrationConfigKey(address,string) (NodeID: 1)
  │   💬 Args: [deployer, registrationKey]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase._setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256) (NodeID: 2)
      💬 Args: [host, ISuperfluidToken(address(0)), configKey, expirationTs]
      👁️  Def: internal
    └─ [2] 🔒 MODIFIER: SuperfluidGovernanceBase.onlyAuthorized(contract ISuperfluid) (NodeID: 3)
        💬 Args: [host]
      └─ [3] ⚙️ FUNCTION: TestGovernance._requireAuthorised(contract ISuperfluid) (NodeID: 4)
          💬 Args: [host]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 5)
        │   💬 Args: [no args]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Ownable.owner() (NodeID: 6)
            💬 Args: [no args]
            👁️  Def: public
```
