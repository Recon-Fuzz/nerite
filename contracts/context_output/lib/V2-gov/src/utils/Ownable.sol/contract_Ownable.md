# Contract: Ownable

## Metadata

- **Name**: Ownable
- **Type**: Contract
- **Path**: lib/V2-gov/src/utils/Ownable.sol
- **Documentation**:  Based on OpenZeppelin's Ownable contract:
   https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
   @dev Contract module which provides a basic access control mechanism, where
   there is an account (an owner) that can be granted exclusive access to
   specific functions.
   This module is used through inheritance. It will make available the modifier
   `onlyOwner`, which can be applied to your functions to restrict their use to
   the owner.

## State Variables

### _owner

```solidity
address private _owner
```

## Events

### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 806:133:37
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner);
```

### owner()

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1015:77:37
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() public view returns (address);
```

### isOwner()

- **Signature**: `isOwner()`
- **Visibility**: public
- **Source Range**: 1366:90:37
- **Details**: [function_isOwner.md](./function_isOwner.md)

**Signature:**
```solidity
///  @dev Returns true if the caller is the current owner.
function isOwner() public view returns (bool);
```
