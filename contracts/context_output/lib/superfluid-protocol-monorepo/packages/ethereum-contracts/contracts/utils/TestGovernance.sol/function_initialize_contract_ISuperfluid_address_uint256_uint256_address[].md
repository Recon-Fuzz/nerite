# Function: initialize(contract ISuperfluid,address,uint256,uint256,address[])

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `initialize(contract ISuperfluid,address,uint256,uint256,address[])`
- **Visibility**: external
- **Source Range**: 552:717:184

## Implementation

```solidity
function initialize(ISuperfluid host, address rewardAddress, uint256 liquidationPeriod, uint256 patricianPeriod, address[] calldata trustedForwarders) external {
    assert(address(host) != address(0));
    assert(address(_host) == address(0));
    _host = host;
    setRewardAddress(_host, ISuperfluidToken(address(0)), rewardAddress);
    setPPPConfig(host, ISuperfluidToken(address(0)), liquidationPeriod, patricianPeriod);
    for (uint i = 0; i < trustedForwarders.length; ++i) {
        enableTrustedForwarder(_host, ISuperfluidToken(address(0)), trustedForwarders[i]);
    }
}
```

## Related Implementations

### setRewardAddress(contract ISuperfluid,contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 8346:382:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:setRewardAddress(contract ISuperfluid,contract ISuperfluidToken,address)`

```solidity
function setRewardAddress(ISuperfluid host, ISuperfluidToken superToken, address rewardAddress) public {
    _setConfig(host, superToken, SuperfluidGovernanceConfigs.SUPERFLUID_REWARD_ADDRESS_CONFIG_KEY, rewardAddress);
    emit RewardAddressChanged(host, superToken, true, rewardAddress);
}
```

### _setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,address)

- **Kind**: internal
- **Source**: 5724:370:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:_setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,address)`

```solidity
function _setConfig(ISuperfluid host, ISuperfluidToken superToken, bytes32 key, address value) internal onlyAuthorized(host) {
    emit ConfigChanged(host, superToken, key, true, uint256(uint160(value)));
    _configs[address(host)][address(superToken)][key] = Value(true, uint256(uint160(value)));
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

### setPPPConfig(contract ISuperfluid,contract ISuperfluidToken,uint256,uint256)

- **Kind**: internal
- **Source**: 10060:767:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:setPPPConfig(contract ISuperfluid,contract ISuperfluidToken,uint256,uint256)`

```solidity
function setPPPConfig(ISuperfluid host, ISuperfluidToken superToken, uint256 liquidationPeriod, uint256 patricianPeriod) public {
    if (((liquidationPeriod <= patricianPeriod) || (liquidationPeriod >= type(uint32).max)) || (patricianPeriod >= type(uint32).max)) {
        revert SF_GOV_INVALID_LIQUIDATION_OR_PATRICIAN_PERIOD();
    }
    uint256 value = (uint256(liquidationPeriod) << 32) | uint256(patricianPeriod);
    _setConfig(host, superToken, SuperfluidGovernanceConfigs.CFAV1_PPP_CONFIG_KEY, value);
    emit PPPConfigurationChanged(host, superToken, true, liquidationPeriod, patricianPeriod);
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

### enableTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 12838:380:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:enableTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address)`

```solidity
function enableTrustedForwarder(ISuperfluid host, ISuperfluidToken superToken, address forwarder) public {
    _setConfig(host, superToken, SuperfluidGovernanceConfigs.getTrustedForwarderConfigKey(forwarder), 1);
    emit TrustedForwarderChanged(host, superToken, true, forwarder, true);
}
```

### getTrustedForwarderConfigKey(address)

- **Kind**: internal
- **Source**: 11067:224:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperfluidGovernanceConfigs:getTrustedForwarderConfigKey(address)`

```solidity
function getTrustedForwarderConfigKey(address forwarder) internal pure returns (bytes32) {
    return keccak256(abi.encode("org.superfluid-finance.superfluid.trustedForwarder", forwarder));
}
```

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_owner** (`address`)

## State Variable Writes

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_configs** (`mapping(address => mapping(address => mapping(bytes32 => struct SuperfluidGovernanceBase.Value)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestGovernance.initialize(contract ISuperfluid,address,uint256,uint256,address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase.setRewardAddress(contract ISuperfluid,contract ISuperfluidToken,address) (NodeID: 1)
  │   💬 Args: [_host, ISuperfluidToken(address(0)), rewardAddress]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: SuperfluidGovernanceBase._setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,address) (NodeID: 2)
  │     💬 Args: [host, superToken, SuperfluidGovernanceConfigs.SUPERFLUID_REWARD_ADDRESS_CONFIG_KEY, rewardAddress]
  │     👁️  Def: internal
  │   └─ [3] 🔒 MODIFIER: SuperfluidGovernanceBase.onlyAuthorized(contract ISuperfluid) (NodeID: 3)
  │       💬 Args: [host]
  │     └─ [4] ⚙️ FUNCTION: TestGovernance._requireAuthorised(contract ISuperfluid) (NodeID: 4)
  │         💬 Args: [host]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Context._msgSender() (NodeID: 5)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: Ownable.owner() (NodeID: 6)
  │           💬 Args: [no args]
  │           👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase.setPPPConfig(contract ISuperfluid,contract ISuperfluidToken,uint256,uint256) (NodeID: 7)
  │   💬 Args: [host, ISuperfluidToken(address(0)), liquidationPeriod, patricianPeriod]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: SuperfluidGovernanceBase._setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256) (NodeID: 8)
  │     💬 Args: [host, superToken, SuperfluidGovernanceConfigs.CFAV1_PPP_CONFIG_KEY, value]
  │     👁️  Def: internal
  │   └─ [3] 🔒 MODIFIER: SuperfluidGovernanceBase.onlyAuthorized(contract ISuperfluid) (NodeID: 9)
  │       💬 Args: [host]
  │     └─ [4] ⚙️ FUNCTION: TestGovernance._requireAuthorised(contract ISuperfluid) (NodeID: 10)
  │         💬 Args: [host]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Context._msgSender() (NodeID: 11)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: Ownable.owner() (NodeID: 12)
  │           💬 Args: [no args]
  │           👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase.enableTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address) (NodeID: 13)
      💬 Args: [_host, ISuperfluidToken(address(0)), trustedForwarders[i]]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: SuperfluidGovernanceBase._setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256) (NodeID: 14)
        💬 Args: [host, superToken, SuperfluidGovernanceConfigs.getTrustedForwarderConfigKey(forwarder), 1]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.getTrustedForwarderConfigKey(address) (NodeID: 19)
      │   💬 Args: [forwarder]
      │   👁️  Def: internal
      └─ [3] 🔒 MODIFIER: SuperfluidGovernanceBase.onlyAuthorized(contract ISuperfluid) (NodeID: 15)
          💬 Args: [host]
        └─ [4] ⚙️ FUNCTION: TestGovernance._requireAuthorised(contract ISuperfluid) (NodeID: 16)
            💬 Args: [host]
            👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: Context._msgSender() (NodeID: 17)
          │   💬 Args: [no args]
          │   👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: Ownable.owner() (NodeID: 18)
              💬 Args: [no args]
              👁️  Def: public
```
