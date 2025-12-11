# Function: constructor(address,address,uint256)

**Contract**: [src/PriceFeeds/COMPPriceFeed.sol/contract_COMPPriceFeed.md]

## Metadata

- **Contract**: COMPPriceFeed
- **Signature**: `constructor(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 146:323:261

## Implementation

```solidity
constructor(address _owner, address _compUsdOracleAddress, uint256 _compUsdStalenessThreshold) TokenPriceFeedBase(_owner,_compUsdOracleAddress,_compUsdStalenessThreshold) {
    _fetchPricePrimary();
    assert(priceSource == PriceSource.primary);
}
```

## Related Implementations

### _fetchPricePrimary()

- **Kind**: internal
- **Source**: 1366:539:261
- **Link**: `src/PriceFeeds/COMPPriceFeed.sol:COMPPriceFeed:_fetchPricePrimary()`

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
- **Source**: 1902:660:265
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
- **Source**: 2906:1250:265
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
- **Source**: 4342:326:265
- **Link**: `src/PriceFeeds/TokenPriceFeedBase.sol:TokenPriceFeedBase:_isValidChainlinkPrice(struct TokenPriceFeedBase.ChainlinkResponse,uint256)`

```solidity
function _isValidChainlinkPrice(ChainlinkResponse memory chainlinkResponse, uint256 _stalenessThreshold) internal view returns (bool) {
    return (chainlinkResponse.success && ((block.timestamp - chainlinkResponse.timestamp) < _stalenessThreshold)) && (chainlinkResponse.answer > 0);
}
```

### _scaleChainlinkPriceTo18decimals(int256,uint256)

- **Kind**: internal
- **Source**: 4784:229:265
- **Link**: `src/PriceFeeds/TokenPriceFeedBase.sol:TokenPriceFeedBase:_scaleChainlinkPriceTo18decimals(int256,uint256)`

```solidity
function _scaleChainlinkPriceTo18decimals(int256 _price, uint256 _decimals) internal pure returns (uint256) {
    return uint256(_price) * (10 ** (18 - _decimals));
}
```

### _shutDownAndSwitchToLastGoodPrice(address)

- **Kind**: internal
- **Source**: 2568:332:265
- **Link**: `src/PriceFeeds/TokenPriceFeedBase.sol:TokenPriceFeedBase:_shutDownAndSwitchToLastGoodPrice(address)`

```solidity
function _shutDownAndSwitchToLastGoodPrice(address _failedOracleAddr) internal returns (uint256) {
    borrowerOperations.shutdownFromOracleFailure();
    priceSource = PriceSource.lastGoodPrice;
    emit ShutDownFromOracleFailure(_failedOracleAddr);
    return lastGoodPrice;
}
```

### (address,address,uint256)

- **Kind**: internal
- **Source**: 1191:429:265
- **Link**: `src/PriceFeeds/TokenPriceFeedBase.sol:TokenPriceFeedBase:constructor(address,address,uint256)`

```solidity
constructor(address _owner, address _tokenUsdOracleAddress, uint256 _tokenUsdStalenessThreshold) Ownable(_owner) {
    tokenUsdOracle.aggregator = AggregatorV3Interface(_tokenUsdOracleAddress);
    tokenUsdOracle.stalenessThreshold = _tokenUsdStalenessThreshold;
    tokenUsdOracle.decimals = tokenUsdOracle.aggregator.decimals();
    assert(tokenUsdOracle.decimals == 8);
}
```

### (address)

- **Kind**: internal
- **Source**: 806:133:216
- **Link**: `src/Dependencies/Ownable.sol:Ownable:constructor(address)`

```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner) {
    _owner = initialOwner;
    emit OwnershipTransferred(address(0), initialOwner);
}
```

## External Calls

- **AggregatorV3Interface::latestRoundData()**
- **IBorrowerOperations::shutdownFromOracleFailure()**
- **AggregatorV3Interface::decimals()**

## State Variable Reads

- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **lastGoodPrice** (`uint256`)
- **tokenUsdOracle** (`struct TokenPriceFeedBase.Oracle`)

## State Variable Writes

- **priceSource** (`enum TokenPriceFeedBase.PriceSource`)
- **tokenUsdOracle** (`struct TokenPriceFeedBase.Oracle`)
- **_owner** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: COMPPriceFeed.constructor(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: COMPPriceFeed
  ├─ [1] ⚙️ FUNCTION: COMPPriceFeed._fetchPricePrimary() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: TokenPriceFeedBase._getOracleAnswer(struct TokenPriceFeedBase.Oracle) (NodeID: 2)
  │ │   💬 Args: [tokenUsdOracle]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: TokenPriceFeedBase._getCurrentChainlinkResponse(contract AggregatorV3Interface) (NodeID: 3)
  │ │ │   💬 Args: [_oracle.aggregator]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: TokenPriceFeedBase._isValidChainlinkPrice(struct TokenPriceFeedBase.ChainlinkResponse,uint256) (NodeID: 4)
  │ │ │   💬 Args: [chainlinkResponse, _oracle.stalenessThreshold]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: TokenPriceFeedBase._scaleChainlinkPriceTo18decimals(int256,uint256) (NodeID: 5)
  │ │     💬 Args: [chainlinkResponse.answer, _oracle.decimals]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: TokenPriceFeedBase._shutDownAndSwitchToLastGoodPrice(address) (NodeID: 6)
  │     💬 Args: [address(tokenUsdOracle.aggregator)]
  │     👁️  Def: internal
  └─ [1] 🏗️ CONSTRUCTOR: TokenPriceFeedBase.constructor(address,address,uint256) (NodeID: 7)
      💬 Args: [_owner, _compUsdOracleAddress, _compUsdStalenessThreshold]
      🏗️  Contract: TokenPriceFeedBase
    └─ [2] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 8)
        💬 Args: [_owner]
        🏗️  Contract: Ownable
```
