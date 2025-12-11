# Function: updateSuperTokenLogic(contract ISuperToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `updateSuperTokenLogic(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 11884:444:163

## Implementation

```solidity
function updateSuperTokenLogic(ISuperToken token, address newLogicOverride) override external onlyGovernance() {
    address newLogic = (newLogicOverride != address(0)) ? newLogicOverride : address(_superTokenFactory.getSuperTokenLogic());
    UUPSProxiable(address(token)).updateCode(newLogic);
    emit SuperTokenLogicUpdated(token, newLogic);
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

- **ISuperTokenFactory::getSuperTokenLogic()**
- **UUPSProxiable::updateCode(address)**

## State Variable Reads

- **_superTokenFactory** (`contract ISuperTokenFactory`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperTokenFactory.sol/interface_ISuperTokenFactory.md]
- **_gov** (`contract ISuperfluidGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol/interface_ISuperfluidGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.updateSuperTokenLogic(contract ISuperToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Superfluid.onlyGovernance() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @notice Update the super token logic to the latest (canonical) implementation
 if `newLogicOverride` is zero, or to `newLogicOverride` otherwise.
 or to the provided implementation `.
 @dev Refer to ISuperTokenFactory.Upgradability for expected behaviours
