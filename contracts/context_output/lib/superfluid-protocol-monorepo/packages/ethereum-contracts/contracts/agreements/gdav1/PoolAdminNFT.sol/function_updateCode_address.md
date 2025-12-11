# Function: updateCode(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]

## Metadata

- **Contract**: PoolAdminNFT
- **Signature**: `updateCode(address)`
- **Visibility**: external
- **Source Range**: 3394:318:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
function updateCode(address newAddress) override external {
    ISuperTokenFactory superTokenFactory = HOST.getSuperTokenFactory();
    if (msg.sender != address(superTokenFactory)) {
        revert POOL_NFT_ONLY_SUPER_TOKEN_FACTORY();
    }
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
- **Source**: 1374:161:124
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol:PoolAdminNFT:proxiableUUID()`

```solidity
function proxiableUUID() override public pure returns (bytes32) {
    return keccak256("org.superfluid-finance.contracts.PoolAdminNFT.implementation");
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

- **ISuperfluid::getSuperTokenFactory()**
- **UUPSProxiable::proxiableUUID()**

## State Variable Reads

- **HOST** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.updateCode(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: UUPSProxiable._updateCodeAddress(address) (NodeID: 1)
      💬 Args: [newAddress]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: UUPSUtils.implementation() (NodeID: 2)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: PoolAdminNFT.proxiableUUID() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: UUPSUtils.setImplementation(address) (NodeID: 4)
    │   💬 Args: [newAddress]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: PoolAdminNFT.proxiableUUID() (NodeID: 5)
        💬 Args: [no args]
        👁️  Def: public
```
