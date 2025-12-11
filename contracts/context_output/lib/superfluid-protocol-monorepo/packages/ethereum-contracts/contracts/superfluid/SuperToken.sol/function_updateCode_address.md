# Function: updateCode(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `updateCode(address)`
- **Visibility**: external
- **Source Range**: 6157:137:161

## Implementation

```solidity
///  @notice Updates the logic contract the proxy is pointing at
///  @dev Only the admin can call this function (host if admin == address(0))
///  @param newAddress Address of the new logic contract
function updateCode(address newAddress) virtual override external onlyAdmin() {
    UUPSProxiable._updateCodeAddress(newAddress);
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
- **Source**: 5762:167:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:proxiableUUID()`

```solidity
function proxiableUUID() virtual override public pure returns (bytes32) {
    return keccak256("org.superfluid-finance.contracts.SuperToken.implementation");
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

### onlyAdmin()

- **Kind**: modifier
- **Source**: 30330:239:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:onlyAdmin()`

```solidity
///  @dev The host contract is implicitly the admin if admin is address(0) else it is the explicitly set admin
///  override address
modifier onlyAdmin() {
    address adminSlotAdmin = _getAdmin();
    address admin = (adminSlotAdmin == address(0)) ? address(_host) : adminSlotAdmin;
    if (msg.sender != admin) revert SUPER_TOKEN_ONLY_ADMIN();
    _;
}
```

### _getAdmin()

- **Kind**: internal
- **Source**: 6599:170:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_getAdmin()`

```solidity
function _getAdmin() internal view returns (address admin) {
    assembly {
        admin := sload(_ADMIN_SLOT)
    }
}
```

## External Calls

- **UUPSProxiable::proxiableUUID()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.updateCode(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: UUPSProxiable._updateCodeAddress(address) (NodeID: 1)
  │   💬 Args: [newAddress]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UUPSUtils.implementation() (NodeID: 2)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperToken.proxiableUUID() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: UUPSUtils.setImplementation(address) (NodeID: 4)
  │ │   💬 Args: [newAddress]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperToken.proxiableUUID() (NodeID: 5)
  │     💬 Args: [no args]
  │     👁️  Def: public
  └─ [1] 🔒 MODIFIER: SuperToken.onlyAdmin() (NodeID: 6)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: SuperToken._getAdmin() (NodeID: 7)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @notice Updates the logic contract the proxy is pointing at
 @dev Only the admin can call this function (host if admin == address(0))
 @param newAddress Address of the new logic contract
