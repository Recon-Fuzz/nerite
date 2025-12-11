# Function: defaultOperators()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `defaultOperators()`
- **Visibility**: external
- **Source Range**: 19883:151:161

## Implementation

```solidity
function defaultOperators() virtual override external view returns (address[] memory) {
    return ERC777Helper.defaultOperators(_operators);
}
```

## Related Implementations

### defaultOperators(struct ERC777Helper.Operators)

- **Kind**: internal
- **Source**: 2295:141:156
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/ERC777Helper.sol:ERC777Helper:defaultOperators(struct ERC777Helper.Operators)`

```solidity
function defaultOperators(Operators storage self) internal view returns (address[] memory) {
    return self.defaultOperatorsArray;
}
```

## State Variable Reads

- **_operators** (`struct ERC777Helper.Operators`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.defaultOperators() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC777Helper.defaultOperators(struct ERC777Helper.Operators) (NodeID: 1)
      💬 Args: [_operators]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Returns the list of default operators. These accounts are operators
 for all token holders, even if {authorizeOperator} was never called on
 them.
 This list is immutable, but individual holders may revoke these via
 {revokeOperator}, in which case {isOperatorFor} will return false.

 @dev Returns the list of default operators. These accounts are operators
 for all token holders, even if {authorizeOperator} was never called on
 them.
 This list is immutable, but individual holders may revoke these via
 {revokeOperator}, in which case {isOperatorFor} will return false.
