# Contract: UUPSProxy

## Metadata

- **Name**: UUPSProxy
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/UUPSProxy.sol
- **Documentation**:  @title UUPS (Universal Upgradeable Proxy Standard) Proxy
   NOTE:
   - Compliant with [Universal Upgradeable Proxy Standard](https://eips.ethereum.org/EIPS/eip-1822)
   - Compiiant with [Standard Proxy Storage Slots](https://eips.ethereum.org/EIPS/eip-1967)
   - Implements delegation of calls to other contracts, with proper forwarding of
     return values and bubbling of failures.
   - It defines a fallback function that delegates all calls to the implementation.

## Public/External Functions

### initializeProxy(address)

- **Signature**: `initializeProxy(address)`
- **Visibility**: external
- **Source Range**: 898:285:49
- **Details**: [function_initializeProxy_address.md](./function_initializeProxy_address.md)

**Signature:**
```solidity
///  @dev Proxy initialization function.
///       This should only be called once and it is permission-less.
///  @param initialAddress Initial logic contract code address to be used.
function initializeProxy(address initialAddress) external;
```

### fallback() (inherited from Proxy)

- **Signature**: `fallback()`
- **Visibility**: external
- **Source Range**: 2629:64:6
- **Details**: [function_fallback.md](./function_fallback.md)

**Signature:**
```solidity
///  @dev Fallback function that delegates calls to the address returned by `_implementation()`. Will run if no other
///  function in the contract matches the call data.
fallback() virtual external payable;
```

### receive() (inherited from Proxy)

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 2853:63:6
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
///  @dev Fallback function that delegates calls to the address returned by `_implementation()`. Will run if call data
///  is empty.
receive() virtual external payable;
```
