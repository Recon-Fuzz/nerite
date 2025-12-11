# Function: symbol()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 7232:104:161

## Implementation

```solidity
function symbol() virtual override external view returns (string memory) {
    return _symbol;
}
```

## State Variable Reads

- **_symbol** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.symbol() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns the symbol of the token, usually a shorter version of the
 name.

 @dev Returns the symbol of the token, usually a shorter version of the
 name.

 @dev Returns the symbol of the token.
