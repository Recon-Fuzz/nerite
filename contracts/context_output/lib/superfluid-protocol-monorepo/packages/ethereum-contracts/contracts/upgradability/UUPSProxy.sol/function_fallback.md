# Function: fallback()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/UUPSProxy.sol/contract_UUPSProxy.md]

## Metadata

- **Contract**: UUPSProxy
- **Signature**: `fallback()`
- **Visibility**: external
- **Source Range**: 2629:64:80
- **Inherited From**: Proxy

## Implementation

```solidity
///  @dev Fallback function that delegates calls to the address returned by `_implementation()`. Will run if no other
///  function in the contract matches the call data.
fallback() virtual external payable {
    _fallback();
}
```

## Related Implementations

### _fallback()

- **Kind**: internal
- **Source**: 2322:110:80
- **Link**: `lib/openzeppelin-contracts/contracts/proxy/Proxy.sol:Proxy:_fallback()`

```solidity
///  @dev Delegates the current call to the address returned by `_implementation()`.
///  This function does not return to its internal call site, it will return directly to the external caller.
function _fallback() virtual internal {
    _beforeFallback();
    _delegate(_implementation());
}
```

### _beforeFallback()

- **Kind**: internal
- **Source**: 3198:46:80
- **Link**: `lib/openzeppelin-contracts/contracts/proxy/Proxy.sol:Proxy:_beforeFallback()`

```solidity
///  @dev Hook that is called before falling back to the implementation. Can happen as part of a manual `_fallback`
///  call, or as part of the Solidity `fallback` or `receive` functions.
///  If overridden should call `super._beforeFallback()`.
function _beforeFallback() virtual internal {}
```

### _delegate(address)

- **Kind**: internal
- **Source**: 948:895:80
- **Link**: `lib/openzeppelin-contracts/contracts/proxy/Proxy.sol:Proxy:_delegate(address)`

```solidity
///  @dev Delegates the current call to `implementation`.
///  This function does not return to its internal call site, it will return directly to the external caller.
function _delegate(address implementation) virtual internal {
    assembly {
        calldatacopy(0, 0, calldatasize())
        let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)
        returndatacopy(0, 0, returndatasize())
        switch result
        case 0 {
            revert(0, returndatasize())
        }
        default {
            return(0, returndatasize())
        }
    }
}
```

### _implementation()

- **Kind**: internal
- **Source**: 1239:130:170
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/UUPSProxy.sol:UUPSProxy:_implementation()`

```solidity
/// @dev Proxy._implementation implementation
function _implementation() virtual override internal view returns (address) {
    return UUPSUtils.implementation();
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

## External Calls

- **IBeacon::implementation()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Proxy.fallback() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: Proxy._fallback() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Proxy._beforeFallback() (NodeID: 2)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Proxy._delegate(address) (NodeID: 3)
        💬 Args: [_implementation()]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: UUPSProxy._implementation() (NodeID: 4)
          💬 Args: [no args]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: UUPSUtils.implementation() (NodeID: 5)
            💬 Args: [no args]
            👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev Fallback function that delegates calls to the address returned by `_implementation()`. Will run if no other
 function in the contract matches the call data.
