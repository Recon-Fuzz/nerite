# Function: totalSupply()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 16835:118:161

## Implementation

```solidity
function totalSupply() virtual override public view returns (uint256) {
    return _totalSupply;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.totalSupply() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev See {IERC20-totalSupply}.

 @dev Returns the amount of tokens in existence.

 @dev Returns the amount of tokens in existence.
