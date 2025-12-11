# Function: toUnderlyingAmount(uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `toUnderlyingAmount(uint256)`
- **Visibility**: external
- **Source Range**: 23237:229:161

## Implementation

```solidity
/// @inheritdoc ISuperToken
function toUnderlyingAmount(uint256 amount) virtual override external view returns (uint256 underlyingAmount, uint256 adjustedAmount) {
    return _toUnderlyingAmount(amount);
}
```

## Related Implementations

### _toUnderlyingAmount(uint256)

- **Kind**: internal
- **Source**: 26558:964:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_toUnderlyingAmount(uint256)`

```solidity
///  @dev Handle decimal differences between underlying token and super token
function _toUnderlyingAmount(uint256 amount) private view returns (uint256 underlyingAmount, uint256 adjustedAmount) {
    uint256 factor;
    if (_underlyingDecimals < _STANDARD_DECIMALS) {
        factor = 10 ** (_STANDARD_DECIMALS - _underlyingDecimals);
        underlyingAmount = amount / factor;
        adjustedAmount = underlyingAmount * factor;
    } else if (_underlyingDecimals > _STANDARD_DECIMALS) {
        factor = 10 ** (_underlyingDecimals - _STANDARD_DECIMALS);
        underlyingAmount = amount * factor;
        adjustedAmount = amount;
    } else {
        underlyingAmount = adjustedAmount = amount;
    }
}
```

## State Variable Reads

- **_underlyingDecimals** (`uint8`)
- **_STANDARD_DECIMALS** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.toUnderlyingAmount(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperToken._toUnderlyingAmount(uint256) (NodeID: 1)
      💬 Args: [amount]
      👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperToken

### Interface Documentation

 @dev Return the underlying token conversion rate
 @param amount Number of tokens to be upgraded (in 18 decimals)
 @return underlyingAmount The underlying token amount after scaling
 @return adjustedAmount The super token amount after scaling
