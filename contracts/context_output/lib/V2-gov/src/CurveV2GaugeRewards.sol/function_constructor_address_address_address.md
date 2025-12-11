# Function: constructor(address,address,address)

**Contract**: [lib/V2-gov/src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

## Metadata

- **Contract**: CurveV2GaugeRewards
- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 1506:385:21
- **Inherited From**: BribeInitiative

## Implementation

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

- **governance** (`contract IGovernance`) [lib/V2-gov/src/interfaces/IGovernance.sol/interface_IGovernance.md]
- **bold** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **bribeToken** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: BribeInitiative.constructor(address,address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: BribeInitiative
```
