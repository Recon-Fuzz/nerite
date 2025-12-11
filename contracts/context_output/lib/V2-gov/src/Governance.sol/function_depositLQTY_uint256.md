# Function: depositLQTY(uint256)

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `depositLQTY(uint256)`
- **Visibility**: external
- **Source Range**: 6558:111:23

## Implementation

```solidity
/// @inheritdoc IGovernance
function depositLQTY(uint256 _lqtyAmount) external {
    depositLQTY(_lqtyAmount, false, msg.sender);
}
```

## Related Implementations

### depositLQTY(uint256,bool,address)

- **Kind**: internal
- **Source**: 6675:462:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:depositLQTY(uint256,bool,address)`

```solidity
function depositLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public nonReentrant() {
    UserProxy userProxy = _increaseUserVoteTrackers(_lqtyAmount);
    (uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent) = userProxy.stake(_lqtyAmount, msg.sender, _doSendRewards, _recipient);
    emit DepositLQTY(msg.sender, _recipient, _lqtyAmount, lusdReceived, lusdSent, ethReceived, ethSent);
}
```

### _increaseUserVoteTrackers(uint256)

- **Kind**: internal
- **Source**: 5915:605:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:_increaseUserVoteTrackers(uint256)`

```solidity
function _increaseUserVoteTrackers(uint256 _lqtyAmount) private returns (UserProxy) {
    require(_lqtyAmount > 0, "Governance: zero-lqty-amount");
    address userProxyAddress = deriveUserProxyAddress(msg.sender);
    if (userProxyAddress.code.length == 0) {
        deployUserProxy();
    }
    UserProxy userProxy = UserProxy(payable(userProxyAddress));
    userStates[msg.sender].unallocatedLQTY += _lqtyAmount;
    userStates[msg.sender].unallocatedOffset += block.timestamp * _lqtyAmount;
    return userProxy;
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

### deployUserProxy()

- **Kind**: internal
- **Source**: 817:310:25
- **Link**: `lib/V2-gov/src/UserProxyFactory.sol:UserProxyFactory:deployUserProxy()`

```solidity
/// @inheritdoc IUserProxyFactory
function deployUserProxy() public returns (address) {
    address userProxy = Clones.cloneDeterministic(userProxyImplementation, bytes32(uint256(uint160(msg.sender))));
    emit DeployUserProxy(msg.sender, userProxy);
    return userProxy;
}
```

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

- **UserProxy::stake(uint256,address,bool,address)**

## State Variable Reads

- **userProxyImplementation** (`address`)
- **_status** (`uint256`)
- **ENTERED** (`uint256`)
- **NOT_ENTERED** (`uint256`)

## State Variable Writes

- **userStates** (`mapping(address => struct IGovernance.UserState)`)
- **_status** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.depositLQTY(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: Governance.depositLQTY(uint256,bool,address) (NodeID: 1)
      💬 Args: [_lqtyAmount, false, msg.sender]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: Governance._increaseUserVoteTrackers(uint256) (NodeID: 2)
    │   💬 Args: [_lqtyAmount]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: UserProxyFactory.deriveUserProxyAddress(address) (NodeID: 3)
    │ │   💬 Args: [msg.sender]
    │ │   👁️  Def: public
    │ │ └─ [4] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32) (NodeID: 4)
    │ │     💬 Args: [userProxyImplementation, bytes32(uint256(uint160(_user)))]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: Clones.predictDeterministicAddress(address,bytes32,address) (NodeID: 5)
    │ │       💬 Args: [implementation, salt, address(this)]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: UserProxyFactory.deployUserProxy() (NodeID: 6)
    │     💬 Args: [no args]
    │     👁️  Def: public
    │   └─ [4] ⚙️ FUNCTION: Clones.cloneDeterministic(address,bytes32) (NodeID: 7)
    │       💬 Args: [userProxyImplementation, bytes32(uint256(uint160(msg.sender)))]
    │       👁️  Def: internal
    └─ [2] 🔒 MODIFIER: ReentrancyGuard.nonReentrant() (NodeID: 8)
        💬 Args: [no args]
      ├─ [3] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantBefore() (NodeID: 9)
      │   💬 Args: [no args]
      │   👁️  Def: private
      └─ [3] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantAfter() (NodeID: 10)
          💬 Args: [no args]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@notice Deposits LQTY
 @dev The caller has to approve their `UserProxy` address to spend the LQTY tokens
 @param _lqtyAmount Amount of LQTY to deposit
