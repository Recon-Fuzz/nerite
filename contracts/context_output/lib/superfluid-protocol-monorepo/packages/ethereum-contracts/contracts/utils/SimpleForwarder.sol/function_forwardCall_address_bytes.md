# Function: forwardCall(address,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SimpleForwarder.sol/contract_SimpleForwarder.md]

## Metadata

- **Contract**: SimpleForwarder
- **Signature**: `forwardCall(address,bytes)`
- **Visibility**: external
- **Source Range**: 713:288:179

## Implementation

```solidity
///  @dev Forwards a call for which msg.sender doesn't matter
///  @param target The target contract to call
///  @param data The call data
///  Note: restricted to `onlyOwner` in order to minimize attack surface
function forwardCall(address target, bytes calldata data) external payable onlyOwner() returns (bool success, bytes memory returnData) {
    (success, returnData) = target.call{value: msg.value}(data);
}
```

## Related Implementations

### onlyOwner()

- **Kind**: modifier
- **Source**: 1063:62:71
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:onlyOwner()`

```solidity
///  @dev Throws if called by any account other than the owner.
modifier onlyOwner() {
    _checkOwner();
    _;
}
```

### _checkOwner()

- **Kind**: internal
- **Source**: 1359:130:71
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:_checkOwner()`

```solidity
///  @dev Throws if the sender is not the owner.
function _checkOwner() virtual internal view {
    require(owner() == _msgSender(), "Ownable: caller is not the owner");
}
```

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:104
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### owner()

- **Kind**: internal
- **Source**: 1201:85:71
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:owner()`

```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address) {
    return _owner;
}
```

## External Calls

- **unknown::unknown**

## State Variable Reads

- **_owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SimpleForwarder.forwardCall(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Ownable.onlyOwner() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Ownable._checkOwner() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 3)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Ownable.owner() (NodeID: 4)
          💬 Args: [no args]
          👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Forwards a call for which msg.sender doesn't matter
 @param target The target contract to call
 @param data The call data
 Note: restricted to `onlyOwner` in order to minimize attack surface
