# Function: getRewardAddress(contract ISuperfluid,contract ISuperfluidToken)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `getRewardAddress(contract ISuperfluid,contract ISuperfluidToken)`
- **Visibility**: external
- **Source Range**: 8042:298:130
- **Inherited From**: SuperfluidGovernanceBase

## Implementation

```solidity
function getRewardAddress(ISuperfluid host, ISuperfluidToken superToken) external view returns (address) {
    return getConfigAsAddress(host, superToken, SuperfluidGovernanceConfigs.SUPERFLUID_REWARD_ADDRESS_CONFIG_KEY);
}
```

## Related Implementations

### getConfigAsAddress(contract ISuperfluid,contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 6753:441:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:getConfigAsAddress(contract ISuperfluid,contract ISuperfluidToken,bytes32)`

```solidity
function getConfigAsAddress(ISuperfluid host, ISuperfluidToken superToken, bytes32 key) override public view returns (address value) {
    Value storage v = _configs[address(host)][address(superToken)][key];
    if (!v.set) {
        v = _configs[address(host)][address(0)][key];
    }
    return address(uint160(v.value));
}
```

## State Variable Reads

- **_configs** (`mapping(address => mapping(address => mapping(bytes32 => struct SuperfluidGovernanceBase.Value)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidGovernanceBase.getRewardAddress(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase.getConfigAsAddress(contract ISuperfluid,contract ISuperfluidToken,bytes32) (NodeID: 1)
      💬 Args: [host, superToken, SuperfluidGovernanceConfigs.SUPERFLUID_REWARD_ADDRESS_CONFIG_KEY]
      👁️  Def: public
```
