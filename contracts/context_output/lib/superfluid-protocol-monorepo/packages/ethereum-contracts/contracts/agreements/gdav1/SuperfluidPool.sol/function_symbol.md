# Function: symbol()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 11574:144:127

## Implementation

```solidity
/// @inheritdoc IERC20Metadata
function symbol() override external view returns (string memory) {
    return (bytes(_erc20Symbol).length == 0) ? "POOL" : _erc20Symbol;
}
```

## State Variable Reads

- **_erc20Symbol** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.symbol() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IERC20Metadata

### Interface Documentation

 @dev Returns the symbol of the token.
