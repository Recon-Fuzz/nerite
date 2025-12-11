# Function: updateCode(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `updateCode(address)`
- **Visibility**: external
- **Source Range**: 4872:305:163

## Implementation

```solidity
function updateCode(address newAddress) override external onlyGovernance() {
    if (NON_UPGRADABLE_DEPLOYMENT) revert HOST_NON_UPGRADEABLE();
    if (Superfluid(newAddress).NON_UPGRADABLE_DEPLOYMENT()) revert HOST_CANNOT_DOWNGRADE_TO_NON_UPGRADEABLE();
    _updateCodeAddress(newAddress);
}
```

## Related Implementations

### _updateCodeAddress(address)

- **Kind**: internal
- **Source**: 1252:576:169
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/UUPSProxiable.sol:UUPSProxiable:_updateCodeAddress(address)`

```solidity
///  @dev Update code address function.
///       It is internal, so the derived contract could setup its own permission logic.
function _updateCodeAddress(address newAddress) internal {
    require(UUPSUtils.implementation() != address(0), "UUPSProxiable: not upgradable");
    require(proxiableUUID() == UUPSProxiable(newAddress).proxiableUUID(), "UUPSProxiable: not compatible logic");
    require(address(this) != newAddress, "UUPSProxiable: proxy loop");
    UUPSUtils.setImplementation(newAddress);
    emit CodeUpdated(proxiableUUID(), newAddress);
}
```

### implementation()

- **Kind**: internal
- **Source**: 619:170:171
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/UUPSUtils.sol:UUPSUtils:implementation()`

```solidity
/// @dev Get implementation address.
function implementation() internal view returns (address impl) {
    assembly {
        impl := sload(_IMPLEMENTATION_SLOT)
    }
}
```

### proxiableUUID()

- **Kind**: internal
- **Source**: 4707:159:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:proxiableUUID()`

```solidity
function proxiableUUID() override public pure returns (bytes32) {
    return keccak256("org.superfluid-finance.contracts.Superfluid.implementation");
}
```

### setImplementation(address)

- **Kind**: internal
- **Source**: 840:228:171
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/UUPSUtils.sol:UUPSUtils:setImplementation(address)`

```solidity
/// @dev Set new implementation address.
function setImplementation(address codeAddress) internal {
    assembly {
        sstore(_IMPLEMENTATION_SLOT, codeAddress)
    }
}
```

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

- **Superfluid::NON_UPGRADABLE_DEPLOYMENT()**
- **UUPSProxiable::proxiableUUID()**

## State Variable Reads

- **NON_UPGRADABLE_DEPLOYMENT** (`bool`)
- **_gov** (`contract ISuperfluidGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol/interface_ISuperfluidGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.updateCode(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: UUPSProxiable._updateCodeAddress(address) (NodeID: 1)
  │   💬 Args: [newAddress]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UUPSUtils.implementation() (NodeID: 2)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Superfluid.proxiableUUID() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: UUPSUtils.setImplementation(address) (NodeID: 4)
  │ │   💬 Args: [newAddress]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Superfluid.proxiableUUID() (NodeID: 5)
  │     💬 Args: [no args]
  │     👁️  Def: public
  └─ [1] 🔒 MODIFIER: Superfluid.onlyGovernance() (NodeID: 6)
      💬 Args: [no args]
```
