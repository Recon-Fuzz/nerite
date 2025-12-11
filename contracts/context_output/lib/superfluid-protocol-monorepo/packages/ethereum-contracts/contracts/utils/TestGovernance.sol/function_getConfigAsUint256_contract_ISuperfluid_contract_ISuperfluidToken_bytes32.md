# Function: getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)`
- **Visibility**: public
- **Source Range**: 7200:424:130
- **Inherited From**: SuperfluidGovernanceBase

## Implementation

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
┌─ [0] ⚙️ FUNCTION: SuperfluidGovernanceBase.getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Get configuration as uint256 value
