# Interface: IPriceFeed

## Metadata

- **Name**: IPriceFeed
- **Type**: Interface
- **Path**: src/Interfaces/IPriceFeed.sol

## Public/External Functions

### fetchPrice()

- **Signature**: `fetchPrice()`
- **Visibility**: external
- **Source Range**: 85:55:236

**Signature:**
```solidity
function fetchPrice() external returns (uint256, bool);;
```

### fetchRedemptionPrice()

- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 145:65:236

**Signature:**
```solidity
function fetchRedemptionPrice() external returns (uint256, bool);;
```

### lastGoodPrice()

- **Signature**: `lastGoodPrice()`
- **Visibility**: external
- **Source Range**: 215:57:236

**Signature:**
```solidity
function lastGoodPrice() external view returns (uint256);;
```

### setAddresses(address)

- **Signature**: `setAddresses(address)`
- **Visibility**: external
- **Source Range**: 277:67:236

**Signature:**
```solidity
function setAddresses(address _borrowerOperationsAddress) external;;
```
