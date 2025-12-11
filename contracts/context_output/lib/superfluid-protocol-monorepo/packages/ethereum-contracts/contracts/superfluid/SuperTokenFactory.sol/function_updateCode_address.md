# Function: updateCode(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

## Metadata

- **Contract**: SuperTokenFactory
- **Signature**: `updateCode(address)`
- **Visibility**: external
- **Source Range**: 5505:1032:162
- **Inherited From**: SuperTokenFactoryBase

## Implementation

```solidity
/// @notice Updates the logic contract for the SuperTokenFactory
///  @dev This function updates the logic contract for the SuperTokenFactory
///  @param newAddress the new address of the SuperTokenFactory logic contract
function updateCode(address newAddress) override external {
    if (msg.sender != address(_host)) {
        revert SUPER_TOKEN_FACTORY_ONLY_HOST();
    }
    _updateCodeAddress(newAddress);
    SuperTokenFactory newFactory = SuperTokenFactory(newAddress);
    if (address(POOL_ADMIN_NFT_LOGIC) != address(newFactory.POOL_ADMIN_NFT_LOGIC())) {
        UUPSProxiable(address(_SUPER_TOKEN_LOGIC.POOL_ADMIN_NFT())).updateCode(address(newFactory.POOL_ADMIN_NFT_LOGIC()));
    }
    if (address(POOL_MEMBER_NFT_LOGIC) != address(newFactory.POOL_MEMBER_NFT_LOGIC())) {
        UUPSProxiable(address(_SUPER_TOKEN_LOGIC.POOL_MEMBER_NFT())).updateCode(address(newFactory.POOL_MEMBER_NFT_LOGIC()));
    }
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
- **Source**: 5102:166:162
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol:SuperTokenFactoryBase:proxiableUUID()`

```solidity
function proxiableUUID() override public pure returns (bytes32) {
    return keccak256("org.superfluid-finance.contracts.SuperTokenFactory.implementation");
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

- **SuperTokenFactory::POOL_ADMIN_NFT_LOGIC()**
- **UUPSProxiable::updateCode(address)**
- **ISuperToken::POOL_ADMIN_NFT()**
- **SuperTokenFactory::POOL_MEMBER_NFT_LOGIC()**
- **ISuperToken::POOL_MEMBER_NFT()**
- **UUPSProxiable::proxiableUUID()**

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **POOL_ADMIN_NFT_LOGIC** (`contract IPoolAdminNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolAdminNFT.sol/interface_IPoolAdminNFT.md]
- **_SUPER_TOKEN_LOGIC** (`contract ISuperToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]
- **POOL_MEMBER_NFT_LOGIC** (`contract IPoolMemberNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolMemberNFT.sol/interface_IPoolMemberNFT.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperTokenFactoryBase.updateCode(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: UUPSProxiable._updateCodeAddress(address) (NodeID: 1)
      💬 Args: [newAddress]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: UUPSUtils.implementation() (NodeID: 2)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperTokenFactoryBase.proxiableUUID() (NodeID: 3)
    │   💬 Args: [no args]
    │   👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: UUPSUtils.setImplementation(address) (NodeID: 4)
    │   💬 Args: [newAddress]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperTokenFactoryBase.proxiableUUID() (NodeID: 5)
        💬 Args: [no args]
        👁️  Def: public
```

## Documentation

### Function Documentation

@notice Updates the logic contract for the SuperTokenFactory
 @dev This function updates the logic contract for the SuperTokenFactory
 @param newAddress the new address of the SuperTokenFactory logic contract
