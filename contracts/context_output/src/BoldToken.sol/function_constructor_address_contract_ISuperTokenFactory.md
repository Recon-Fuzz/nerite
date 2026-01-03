# Function: constructor(address,contract ISuperTokenFactory)

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `constructor(address,contract ISuperTokenFactory)`
- **Visibility**: public
- **Source Range**: 2925:74:53

## Implementation

```solidity
constructor(address _owner, ISuperTokenFactory factory) Ownable(_owner) {}
```

## Related Implementations

### (address)

- **Kind**: internal
- **Source**: 806:133:65
- **Link**: `src/Dependencies/Ownable.sol:Ownable:constructor(address)`

```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner) {
    _owner = initialOwner;
    emit OwnershipTransferred(address(0), initialOwner);
}
```

## State Variable Writes

- **_owner** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: BoldToken.constructor(address,contract ISuperTokenFactory) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: BoldToken
  └─ [1] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 1)
      💬 Args: [_owner]
      🏗️  Contract: Ownable
```
