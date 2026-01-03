# Interface: IERC6372

## Metadata

- **Name**: IERC6372
- **Type**: Interface
- **Path**: lib/openzeppelin-contracts/contracts/interfaces/IERC6372.sol

## Public/External Functions

### clock()

- **Signature**: `clock()`
- **Visibility**: external
- **Source Range**: 295:48:5

**Signature:**
```solidity
///  @dev Clock used for flagging checkpoints. Can be overridden to implement timestamp based checkpoints (and voting).
function clock() external view returns (uint48);;
```

### CLOCK_MODE()

- **Signature**: `CLOCK_MODE()`
- **Visibility**: external
- **Source Range**: 455:60:5

**Signature:**
```solidity
///  @dev Description of the clock
function CLOCK_MODE() external view returns (string memory);;
```
