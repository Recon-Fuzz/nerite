# Interface: IExchange

## Metadata

- **Name**: IExchange
- **Type**: Interface
- **Path**: src/Zappers/Interfaces/IExchange.sol

## Public/External Functions

### swapFromBold(uint256,uint256)

- **Signature**: `swapFromBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 84:76:133

**Signature:**
```solidity
function swapFromBold(uint256 _boldAmount, uint256 _minCollAmount) external;;
```

### swapToBold(uint256,uint256)

- **Signature**: `swapToBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 166:92:133

**Signature:**
```solidity
function swapToBold(uint256 _collAmount, uint256 _minBoldAmount) external returns (uint256);;
```
