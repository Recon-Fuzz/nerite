# Interface: IERC5805

## Metadata

- **Name**: IERC5805
- **Type**: Interface
- **Path**: lib/openzeppelin-contracts/contracts/interfaces/IERC5805.sol

## Implements Interfaces

- **IVotes** [lib/openzeppelin-contracts/contracts/governance/utils/IVotes.sol/interface_IVotes.md]
- **IERC6372** [lib/openzeppelin-contracts/contracts/interfaces/IERC6372.sol/interface_IERC6372.md]

## Events

### DelegateChanged (inherited from IVotes)

```solidity
///  @dev Emitted when an account changes their delegate.
event DelegateChanged(address indexed delegator, address indexed fromDelegate, address indexed toDelegate);
```

### DelegateVotesChanged (inherited from IVotes)

```solidity
///  @dev Emitted when a token transfer or delegate change results in changes to a delegate's number of votes.
event DelegateVotesChanged(address indexed delegate, uint256 previousBalance, uint256 newBalance);
```

## Public/External Functions

### clock() (inherited from IERC6372)

- **Signature**: `clock()`
- **Visibility**: external
- **Source Range**: 295:48:5

**Signature:**
```solidity
///  @dev Clock used for flagging checkpoints. Can be overridden to implement timestamp based checkpoints (and voting).
function clock() external view returns (uint48);;
```

### CLOCK_MODE() (inherited from IERC6372)

- **Signature**: `CLOCK_MODE()`
- **Visibility**: external
- **Source Range**: 455:60:5

**Signature:**
```solidity
///  @dev Description of the clock
function CLOCK_MODE() external view returns (string memory);;
```

### getVotes(address) (inherited from IVotes)

- **Signature**: `getVotes(address)`
- **Visibility**: external
- **Source Range**: 797:67:2

**Signature:**
```solidity
///  @dev Returns the current amount of votes that `account` has.
function getVotes(address account) external view returns (uint256);;
```

### getPastVotes(address,uint256) (inherited from IVotes)

- **Signature**: `getPastVotes(address,uint256)`
- **Visibility**: external
- **Source Range**: 1105:90:2

**Signature:**
```solidity
///  @dev Returns the amount of votes that `account` had at a specific moment in the past. If the `clock()` is
///  configured to use block numbers, this will return the value at the end of the corresponding block.
function getPastVotes(address account, uint256 timepoint) external view returns (uint256);;
```

### getPastTotalSupply(uint256) (inherited from IVotes)

- **Signature**: `getPastTotalSupply(uint256)`
- **Visibility**: external
- **Source Range**: 1687:79:2

**Signature:**
```solidity
///  @dev Returns the total supply of votes available at a specific moment in the past. If the `clock()` is
///  configured to use block numbers, this will return the value at the end of the corresponding block.
///  NOTE: This value is the sum of all available votes, which is not necessarily the sum of all delegated votes.
///  Votes that have not been delegated are still part of total supply, even though they would not participate in a
///  vote.
function getPastTotalSupply(uint256 timepoint) external view returns (uint256);;
```

### delegates(address) (inherited from IVotes)

- **Signature**: `delegates(address)`
- **Visibility**: external
- **Source Range**: 1848:68:2

**Signature:**
```solidity
///  @dev Returns the delegate that `account` has chosen.
function delegates(address account) external view returns (address);;
```

### delegate(address) (inherited from IVotes)

- **Signature**: `delegate(address)`
- **Visibility**: external
- **Source Range**: 1998:46:2

**Signature:**
```solidity
///  @dev Delegates votes from the sender to `delegatee`.
function delegate(address delegatee) external;;
```

### delegateBySig(address,uint256,uint256,uint8,bytes32,bytes32) (inherited from IVotes)

- **Signature**: `delegateBySig(address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 2122:113:2

**Signature:**
```solidity
///  @dev Delegates votes from signer to `delegatee`.
function delegateBySig(address delegatee, uint256 nonce, uint256 expiry, uint8 v, bytes32 r, bytes32 s) external;;
```
