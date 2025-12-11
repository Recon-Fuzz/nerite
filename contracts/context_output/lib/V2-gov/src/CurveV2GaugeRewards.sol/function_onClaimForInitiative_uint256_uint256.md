# Function: onClaimForInitiative(uint256,uint256)

**Contract**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

## Metadata

- **Contract**: CurveV2GaugeRewards
- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 785:128:22

## Implementation

```solidity
/// @notice Governance transfers Bold, and we deposit it into the gauge
///  @dev Doing this allows anyone to trigger the claim
function onClaimForInitiative(uint256, uint256 _bold) override external onlyGovernance() {
    _depositIntoGauge(_bold);
}
```

## Related Implementations

### _depositIntoGauge(uint256)

- **Kind**: internal
- **Source**: 919:647:22
- **Link**: `lib/V2-gov/src/CurveV2GaugeRewards.sol:CurveV2GaugeRewards:_depositIntoGauge(uint256)`

```solidity
function _depositIntoGauge(uint256 amount) internal {
    uint256 total = amount + remainder;
    if (total < (duration * 1000)) {
        remainder += amount;
        return;
    }
    remainder = 0;
    uint256 available = bold.balanceOf(address(this));
    if (available < total) {
        total = available;
    }
    bold.approve(address(gauge), total);
    gauge.deposit_reward_token(address(bold), total, duration);
    emit DepositIntoGauge(total);
}
```

### onlyGovernance()

- **Kind**: modifier
- **Source**: 1897:131:21
- **Link**: `lib/V2-gov/src/BribeInitiative.sol:BribeInitiative:onlyGovernance()`

```solidity
modifier onlyGovernance() {
    require(msg.sender == address(governance), "BribeInitiative: invalid-sender");
    _;
}
```

## External Calls

- **IERC20::balanceOf(address)**
- **IERC20::approve(address,uint256)**
- **ILiquidityGauge::deposit_reward_token(address,uint256,uint256)**

## State Variable Reads

- **remainder** (`uint256`)
- **duration** (`uint256`)
- **gauge** (`contract ILiquidityGauge`) [lib/V2-gov/src/interfaces/ILiquidityGauge.sol/interface_ILiquidityGauge.md]
- **governance** (`contract IGovernance`) [lib/V2-gov/src/interfaces/IGovernance.sol/interface_IGovernance.md]

## State Variable Writes

- **remainder** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CurveV2GaugeRewards.onClaimForInitiative(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: CurveV2GaugeRewards._depositIntoGauge(uint256) (NodeID: 1)
  │   💬 Args: [_bold]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: BribeInitiative.onlyGovernance() (NodeID: 2)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@notice Governance transfers Bold, and we deposit it into the gauge
 @dev Doing this allows anyone to trigger the claim

### Interface Documentation

@notice Callback hook that is called by Governance after the claim for the last epoch was distributed
 to the initiative
 @param _claimEpoch Epoch at which the claim was distributed
 @param _bold Amount of BOLD that was distributed
