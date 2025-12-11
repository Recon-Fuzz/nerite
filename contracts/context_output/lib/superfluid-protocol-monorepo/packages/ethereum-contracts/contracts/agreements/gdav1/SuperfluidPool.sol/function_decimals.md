# Function: decimals()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 11759:97:127

## Implementation

```solidity
/// @inheritdoc IERC20Metadata
function decimals() override external view returns (uint8) {
    return _erc20Decimals;
}
```

## State Variable Reads

- **_erc20Decimals** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IERC20Metadata

### Interface Documentation

 @dev Returns the decimals places of the token.
