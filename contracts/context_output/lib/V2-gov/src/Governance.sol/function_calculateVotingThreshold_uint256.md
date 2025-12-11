# Function: calculateVotingThreshold(uint256)

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `calculateVotingThreshold(uint256)`
- **Visibility**: public
- **Source Range**: 11889:442:23

## Implementation

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

## Related Implementations

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

- **boldAccrued** (`uint256`)
- **MIN_CLAIM** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.calculateVotingThreshold(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Unknown.max(uint256,uint256) (NodeID: 1)
      💬 Args: [(_votes * VOTING_THRESHOLD_FACTOR) / WAD, minVotes]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@dev Utility function to compute the threshold votes without recomputing the snapshot
 Note that `boldAccrued` is a cached value, this function works correctly only when called after an accrual
