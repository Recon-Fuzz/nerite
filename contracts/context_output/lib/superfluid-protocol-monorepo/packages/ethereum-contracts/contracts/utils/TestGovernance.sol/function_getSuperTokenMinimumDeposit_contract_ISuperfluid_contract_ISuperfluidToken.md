# Function: getSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperfluidToken)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `getSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperfluidToken)`
- **Visibility**: external
- **Source Range**: 11332:296:130
- **Inherited From**: SuperfluidGovernanceBase

## Implementation

```solidity
function getSuperTokenMinimumDeposit(ISuperfluid host, ISuperfluidToken superToken) external view returns (uint256 value) {
    return getConfigAsUint256(host, superToken, SuperfluidGovernanceConfigs.SUPERTOKEN_MINIMUM_DEPOSIT_KEY);
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

## State Variable Reads

- **_configs** (`mapping(address => mapping(address => mapping(bytes32 => struct SuperfluidGovernanceBase.Value)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidGovernanceBase.getSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase.getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32) (NodeID: 1)
      💬 Args: [host, superToken, SuperfluidGovernanceConfigs.SUPERTOKEN_MINIMUM_DEPOSIT_KEY]
      👁️  Def: public
```
