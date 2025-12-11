# Function: granularity()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `granularity()`
- **Visibility**: external
- **Source Range**: 18797:85:161

## Implementation

```solidity
function granularity() virtual override external pure returns (uint256) {
    return 1;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.granularity() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns the smallest part of the token that is not divisible. This
         means all token operations (creation, movement and destruction) must have
         amounts that are a multiple of this number.
 @custom:note For super token contracts, this value is always 1

 @dev Returns the smallest part of the token that is not divisible. This
 means all token operations (creation, movement and destruction) must have
 amounts that are a multiple of this number.
 For most token contracts, this value will equal 1.
