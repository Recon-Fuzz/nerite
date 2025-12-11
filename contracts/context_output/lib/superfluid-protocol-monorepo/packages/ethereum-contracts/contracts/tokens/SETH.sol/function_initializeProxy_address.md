# Function: initializeProxy(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/tokens/SETH.sol/contract_SETHProxy.md]

## Metadata

- **Contract**: SETHProxy
- **Signature**: `initializeProxy(address)`
- **Visibility**: external
- **Source Range**: 898:285:170
- **Inherited From**: UUPSProxy

## Implementation

```solidity
///  @dev Proxy initialization function.
///       This should only be called once and it is permission-less.
///  @param initialAddress Initial logic contract code address to be used.
function initializeProxy(address initialAddress) external {
    require(initialAddress != address(0), "UUPSProxy: zero address");
    require(UUPSUtils.implementation() == address(0), "UUPSProxy: already initialized");
    UUPSUtils.setImplementation(initialAddress);
}
```

## Related Implementations

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UUPSProxy.initializeProxy(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: UUPSUtils.implementation() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: UUPSUtils.setImplementation(address) (NodeID: 2)
      💬 Args: [initialAddress]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev Proxy initialization function.
      This should only be called once and it is permission-less.
 @param initialAddress Initial logic contract code address to be used.
