# Function: lqtyToVotes(uint256,uint256,uint256)

**Contract**: [lib/V2-gov/src/Governance.sol/contract_Governance.md]

## Metadata

- **Contract**: Governance
- **Signature**: `lqtyToVotes(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 11045:179:23

## Implementation

```solidity
/// @inheritdoc IGovernance
function lqtyToVotes(uint256 _lqtyAmount, uint256 _timestamp, uint256 _offset) public pure returns (uint256) {
    return _lqtyToVotes(_lqtyAmount, _timestamp, _offset);
}
```

## Related Implementations

### _lqtyToVotes(uint256,uint256,uint256)

- **Kind**: free-function
- **Source**: 58:199:41
- **Link**: `lib/V2-gov/src/utils/VotingPower.sol:_lqtyToVotes(uint256,uint256,uint256)`

```solidity
function _lqtyToVotes(uint256 _lqtyAmount, uint256 _timestamp, uint256 _offset) pure returns (uint256) {
    uint256 prod = _lqtyAmount * _timestamp;
    return (prod > _offset) ? (prod - _offset) : 0;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Governance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [_lqtyAmount, _timestamp, _offset]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGovernance

### Interface Documentation

@notice Returns the voting power for an entity (i.e. user or initiative) at a given timestamp
 @param _lqtyAmount Amount of LQTY associated with the entity
 @param _timestamp Timestamp at which to calculate voting power
 @param _offset The entity's offset sum
 @return votes Number of votes
