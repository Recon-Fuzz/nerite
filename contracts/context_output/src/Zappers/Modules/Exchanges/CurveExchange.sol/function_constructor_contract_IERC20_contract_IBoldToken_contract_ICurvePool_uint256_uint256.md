# Function: constructor(contract IERC20,contract IBoldToken,contract ICurvePool,uint256,uint256)

**Contract**: [src/Zappers/Modules/Exchanges/CurveExchange.sol/contract_CurveExchange.md]

## Metadata

- **Contract**: CurveExchange
- **Signature**: `constructor(contract IERC20,contract IBoldToken,contract ICurvePool,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 549:344:297

## Implementation

```solidity
constructor(IERC20 _collToken, IBoldToken _boldToken, ICurvePool _curvePool, uint256 _collIndex, uint256 _boldIndex) {
    collToken = _collToken;
    boldToken = _boldToken;
    curvePool = _curvePool;
    COLL_TOKEN_INDEX = _collIndex;
    BOLD_TOKEN_INDEX = _boldIndex;
}
```

## State Variable Writes

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **curvePool** (`contract ICurvePool`) [src/Zappers/Modules/Exchanges/Curve/ICurvePool.sol/interface_ICurvePool.md]
- **COLL_TOKEN_INDEX** (`uint256`)
- **BOLD_TOKEN_INDEX** (`uint256`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: CurveExchange.constructor(contract IERC20,contract IBoldToken,contract ICurvePool,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: CurveExchange
```
