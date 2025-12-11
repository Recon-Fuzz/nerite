# Interface: IWeETHPriceFeed

## Metadata

- **Name**: IWeETHPriceFeed
- **Type**: Interface
- **Path**: src/Interfaces/IWeETHPriceFeed.sol

## Implements Interfaces

- **IMainnetPriceFeed** [src/Interfaces/IMainnetPriceFeed.sol/interface_IMainnetPriceFeed.md]
- **IPriceFeed** [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## Enums

### PriceSource (inherited from IMainnetPriceFeed)

```solidity
enum PriceSource {
    primary,
    ETHUSDxCanonical,
    lastGoodPrice
}
```

## Public/External Functions

### weEthEthOracle()

- **Signature**: `weEthEthOracle()`
- **Visibility**: external
- **Source Range**: 197:88:250

**Signature:**
```solidity
function weEthEthOracle() external view returns (AggregatorV3Interface, uint256, uint8);;
```

### fetchPrice() (inherited from IPriceFeed)

- **Signature**: `fetchPrice()`
- **Visibility**: external
- **Source Range**: 85:55:236

**Signature:**
```solidity
function fetchPrice() external returns (uint256, bool);;
```

### fetchRedemptionPrice() (inherited from IPriceFeed)

- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 145:65:236

**Signature:**
```solidity
function fetchRedemptionPrice() external returns (uint256, bool);;
```

### lastGoodPrice() (inherited from IPriceFeed)

- **Signature**: `lastGoodPrice()`
- **Visibility**: external
- **Source Range**: 215:57:236

**Signature:**
```solidity
function lastGoodPrice() external view returns (uint256);;
```

### setAddresses(address) (inherited from IPriceFeed)

- **Signature**: `setAddresses(address)`
- **Visibility**: external
- **Source Range**: 277:67:236

**Signature:**
```solidity
function setAddresses(address _borrowerOperationsAddress) external;;
```

### ethUsdOracle() (inherited from IMainnetPriceFeed)

- **Signature**: `ethUsdOracle()`
- **Visibility**: external
- **Source Range**: 292:86:234

**Signature:**
```solidity
function ethUsdOracle() external view returns (AggregatorV3Interface, uint256, uint8);;
```

### priceSource() (inherited from IMainnetPriceFeed)

- **Signature**: `priceSource()`
- **Visibility**: external
- **Source Range**: 383:59:234

**Signature:**
```solidity
function priceSource() external view returns (PriceSource);;
```
