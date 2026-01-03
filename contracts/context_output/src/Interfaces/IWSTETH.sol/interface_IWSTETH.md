# Interface: IWSTETH

## Metadata

- **Name**: IWSTETH
- **Type**: Interface
- **Path**: src/Interfaces/IWSTETH.sol

## Public/External Functions

### wrap(uint256)

- **Signature**: `wrap(uint256)`
- **Visibility**: external
- **Source Range**: 82:63:97

**Signature:**
```solidity
function wrap(uint256 _stETHAmount) external returns (uint256);;
```

### unwrap(uint256)

- **Signature**: `unwrap(uint256)`
- **Visibility**: external
- **Source Range**: 150:66:97

**Signature:**
```solidity
function unwrap(uint256 _wstETHAmount) external returns (uint256);;
```

### getWstETHByStETH(uint256)

- **Signature**: `getWstETHByStETH(uint256)`
- **Visibility**: external
- **Source Range**: 221:80:97

**Signature:**
```solidity
function getWstETHByStETH(uint256 _stETHAmount) external view returns (uint256);;
```

### getStETHByWstETH(uint256)

- **Signature**: `getStETHByWstETH(uint256)`
- **Visibility**: external
- **Source Range**: 306:81:97

**Signature:**
```solidity
function getStETHByWstETH(uint256 _wstETHAmount) external view returns (uint256);;
```

### stEthPerToken()

- **Signature**: `stEthPerToken()`
- **Visibility**: external
- **Source Range**: 392:57:97

**Signature:**
```solidity
function stEthPerToken() external view returns (uint256);;
```

### tokensPerStEth()

- **Signature**: `tokensPerStEth()`
- **Visibility**: external
- **Source Range**: 454:58:97

**Signature:**
```solidity
function tokensPerStEth() external view returns (uint256);;
```
