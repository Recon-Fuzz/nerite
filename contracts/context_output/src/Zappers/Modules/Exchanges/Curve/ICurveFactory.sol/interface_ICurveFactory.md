# Interface: ICurveFactory

## Metadata

- **Name**: ICurveFactory
- **Type**: Interface
- **Path**: src/Zappers/Modules/Exchanges/Curve/ICurveFactory.sol

## Public/External Functions

### deploy_pool(string,string,address[2],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256)

- **Signature**: `deploy_pool(string,string,address[2],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 116:433:142

**Signature:**
```solidity
function deploy_pool(string memory name, string memory symbol, address[2] memory coins, uint256 implementation_id, uint256 A, uint256 gamma, uint256 mid_fee, uint256 out_fee, uint256 fee_gamma, uint256 allowed_extra_profit, uint256 adjustment_step, uint256 ma_exp_time, uint256 initial_price) external returns (ICurvePool);;
```
