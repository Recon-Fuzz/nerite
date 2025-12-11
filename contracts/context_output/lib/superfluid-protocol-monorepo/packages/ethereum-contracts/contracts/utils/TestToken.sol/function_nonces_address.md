# Function: nonces(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestToken.sol/contract_TestToken.md]

## Metadata

- **Contract**: TestToken
- **Signature**: `nonces(address)`
- **Visibility**: public
- **Source Range**: 2603:126:90
- **Inherited From**: ERC20Permit

## Implementation

```solidity
///  @inheritdoc IERC20Permit
function nonces(address owner) virtual override public view returns (uint256) {
    return _nonces[owner].current();
}
```

## Related Implementations

### current(struct Counters.Counter)

- **Kind**: internal
- **Source**: 827:112:105
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Counters.sol:Counters:current(struct Counters.Counter)`

```solidity
function current(Counter storage counter) internal view returns (uint256) {
    return counter._value;
}
```

## State Variable Reads

- **_nonces** (`mapping(address => struct Counters.Counter)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Permit.nonces(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Counters.current(struct Counters.Counter) (NodeID: 1)
      💬 Args: [_nonces[owner]]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 @inheritdoc IERC20Permit

### Interface Documentation

 @dev Returns the current nonce for `owner`. This value must be
 included whenever a signature is generated for {permit}.
 Every successful call to {permit} increases ``owner``'s nonce by one. This
 prevents a signature from being used multiple times.
