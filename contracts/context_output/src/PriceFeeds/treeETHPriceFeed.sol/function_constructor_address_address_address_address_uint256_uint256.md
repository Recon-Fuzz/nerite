# Function: constructor(address,address,address,address,uint256,uint256)

**Contract**: [src/PriceFeeds/treeETHPriceFeed.sol/contract_TreeETHPriceFeed.md]

## Metadata

- **Contract**: TreeETHPriceFeed
- **Signature**: `constructor(address,address,address,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 257:768:121

## Implementation

```solidity
constructor(address _owner, address _ethUsdOracleAddress, address _treeEthEthOracleAddress, address _treeEthTokenAddress, uint256 _ethUsdStalenessThreshold, uint256 _treeEthEthStalenessThreshold) CompositePriceFeed(_owner,_ethUsdOracleAddress,_treeEthTokenAddress,_ethUsdStalenessThreshold) {
    treeEthEthOracle.aggregator = AggregatorV3Interface(_treeEthEthOracleAddress);
    treeEthEthOracle.stalenessThreshold = _treeEthEthStalenessThreshold;
    treeEthEthOracle.decimals = treeEthEthOracle.aggregator.decimals();
    _fetchPricePrimary(false);
    assert(priceSource == PriceSource.primary);
}
```

## Related Implementations

### _fetchPricePrimary(bool)

- **Kind**: internal
- **Source**: 1143:2466:121
- **Link**: `src/PriceFeeds/treeETHPriceFeed.sol:TreeETHPriceFeed:_fetchPricePrimary(bool)`

```solidity
function _fetchPricePrimary(bool _isRedemption) override internal returns (uint256, bool) {
    assert(priceSource == PriceSource.primary);
    (uint256 ethUsdPrice, bool ethUsdOracleDown) = _getOracleAnswer(ethUsdOracle);
    (uint256 treeEthEthPrice, bool treeEthEthOracleDown) = _getOracleAnswer(treeEthEthOracle);
    (uint256 treeEthPerEth, bool exchangeRateIsDown) = _getCanonicalRate();
    if (ethUsdOracleDown) {
        return (_shutDownAndSwitchToLastGoodPrice(address(ethUsdOracle.aggregator)), true);
    }
    if (exchangeRateIsDown) {
        return (_shutDownAndSwitchToLastGoodPrice(rateProviderAddress), true);
    }
    if (treeEthEthOracleDown) {
        return (_shutDownAndSwitchToETHUSDxCanonical(address(treeEthEthOracle.aggregator), ethUsdPrice), true);
    }
    uint256 treeEthUsdMarketPrice = (ethUsdPrice * treeEthEthPrice) / 1e18;
    uint256 treeEthUsdCanonicalPrice = (ethUsdPrice * treeEthPerEth) / 1e18;
    uint256 treeEthUsdPrice;
    if (_isRedemption && _withinDeviationThreshold(treeEthUsdMarketPrice, treeEthUsdCanonicalPrice, TREEETH_ETH_DEVIATION_THRESHOLD)) {
        treeEthUsdPrice = LiquityMath._max(treeEthUsdMarketPrice, treeEthUsdCanonicalPrice);
    } else {
        treeEthUsdPrice = LiquityMath._min(treeEthUsdMarketPrice, treeEthUsdCanonicalPrice);
    }
    lastGoodPrice = treeEthUsdPrice;
    return (treeEthUsdPrice, false);
}
```

### _getOracleAnswer(struct MainnetPriceFeedBase.Oracle)

- **Kind**: internal
- **Source**: 1938:660:112
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
- **Source**: 2942:1250:112
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
- **Source**: 4378:326:112
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_isValidChainlinkPrice(struct MainnetPriceFeedBase.ChainlinkResponse,uint256)`

```solidity
function _isValidChainlinkPrice(ChainlinkResponse memory chainlinkResponse, uint256 _stalenessThreshold) internal view returns (bool) {
    return (chainlinkResponse.success && ((block.timestamp - chainlinkResponse.timestamp) < _stalenessThreshold)) && (chainlinkResponse.answer > 0);
}
```

### _scaleChainlinkPriceTo18decimals(int256,uint256)

- **Kind**: internal
- **Source**: 4820:229:112
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:_scaleChainlinkPriceTo18decimals(int256,uint256)`

```solidity
function _scaleChainlinkPriceTo18decimals(int256 _price, uint256 _decimals) internal pure returns (uint256) {
    return uint256(_price) * (10 ** (18 - _decimals));
}
```

### _getCanonicalRate()

- **Kind**: internal
- **Source**: 3615:805:121
- **Link**: `src/PriceFeeds/treeETHPriceFeed.sol:TreeETHPriceFeed:_getCanonicalRate()`

```solidity
function _getCanonicalRate() override internal view returns (uint256, bool) {
    uint256 gasBefore = gasleft();
    try ITreeETHToken(rateProviderAddress).getExchangeRate() returns (uint256 ethPerTreeEth) {
        if (ethPerTreeEth == 0) return (0, true);
        return (ethPerTreeEth, false);
    } catch {
        if (gasleft() <= (gasBefore / 64)) revert InsufficientGasForExternalCall();
        return (0, true);
    }
}
```

### _shutDownAndSwitchToLastGoodPrice(address)

- **Kind**: internal
- **Source**: 2604:332:112
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
- **Source**: 1623:408:111
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
- **Source**: 3136:847:111
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
- **Source**: 136:113:64
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_min(uint256,uint256)`

```solidity
function _min(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a < _b) ? _a : _b;
}
```

### _withinDeviationThreshold(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 3989:518:111
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
- **Source**: 255:114:64
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_max(uint256,uint256)`

```solidity
function _max(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a >= _b) ? _a : _b;
}
```

### (address,address,address,uint256)

- **Kind**: internal
- **Source**: 464:329:111
- **Link**: `src/PriceFeeds/CompositePriceFeed.sol:CompositePriceFeed:constructor(address,address,address,uint256)`

```solidity
constructor(address _owner, address _ethUsdOracleAddress, address _rateProviderAddress, uint256 _ethUsdStalenessThreshold) MainnetPriceFeedBase(_owner,_ethUsdOracleAddress,_ethUsdStalenessThreshold) {
    rateProviderAddress = _rateProviderAddress;
}
```

### (address,address,uint256)

- **Kind**: internal
- **Source**: 1247:409:112
- **Link**: `src/PriceFeeds/MainnetPriceFeedBase.sol:MainnetPriceFeedBase:constructor(address,address,uint256)`

```solidity
constructor(address _owner, address _ethUsdOracleAddress, uint256 _ethUsdStalenessThreshold) Ownable(_owner) {
    ethUsdOracle.aggregator = AggregatorV3Interface(_ethUsdOracleAddress);
    ethUsdOracle.stalenessThreshold = _ethUsdStalenessThreshold;
    ethUsdOracle.decimals = ethUsdOracle.aggregator.decimals();
    assert(ethUsdOracle.decimals == 8);
}
```

### (address)

- **Kind**: internal
- **Source**: 806:133:65
- **Link**: `src/Dependencies/Ownable.sol:Ownable:constructor(address)`

```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner) {
    _owner = initialOwner;
    emit OwnershipTransferred(address(0), initialOwner);
}
```

## External Calls

- **AggregatorV3Interface::decimals()**
- **AggregatorV3Interface::latestRoundData()**
- **ITreeETHToken::getExchangeRate()**
- **IBorrowerOperations::shutdownFromOracleFailure()**

## State Variable Reads

- **treeEthEthOracle** (`struct MainnetPriceFeedBase.Oracle`)
- **TREEETH_ETH_DEVIATION_THRESHOLD** (`uint256`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **lastGoodPrice** (`uint256`)
- **ethUsdOracle** (`struct MainnetPriceFeedBase.Oracle`)

## State Variable Writes

- **treeEthEthOracle** (`struct MainnetPriceFeedBase.Oracle`)
- **priceSource** (`enum IMainnetPriceFeed.PriceSource`)
- **rateProviderAddress** (`address`)
- **ethUsdOracle** (`struct MainnetPriceFeedBase.Oracle`)
- **_owner** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: TreeETHPriceFeed.constructor(address,address,address,address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: TreeETHPriceFeed
  ├─ [1] ⚙️ FUNCTION: TreeETHPriceFeed._fetchPricePrimary(bool) (NodeID: 1)
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
  │ │   💬 Args: [treeEthEthOracle]
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
  │ ├─ [2] ⚙️ FUNCTION: TreeETHPriceFeed._getCanonicalRate() (NodeID: 10)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._shutDownAndSwitchToLastGoodPrice(address) (NodeID: 11)
  │ │   💬 Args: [address(ethUsdOracle.aggregator)]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MainnetPriceFeedBase._shutDownAndSwitchToLastGoodPrice(address) (NodeID: 12)
  │ │   💬 Args: [rateProviderAddress]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CompositePriceFeed._shutDownAndSwitchToETHUSDxCanonical(address,uint256) (NodeID: 13)
  │ │   💬 Args: [address(treeEthEthOracle.aggregator), ethUsdPrice]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: CompositePriceFeed._fetchPriceETHUSDxCanonical(uint256) (NodeID: 14)
  │ │     💬 Args: [_ethUsdPrice]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: TreeETHPriceFeed._getCanonicalRate() (NodeID: 15)
  │ │   │   💬 Args: [no args]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 16)
  │ │       💬 Args: [lstUsdCanonicalPrice, lastGoodPrice]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: CompositePriceFeed._withinDeviationThreshold(uint256,uint256,uint256) (NodeID: 17)
  │ │   💬 Args: [treeEthUsdMarketPrice, treeEthUsdCanonicalPrice, TREEETH_ETH_DEVIATION_THRESHOLD]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: LiquityMath._max(uint256,uint256) (NodeID: 18)
  │ │   💬 Args: [treeEthUsdMarketPrice, treeEthUsdCanonicalPrice]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LiquityMath._min(uint256,uint256) (NodeID: 19)
  │     💬 Args: [treeEthUsdMarketPrice, treeEthUsdCanonicalPrice]
  │     👁️  Def: internal
  └─ [1] 🏗️ CONSTRUCTOR: CompositePriceFeed.constructor(address,address,address,uint256) (NodeID: 20)
      💬 Args: [_owner, _ethUsdOracleAddress, _treeEthTokenAddress, _ethUsdStalenessThreshold]
      🏗️  Contract: CompositePriceFeed
    └─ [2] 🏗️ CONSTRUCTOR: MainnetPriceFeedBase.constructor(address,address,uint256) (NodeID: 21)
        💬 Args: [_owner, _ethUsdOracleAddress, _ethUsdStalenessThreshold]
        🏗️  Contract: MainnetPriceFeedBase
      └─ [3] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 22)
          💬 Args: [_owner]
          🏗️  Contract: Ownable
```
