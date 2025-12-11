# Contract: FullUpgradableSuperTokenProxy

## Metadata

- **Name**: FullUpgradableSuperTokenProxy
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/FullUpgradableSuperTokenProxy.sol
- **Documentation**:  @title Full upgradable super token proxy contract
   @author Superfluid

## State Variables

### _FACTORY_SLOT

```solidity
bytes32 internal constant _FACTORY_SLOT = 0xb8fcd5719b3ddf8626f3664705a89b7fc476129a58c1aa5eda57c600cc1821a0
```

## Errors

### FUSTP_ALREADY_INITIALIZED

```solidity
error FUSTP_ALREADY_INITIALIZED();
```

## Public/External Functions

### initialize()

- **Signature**: `initialize()`
- **Visibility**: external
- **Source Range**: 606:368:160
- **Details**: [function_initialize.md](./function_initialize.md)

**Signature:**
```solidity
function initialize() external;
```

### fallback() (inherited from Proxy)

- **Signature**: `fallback()`
- **Visibility**: external
- **Source Range**: 2629:64:80
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
- **Source Range**: 2853:63:80
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
///  @dev Fallback function that delegates calls to the address returned by `_implementation()`. Will run if call data
///  is empty.
receive() virtual external payable;
```
