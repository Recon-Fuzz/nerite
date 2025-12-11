# Function: revokeOperator(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `revokeOperator(address)`
- **Visibility**: external
- **Source Range**: 19664:213:161

## Implementation

```solidity
function revokeOperator(address operator) virtual override external {
    address holder = msg.sender;
    _operators.revokeOperator(holder, operator);
    emit RevokedOperator(operator, holder);
}
```

## Related Implementations

### revokeOperator(struct ERC777Helper.Operators,address,address)

- **Kind**: internal
- **Source**: 1910:379:156
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/ERC777Helper.sol:ERC777Helper:revokeOperator(struct ERC777Helper.Operators,address,address)`

```solidity
function revokeOperator(Operators storage self, address holder, address operator) internal {
    require(operator != msg.sender, "ERC777Operators: revoking self as operator");
    if (self.defaultOperators[operator]) {
        self.revokedDefaultOperators[holder][operator] = true;
    } else {
        delete self.operators[holder][operator];
    }
}
```

## State Variable Reads

- **_operators** (`struct ERC777Helper.Operators`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.revokeOperator(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC777Helper.revokeOperator(struct ERC777Helper.Operators,address,address) (NodeID: 1)
      💬 Args: [_operators, holder, operator]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Revoke an account's operator status for the caller.
 See {isOperatorFor} and {defaultOperators}.
 @custom:emits a {RevokedOperator} event.
 @custom:requirements
 - `operator` cannot be calling address.

 @dev Revoke an account's operator status for the caller.
 See {isOperatorFor} and {defaultOperators}.
 Emits a {RevokedOperator} event.
 Requirements
 - `operator` cannot be calling address.
