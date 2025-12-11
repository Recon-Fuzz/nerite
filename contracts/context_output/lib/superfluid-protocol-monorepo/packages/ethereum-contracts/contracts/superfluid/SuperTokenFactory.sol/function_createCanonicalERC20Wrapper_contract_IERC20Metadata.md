# Function: createCanonicalERC20Wrapper(contract IERC20Metadata)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

## Metadata

- **Contract**: SuperTokenFactory
- **Signature**: `createCanonicalERC20Wrapper(contract IERC20Metadata)`
- **Visibility**: external
- **Source Range**: 6949:2052:162
- **Inherited From**: SuperTokenFactoryBase

## Implementation

```solidity
/// @inheritdoc ISuperTokenFactory
function createCanonicalERC20Wrapper(IERC20Metadata _underlyingToken) external returns (ISuperToken) {
    if (_canonicalWrapperSuperTokens[address(0)] == address(0)) {
        revert SUPER_TOKEN_FACTORY_UNINITIALIZED();
    }
    address underlyingTokenAddress = address(_underlyingToken);
    address canonicalSuperTokenAddress = _canonicalWrapperSuperTokens[underlyingTokenAddress];
    if (canonicalSuperTokenAddress != address(0)) {
        revert SUPER_TOKEN_FACTORY_ALREADY_EXISTS();
    }
    bytes32 salt = keccak256(abi.encode(underlyingTokenAddress));
    UUPSProxy proxy = new UUPSProxy{salt: salt}();
    _canonicalWrapperSuperTokens[underlyingTokenAddress] = address(proxy);
    proxy.initializeProxy(address(_SUPER_TOKEN_LOGIC));
    ISuperToken superToken = ISuperToken(address(proxy));
    uint8 underlyingDecimals = _underlyingToken.decimals();
    string memory underlyingName = _underlyingToken.name();
    string memory underlyingSymbol = _underlyingToken.symbol();
    superToken.initialize(_underlyingToken, underlyingDecimals, string.concat("Super ", underlyingName), string.concat(underlyingSymbol, "x"));
    emit SuperTokenCreated(superToken);
    return superToken;
}
```

## External Calls

- **unknown::unknown**
- **UUPSProxy::initializeProxy(address)**
- **IERC20Metadata::decimals()**
- **IERC20Metadata::name()**
- **IERC20Metadata::symbol()**
- **ISuperToken::initialize(contract IERC20,uint8,string,string)**

## State Variable Reads

- **_canonicalWrapperSuperTokens** (`mapping(address => address)`)
- **_SUPER_TOKEN_LOGIC** (`contract ISuperToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

## State Variable Writes

- **_canonicalWrapperSuperTokens** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperTokenFactoryBase.createCanonicalERC20Wrapper(contract IERC20Metadata) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperTokenFactory

### Interface Documentation

 @notice Creates a wrapper super token AND sets it in the canonical list OR reverts if it already exists
 @dev salt for create2 is the keccak256 hash of abi.encode(address(_underlyingToken))
 @param _underlyingToken Underlying ERC20 token
 @return ISuperToken the created supertoken
