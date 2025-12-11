# Function: balanceOf(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 8771:128:127

## Implementation

```solidity
/// @notice Returns the total number of units for an account for this pool
///  @dev Although the type is uint256, this can never be greater than type(int128).max
///  because the custom user type Unit is int128 in the SemanticMoney library
///  @param account The account to query
///  @return The total number of owned units of the account
function balanceOf(address account) override external view returns (uint256) {
    return uint256(_getUnits(account));
}
```

## Related Implementations

### _getUnits(address)

- **Kind**: internal
- **Source**: 8277:130:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_getUnits(address)`

```solidity
function _getUnits(address memberAddr) internal view returns (uint128) {
    return _membersData[memberAddr].ownedUnits;
}
```

## State Variable Reads

- **_membersData** (`mapping(address => struct SuperfluidPool.MemberData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.balanceOf(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidPool._getUnits(address) (NodeID: 1)
      💬 Args: [account]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Returns the total number of units for an account for this pool
 @dev Although the type is uint256, this can never be greater than type(int128).max
 because the custom user type Unit is int128 in the SemanticMoney library
 @param account The account to query
 @return The total number of owned units of the account

### Interface Documentation

 @dev Returns the amount of tokens owned by `account`.
