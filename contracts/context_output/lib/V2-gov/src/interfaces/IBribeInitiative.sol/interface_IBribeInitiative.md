# Interface: IBribeInitiative

## Metadata

- **Name**: IBribeInitiative
- **Type**: Interface
- **Path**: lib/V2-gov/src/interfaces/IBribeInitiative.sol

## Structs

### Bribe

```solidity
struct Bribe {
    uint256 remainingBoldAmount;
    uint256 remainingBribeTokenAmount;
    uint256 claimedVotes;
}
```

### ClaimData

```solidity
struct ClaimData {
    uint256 epoch;
    uint256 prevLQTYAllocationEpoch;
    uint256 prevTotalLQTYAllocationEpoch;
}
```

## Events

### DepositBribe

```solidity
event DepositBribe(address depositor, uint256 boldAmount, uint256 bribeTokenAmount, uint256 epoch);
```

### ModifyLQTYAllocation

```solidity
event ModifyLQTYAllocation(address user, uint256 epoch, uint256 lqtyAllocated, uint256 offset);
```

### ModifyTotalLQTYAllocation

```solidity
event ModifyTotalLQTYAllocation(uint256 epoch, uint256 totalLQTYAllocated, uint256 offset);
```

### ClaimBribe

```solidity
event ClaimBribe(address user, uint256 epoch, uint256 boldAmount, uint256 bribeTokenAmount);
```

## Public/External Functions

### governance()

- **Signature**: `governance()`
- **Visibility**: external
- **Source Range**: 719:69:26

**Signature:**
```solidity
/// @notice Address of the governance contract
///  @return governance Adress of the governance contract
function governance() external view returns (IGovernance governance);;
```

### bold()

- **Signature**: `bold()`
- **Visibility**: external
- **Source Range**: 882:52:26

**Signature:**
```solidity
/// @notice Address of the BOLD token
///  @return bold Address of the BOLD token
function bold() external view returns (IERC20 bold);;
```

### bribeToken()

- **Signature**: `bribeToken()`
- **Visibility**: external
- **Source Range**: 1036:64:26

**Signature:**
```solidity
/// @notice Address of the bribe token
///  @return bribeToken Address of the bribe token
function bribeToken() external view returns (IERC20 bribeToken);;
```

### bribeByEpoch(uint256)

- **Signature**: `bribeByEpoch(uint256)`
- **Visibility**: external
- **Source Range**: 1692:171:26

**Signature:**
```solidity
/// @notice Amount of bribe tokens deposited for a given epoch
///  @param _epoch Epoch at which the bribe was deposited
///  @return remainingBoldAmount Amount of BOLD tokens that haven't been claimed yet
///  @return remainingBribeTokenAmount Amount of bribe tokens that haven't been claimed yet
///  @return claimedVotes Sum of voting power of users who have already claimed their bribes
function bribeByEpoch(uint256 _epoch) external view returns (uint256 remainingBoldAmount, uint256 remainingBribeTokenAmount, uint256 claimedVotes);;
```

### claimedBribeAtEpoch(address,uint256)

- **Signature**: `claimedBribeAtEpoch(address,uint256)`
- **Visibility**: external
- **Source Range**: 2117:97:26

**Signature:**
```solidity
/// @notice Check if a user has claimed bribes for a given epoch
///  @param _user Address of the user
///  @param _epoch Epoch at which the bribe may have been claimed by the user
///  @return claimed If the user has claimed the bribe
function claimedBribeAtEpoch(address _user, uint256 _epoch) external view returns (bool claimed);;
```

### totalLQTYAllocatedByEpoch(uint256)

- **Signature**: `totalLQTYAllocatedByEpoch(uint256)`
- **Visibility**: external
- **Source Range**: 2543:142:26

**Signature:**
```solidity
/// @notice Total LQTY allocated to the initiative at a given epoch
///          Voting power can be calculated as `totalLQTYAllocated * timestamp - offset`
///  @param _epoch Epoch at which the LQTY was allocated
///  @return totalLQTYAllocated Total LQTY allocated
///  @return offset Voting power offset
function totalLQTYAllocatedByEpoch(uint256 _epoch) external view returns (uint256 totalLQTYAllocated, uint256 offset);;
```

### lqtyAllocatedByUserAtEpoch(address,uint256)

- **Signature**: `lqtyAllocatedByUserAtEpoch(address,uint256)`
- **Visibility**: external
- **Source Range**: 3066:153:26

**Signature:**
```solidity
/// @notice LQTY allocated by a user to the initiative at a given epoch
///          Voting power can be calculated as `lqtyAllocated * timestamp - offset`
///  @param _user Address of the user
///  @param _epoch Epoch at which the LQTY was allocated by the user
///  @return lqtyAllocated LQTY allocated by the user
///  @return offset Voting power offset
function lqtyAllocatedByUserAtEpoch(address _user, uint256 _epoch) external view returns (uint256 lqtyAllocated, uint256 offset);;
```

### depositBribe(uint256,uint256,uint256)

- **Signature**: `depositBribe(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3617:95:26

**Signature:**
```solidity
/// @notice Deposit bribe tokens for a given epoch
///  @dev The caller has to approve this contract to spend the BOLD and bribe tokens.
///  The caller can only deposit bribes for future epochs
///  @param _boldAmount Amount of BOLD tokens to deposit
///  @param _bribeTokenAmount Amount of bribe tokens to deposit
///  @param _epoch Epoch at which the bribe is deposited
function depositBribe(uint256 _boldAmount, uint256 _bribeTokenAmount, uint256 _epoch) external;;
```

### claimBribes(struct IBribeInitiative.ClaimData[])

- **Signature**: `claimBribes(struct IBribeInitiative.ClaimData[])`
- **Visibility**: external
- **Source Range**: 4482:134:26

**Signature:**
```solidity
/// @notice Claim bribes for a user
///  @dev The user can only claim bribes for past epochs.
///  The arrays `_epochs`, `_prevLQTYAllocationEpochs` and `_prevTotalLQTYAllocationEpochs` should be sorted
///  from oldest epoch to the newest. The length of the arrays has to be the same.
///  @param _claimData Array specifying the epochs at which the user wants to claim the bribes
function claimBribes(ClaimData[] calldata _claimData) external returns (uint256 boldAmount, uint256 bribeTokenAmount);;
```

### getMostRecentUserEpoch(address)

- **Signature**: `getMostRecentUserEpoch(address)`
- **Visibility**: external
- **Source Range**: 4711:79:26

**Signature:**
```solidity
/// @notice Given a user address return the last recorded epoch for their allocation
function getMostRecentUserEpoch(address _user) external view returns (uint256);;
```

### getMostRecentTotalEpoch()

- **Signature**: `getMostRecentTotalEpoch()`
- **Visibility**: external
- **Source Range**: 4858:67:26

**Signature:**
```solidity
/// @notice Return the last recorded epoch for the system
function getMostRecentTotalEpoch() external view returns (uint256);;
```
