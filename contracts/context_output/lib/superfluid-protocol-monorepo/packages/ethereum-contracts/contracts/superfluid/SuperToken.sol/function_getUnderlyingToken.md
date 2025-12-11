# Function: getUnderlyingToken()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `getUnderlyingToken()`
- **Visibility**: external
- **Source Range**: 22911:127:161

## Implementation

```solidity
/// @inheritdoc ISuperToken
function getUnderlyingToken() virtual override external view returns (address) {
    return address(_underlyingToken);
}
```

## State Variable Reads

- **_underlyingToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.getUnderlyingToken() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperToken

### Interface Documentation

 @dev Return the underlying token contract
 @return tokenAddr Underlying token address
