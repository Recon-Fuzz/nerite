# Function: authorizeOperator(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `authorizeOperator(address)`
- **Visibility**: external
- **Source Range**: 19436:222:161

## Implementation

```solidity
function authorizeOperator(address operator) virtual override external {
    address holder = msg.sender;
    _operators.authorizeOperator(holder, operator);
    emit AuthorizedOperator(operator, holder);
}
```

## Related Implementations

### authorizeOperator(struct ERC777Helper.Operators,address,address)

- **Kind**: internal
- **Source**: 1522:382:156
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/ERC777Helper.sol:ERC777Helper:authorizeOperator(struct ERC777Helper.Operators,address,address)`

```solidity
function authorizeOperator(Operators storage self, address holder, address operator) internal {
    require(holder != operator, "ERC777Operators: authorizing self as operator");
    if (self.defaultOperators[operator]) {
        delete self.revokedDefaultOperators[holder][operator];
    } else {
        self.operators[holder][operator] = true;
    }
}
```

## State Variable Reads

- **_operators** (`struct ERC777Helper.Operators`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.authorizeOperator(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC777Helper.authorizeOperator(struct ERC777Helper.Operators,address,address) (NodeID: 1)
      💬 Args: [_operators, holder, operator]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Make an account an operator of the caller.
 See {isOperatorFor}.
 @custom:emits an {AuthorizedOperator} event.
 @custom:requirements
 - `operator` cannot be calling address.

 @dev Make an account an operator of the caller.
 See {isOperatorFor}.
 Emits an {AuthorizedOperator} event.
 Requirements
 - `operator` cannot be calling address.
