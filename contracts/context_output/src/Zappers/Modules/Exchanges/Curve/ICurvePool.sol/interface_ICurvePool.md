# Interface: ICurvePool

## Metadata

- **Name**: ICurvePool
- **Type**: Interface
- **Path**: src/Zappers/Modules/Exchanges/Curve/ICurvePool.sol

## Public/External Functions

### add_liquidity(uint256[2],uint256)

- **Signature**: `add_liquidity(uint256[2],uint256)`
- **Visibility**: external
- **Source Range**: 85:102:143

**Signature:**
```solidity
function add_liquidity(uint256[2] memory amounts, uint256 min_mint_amount) external returns (uint256);;
```

### exchange(uint256,uint256,uint256,uint256)

- **Signature**: `exchange(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 333:102:143

**Signature:**
```solidity
function exchange(uint256 i, uint256 j, uint256 dx, uint256 min_dy) external returns (uint256 output);;
```

### get_dy(uint256,uint256,uint256)

- **Signature**: `get_dy(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 440:85:143

**Signature:**
```solidity
function get_dy(uint256 i, uint256 j, uint256 dx) external view returns (uint256 dy);;
```
