# Function: nonces(address)

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `nonces(address)`
- **Visibility**: external
- **Source Range**: 8147:110:53

## Implementation

```solidity
function nonces(address owner) override external view returns (uint256) {
    return _nonces[owner];
}
```

## State Variable Reads

- **_nonces** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldToken.nonces(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns the current nonce for `owner`. This value must be
 included whenever a signature is generated for {permit}.
 Every successful call to {permit} increases ``owner``'s nonce by one. This
 prevents a signature from being used multiple times.
