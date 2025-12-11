# Function: get(string)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/Resolver.sol/contract_Resolver.md]

## Metadata

- **Contract**: Resolver
- **Signature**: `get(string)`
- **Visibility**: external
- **Source Range**: 950:115:178

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
