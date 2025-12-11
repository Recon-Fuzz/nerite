# Function: updateSuperTokenFactory(contract ISuperTokenFactory)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `updateSuperTokenFactory(contract ISuperTokenFactory)`
- **Visibility**: external
- **Source Range**: 11050:828:163

## Implementation

```solidity
function updateSuperTokenFactory(ISuperTokenFactory newFactory) override external onlyGovernance() {
    if (address(_superTokenFactory) == address(0)) {
        if (!NON_UPGRADABLE_DEPLOYMENT) {
            UUPSProxy proxy = new UUPSProxy();
            proxy.initializeProxy(address(newFactory));
            _superTokenFactory = ISuperTokenFactory(address(proxy));
        } else {
            _superTokenFactory = newFactory;
        }
        _superTokenFactory.initialize();
    } else {
        if (NON_UPGRADABLE_DEPLOYMENT) revert HOST_NON_UPGRADEABLE();
        UUPSProxiable(address(_superTokenFactory)).updateCode(address(newFactory));
    }
    emit SuperTokenFactoryUpdated(_superTokenFactory);
}
```

## Related Implementations

### onlyGovernance()

- **Kind**: modifier
- **Source**: 44183:116:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:onlyGovernance()`

```solidity
modifier onlyGovernance() {
    if (msg.sender != address(_gov)) revert HOST_ONLY_GOVERNANCE();
    _;
}
```

## External Calls

- **UUPSProxy::initializeProxy(address)**
- **ISuperTokenFactory::initialize()**
- **UUPSProxiable::updateCode(address)**

## State Variable Reads

- **_superTokenFactory** (`contract ISuperTokenFactory`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperTokenFactory.sol/interface_ISuperTokenFactory.md]
- **NON_UPGRADABLE_DEPLOYMENT** (`bool`)
- **_gov** (`contract ISuperfluidGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol/interface_ISuperfluidGovernance.md]

## State Variable Writes

- **_superTokenFactory** (`contract ISuperTokenFactory`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperTokenFactory.sol/interface_ISuperTokenFactory.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.updateSuperTokenFactory(contract ISuperTokenFactory) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Superfluid.onlyGovernance() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @dev Update super token factory
 @param newFactory New factory logic
