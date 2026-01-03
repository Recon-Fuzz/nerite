# Interface: IMainnetPriceFeed

## Metadata

- **Name**: IMainnetPriceFeed
- **Type**: Interface
- **Path**: src/Interfaces/IMainnetPriceFeed.sol

## Implements Interfaces

- **IPriceFeed** [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## Enums

### PriceSource

```solidity
enum PriceSource {
    primary,
    ETHUSDxCanonical,
    lastGoodPrice
}
```

## Public/External Functions

### ethUsdOracle()

- **Signature**: `ethUsdOracle()`
- **Visibility**: external
- **Source Range**: 292:86:83

**Signature:**
```solidity
function ethUsdOracle() external view returns (AggregatorV3Interface, uint256, uint8);;
```

### priceSource()

- **Signature**: `priceSource()`
- **Visibility**: external
- **Source Range**: 383:59:83

**Signature:**
```solidity
function priceSource() external view returns (PriceSource);;
```

### fetchPrice() (inherited from IPriceFeed)

- **Signature**: `fetchPrice()`
- **Visibility**: external
- **Source Range**: 85:55:85

**Signature:**
```solidity
function fetchPrice() external returns (uint256, bool);;
```

### fetchRedemptionPrice() (inherited from IPriceFeed)

- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 145:65:85

**Signature:**
```solidity
function fetchRedemptionPrice() external returns (uint256, bool);;
```

### lastGoodPrice() (inherited from IPriceFeed)

- **Signature**: `lastGoodPrice()`
- **Visibility**: external
- **Source Range**: 215:57:85

**Signature:**
```solidity
function lastGoodPrice() external view returns (uint256);;
```

### setAddresses(address) (inherited from IPriceFeed)

- **Signature**: `setAddresses(address)`
- **Visibility**: external
- **Source Range**: 277:67:85

**Signature:**
```solidity
function setAddresses(address _borrowerOperationsAddress) external;;
```
