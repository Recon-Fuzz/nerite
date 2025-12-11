# Contract: ContextDefinitions

## Metadata

- **Name**: ContextDefinitions
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol
- **Documentation**:  @title Context definitions library
   @author Superfluid

## State Variables

### CALL_INFO_APP_LEVEL_MASK

```solidity
uint256 internal constant CALL_INFO_APP_LEVEL_MASK = 0xFF
```

### CALL_INFO_CALL_TYPE_SHIFT

```solidity
uint256 internal constant CALL_INFO_CALL_TYPE_SHIFT = 32
```

### CALL_INFO_CALL_TYPE_MASK

```solidity
uint256 internal constant CALL_INFO_CALL_TYPE_MASK = 0xF << CALL_INFO_CALL_TYPE_SHIFT
```

### CALL_INFO_CALL_TYPE_AGREEMENT

```solidity
uint8 internal constant CALL_INFO_CALL_TYPE_AGREEMENT = 1
```

### CALL_INFO_CALL_TYPE_APP_ACTION

```solidity
uint8 internal constant CALL_INFO_CALL_TYPE_APP_ACTION = 2
```

### CALL_INFO_CALL_TYPE_APP_CALLBACK

```solidity
uint8 internal constant CALL_INFO_CALL_TYPE_APP_CALLBACK = 3
```
