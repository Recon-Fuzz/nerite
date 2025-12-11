# Function: isAuthorizedAppFactory(contract ISuperfluid,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `isAuthorizedAppFactory(contract ISuperfluid,address)`
- **Visibility**: external
- **Source Range**: 15653:307:130
- **Inherited From**: SuperfluidGovernanceBase

## Implementation

```solidity
///  @dev tells if the given factory is authorized to register apps
function isAuthorizedAppFactory(ISuperfluid host, address factory) external view returns (bool) {
    return getConfigAsUint256(host, ISuperfluidToken(address(0)), SuperfluidGovernanceConfigs.getAppFactoryConfigKey(factory)) == 1;
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

### getAppFactoryConfigKey(address)

- **Kind**: internal
- **Source**: 11611:225:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperfluidGovernanceConfigs:getAppFactoryConfigKey(address)`

```solidity
function getAppFactoryConfigKey(address factory) internal pure returns (bytes32) {
    return keccak256(abi.encode("org.superfluid-finance.superfluid.appWhiteListing.factory", factory));
}
```

## State Variable Reads

- **_configs** (`mapping(address => mapping(address => mapping(bytes32 => struct SuperfluidGovernanceBase.Value)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidGovernanceBase.isAuthorizedAppFactory(contract ISuperfluid,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase.getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32) (NodeID: 1)
      💬 Args: [host, ISuperfluidToken(address(0)), SuperfluidGovernanceConfigs.getAppFactoryConfigKey(factory)]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.getAppFactoryConfigKey(address) (NodeID: 2)
        💬 Args: [factory]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev tells if the given factory is authorized to register apps
