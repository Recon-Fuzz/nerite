# Function: deployUserProxy()

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `deployUserProxy()`
- **Visibility**: public
- **Source Range**: 817:310:25
- **Inherited From**: UserProxyFactory

## Implementation

```solidity
/// @inheritdoc IUserProxyFactory
function deployUserProxy() public returns (address) {
    address userProxy = Clones.cloneDeterministic(userProxyImplementation, bytes32(uint256(uint160(msg.sender))));
    emit DeployUserProxy(msg.sender, userProxy);
    return userProxy;
}
```

## Related Implementations

### cloneDeterministic(address,bytes32)

- **Kind**: internal
- **Source**: 2209:821:12
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/proxy/Clones.sol:Clones:cloneDeterministic(address,bytes32)`

```solidity
///  @dev Deploys and returns the address of a clone that mimics the behaviour of `implementation`.
///  This function uses the create2 opcode and a `salt` to deterministically deploy
///  the clone. Using the same `implementation` and `salt` multiple time will revert, since
///  the clones cannot be deployed twice at the same address.
function cloneDeterministic(address implementation, bytes32 salt) internal returns (address instance) {
    /// @solidity memory-safe-assembly
    assembly {
        mstore(0x00, or(shr(0xe8, shl(0x60, implementation)), 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000))
        mstore(0x20, or(shl(0x78, implementation), 0x5af43d82803e903d91602b57fd5bf3))
        instance := create2(0, 0x09, 0x37, salt)
    }
    if (instance == address(0)) {
        revert ERC1167FailedCreateClone();
    }
}
```

## State Variable Reads

- **userProxyImplementation** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserProxyFactory.deployUserProxy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Clones.cloneDeterministic(address,bytes32) (NodeID: 1)
      💬 Args: [userProxyImplementation, bytes32(uint256(uint160(msg.sender)))]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IUserProxyFactory

### Interface Documentation

@notice Deploy a new UserProxy contract for the sender
 @return userProxyAddress Address of the deployed UserProxy contract
