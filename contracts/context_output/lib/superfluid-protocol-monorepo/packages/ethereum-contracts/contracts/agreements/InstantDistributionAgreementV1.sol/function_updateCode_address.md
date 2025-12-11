# Function: updateCode(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `updateCode(address)`
- **Visibility**: external
- **Source Range**: 706:192:119
- **Inherited From**: AgreementBase

## Implementation

```solidity
function updateCode(address newAddress) override external {
    if (msg.sender != _host) revert AGREEMENT_BASE_ONLY_HOST();
    return _updateCodeAddress(newAddress);
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
- **Source**: 555:145:119
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementBase.sol:AgreementBase:proxiableUUID()`

```solidity
function proxiableUUID() override public view returns (bytes32) {
    return ISuperAgreement(this).agreementType();
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

## External Calls

- **UUPSProxiable::proxiableUUID()**
- **ISuperAgreement::agreementType()**

## State Variable Reads

- **_host** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AgreementBase.updateCode(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: UUPSProxiable._updateCodeAddress(address) (NodeID: 1)
      💬 Args: [newAddress]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: UUPSUtils.implementation() (NodeID: 2)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AgreementBase.proxiableUUID() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: UUPSUtils.setImplementation(address) (NodeID: 4)
    │   💬 Args: [newAddress]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AgreementBase.proxiableUUID() (NodeID: 5)
        💬 Args: [no args]
        👁️  Def: public
```
