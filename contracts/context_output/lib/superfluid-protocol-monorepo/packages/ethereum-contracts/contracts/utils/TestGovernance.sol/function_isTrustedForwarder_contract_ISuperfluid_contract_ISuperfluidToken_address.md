# Function: isTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `isTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 12500:332:130
- **Inherited From**: SuperfluidGovernanceBase

## Implementation

```solidity
function isTrustedForwarder(ISuperfluid host, ISuperfluidToken superToken, address forwarder) external view returns (bool) {
    return getConfigAsUint256(host, superToken, SuperfluidGovernanceConfigs.getTrustedForwarderConfigKey(forwarder)) == 1;
}
```

## Related Implementations

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

- **_configs** (`mapping(address => mapping(address => mapping(bytes32 => struct SuperfluidGovernanceBase.Value)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidGovernanceBase.isTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase.getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32) (NodeID: 1)
      💬 Args: [host, superToken, SuperfluidGovernanceConfigs.getTrustedForwarderConfigKey(forwarder)]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.getTrustedForwarderConfigKey(address) (NodeID: 2)
        💬 Args: [forwarder]
        👁️  Def: internal
```
