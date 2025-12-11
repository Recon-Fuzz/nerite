# Function: deriveUserProxyAddress(address)

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `deriveUserProxyAddress(address)`
- **Visibility**: public
- **Source Range**: 579:194:25
- **Inherited From**: UserProxyFactory

## Implementation

```solidity
/// @inheritdoc IUserProxyFactory
function deriveUserProxyAddress(address _user) public view returns (address) {
    return Clones.predictDeterministicAddress(userProxyImplementation, bytes32(uint256(uint160(_user))));
}
```

## Related Implementations

### predictDeterministicAddress(address,bytes32)

- **Kind**: internal
- **Source**: 3930:227:12
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/proxy/Clones.sol:Clones:predictDeterministicAddress(address,bytes32)`

```solidity
///  @dev Computes the address of a clone deployed using {Clones-cloneDeterministic}.
function predictDeterministicAddress(address implementation, bytes32 salt) internal view returns (address predicted) {
    return predictDeterministicAddress(implementation, salt, address(this));
}
```

### predictDeterministicAddress(address,bytes32,address)

- **Kind**: internal
- **Source**: 3140:680:12
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/proxy/Clones.sol:Clones:predictDeterministicAddress(address,bytes32,address)`

```solidity
///  @dev Computes the address of a clone deployed using {Clones-cloneDeterministic}.
function predictDeterministicAddress(address implementation, bytes32 salt, address deployer) internal pure returns (address predicted) {
    /// @solidity memory-safe-assembly
    assembly {
        let ptr := mload(0x40)
        mstore(add(ptr, 0x38), deployer)
        mstore(add(ptr, 0x24), 0x5af43d82803e903d91602b57fd5bf3ff)
        mstore(add(ptr, 0x14), implementation)
        mstore(ptr, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73)
        mstore(add(ptr, 0x58), salt)
        mstore(add(ptr, 0x78), keccak256(add(ptr, 0x0c), 0x37))
        predicted := keccak256(add(ptr, 0x43), 0x55)
    }
}
```

## State Variable Reads

- **userProxyImplementation** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserProxyFactory.deriveUserProxyAddress(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32) (NodeID: 1)
      💬 Args: [userProxyImplementation, bytes32(uint256(uint160(_user)))]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32,address) (NodeID: 2)
        💬 Args: [implementation, salt, address(this)]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IUserProxyFactory

### Interface Documentation

@notice Derive the address of a user's proxy contract
 @param _user Address of the user
 @return userProxyAddress Address of the user's proxy contract
