# Function: constructor(address,address,address,address,struct IGovernance.Configuration,address,address[])

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `constructor(address,address,address,address,struct IGovernance.Configuration,address,address[])`
- **Visibility**: public
- **Source Range**: 3071:1878:23

## Implementation

```solidity
constructor(address _lqty, address _lusd, address _stakingV1, address _bold, Configuration memory _config, address _owner, address[] memory _initiatives) UserProxyFactory(_lqty,_lusd,_stakingV1) Ownable(_owner) {
    stakingV1 = ILQTYStaking(_stakingV1);
    lqty = IERC20(_lqty);
    bold = IERC20(_bold);
    require(_config.minClaim <= _config.minAccrual, "Gov: min-claim-gt-min-accrual");
    REGISTRATION_FEE = _config.registrationFee;
    require(_config.registrationThresholdFactor < WAD, "Gov: registration-config");
    REGISTRATION_THRESHOLD_FACTOR = _config.registrationThresholdFactor;
    require(_config.unregistrationThresholdFactor > WAD, "Gov: unregistration-config");
    UNREGISTRATION_THRESHOLD_FACTOR = _config.unregistrationThresholdFactor;
    UNREGISTRATION_AFTER_EPOCHS = _config.unregistrationAfterEpochs;
    require(_config.votingThresholdFactor < WAD, "Gov: voting-config");
    VOTING_THRESHOLD_FACTOR = _config.votingThresholdFactor;
    MIN_CLAIM = _config.minClaim;
    MIN_ACCRUAL = _config.minAccrual;
    require(_config.epochStart <= block.timestamp, "Gov: cannot-start-in-future");
    EPOCH_START = _config.epochStart;
    require(_config.epochDuration > 0, "Gov: epoch-duration-zero");
    EPOCH_DURATION = _config.epochDuration;
    require(_config.epochVotingCutoff < _config.epochDuration, "Gov: epoch-voting-cutoff-gt-epoch-duration");
    EPOCH_VOTING_CUTOFF = _config.epochVotingCutoff;
    if (_initiatives.length > 0) {
        registerInitialInitiatives(_initiatives);
    }
}
```

## Related Implementations

### registerInitialInitiatives(address[])

- **Kind**: internal
- **Source**: 4955:775:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:registerInitialInitiatives(address[])`

```solidity
function registerInitialInitiatives(address[] memory _initiatives) public onlyOwner() {
    for (uint256 i = 0; i < _initiatives.length; i++) {
        registeredInitiatives[_initiatives[i]] = 1;
        bool success = safeCallWithMinGas(_initiatives[i], MIN_GAS_TO_HOOK, 0, abi.encodeCall(IInitiative.onRegisterInitiative, (1)));
        emit RegisterInitiative(_initiatives[i], msg.sender, 1, success ? HookStatus.Succeeded : HookStatus.Failed);
    }
    _renounceOwnership();
}
```

### safeCallWithMinGas(address,uint256,uint256,bytes)

- **Kind**: free-function
- **Source**: 775:892:38
- **Link**: `lib/V2-gov/src/utils/SafeCallMinGas.sol:safeCallWithMinGas(address,uint256,uint256,bytes)`

```solidity
/// @dev Performs a call ignoring the recipient existing or not, passing the exact gas value, ignoring any return value
function safeCallWithMinGas(address _target, uint256 _gas, uint256 _value, bytes memory _calldata) returns (bool success) {
    /// This is not necessary
    ///  But this is basically a worst case estimate of mem exp cost + operations before the call
    require(hasMinGas(_gas, 1_000), "Must have minGas");
    assembly {
        success := call(_gas, _target, _value, add(_calldata, 0x20), mload(_calldata), 0, 0)
    }
    return (success);
}
```

### hasMinGas(uint256,uint256)

- **Kind**: free-function
- **Source**: 325:328:38
- **Link**: `lib/V2-gov/src/utils/SafeCallMinGas.sol:hasMinGas(uint256,uint256)`

```solidity
/// @notice Given the gas requirement, ensures that the current context has sufficient gas to perform a call + a fixed buffer
///  @dev Credits: https://github.com/ethereum-optimism/optimism/blob/develop/packages/contracts-bedrock/src/libraries/SafeCall.sol#L100-L107
function hasMinGas(uint256 _minGas, uint256 _reservedGas) view returns (bool) {
    bool _hasMinGas;
    assembly {
        _hasMinGas := iszero(lt(mul(gas(), 63), add(mul(_minGas, 64), mul(add(40000, _reservedGas), 63))))
    }
    return _hasMinGas;
}
```

### _renounceOwnership()

- **Kind**: internal
- **Source**: 1896:130:37
- **Link**: `lib/V2-gov/src/utils/Ownable.sol:Ownable:_renounceOwnership()`

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
- **Source**: 1180:103:37
- **Link**: `lib/V2-gov/src/utils/Ownable.sol:Ownable:onlyOwner()`

```solidity
///  @dev Throws if called by any account other than the owner.
modifier onlyOwner() {
    require(isOwner(), "Ownable: caller is not the owner");
    _;
}
```

### isOwner()

- **Kind**: internal
- **Source**: 1366:90:37
- **Link**: `lib/V2-gov/src/utils/Ownable.sol:Ownable:isOwner()`

```solidity
///  @dev Returns true if the caller is the current owner.
function isOwner() public view returns (bool) {
    return msg.sender == _owner;
}
```

### (address)

- **Kind**: internal
- **Source**: 806:133:37
- **Link**: `lib/V2-gov/src/utils/Ownable.sol:Ownable:constructor(address)`

```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner) {
    _owner = initialOwner;
    emit OwnershipTransferred(address(0), initialOwner);
}
```

### (address,address,address)

- **Kind**: internal
- **Source**: 382:153:25
- **Link**: `lib/V2-gov/src/UserProxyFactory.sol:UserProxyFactory:constructor(address,address,address)`

```solidity
constructor(address _lqty, address _lusd, address _stakingV1) {
    userProxyImplementation = address(new UserProxy(_lqty, _lusd, _stakingV1));
}
```

## State Variable Reads

- **MIN_GAS_TO_HOOK** (`uint256`)
- **_owner** (`address`)

## State Variable Writes

- **stakingV1** (`contract ILQTYStaking`) [lib/V2-gov/src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
- **lqty** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **bold** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **REGISTRATION_FEE** (`uint256`)
- **REGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)
- **MIN_CLAIM** (`uint256`)
- **MIN_ACCRUAL** (`uint256`)
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **EPOCH_VOTING_CUTOFF** (`uint256`)
- **registeredInitiatives** (`mapping(address => uint256)`)
- **_owner** (`address`)
- **userProxyImplementation** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: Governance.constructor(address,address,address,address,struct IGovernance.Configuration,address,address[]) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: Governance
  ├─ [1] ⚙️ FUNCTION: Governance.registerInitialInitiatives(address[]) (NodeID: 1)
  │   💬 Args: [_initiatives]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: Unknown.safeCallWithMinGas(address,uint256,uint256,bytes) (NodeID: 2)
  │ │   💬 Args: [_initiatives[i], MIN_GAS_TO_HOOK, 0, abi.encodeCall(IInitiative.onRegisterInitiative, (1))]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown.hasMinGas(uint256,uint256) (NodeID: 3)
  │ │     💬 Args: [_gas, 1_000]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Ownable._renounceOwnership() (NodeID: 4)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Ownable.onlyOwner() (NodeID: 5)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: Ownable.isOwner() (NodeID: 6)
  │       💬 Args: [no args]
  │       👁️  Def: public
  ├─ [1] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 7)
  │   💬 Args: [_owner]
  │   🏗️  Contract: Ownable
  └─ [1] 🏗️ CONSTRUCTOR: UserProxyFactory.constructor(address,address,address) (NodeID: 8)
      💬 Args: [_lqty, _lusd, _stakingV1]
      🏗️  Contract: UserProxyFactory
```
