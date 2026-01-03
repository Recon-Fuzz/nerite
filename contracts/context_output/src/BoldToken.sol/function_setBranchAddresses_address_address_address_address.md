# Function: setBranchAddresses(address,address,address,address)

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `setBranchAddresses(address,address,address,address)`
- **Visibility**: external
- **Source Range**: 3625:733:53

## Implementation

```solidity
function setBranchAddresses(address _troveManagerAddress, address _stabilityPoolAddress, address _borrowerOperationsAddress, address _activePoolAddress) override external onlyOwner() {
    troveManagerAddresses[_troveManagerAddress] = true;
    emit TroveManagerAddressAdded(_troveManagerAddress);
    stabilityPoolAddresses[_stabilityPoolAddress] = true;
    emit StabilityPoolAddressAdded(_stabilityPoolAddress);
    borrowerOperationsAddresses[_borrowerOperationsAddress] = true;
    emit BorrowerOperationsAddressAdded(_borrowerOperationsAddress);
    activePoolAddresses[_activePoolAddress] = true;
    emit ActivePoolAddressAdded(_activePoolAddress);
}
```

## Related Implementations

### onlyOwner()

- **Kind**: modifier
- **Source**: 1180:103:65
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
- **Source**: 1366:90:65
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

- **troveManagerAddresses** (`mapping(address => bool)`)
- **stabilityPoolAddresses** (`mapping(address => bool)`)
- **borrowerOperationsAddresses** (`mapping(address => bool)`)
- **activePoolAddresses** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldToken.setBranchAddresses(address,address,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Ownable.onlyOwner() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Ownable.isOwner() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: public
```
