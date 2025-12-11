# Function: getLatestVotingThreshold()

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `getLatestVotingThreshold()`
- **Visibility**: public
- **Source Range**: 11444:183:23

## Implementation

```solidity
/// @inheritdoc IGovernance
function getLatestVotingThreshold() public view returns (uint256) {
    uint256 snapshotVotes = votesSnapshot.votes;
    return calculateVotingThreshold(snapshotVotes);
}
```

## Related Implementations

### calculateVotingThreshold(uint256)

- **Kind**: internal
- **Source**: 11889:442:23
- **Link**: `lib/V2-gov/src/Governance.sol:Governance:calculateVotingThreshold(uint256)`

```solidity
/// @inheritdoc IGovernance
function calculateVotingThreshold(uint256 _votes) public view returns (uint256) {
    if (_votes == 0) return 0;
    uint256 minVotes;
    uint256 payoutPerVote = (boldAccrued * WAD) / _votes;
    if (payoutPerVote != 0) {
        minVotes = (MIN_CLAIM * WAD) / payoutPerVote;
    }
    return max((_votes * VOTING_THRESHOLD_FACTOR) / WAD, minVotes);
}
```

### max(uint256,uint256)

- **Kind**: free-function
- **Source**: 336:87:35
- **Link**: `lib/V2-gov/src/utils/Math.sol:max(uint256,uint256)`

```solidity
function max(uint256 a, uint256 b) pure returns (uint256) {
    return (a > b) ? a : b;
}
```

## State Variable Reads

- **votesSnapshot** (`struct IGovernance.VoteSnapshot`)
- **boldAccrued** (`uint256`)
- **MIN_CLAIM** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.getLatestVotingThreshold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Governance.calculateVotingThreshold(uint256) (NodeID: 1)
      💬 Args: [snapshotVotes]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Unknown.max(uint256,uint256) (NodeID: 2)
        💬 Args: [(_votes * VOTING_THRESHOLD_FACTOR) / WAD, minVotes]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@notice Voting threshold is the max. of either:
   - 4% of the total voting LQTY in the previous epoch
   - or the minimum number of votes necessary to claim at least MIN_CLAIM BOLD
 This value can be offsynch, use the non view `calculateVotingThreshold` to always retrieve the most up to date value
 @return votingThreshold Voting threshold
