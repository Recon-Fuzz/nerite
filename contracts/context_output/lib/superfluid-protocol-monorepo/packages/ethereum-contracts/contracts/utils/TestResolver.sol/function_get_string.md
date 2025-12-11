# Function: get(string)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol/contract_TestResolver.md]

## Metadata

- **Contract**: TestResolver
- **Signature**: `get(string)`
- **Visibility**: external
- **Source Range**: 950:115:178
- **Inherited From**: Resolver

## Implementation

```solidity
function get(string calldata name) override external view returns (address) {
    return _registry[name];
}
```

## State Variable Reads

- **_registry** (`mapping(string => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Resolver.get(string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Get address by name
