# Function: claimFromStakingV1(address)

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `claimFromStakingV1(address)`
- **Visibility**: external
- **Source Range**: 9620:717:23

## Implementation

```solidity
/// @inheritdoc IGovernance
function claimFromStakingV1(address _rewardRecipient) external returns (uint256 lusdSent, uint256 ethSent) {
    address payable userProxyAddress = payable(deriveUserProxyAddress(msg.sender));
    require(userProxyAddress.code.length != 0, "Governance: user-proxy-not-deployed");
    uint256 lqtyReceived;
    uint256 lqtySent;
    uint256 lusdReceived;
    uint256 ethReceived;
    (lqtyReceived, lqtySent, lusdReceived, lusdSent, ethReceived, ethSent) = UserProxy(userProxyAddress).unstake(0, true, _rewardRecipient);
    emit WithdrawLQTY(msg.sender, _rewardRecipient, lqtyReceived, lqtySent, lusdReceived, lusdSent, ethReceived, ethSent);
}
```

## Related Implementations

### deriveUserProxyAddress(address)

- **Kind**: internal
- **Source**: 579:194:25
- **Link**: `lib/V2-gov/src/UserProxyFactory.sol:UserProxyFactory:deriveUserProxyAddress(address)`

```solidity
/// @inheritdoc IUserProxyFactory
function deriveUserProxyAddress(address _user) public view returns (address) {
    return Clones.predictDeterministicAddress(userProxyImplementation, bytes32(uint256(uint160(_user))));
}
```

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

## External Calls

- **UserProxy::unstake(uint256,bool,address)**

## State Variable Reads

- **userProxyImplementation** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.claimFromStakingV1(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: UserProxyFactory.deriveUserProxyAddress(address) (NodeID: 1)
      💬 Args: [msg.sender]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32) (NodeID: 2)
        💬 Args: [userProxyImplementation, bytes32(uint256(uint160(_user)))]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32,address) (NodeID: 3)
          💬 Args: [implementation, salt, address(this)]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@notice Claims staking rewards from StakingV1 without unstaking
 @dev Note: in the unlikely event that the caller's `UserProxy` holds any LQTY tokens, they will also be sent to `_rewardRecipient`
 @param _rewardRecipient Address that will receive the rewards
 @return lusdSent Amount of LUSD tokens sent to `_rewardRecipient` (may include previously received LUSD)
 @return ethSent Amount of ETH sent to `_rewardRecipient` (may include previously received ETH)
