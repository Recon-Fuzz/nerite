# Contract: ERC777Helper

## Metadata

- **Name**: ERC777Helper
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/ERC777Helper.sol
- **Documentation**:  @title ERC777 helper library
   @author Superfluid

## State Variables

### _ERC1820_REGISTRY

```solidity
IERC1820Registry internal constant _ERC1820_REGISTRY = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24)
```

**IERC1820Registry**: [lib/openzeppelin-contracts/contracts/utils/introspection/IERC1820Registry.sol/interface_IERC1820Registry.md]

### _TOKENS_SENDER_INTERFACE_HASH

```solidity
bytes32 internal constant _TOKENS_SENDER_INTERFACE_HASH = keccak256("ERC777TokensSender")
```

### _TOKENS_RECIPIENT_INTERFACE_HASH

```solidity
bytes32 internal constant _TOKENS_RECIPIENT_INTERFACE_HASH = keccak256("ERC777TokensRecipient")
```

## Structs

### Operators

```solidity
/// @dev ERC777 operators support self structure
struct Operators {
    address[] defaultOperatorsArray;
    mapping(address => bool) defaultOperators;
    mapping(address => mapping(address => bool)) operators;
    mapping(address => mapping(address => bool)) revokedDefaultOperators;
}
```
