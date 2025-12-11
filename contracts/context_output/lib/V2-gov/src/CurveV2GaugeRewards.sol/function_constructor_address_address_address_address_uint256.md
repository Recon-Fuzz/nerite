# Function: constructor(address,address,address,address,uint256)

**Contract**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

## Metadata

- **Contract**: CurveV2GaugeRewards
- **Signature**: `constructor(address,address,address,address,uint256)`
- **Visibility**: public
- **Source Range**: 370:243:22

## Implementation

```solidity
constructor(address _governance, address _bold, address _bribeToken, address _gauge, uint256 _duration) BribeInitiative(_governance,_bold,_bribeToken) {
    gauge = ILiquidityGauge(_gauge);
    duration = _duration;
}
```

## Related Implementations

### (address,address,address)

- **Kind**: internal
- **Source**: 1506:385:21
- **Link**: `lib/V2-gov/src/BribeInitiative.sol:BribeInitiative:constructor(address,address,address)`

```solidity
constructor(address _governance, address _bold, address _bribeToken) {
    require(_bribeToken != _bold, "BribeInitiative: bribe-token-cannot-be-bold");
    governance = IGovernance(_governance);
    bold = IERC20(_bold);
    bribeToken = IERC20(_bribeToken);
    EPOCH_START = governance.EPOCH_START();
    EPOCH_DURATION = governance.EPOCH_DURATION();
}
```

## External Calls

- **IGovernance::EPOCH_START()**
- **IGovernance::EPOCH_DURATION()**

## State Variable Reads

- **governance** (`contract IGovernance`) [lib/V2-gov/src/interfaces/IGovernance.sol/interface_IGovernance.md]

## State Variable Writes

- **gauge** (`contract ILiquidityGauge`) [lib/V2-gov/src/interfaces/ILiquidityGauge.sol/interface_ILiquidityGauge.md]
- **duration** (`uint256`)
- **governance** (`contract IGovernance`) [lib/V2-gov/src/interfaces/IGovernance.sol/interface_IGovernance.md]
- **bold** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **bribeToken** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: CurveV2GaugeRewards.constructor(address,address,address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: CurveV2GaugeRewards
  └─ [1] 🏗️ CONSTRUCTOR: BribeInitiative.constructor(address,address,address) (NodeID: 1)
      💬 Args: [_governance, _bold, _bribeToken]
      🏗️  Contract: BribeInitiative
```
