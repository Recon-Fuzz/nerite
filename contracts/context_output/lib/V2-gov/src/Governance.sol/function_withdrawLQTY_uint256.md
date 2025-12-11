# Function: withdrawLQTY(uint256)

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `withdrawLQTY(uint256)`
- **Visibility**: external
- **Source Range**: 7970:112:23

## Implementation

```solidity
/// @inheritdoc IGovernance
function withdrawLQTY(uint256 _lqtyAmount) external {
    withdrawLQTY(_lqtyAmount, true, msg.sender);
}
```

## Related Implementations

### withdrawLQTY(uint256,bool,address)

- **Kind**: internal
- **Source**: 8088:1494:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:withdrawLQTY(uint256,bool,address)`

```solidity
function withdrawLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public nonReentrant() {
    UserState storage userState = userStates[msg.sender];
    UserProxy userProxy = UserProxy(payable(deriveUserProxyAddress(msg.sender)));
    require(address(userProxy).code.length != 0, "Governance: user-proxy-not-deployed");
    require(_lqtyAmount <= userState.unallocatedLQTY, "Governance: insufficient-unallocated-lqty");
    if (_lqtyAmount < userState.unallocatedLQTY) {
        uint256 offsetDecrease = (_lqtyAmount * userState.unallocatedOffset) / userState.unallocatedLQTY;
        userState.unallocatedOffset -= offsetDecrease;
    } else {
        userState.unallocatedOffset = 0;
    }
    userState.unallocatedLQTY -= _lqtyAmount;
    (uint256 lqtyReceived, uint256 lqtySent, uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent) = userProxy.unstake(_lqtyAmount, _doSendRewards, _recipient);
    emit WithdrawLQTY(msg.sender, _recipient, lqtyReceived, lqtySent, lusdReceived, lusdSent, ethReceived, ethSent);
}
```

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

### nonReentrant()

- **Kind**: modifier
- **Source**: 2322:103:18
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:nonReentrant()`

```solidity
///  @dev Prevents a contract from calling itself, directly or indirectly.
///  Calling a `nonReentrant` function from another `nonReentrant`
///  function is not supported. It is possible to prevent this from happening
///  by making the `nonReentrant` function external, and making it call a
///  `private` function that does the actual work.
modifier nonReentrant() {
    _nonReentrantBefore();
    _;
    _nonReentrantAfter();
}
```

### _nonReentrantBefore()

- **Kind**: internal
- **Source**: 2431:307:18
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:_nonReentrantBefore()`

```solidity
function _nonReentrantBefore() private {
    if (_status == ENTERED) {
        revert ReentrancyGuardReentrantCall();
    }
    _status = ENTERED;
}
```

### _nonReentrantAfter()

- **Kind**: internal
- **Source**: 2744:208:18
- **Link**: `lib/V2-gov/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:_nonReentrantAfter()`

```solidity
function _nonReentrantAfter() private {
    _status = NOT_ENTERED;
}
```

## External Calls

- **UserProxy::unstake(uint256,bool,address)**

## State Variable Reads

- **userStates** (`mapping(address => struct IGovernance.UserState)`)
- **userProxyImplementation** (`address`)
- **_status** (`uint256`)
- **ENTERED** (`uint256`)
- **NOT_ENTERED** (`uint256`)

## State Variable Writes

- **_status** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.withdrawLQTY(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: Governance.withdrawLQTY(uint256,bool,address) (NodeID: 1)
      💬 Args: [_lqtyAmount, true, msg.sender]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: UserProxyFactory.deriveUserProxyAddress(address) (NodeID: 2)
    │   💬 Args: [msg.sender]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32) (NodeID: 3)
    │     💬 Args: [userProxyImplementation, bytes32(uint256(uint160(_user)))]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32,address) (NodeID: 4)
    │       💬 Args: [implementation, salt, address(this)]
    │       👁️  Def: internal
    └─ [2] 🔒 MODIFIER: ReentrancyGuard.nonReentrant() (NodeID: 5)
        💬 Args: [no args]
      ├─ [3] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantBefore() (NodeID: 6)
      │   💬 Args: [no args]
      │   👁️  Def: private
      └─ [3] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantAfter() (NodeID: 7)
          💬 Args: [no args]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@notice Withdraws LQTY and claims any accrued LUSD and ETH rewards from StakingV1
 @param _lqtyAmount Amount of LQTY to withdraw
