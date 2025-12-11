# Contract: FlowOperatorDefinitions

## Metadata

- **Name**: FlowOperatorDefinitions
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol
- **Documentation**:  @title Flow Operator definitions library
   @author Superfluid

## State Variables

### AUTHORIZE_FLOW_OPERATOR_CREATE

```solidity
uint8 internal constant AUTHORIZE_FLOW_OPERATOR_CREATE = uint8(1) << 0
```

### AUTHORIZE_FLOW_OPERATOR_UPDATE

```solidity
uint8 internal constant AUTHORIZE_FLOW_OPERATOR_UPDATE = uint8(1) << 1
```

### AUTHORIZE_FLOW_OPERATOR_DELETE

```solidity
uint8 internal constant AUTHORIZE_FLOW_OPERATOR_DELETE = uint8(1) << 2
```

### AUTHORIZE_FULL_CONTROL

```solidity
uint8 internal constant AUTHORIZE_FULL_CONTROL = (AUTHORIZE_FLOW_OPERATOR_CREATE | AUTHORIZE_FLOW_OPERATOR_UPDATE) | AUTHORIZE_FLOW_OPERATOR_DELETE
```

### REVOKE_FLOW_OPERATOR_CREATE

```solidity
uint8 internal constant REVOKE_FLOW_OPERATOR_CREATE = ~(uint8(1) << 0)
```

### REVOKE_FLOW_OPERATOR_UPDATE

```solidity
uint8 internal constant REVOKE_FLOW_OPERATOR_UPDATE = ~(uint8(1) << 1)
```

### REVOKE_FLOW_OPERATOR_DELETE

```solidity
uint8 internal constant REVOKE_FLOW_OPERATOR_DELETE = ~(uint8(1) << 2)
```
