# Function: setCollateralRegistry(address)

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `setCollateralRegistry(address)`
- **Visibility**: external
- **Source Range**: 4364:272:204

## Implementation

```solidity
function setCollateralRegistry(address _collateralRegistryAddress) override external onlyOwner() {
    collateralRegistryAddress = _collateralRegistryAddress;
    emit CollateralRegistryAddressChanged(_collateralRegistryAddress);
    _renounceOwnership();
}
```

## Related Implementations

### _renounceOwnership()

- **Kind**: internal
- **Source**: 1896:130:216
- **Link**: `src/Dependencies/Ownable.sol:Ownable:_renounceOwnership()`

```solidity
///  @dev Leaves the contract without owner. It will not be possible to call
///  `onlyOwner` functions anymore.
///  NOTE: Renouncing ownership will leave the contract without an owner,
///  thereby removing any functionality that is only available to the owner.
///  NOTE: This function is not safe, as it doesn’t check owner is calling it.
///  Make sure you check it before calling it.
function _renounceOwnership() internal {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
}
```

### onlyOwner()

- **Kind**: modifier
- **Source**: 1180:103:216
- **Link**: `src/Dependencies/Ownable.sol:Ownable:onlyOwner()`

```solidity
///  @dev Throws if called by any account other than the owner.
modifier onlyOwner() {
    require(isOwner(), "Ownable: caller is not the owner");
    _;
}
```

### isOwner()

- **Kind**: internal
- **Source**: 1366:90:216
- **Link**: `src/Dependencies/Ownable.sol:Ownable:isOwner()`

```solidity
///  @dev Returns true if the caller is the current owner.
function isOwner() public view returns (bool) {
    return msg.sender == _owner;
}
```

## State Variable Reads

- **_owner** (`address`)

## State Variable Writes

- **collateralRegistryAddress** (`address`)
- **_owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldToken.setCollateralRegistry(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Ownable._renounceOwnership() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Ownable.onlyOwner() (NodeID: 2)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Ownable.isOwner() (NodeID: 3)
        💬 Args: [no args]
        👁️  Def: public
```
