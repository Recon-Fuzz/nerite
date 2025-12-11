# Function: getCanonicalERC20Wrapper(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

## Metadata

- **Contract**: SuperTokenFactory
- **Signature**: `getCanonicalERC20Wrapper(address)`
- **Visibility**: external
- **Source Range**: 13476:257:162
- **Inherited From**: SuperTokenFactoryBase

## Implementation

```solidity
/// @inheritdoc ISuperTokenFactory
function getCanonicalERC20Wrapper(address _underlyingTokenAddress) external view returns (address superTokenAddress) {
    superTokenAddress = _canonicalWrapperSuperTokens[_underlyingTokenAddress];
}
```

## State Variable Reads

- **_canonicalWrapperSuperTokens** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperTokenFactoryBase.getCanonicalERC20Wrapper(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperTokenFactory

### Interface Documentation

 @notice Gets the canonical ERC20 wrapper super token address given the underlying token address
 @dev We return the address if it exists and the zero address otherwise
 @param _underlyingTokenAddress Underlying ERC20 token address
 @return superTokenAddress Super token address
