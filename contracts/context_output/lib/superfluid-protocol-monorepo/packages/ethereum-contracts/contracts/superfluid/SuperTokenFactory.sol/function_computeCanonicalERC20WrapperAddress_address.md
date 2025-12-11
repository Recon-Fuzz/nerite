# Function: computeCanonicalERC20WrapperAddress(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

## Metadata

- **Contract**: SuperTokenFactory
- **Signature**: `computeCanonicalERC20WrapperAddress(address)`
- **Visibility**: external
- **Source Range**: 12398:1033:162
- **Inherited From**: SuperTokenFactoryBase

## Implementation

```solidity
/// @inheritdoc ISuperTokenFactory
function computeCanonicalERC20WrapperAddress(address _underlyingToken) external view returns (address superTokenAddress, bool isDeployed) {
    address existingAddress = _canonicalWrapperSuperTokens[_underlyingToken];
    if (existingAddress != address(0)) {
        superTokenAddress = existingAddress;
        isDeployed = true;
    } else {
        bytes memory bytecode = type(UUPSProxy).creationCode;
        superTokenAddress = address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xff), address(this), keccak256(abi.encode(_underlyingToken)), keccak256(bytecode))))));
        isDeployed = false;
    }
}
```

## State Variable Reads

- **_canonicalWrapperSuperTokens** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperTokenFactoryBase.computeCanonicalERC20WrapperAddress(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperTokenFactory

### Interface Documentation

 @notice Computes/Retrieves wrapper super token address given the underlying token address
 @dev We return from our canonical list if it already exists, otherwise we compute it
 @dev note that this function only computes addresses for SEMI_UPGRADABLE SuperTokens
 @param _underlyingToken Underlying ERC20 token address
 @return superTokenAddress Super token address
 @return isDeployed whether the super token is deployed AND set in the canonical mapping
