# Contract: WSTETHPriceFeed

## Metadata

- **Name**: WSTETHPriceFeed
- **Type**: Contract
- **Path**: src/PriceFeeds/WSTETHPriceFeed.sol

## Implements Interfaces

- **IWSTETHPriceFeed** [src/Interfaces/IWSTETHPriceFeed.sol/interface_IWSTETHPriceFeed.md]
- **IMainnetPriceFeed** [src/Interfaces/IMainnetPriceFeed.sol/interface_IMainnetPriceFeed.md]
- **IPriceFeed** [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## State Variables

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### priceSource (inherited from MainnetPriceFeedBase)

```solidity
PriceSource public priceSource
```

### lastGoodPrice (inherited from MainnetPriceFeedBase)

```solidity
uint256 public lastGoodPrice
```

### ethUsdOracle (inherited from MainnetPriceFeedBase)

```solidity
Oracle public ethUsdOracle
```

### borrowerOperations (inherited from MainnetPriceFeedBase)

```solidity
IBorrowerOperations internal borrowerOperations
```

**IBorrowerOperations**: [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

### rateProviderAddress (inherited from CompositePriceFeed)

```solidity
address public rateProviderAddress
```

### stEthUsdOracle

```solidity
Oracle public stEthUsdOracle
```

### STETH_USD_DEVIATION_THRESHOLD

```solidity
uint256 public constant STETH_USD_DEVIATION_THRESHOLD = 1e16
```

## Structs

### Oracle (inherited from MainnetPriceFeedBase)

```solidity
struct Oracle {
    AggregatorV3Interface aggregator;
    uint256 stalenessThreshold;
    uint8 decimals;
}
```

### ChainlinkResponse (inherited from MainnetPriceFeedBase)

```solidity
struct ChainlinkResponse {
    uint80 roundId;
    int256 answer;
    uint256 timestamp;
    bool success;
}
```

## Errors

### InsufficientGasForExternalCall (inherited from MainnetPriceFeedBase)

```solidity
error InsufficientGasForExternalCall();
```

## Events

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

### ShutDownFromOracleFailure (inherited from MainnetPriceFeedBase)

```solidity
event ShutDownFromOracleFailure(address _failedOracleAddr);
```

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

### constructor(address,address,address,address,uint256,uint256)

- **Signature**: `constructor(address,address,address,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 391:714:117
- **Details**: [function_constructor_address_address_address_address_uint256_uint256.md](./function_constructor_address_address_address_address_uint256_uint256.md)

**Signature:**
```solidity
constructor(address _owner, address _ethUsdOracleAddress, address _stEthUsdOracleAddress, address _wstEthTokenAddress, uint256 _ethUsdStalenessThreshold, uint256 _stEthUsdStalenessThreshold) CompositePriceFeed(_owner,_ethUsdOracleAddress,_wstEthTokenAddress,_ethUsdStalenessThreshold);
```

### constructor(address) (inherited from Ownable)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 806:133:65
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner);
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1015:77:65
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() public view returns (address);
```

### isOwner() (inherited from Ownable)

- **Signature**: `isOwner()`
- **Visibility**: public
- **Source Range**: 1366:90:65
- **Details**: [function_isOwner.md](./function_isOwner.md)

**Signature:**
```solidity
///  @dev Returns true if the caller is the current owner.
function isOwner() public view returns (bool);
```

### setAddresses(address) (inherited from MainnetPriceFeedBase)

- **Signature**: `setAddresses(address)`
- **Visibility**: external
- **Source Range**: 1743:189:112
- **Details**: [function_setAddresses_address.md](./function_setAddresses_address.md)

**Signature:**
```solidity
function setAddresses(address _borrowOperationsAddress) external onlyOwner();
```

### fetchPrice() (inherited from CompositePriceFeed)

- **Signature**: `fetchPrice()`
- **Visibility**: public
- **Source Range**: 1046:277:111
- **Details**: [function_fetchPrice.md](./function_fetchPrice.md)

**Signature:**
```solidity
function fetchPrice() public returns (uint256, bool);
```

### fetchRedemptionPrice() (inherited from CompositePriceFeed)

- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 1329:288:111
- **Details**: [function_fetchRedemptionPrice.md](./function_fetchRedemptionPrice.md)

**Signature:**
```solidity
function fetchRedemptionPrice() external returns (uint256, bool);
```
