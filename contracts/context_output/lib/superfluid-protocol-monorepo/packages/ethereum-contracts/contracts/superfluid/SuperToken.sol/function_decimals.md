# Function: decimals()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 7342:109:161

## Implementation

```solidity
function decimals() virtual override external pure returns (uint8) {
    return _STANDARD_DECIMALS;
}
```

## State Variable Reads

- **_STANDARD_DECIMALS** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns the number of decimals used to get its user representation.
 For example, if `decimals` equals `2`, a balance of `505` tokens should
 be displayed to a user as `5,05` (`505 / 10 ** 2`).
 Tokens usually opt for a value of 18, imitating the relationship between
 Ether and Wei. This is the value {ERC20} uses, unless {_setupDecimals} is
 called.
 @custom:note SuperToken always uses 18 decimals.
 This information is only used for _display_ purposes: it in
 no way affects any of the arithmetic of the contract, including
 {IERC20-balanceOf} and {IERC20-transfer}.

 @dev Returns the decimals places of the token.
