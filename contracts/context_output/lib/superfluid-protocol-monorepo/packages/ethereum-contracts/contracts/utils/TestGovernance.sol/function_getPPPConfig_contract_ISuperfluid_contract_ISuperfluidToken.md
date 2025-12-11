# Function: getPPPConfig(contract ISuperfluid,contract ISuperfluidToken)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `getPPPConfig(contract ISuperfluid,contract ISuperfluidToken)`
- **Visibility**: external
- **Source Range**: 9596:458:130
- **Inherited From**: SuperfluidGovernanceBase

## Implementation

```solidity
function getPPPConfig(ISuperfluid host, ISuperfluidToken superToken) external view returns (uint256 liquidationPeriod, uint256 patricianPeriod) {
    uint256 pppConfig = getConfigAsUint256(host, superToken, SuperfluidGovernanceConfigs.CFAV1_PPP_CONFIG_KEY);
    (liquidationPeriod, patricianPeriod) = SuperfluidGovernanceConfigs.decodePPPConfig(pppConfig);
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

### decodePPPConfig(uint256)

- **Kind**: internal
- **Source**: 11842:260:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperfluidGovernanceConfigs:decodePPPConfig(uint256)`

```solidity
function decodePPPConfig(uint256 pppConfig) internal pure returns (uint256 liquidationPeriod, uint256 patricianPeriod) {
    liquidationPeriod = (pppConfig >> 32) & type(uint32).max;
    patricianPeriod = pppConfig & type(uint32).max;
}
```

## State Variable Reads

- **_configs** (`mapping(address => mapping(address => mapping(bytes32 => struct SuperfluidGovernanceBase.Value)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidGovernanceBase.getPPPConfig(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase.getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32) (NodeID: 1)
  │   💬 Args: [host, superToken, SuperfluidGovernanceConfigs.CFAV1_PPP_CONFIG_KEY]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 2)
      💬 Args: [pppConfig]
      👁️  Def: internal
```
