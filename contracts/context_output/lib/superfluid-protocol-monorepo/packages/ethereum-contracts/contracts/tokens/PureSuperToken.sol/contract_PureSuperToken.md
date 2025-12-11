# Contract: PureSuperToken

## Metadata

- **Name**: PureSuperToken
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/tokens/PureSuperToken.sol
- **Documentation**:  @title Native SuperToken custom super token implementation
   @author Superfluid
   @dev This is a simple implementation where the supply is pre-minted.

## Implements Interfaces

- **IPureSuperTokenCustom** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/tokens/IPureSuperToken.sol/interface_IPureSuperTokenCustom.md]

## State Variables

### _storagePaddings (inherited from CustomSuperTokenBase)

```solidity
uint256[32] internal _storagePaddings
```

## Public/External Functions

### initialize(string,string,uint256)

- **Signature**: `initialize(string,string,uint256)`
- **Visibility**: external
- **Source Range**: 641:516:165
- **Details**: [function_initialize_string_string_uint256.md](./function_initialize_string_string_uint256.md)

**Signature:**
```solidity
function initialize(string calldata name, string calldata symbol, uint256 initialSupply) override external;
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

### initializeProxy(address) (inherited from UUPSProxy)

- **Signature**: `initializeProxy(address)`
- **Visibility**: external
- **Source Range**: 898:285:170
- **Details**: [function_initializeProxy_address.md](./function_initializeProxy_address.md)

**Signature:**
```solidity
///  @dev Proxy initialization function.
///       This should only be called once and it is permission-less.
///  @param initialAddress Initial logic contract code address to be used.
function initializeProxy(address initialAddress) external;
```
