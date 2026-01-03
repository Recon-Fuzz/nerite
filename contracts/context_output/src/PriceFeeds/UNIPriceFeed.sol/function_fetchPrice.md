# Function: fetchPrice()

**Contract**: [src/PriceFeeds/UNIPriceFeed.sol/contract_UNIPriceFeed.md]

## Metadata

- **Contract**: UNIPriceFeed
- **Signature**: `fetchPrice()`
- **Visibility**: public
- **Source Range**: 468:423:115

## Implementation

```solidity
function fetchPrice() public returns (uint256, bool) {
    if (priceSource == PriceSource.primary) return _fetchPricePrimary();
    assert(priceSource == PriceSource.lastGoodPrice);
    return (lastGoodPrice, false);
}
```

## Related Implementations

### _fetchPricePrimary()

- **Kind**: internal
- **Source**: 1358:537:115
- **Link**: `src/PriceFeeds/UNIPriceFeed.sol:UNIPriceFeed:_fetchPricePrimary()`

```solidity
function _fetchPricePrimary() internal returns (uint256, bool) {
    assert(priceSource == PriceSource.primary);
    (uint256 tokenUsdPrice, bool tokenUsdOracleDown) = _getOracleAnswer(tokenUsdOracle);
    if (tokenUsdOracleDown) return (_shutDownAndSwitchToLastGoodPrice(address(tokenUsdOracle.aggregator)), true);
    lastGoodPrice = tokenUsdPrice;
    return (tokenUsdPrice, false);
}
```

### _getOracleAnswer(struct TokenPriceFeedBase.Oracle)

- **Kind**: internal
- **Source**: 1902:660:114
- **Link**: `src/PriceFeeds/TokenPriceFeedBase.sol:TokenPriceFeedBase:_getOracleAnswer(struct TokenPriceFeedBase.Oracle)`

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
- **Source**: 2906:1250:114
- **Link**: `src/PriceFeeds/TokenPriceFeedBase.sol:TokenPriceFeedBase:_getCurrentChainlinkResponse(contract AggregatorV3Interface)`

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

### _isValidChainlinkPrice(struct TokenPriceFeedBase.ChainlinkResponse,uint256)

- **Kind**: internal
- **Source**: 4342:326:114
- **Link**: `src/PriceFeeds/TokenPriceFeedBase.sol:TokenPriceFeedBase:_isValidChainlinkPrice(struct TokenPriceFeedBase.ChainlinkResponse,uint256)`

```solidity
function _isValidChainlinkPrice(ChainlinkResponse memory chainlinkResponse, uint256 _stalenessThreshold) internal view returns (bool) {
    return (chainlinkResponse.success && ((block.timestamp - chainlinkResponse.timestamp) < _stalenessThreshold)) && (chainlinkResponse.answer > 0);
}
```

### _scaleChainlinkPriceTo18decimals(int256,uint256)

- **Kind**: internal
- **Source**: 4784:229:114
- **Link**: `src/PriceFeeds/TokenPriceFeedBase.sol:TokenPriceFeedBase:_scaleChainlinkPriceTo18decimals(int256,uint256)`

```solidity
function _scaleChainlinkPriceTo18decimals(int256 _price, uint256 _decimals) internal pure returns (uint256) {
    return uint256(_price) * (10 ** (18 - _decimals));
}
```

### _shutDownAndSwitchToLastGoodPrice(address)

- **Kind**: internal
- **Source**: 2568:332:114
- **Link**: `src/PriceFeeds/TokenPriceFeedBase.sol:TokenPriceFeedBase:_shutDownAndSwitchToLastGoodPrice(address)`

```solidity
function _shutDownAndSwitchToLastGoodPrice(address _failedOracleAddr) internal returns (uint256) {
    borrowerOperations.shutdownFromOracleFailure();
    priceSource = PriceSource.lastGoodPrice;
    emit ShutDownFromOracleFailure(_failedOracleAddr);
    return lastGoodPrice;
}
```

## External Calls

- **AggregatorV3Interface::latestRoundData()**
- **IBorrowerOperations::shutdownFromOracleFailure()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **lastGoodPrice** (`uint256`)

## State Variable Writes

- **priceSource** (`enum TokenPriceFeedBase.PriceSource`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UNIPriceFeed.fetchPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: UNIPriceFeed._fetchPricePrimary() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: TokenPriceFeedBase._getOracleAnswer(struct TokenPriceFeedBase.Oracle) (NodeID: 2)
    │   💬 Args: [tokenUsdOracle]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: TokenPriceFeedBase._getCurrentChainlinkResponse(contract AggregatorV3Interface) (NodeID: 3)
    │ │   💬 Args: [_oracle.aggregator]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: TokenPriceFeedBase._isValidChainlinkPrice(struct TokenPriceFeedBase.ChainlinkResponse,uint256) (NodeID: 4)
    │ │   💬 Args: [chainlinkResponse, _oracle.stalenessThreshold]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: TokenPriceFeedBase._scaleChainlinkPriceTo18decimals(int256,uint256) (NodeID: 5)
    │     💬 Args: [chainlinkResponse.answer, _oracle.decimals]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: TokenPriceFeedBase._shutDownAndSwitchToLastGoodPrice(address) (NodeID: 6)
        💬 Args: [address(tokenUsdOracle.aggregator)]
        👁️  Def: internal
```
