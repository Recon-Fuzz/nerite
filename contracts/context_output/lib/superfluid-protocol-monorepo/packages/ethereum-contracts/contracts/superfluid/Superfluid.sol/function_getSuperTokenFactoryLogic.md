# Function: getSuperTokenFactoryLogic()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `getSuperTokenFactoryLogic()`
- **Visibility**: external
- **Source Range**: 10718:326:163

## Implementation

```solidity
function getSuperTokenFactoryLogic() override external view returns (address logic) {
    assert(address(_superTokenFactory) != address(0));
    if (NON_UPGRADABLE_DEPLOYMENT) return address(_superTokenFactory); else return UUPSProxiable(address(_superTokenFactory)).getCodeAddress();
}
```

## External Calls

- **UUPSProxiable::getCodeAddress()**

## State Variable Reads

- **_superTokenFactory** (`contract ISuperTokenFactory`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperTokenFactory.sol/interface_ISuperTokenFactory.md]
- **NON_UPGRADABLE_DEPLOYMENT** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.getSuperTokenFactoryLogic() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Get the super token factory logic (applicable to upgradable deployment)
 @return logic The factory logic
