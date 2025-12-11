# Function: initializeCanonicalWrapperSuperTokens(struct SuperTokenFactoryBase.InitializeData[])

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

## Metadata

- **Contract**: SuperTokenFactory
- **Signature**: `initializeCanonicalWrapperSuperTokens(struct SuperTokenFactoryBase.InitializeData[])`
- **Visibility**: external
- **Source Range**: 13988:789:162
- **Inherited From**: SuperTokenFactoryBase

## Implementation

```solidity
/// @notice Initializes list of canonical wrapper super tokens.
///  @dev Note that this should also be kind of a throwaway function which will be executed only once.
///  @param _data an array of canonical wrappper super tokens to be set
function initializeCanonicalWrapperSuperTokens(InitializeData[] calldata _data) virtual external {
    Ownable gov = Ownable(address(_host.getGovernance()));
    if (msg.sender != gov.owner()) revert SUPER_TOKEN_FACTORY_ONLY_GOVERNANCE_OWNER();
    if (_canonicalWrapperSuperTokens[address(0)] != address(0)) {
        revert SUPER_TOKEN_FACTORY_ALREADY_EXISTS();
    }
    for (uint256 i = 0; i < _data.length; i++) {
        _canonicalWrapperSuperTokens[_data[i].underlyingToken] = _data[i].superToken;
    }
}
```

## External Calls

- **ISuperfluid::getGovernance()**
- **Ownable::owner()**

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_canonicalWrapperSuperTokens** (`mapping(address => address)`)

## State Variable Writes

- **_canonicalWrapperSuperTokens** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperTokenFactoryBase.initializeCanonicalWrapperSuperTokens(struct SuperTokenFactoryBase.InitializeData[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Initializes list of canonical wrapper super tokens.
 @dev Note that this should also be kind of a throwaway function which will be executed only once.
 @param _data an array of canonical wrappper super tokens to be set
