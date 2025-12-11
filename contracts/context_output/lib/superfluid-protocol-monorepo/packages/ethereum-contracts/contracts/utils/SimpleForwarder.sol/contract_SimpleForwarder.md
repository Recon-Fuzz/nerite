# Contract: SimpleForwarder

## Metadata

- **Name**: SimpleForwarder
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SimpleForwarder.sol
- **Documentation**:  @title Forwards arbitrary calls
   @dev The purpose of this contract is to let accounts forward arbitrary calls,
   without themselves being the msg.sender from the perspective of the call target.
   This is necessary for security reasons if the calling account has privileged access anywhere.

## State Variables

### _owner (inherited from Ownable)

```solidity
address private _owner
```

## Events

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

## Public/External Functions

### forwardCall(address,bytes)

- **Signature**: `forwardCall(address,bytes)`
- **Visibility**: external
- **Source Range**: 713:288:179
- **Details**: [function_forwardCall_address_bytes.md](./function_forwardCall_address_bytes.md)

**Signature:**
```solidity
///  @dev Forwards a call for which msg.sender doesn't matter
///  @param target The target contract to call
///  @param data The call data
///  Note: restricted to `onlyOwner` in order to minimize attack surface
function forwardCall(address target, bytes calldata data) external payable onlyOwner() returns (bool success, bytes memory returnData);
```

### withdrawLostNativeTokens(address payable)

- **Signature**: `withdrawLostNativeTokens(address payable)`
- **Visibility**: external
- **Source Range**: 1188:136:179
- **Details**: [function_withdrawLostNativeTokens_address_payable.md](./function_withdrawLostNativeTokens_address_payable.md)

**Signature:**
```solidity
///  @dev Allows to withdraw native tokens (ETH) which got stuck in this contract.
///  This could happen if a call fails, but the caller doesn't revert the tx.
function withdrawLostNativeTokens(address payable receiver) external onlyOwner();
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1201:85:71
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address);
```

### renounceOwnership() (inherited from Ownable)

- **Signature**: `renounceOwnership()`
- **Visibility**: public
- **Source Range**: 1824:101:71
- **Details**: [function_renounceOwnership.md](./function_renounceOwnership.md)

**Signature:**
```solidity
///  @dev Leaves the contract without owner. It will not be possible to call
///  `onlyOwner` functions. Can only be called by the current owner.
///  NOTE: Renouncing ownership will leave the contract without an owner,
///  thereby disabling any functionality that is only available to the owner.
function renounceOwnership() virtual public onlyOwner();
```

### transferOwnership(address) (inherited from Ownable)

- **Signature**: `transferOwnership(address)`
- **Visibility**: public
- **Source Range**: 2074:198:71
- **Details**: [function_transferOwnership_address.md](./function_transferOwnership_address.md)

**Signature:**
```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`).
///  Can only be called by the current owner.
function transferOwnership(address newOwner) virtual public onlyOwner();
```
