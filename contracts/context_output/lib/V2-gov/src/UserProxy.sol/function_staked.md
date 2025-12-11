# Function: staked()

**Contract**: [lib/V2-gov/src/UserProxy.sol/contract_UserProxy.md]

## Metadata

- **Contract**: UserProxy
- **Signature**: `staked()`
- **Visibility**: external
- **Source Range**: 4219:105:24

## Implementation

```solidity
/// @inheritdoc IUserProxy
function staked() external view returns (uint256) {
    return stakingV1.stakes(address(this));
}
```

## External Calls

- **ILQTYStaking::stakes(address)**

## State Variable Reads

- **stakingV1** (`contract ILQTYStaking`) [lib/V2-gov/src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserProxy.staked() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IUserProxy

### Interface Documentation

@notice Returns the current amount LQTY staked by a user in the V1 staking contract
 @return staked Amount of LQTY tokens staked
