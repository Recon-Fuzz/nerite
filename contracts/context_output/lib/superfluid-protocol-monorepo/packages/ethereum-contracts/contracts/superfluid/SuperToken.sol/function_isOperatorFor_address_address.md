# Function: isOperatorFor(address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `isOperatorFor(address,address)`
- **Visibility**: external
- **Source Range**: 19251:179:161

## Implementation

```solidity
function isOperatorFor(address operator, address tokenHolder) virtual override external view returns (bool) {
    return _operators.isOperatorFor(operator, tokenHolder);
}
```

## Related Implementations

### isOperatorFor(struct ERC777Helper.Operators,address,address)

- **Kind**: internal
- **Source**: 1150:366:156
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/ERC777Helper.sol:ERC777Helper:isOperatorFor(struct ERC777Helper.Operators,address,address)`

```solidity
function isOperatorFor(Operators storage self, address operator, address tokenHolder) internal view returns (bool) {
    return ((operator == tokenHolder) || (self.defaultOperators[operator] && (!self.revokedDefaultOperators[tokenHolder][operator]))) || self.operators[tokenHolder][operator];
}
```

## State Variable Reads

- **_operators** (`struct ERC777Helper.Operators`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.isOperatorFor(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC777Helper.isOperatorFor(struct ERC777Helper.Operators,address,address) (NodeID: 1)
      💬 Args: [_operators, operator, tokenHolder]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Returns true if an account is an operator of `tokenHolder`.
 Operators can send and burn tokens on behalf of their owners. All
 accounts are their own operator.
 See {operatorSend} and {operatorBurn}.

 @dev Returns true if an account is an operator of `tokenHolder`.
 Operators can send and burn tokens on behalf of their owners. All
 accounts are their own operator.
 See {operatorSend} and {operatorBurn}.
