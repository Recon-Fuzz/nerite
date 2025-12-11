# Contract: ERC2771Forwarder

## Metadata

- **Name**: ERC2771Forwarder
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/ERC2771Forwarder.sol
- **Documentation**:  @title Forwards calls preserving the original msg.sender according to ERC-2771

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

### forward2771Call(address,address,bytes)

- **Signature**: `forward2771Call(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 554:337:174
- **Details**: [function_forward2771Call_address_address_bytes.md](./function_forward2771Call_address_address_bytes.md)

**Signature:**
```solidity
///  @dev Forwards a call passing along the original msg.sender encoded as specified in ERC-2771.
///  @param target The target contract to call
///  @param msgSender The original msg.sender passed along by the trusted contract owner
///  @param data The call data
function forward2771Call(address target, address msgSender, bytes memory data) external payable onlyOwner() returns (bool success, bytes memory returnData);
```

### withdrawLostNativeTokens(address payable)

- **Signature**: `withdrawLostNativeTokens(address payable)`
- **Visibility**: external
- **Source Range**: 1078:136:174
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
