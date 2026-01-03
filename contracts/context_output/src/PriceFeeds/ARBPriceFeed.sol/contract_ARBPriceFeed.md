# Contract: ARBPriceFeed

## Metadata

- **Name**: ARBPriceFeed
- **Type**: Contract
- **Path**: src/PriceFeeds/ARBPriceFeed.sol

## State Variables

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### priceSource (inherited from TokenPriceFeedBase)

```solidity
PriceSource public priceSource
```

### lastGoodPrice (inherited from TokenPriceFeedBase)

```solidity
uint256 public lastGoodPrice
```

### tokenUsdOracle (inherited from TokenPriceFeedBase)

```solidity
Oracle public tokenUsdOracle
```

### borrowerOperations (inherited from TokenPriceFeedBase)

```solidity
IBorrowerOperations internal borrowerOperations
```

**IBorrowerOperations**: [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## Structs

### Oracle (inherited from TokenPriceFeedBase)

```solidity
struct Oracle {
    AggregatorV3Interface aggregator;
    uint256 stalenessThreshold;
    uint8 decimals;
}
```

### ChainlinkResponse (inherited from TokenPriceFeedBase)

```solidity
struct ChainlinkResponse {
    uint80 roundId;
    int256 answer;
    uint256 timestamp;
    bool success;
}
```

## Errors

### InsufficientGasForExternalCall (inherited from TokenPriceFeedBase)

```solidity
error InsufficientGasForExternalCall();
```

## Events

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

### ShutDownFromOracleFailure (inherited from TokenPriceFeedBase)

```solidity
event ShutDownFromOracleFailure(address _failedOracleAddr);
```

## Enums

### PriceSource (inherited from TokenPriceFeedBase)

```solidity
enum PriceSource {
    primary,
    TokenUSDxCanonical,
    lastGoodPrice
}
```

## Public/External Functions

### constructor(address,address,uint256)

- **Signature**: `constructor(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 144:319:109
- **Details**: [function_constructor_address_address_uint256.md](./function_constructor_address_address_uint256.md)

**Signature:**
```solidity
constructor(address _owner, address _arbUsdOracleAddress, uint256 _arbUsdStalenessThreshold) TokenPriceFeedBase(_owner,_arbUsdOracleAddress,_arbUsdStalenessThreshold);
```

### fetchPrice()

- **Signature**: `fetchPrice()`
- **Visibility**: public
- **Source Range**: 469:423:109
- **Details**: [function_fetchPrice.md](./function_fetchPrice.md)

**Signature:**
```solidity
function fetchPrice() public returns (uint256, bool);
```

### fetchRedemptionPrice()

- **Signature**: `fetchRedemptionPrice()`
- **Visibility**: external
- **Source Range**: 898:173:109
- **Details**: [function_fetchRedemptionPrice.md](./function_fetchRedemptionPrice.md)

**Signature:**
```solidity
function fetchRedemptionPrice() external returns (uint256, bool);
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

### setAddresses(address) (inherited from TokenPriceFeedBase)

- **Signature**: `setAddresses(address)`
- **Visibility**: external
- **Source Range**: 1707:189:114
- **Details**: [function_setAddresses_address.md](./function_setAddresses_address.md)

**Signature:**
```solidity
function setAddresses(address _borrowOperationsAddress) external onlyOwner();
```
