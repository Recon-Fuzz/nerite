# Function: verifyAppRegistrationKey(contract ISuperfluid,address,string)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `verifyAppRegistrationKey(contract ISuperfluid,address,string)`
- **Visibility**: external
- **Source Range**: 13812:617:130
- **Inherited From**: SuperfluidGovernanceBase

## Implementation

```solidity
function verifyAppRegistrationKey(ISuperfluid host, address deployer, string memory registrationKey) external view returns (bool validNow, uint256 expirationTs) {
    bytes32 configKey = SuperfluidGovernanceConfigs.getAppRegistrationConfigKey(deployer, registrationKey);
    uint256 expirationTS = getConfigAsUint256(host, ISuperfluidToken(address(0)), configKey);
    return (expirationTS >= block.timestamp, expirationTS);
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

### getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 7200:424:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)`

```solidity
function getConfigAsUint256(ISuperfluid host, ISuperfluidToken superToken, bytes32 key) override public view returns (uint256 period) {
    Value storage v = _configs[address(host)][address(superToken)][key];
    if (!v.set) {
        v = _configs[address(host)][address(0)][key];
    }
    return v.value;
}
```

## State Variable Reads

- **_configs** (`mapping(address => mapping(address => mapping(bytes32 => struct SuperfluidGovernanceBase.Value)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidGovernanceBase.verifyAppRegistrationKey(contract ISuperfluid,address,string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.getAppRegistrationConfigKey(address,string) (NodeID: 1)
  │   💬 Args: [deployer, registrationKey]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase.getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32) (NodeID: 2)
      💬 Args: [host, ISuperfluidToken(address(0)), configKey]
      👁️  Def: public
```
