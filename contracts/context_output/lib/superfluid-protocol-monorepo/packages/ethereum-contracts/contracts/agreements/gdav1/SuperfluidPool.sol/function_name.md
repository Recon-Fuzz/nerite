# Function: name()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 11384:149:127

## Implementation

```solidity
/// @inheritdoc IERC20Metadata
function name() override external view returns (string memory) {
    return (bytes(_erc20Name).length == 0) ? "Superfluid Pool" : _erc20Name;
}
```

## State Variable Reads

- **_erc20Name** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IERC20Metadata

### Interface Documentation

 @dev Returns the name of the token.
