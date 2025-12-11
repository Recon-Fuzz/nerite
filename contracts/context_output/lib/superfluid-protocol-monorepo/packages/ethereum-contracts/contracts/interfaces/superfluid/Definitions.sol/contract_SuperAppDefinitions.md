# Contract: SuperAppDefinitions

## Metadata

- **Name**: SuperAppDefinitions
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol
- **Documentation**:  @title Super app definitions library
   @author Superfluid

## State Variables

### APP_LEVEL_MASK

```solidity
uint256 internal constant APP_LEVEL_MASK = 0xFF
```

### APP_LEVEL_FINAL

```solidity
uint256 internal constant APP_LEVEL_FINAL = 1 << 0
```

### APP_LEVEL_SECOND

```solidity
uint256 internal constant APP_LEVEL_SECOND = 1 << 1
```

### APP_JAIL_BIT

```solidity
uint256 internal constant APP_JAIL_BIT = 1 << 15
```

### AGREEMENT_CALLBACK_NOOP_BITMASKS

```solidity
uint256 internal constant AGREEMENT_CALLBACK_NOOP_BITMASKS = 0xFF << 32
```

### BEFORE_AGREEMENT_CREATED_NOOP

```solidity
uint256 internal constant BEFORE_AGREEMENT_CREATED_NOOP = 1 << (32 + 0)
```

### AFTER_AGREEMENT_CREATED_NOOP

```solidity
uint256 internal constant AFTER_AGREEMENT_CREATED_NOOP = 1 << (32 + 1)
```

### BEFORE_AGREEMENT_UPDATED_NOOP

```solidity
uint256 internal constant BEFORE_AGREEMENT_UPDATED_NOOP = 1 << (32 + 2)
```

### AFTER_AGREEMENT_UPDATED_NOOP

```solidity
uint256 internal constant AFTER_AGREEMENT_UPDATED_NOOP = 1 << (32 + 3)
```

### BEFORE_AGREEMENT_TERMINATED_NOOP

```solidity
uint256 internal constant BEFORE_AGREEMENT_TERMINATED_NOOP = 1 << (32 + 4)
```

### AFTER_AGREEMENT_TERMINATED_NOOP

```solidity
uint256 internal constant AFTER_AGREEMENT_TERMINATED_NOOP = 1 << (32 + 5)
```

### APP_RULE_NO_REVERT_ON_TERMINATION_CALLBACK

```solidity
uint256 internal constant APP_RULE_NO_REVERT_ON_TERMINATION_CALLBACK = 10
```

### APP_RULE_NO_CRITICAL_SENDER_ACCOUNT

```solidity
uint256 internal constant APP_RULE_NO_CRITICAL_SENDER_ACCOUNT = 11
```

### APP_RULE_NO_CRITICAL_RECEIVER_ACCOUNT

```solidity
uint256 internal constant APP_RULE_NO_CRITICAL_RECEIVER_ACCOUNT = 12
```

### APP_RULE_CTX_IS_READONLY

```solidity
uint256 internal constant APP_RULE_CTX_IS_READONLY = 20
```

### APP_RULE_CTX_IS_NOT_CLEAN

```solidity
uint256 internal constant APP_RULE_CTX_IS_NOT_CLEAN = 21
```

### APP_RULE_CTX_IS_MALFORMATED

```solidity
uint256 internal constant APP_RULE_CTX_IS_MALFORMATED = 22
```

### APP_RULE_COMPOSITE_APP_IS_NOT_WHITELISTED

```solidity
uint256 internal constant APP_RULE_COMPOSITE_APP_IS_NOT_WHITELISTED = 30
```

### APP_RULE_COMPOSITE_APP_IS_JAILED

```solidity
uint256 internal constant APP_RULE_COMPOSITE_APP_IS_JAILED = 31
```

### APP_RULE_MAX_APP_LEVEL_REACHED

```solidity
uint256 internal constant APP_RULE_MAX_APP_LEVEL_REACHED = 40
```
