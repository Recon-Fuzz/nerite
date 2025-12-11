# Function: getUnderlyingDecimals()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `getUnderlyingDecimals()`
- **Visibility**: external
- **Source Range**: 23076:123:161

## Implementation

```solidity
/// @inheritdoc ISuperToken
function getUnderlyingDecimals() virtual override external view returns (uint8) {
    return _underlyingDecimals;
}
```

## State Variable Reads

- **_underlyingDecimals** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.getUnderlyingDecimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperToken

### Interface Documentation

 @dev Return the underlying token decimals
 @return underlyingDecimals Underlying token decimals
