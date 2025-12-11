# Interface: ICurveStableswapNGPool

## Metadata

- **Name**: ICurveStableswapNGPool
- **Type**: Interface
- **Path**: src/Zappers/Modules/Exchanges/Curve/ICurveStableswapNGPool.sol

## Public/External Functions

### add_liquidity(uint256[],uint256)

- **Signature**: `add_liquidity(uint256[],uint256)`
- **Visibility**: external
- **Source Range**: 97:101:296

**Signature:**
```solidity
function add_liquidity(uint256[] memory amounts, uint256 min_mint_amount) external returns (uint256);;
```

### exchange(int128,int128,uint256,uint256)

- **Signature**: `exchange(int128,int128,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 203:100:296

**Signature:**
```solidity
function exchange(int128 i, int128 j, uint256 dx, uint256 min_dy) external returns (uint256 output);;
```

### get_dx(int128,int128,uint256)

- **Signature**: `get_dx(int128,int128,uint256)`
- **Visibility**: external
- **Source Range**: 308:83:296

**Signature:**
```solidity
function get_dx(int128 i, int128 j, uint256 dy) external view returns (uint256 dx);;
```

### get_dy(int128,int128,uint256)

- **Signature**: `get_dy(int128,int128,uint256)`
- **Visibility**: external
- **Source Range**: 396:83:296

**Signature:**
```solidity
function get_dy(int128 i, int128 j, uint256 dx) external view returns (uint256 dy);;
```
