# Function: fetchPrice()

**Contract**: [src/PriceFeeds/WeETHPriceFeed.sol/contract_WeETHPriceFeed.md]

## Metadata

- **Contract**: WeETHPriceFeed
- **Signature**: `fetchPrice()`
- **Visibility**: public
- **Source Range**: 1046:277:262
- **Inherited From**: CompositePriceFeed

## Implementation

```solidity
function fetchPrice() public returns (uint256, bool) {
    if (priceSource == PriceSource.primary) return _fetchPricePrimary(false);
    return _fetchPriceDuringShutdown();
}
```

## Related Implementations

### _fetchPricePrimary(bool)

- **Kind**: internal
- **Source**: 1109:2408:269
- **Link**: `src/PriceFeeds/WeETHPriceFeed.sol:WeETHPriceFeed:_fetchPricePrimary(bool)`

```solidity
function _fetchPricePrimary(bool _isRedemption) override internal returns (uint256, bool) {
    assert(priceSource == PriceSource.primary);
    (uint256 ethUsdPrice, bool ethUsdOracleDown) = _getOracleAnswer(ethUsdOracle);
    (uint256 weEthEthPrice, bool weEthEthOracleDown) = _getOracleAnswer(weEthEthOracle);
    (uint256 weEthPerEth, bool exchangeRateIsDown) = _getCanonicalRate();
    if (ethUsdOracleDown) {
        return (_shutDownAndSwitchToLastGoodPrice(address(ethUsdOracle.aggregator)), true);
    }
    if (exchangeRateIsDown) {
        return (_shutDownAndSwitchToLastGoodPrice(rateProviderAddress), true);
    }
    if (weEthEthOracleDown) {
        return (_shutDownAndSwitchToETHUSDxCanonical(address(weEthEthOracle.aggregator), ethUsdPrice), true);
    }
    uint256 weEthUsdMarketPrice = (ethUsdPrice * weEthEthPrice) / 1e18;
    uint256 weEthUsdCanonicalPrice = (ethUsdPrice * weEthPerEth) / 1e18;
    uint256 weEthUsdPrice;
    if (_isRedemption && _withinDeviationThreshold(weEthUsdMarketPrice, weEthUsdCanonicalPrice, WEETH_ETH_DEVIATION_THRESHOLD)) {
        weEthUsdPrice = LiquityMath._max(weEthUsdMarketPrice, weEthUsdCanonicalPrice);
    } else {
        weEthUsdPrice = LiquityMath._min(weEthUsdMarketPrice, weEthUsdCanonicalPrice);
    }
    lastGoodPrice = weEthUsdPrice;
    return (weEthUsdPrice, false);
}
```

### _getOracleAnswer(struct MainnetPriceFeedBase.Oracle)

- **Kind**: internal
- **Source**: 1938:660:263
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_getOracleAnswer(struct MainnetPriceFeedBase.Oracle)`

```solidity
function _getOracleAnswer(Oracle memory _oracle) internal view returns (uint256, bool) {
    ChainlinkResponse memory chainlinkResponse = _getCurrentChainlinkResponse(_oracle.aggregator);
    uint256 scaledPrice;
    bool oracleIsDown;
    if (!_isValidChainlinkPrice(chainlinkResponse, _oracle.stalenessThreshold)) {
        oracleIsDown = true;
    } else {
        scaledPrice = _scaleChainlinkPriceTo18decimals(chainlinkResponse.answer, _oracle.decimals);
    }
    return (scaledPrice, oracleIsDown);
}
```

### _getCurrentChainlinkResponse(contract AggregatorV3Interface)

- **Kind**: internal
- **Source**: 2942:1250:263
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_getCurrentChainlinkResponse(contract AggregatorV3Interface)`

```solidity
function _getCurrentChainlinkResponse(AggregatorV3Interface _aggregator) internal view returns (ChainlinkResponse memory chainlinkResponse) {
    uint256 gasBefore = gasleft();
    try _aggregator.latestRoundData() returns (uint80 roundId, int256 answer, uint256, uint256 updatedAt, uint80) {
        chainlinkResponse.roundId = roundId;
        chainlinkResponse.answer = answer;
        chainlinkResponse.timestamp = updatedAt;
        chainlinkResponse.success = true;
        return chainlinkResponse;
    } catch {
        if (gasleft() <= (gasBefore / 64)) revert InsufficientGasForExternalCall();
        return chainlinkResponse;
    }
}
```

### _isValidChainlinkPrice(struct MainnetPriceFeedBase.ChainlinkResponse,uint256)

- **Kind**: internal
- **Source**: 4378:326:263
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_isValidChainlinkPrice(struct MainnetPriceFeedBase.ChainlinkResponse,uint256)`

```solidity
function _isValidChainlinkPrice(ChainlinkResponse memory chainlinkResponse, uint256 _stalenessThreshold) internal view returns (bool) {
    return (chainlinkResponse.success && ((block.timestamp - chainlinkResponse.timestamp) < _stalenessThreshold)) && (chainlinkResponse.answer > 0);
}
```

### _scaleChainlinkPriceTo18decimals(int256,uint256)

- **Kind**: internal
- **Source**: 4820:229:263
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_scaleChainlinkPriceTo18decimals(int256,uint256)`

```solidity
function _scaleChainlinkPriceTo18decimals(int256 _price, uint256 _decimals) internal pure returns (uint256) {
    return uint256(_price) * (10 ** (18 - _decimals));
}
```

### _getCanonicalRate()

- **Kind**: internal
- **Source**: 3523:797:269
- **Link**: `src/PriceFeeds/WeETHPriceFeed.sol:WeETHPriceFeed:_getCanonicalRate()`

```solidity
function _getCanonicalRate() override internal view returns (uint256, bool) {
    uint256 gasBefore = gasleft();
    try IWeETHToken(rateProviderAddress).getExchangeRate() returns (uint256 ethPerWeEth) {
        if (ethPerWeEth == 0) return (0, true);
        return (ethPerWeEth, false);
    } catch {
        if (gasleft() <= (gasBefore / 64)) revert InsufficientGasForExternalCall();
        return (0, true);
    }
}
```

### _shutDownAndSwitchToLastGoodPrice(address)

- **Kind**: internal
- **Source**: 2604:332:263
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_shutDownAndSwitchToLastGoodPrice(address)`

```solidity
function _shutDownAndSwitchToLastGoodPrice(address _failedOracleAddr) internal returns (uint256) {
    borrowerOperations.shutdownFromOracleFailure();
    priceSource = PriceSource.lastGoodPrice;
    emit ShutDownFromOracleFailure(_failedOracleAddr);
    return lastGoodPrice;
}
```

### _shutDownAndSwitchToETHUSDxCanonical(address,uint256)

- **Kind**: internal
- **Source**: 1623:408:262
- **Link**: `src/PriceFeeds/CompositePriceFeed.sol:CompositePriceFeed:_shutDownAndSwitchToETHUSDxCanonical(address,uint256)`

```solidity
function _shutDownAndSwitchToETHUSDxCanonical(address _failedOracleAddr, uint256 _ethUsdPrice) internal returns (uint256) {
    borrowerOperations.shutdownFromOracleFailure();
    priceSource = PriceSource.ETHUSDxCanonical;
    emit ShutDownFromOracleFailure(_failedOracleAddr);
    return _fetchPriceETHUSDxCanonical(_ethUsdPrice);
}
```

### _fetchPriceETHUSDxCanonical(uint256)

- **Kind**: internal
- **Source**: 3136:847:262
- **Link**: `src/PriceFeeds/CompositePriceFeed.sol:CompositePriceFeed:_fetchPriceETHUSDxCanonical(uint256)`

```solidity
function _fetchPriceETHUSDxCanonical(uint256 _ethUsdPrice) internal returns (uint256) {
    assert(priceSource == PriceSource.ETHUSDxCanonical);
    (uint256 lstRate, bool exchangeRateIsDown) = _getCanonicalRate();
    if (exchangeRateIsDown) {
        priceSource = PriceSource.lastGoodPrice;
        return lastGoodPrice;
    }
    uint256 lstUsdCanonicalPrice = (_ethUsdPrice * lstRate) / 1e18;
    uint256 bestPrice = LiquityMath._min(lstUsdCanonicalPrice, lastGoodPrice);
    lastGoodPrice = bestPrice;
    return bestPrice;
}
```

### _min(uint256,uint256)

- **Kind**: internal
- **Source**: 136:113:215
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

### _withinDeviationThreshold(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 3989:518:262
- **Link**: `src/PriceFeeds/CompositePriceFeed.sol:CompositePriceFeed:_withinDeviationThreshold(uint256,uint256,uint256)`

```solidity
function _withinDeviationThreshold(uint256 _priceToCheck, uint256 _referencePrice, uint256 _deviationThreshold) internal pure returns (bool) {
    uint256 max = (_referencePrice * (DECIMAL_PRECISION + _deviationThreshold)) / 1e18;
    uint256 min = (_referencePrice * (DECIMAL_PRECISION - _deviationThreshold)) / 1e18;
    return (_priceToCheck >= min) && (_priceToCheck <= max);
}
```

### _max(uint256,uint256)

- **Kind**: internal
- **Source**: 255:114:215
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_max(uint256,uint256)`

```solidity
function _max(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a >= _b) ? _a : _b;
}
```

### _fetchPriceDuringShutdown()

- **Kind**: internal
- **Source**: 2037:952:262
- **Link**: `src/PriceFeeds/CompositePriceFeed.sol:CompositePriceFeed:_fetchPriceDuringShutdown()`

```solidity
function _fetchPriceDuringShutdown() internal returns (uint256, bool) {
    if (priceSource == PriceSource.ETHUSDxCanonical) {
        (uint256 ethUsdPrice, bool ethUsdOracleDown) = _getOracleAnswer(ethUsdOracle);
        if (ethUsdOracleDown) {
            priceSource = PriceSource.lastGoodPrice;
            return (lastGoodPrice, false);
        } else {
            return (_fetchPriceETHUSDxCanonical(ethUsdPrice), false);
        }
    }
    assert(priceSource == PriceSource.lastGoodPrice);
    return (lastGoodPrice, false);
}
```

## External Calls

- **AggregatorV3Interface::latestRoundData()**
- **IRETHToken::getExchangeRate()**
- **IBorrowerOperations::shutdownFromOracleFailure()**

## State Variable Reads

- **weEthEthOracle** (`struct MainnetPriceFeedBase.Oracle`)
- **WEETH_ETH_DEVIATION_THRESHOLD** (`uint256`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **lastGoodPrice** (`uint256`)

## State Variable Writes

- **priceSource** (`enum IMainnetPriceFeed.PriceSource`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CompositePriceFeed.fetchPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: WeETHPriceFeed._fetchPricePrimary(bool) (NodeID: 1)
  │   💬 Args: [false]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._getOracleAnswer(struct MainnetPriceFeedBase.Oracle) (NodeID: 2)
  │ │   💬 Args: [ethUsdOracle]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._getCurrentChainlinkResponse(contract AggregatorV3Interface) (NodeID: 3)
  │ │ │   💬 Args: [_oracle.aggregator]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._isValidChainlinkPrice(struct MainnetPriceFeedBase.ChainlinkResponse,uint256) (NodeID: 4)
  │ │ │   💬 Args: [chainlinkResponse, _oracle.stalenessThreshold]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._scaleChainlinkPriceTo18decimals(int256,uint256) (NodeID: 5)
  │ │     💬 Args: [chainlinkResponse.answer, _oracle.decimals]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._getOracleAnswer(struct MainnetPriceFeedBase.Oracle) (NodeID: 6)
  │ │   💬 Args: [weEthEthOracle]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._getCurrentChainlinkResponse(contract AggregatorV3Interface) (NodeID: 7)
  │ │ │   💬 Args: [_oracle.aggregator]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._isValidChainlinkPrice(struct MainnetPriceFeedBase.ChainlinkResponse,uint256) (NodeID: 8)
  │ │ │   💬 Args: [chainlinkResponse, _oracle.stalenessThreshold]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._scaleChainlinkPriceTo18decimals(int256,uint256) (NodeID: 9)
  │ │     💬 Args: [chainlinkResponse.answer, _oracle.decimals]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: WeETHPriceFeed._getCanonicalRate() (NodeID: 10)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._shutDownAndSwitchToLastGoodPrice(address) (NodeID: 11)
  │ │   💬 Args: [address(ethUsdOracle.aggregator)]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._shutDownAndSwitchToLastGoodPrice(address) (NodeID: 12)
  │ │   💬 Args: [rateProviderAddress]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CompositePriceFeed._shutDownAndSwitchToETHUSDxCanonical(address,uint256) (NodeID: 13)
  │ │   💬 Args: [address(weEthEthOracle.aggregator), ethUsdPrice]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: CompositePriceFeed._fetchPriceETHUSDxCanonical(uint256) (NodeID: 14)
  │ │     💬 Args: [_ethUsdPrice]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: WeETHPriceFeed._getCanonicalRate() (NodeID: 15)
  │ │   │   💬 Args: [no args]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 16)
  │ │       💬 Args: [lstUsdCanonicalPrice, lastGoodPrice]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CompositePriceFeed._withinDeviationThreshold(uint256,uint256,uint256) (NodeID: 17)
  │ │   💬 Args: [weEthUsdMarketPrice, weEthUsdCanonicalPrice, WEETH_ETH_DEVIATION_THRESHOLD]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 18)
  │ │   💬 Args: [weEthUsdMarketPrice, weEthUsdCanonicalPrice]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 19)
  │     💬 Args: [weEthUsdMarketPrice, weEthUsdCanonicalPrice]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CompositePriceFeed._fetchPriceDuringShutdown() (NodeID: 20)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._getOracleAnswer(struct MainnetPriceFeedBase.Oracle) (NodeID: 21)
    │   💬 Args: [ethUsdOracle]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._getCurrentChainlinkResponse(contract AggregatorV3Interface) (NodeID: 22)
    │ │   💬 Args: [_oracle.aggregator]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._isValidChainlinkPrice(struct MainnetPriceFeedBase.ChainlinkResponse,uint256) (NodeID: 23)
    │ │   💬 Args: [chainlinkResponse, _oracle.stalenessThreshold]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: MainnetPriceFeedBase._scaleChainlinkPriceTo18decimals(int256,uint256) (NodeID: 24)
    │     💬 Args: [chainlinkResponse.answer, _oracle.decimals]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: CompositePriceFeed._fetchPriceETHUSDxCanonical(uint256) (NodeID: 25)
        💬 Args: [ethUsdPrice]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: WeETHPriceFeed._getCanonicalRate() (NodeID: 26)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 27)
          💬 Args: [lstUsdCanonicalPrice, lastGoodPrice]
          👁️  Def: internal
```
