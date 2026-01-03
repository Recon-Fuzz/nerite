# Interface: ICurveStableswapNGFactory

## Metadata

- **Name**: ICurveStableswapNGFactory
- **Type**: Interface
- **Path**: src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGFactory.sol

## Public/External Functions

### deploy_plain_pool(string,string,address[],uint256,uint256,uint256,uint256,uint256,uint8[],bytes4[],address[])

- **Signature**: `deploy_plain_pool(string,string,address[],uint256,uint256,uint256,uint256,uint256,uint8[],bytes4[],address[])`
- **Visibility**: external
- **Source Range**: 416:414:144

**Signature:**
```solidity
function deploy_plain_pool(string memory name, string memory symbol, address[] memory coins, uint256 A, uint256 fee, uint256 offpeg_fee_multiplier, uint256 ma_exp_time, uint256 implementation_id, uint8[] memory asset_types, bytes4[] memory method_ids, address[] memory oracles) external returns (ICurveStableswapNGPool);;
```
