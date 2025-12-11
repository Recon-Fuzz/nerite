# Function: claimBribes(struct IBribeInitiative.ClaimData[])

**Contract**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

## Metadata

- **Contract**: CurveV2GaugeRewards
- **Signature**: `claimBribes(struct IBribeInitiative.ClaimData[])`
- **Visibility**: external
- **Source Range**: 5953:732:21
- **Inherited From**: BribeInitiative

## Implementation

```solidity
/// @inheritdoc IBribeInitiative
function claimBribes(ClaimData[] calldata _claimData) external returns (uint256 boldAmount, uint256 bribeTokenAmount) {
    for (uint256 i = 0; i < _claimData.length; i++) {
        ClaimData memory claimData = _claimData[i];
        (uint256 boldAmount_, uint256 bribeTokenAmount_) = _claimBribe(msg.sender, claimData.epoch, claimData.prevLQTYAllocationEpoch, claimData.prevTotalLQTYAllocationEpoch);
        boldAmount += boldAmount_;
        bribeTokenAmount += bribeTokenAmount_;
    }
    if (boldAmount != 0) bold.safeTransfer(msg.sender, boldAmount);
    if (bribeTokenAmount != 0) bribeToken.safeTransfer(msg.sender, bribeTokenAmount);
}
```

## Related Implementations

### _claimBribe(address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 3252:2658:21
- **Link**: `lib/V2-gov/src/BribeInitiative.sol:BribeInitiative:_claimBribe(address,uint256,uint256,uint256)`

```solidity
function _claimBribe(address _user, uint256 _epoch, uint256 _prevLQTYAllocationEpoch, uint256 _prevTotalLQTYAllocationEpoch) internal returns (uint256 boldAmount, uint256 bribeTokenAmount) {
    require(_epoch < governance.epoch(), "BribeInitiative: cannot-claim-for-current-epoch");
    require(!claimedBribeAtEpoch[_user][_epoch], "BribeInitiative: already-claimed");
    Bribe memory bribe = bribeByEpoch[_epoch];
    require((bribe.remainingBoldAmount != 0) || (bribe.remainingBribeTokenAmount != 0), "BribeInitiative: no-bribe");
    DoubleLinkedList.Item memory lqtyAllocation = lqtyAllocationByUserAtEpoch[_user].getItem(_prevLQTYAllocationEpoch);
    require((_prevLQTYAllocationEpoch <= _epoch) && ((lqtyAllocation.next > _epoch) || (lqtyAllocation.next == 0)), "BribeInitiative: invalid-prev-lqty-allocation-epoch");
    DoubleLinkedList.Item memory totalLQTYAllocation = totalLQTYAllocationByEpoch.getItem(_prevTotalLQTYAllocationEpoch);
    require((_prevTotalLQTYAllocationEpoch <= _epoch) && ((totalLQTYAllocation.next > _epoch) || (totalLQTYAllocation.next == 0)), "BribeInitiative: invalid-prev-total-lqty-allocation-epoch");
    require(totalLQTYAllocation.lqty > 0, "BribeInitiative: total-lqty-allocation-zero");
    require(lqtyAllocation.lqty > 0, "BribeInitiative: lqty-allocation-zero");
    uint256 epochEnd = EPOCH_START + (_epoch * EPOCH_DURATION);
    uint256 totalVotes = _lqtyToVotes(totalLQTYAllocation.lqty, epochEnd, totalLQTYAllocation.offset);
    uint256 votes = _lqtyToVotes(lqtyAllocation.lqty, epochEnd, lqtyAllocation.offset);
    uint256 remainingVotes = totalVotes - bribe.claimedVotes;
    boldAmount = (bribe.remainingBoldAmount * votes) / remainingVotes;
    bribeTokenAmount = (bribe.remainingBribeTokenAmount * votes) / remainingVotes;
    bribe.remainingBoldAmount -= boldAmount;
    bribe.remainingBribeTokenAmount -= bribeTokenAmount;
    bribe.claimedVotes += votes;
    bribeByEpoch[_epoch] = bribe;
    claimedBribeAtEpoch[_user][_epoch] = true;
    emit ClaimBribe(_user, _epoch, boldAmount, bribeTokenAmount);
}
```

### getItem(struct DoubleLinkedList.List,uint256)

- **Kind**: internal
- **Source**: 2448:122:34
- **Link**: `lib/V2-gov/src/utils/DoubleLinkedList.sol:DoubleLinkedList:getItem(struct DoubleLinkedList.List,uint256)`

```solidity
/// @notice Returns the item `id`
///  @param list Linked list which contains the item
///  @param id Id of the item
///  @return _ Item
function getItem(List storage list, uint256 id) internal view returns (Item memory) {
    return list.items[id];
}
```

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

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **IGovernance::epoch()**

## State Variable Reads

- **bold** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **bribeToken** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **governance** (`contract IGovernance`) [lib/V2-gov/src/interfaces/IGovernance.sol/interface_IGovernance.md]
- **claimedBribeAtEpoch** (`mapping(address => mapping(uint256 => bool))`)
- **bribeByEpoch** (`mapping(uint256 => struct IBribeInitiative.Bribe)`)
- **lqtyAllocationByUserAtEpoch** (`mapping(address => struct DoubleLinkedList.List)`)
- **totalLQTYAllocationByEpoch** (`struct DoubleLinkedList.List`)
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)

## State Variable Writes

- **bribeByEpoch** (`mapping(uint256 => struct IBribeInitiative.Bribe)`)
- **claimedBribeAtEpoch** (`mapping(address => mapping(uint256 => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.claimBribes(struct IBribeInitiative.ClaimData[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BribeInitiative._claimBribe(address,uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [msg.sender, claimData.epoch, claimData.prevLQTYAllocationEpoch, claimData.prevTotalLQTYAllocationEpoch]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: DoubleLinkedList.getItem(struct DoubleLinkedList.List,uint256) (NodeID: 2)
    │   💬 Args: [lqtyAllocationByUserAtEpoch[_user], _prevLQTYAllocationEpoch]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: DoubleLinkedList.getItem(struct DoubleLinkedList.List,uint256) (NodeID: 3)
    │   💬 Args: [totalLQTYAllocationByEpoch, _prevTotalLQTYAllocationEpoch]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 4)
    │   💬 Args: [totalLQTYAllocation.lqty, epochEnd, totalLQTYAllocation.offset]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Unknown._lqtyToVotes(uint256,uint256,uint256) (NodeID: 5)
        💬 Args: [lqtyAllocation.lqty, epochEnd, lqtyAllocation.offset]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IBribeInitiative

### Interface Documentation

@notice Claim bribes for a user
 @dev The user can only claim bribes for past epochs.
 The arrays `_epochs`, `_prevLQTYAllocationEpochs` and `_prevTotalLQTYAllocationEpochs` should be sorted
 from oldest epoch to the newest. The length of the arrays has to be the same.
 @param _claimData Array specifying the epochs at which the user wants to claim the bribes
