# Function: registerInitialInitiatives(address[])

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `registerInitialInitiatives(address[])`
- **Visibility**: public
- **Source Range**: 4955:775:23

## Implementation

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

## Related Implementations

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

## State Variable Reads

- **MIN_GAS_TO_HOOK** (`uint256`)
- **_owner** (`address`)

## State Variable Writes

- **registeredInitiatives** (`mapping(address => uint256)`)
- **_owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.registerInitialInitiatives(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Unknown.safeCallWithMinGas(address,uint256,uint256,bytes) (NodeID: 1)
  │   💬 Args: [_initiatives[i], MIN_GAS_TO_HOOK, 0, abi.encodeCall(IInitiative.onRegisterInitiative, (1))]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.hasMinGas(uint256,uint256) (NodeID: 2)
  │     💬 Args: [_gas, 1_000]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Ownable._renounceOwnership() (NodeID: 3)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Ownable.onlyOwner() (NodeID: 4)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Ownable.isOwner() (NodeID: 5)
        💬 Args: [no args]
        👁️  Def: public
```
