# Function: constructor(contract IERC20,contract IBoldToken,uint24,contract ISwapRouter)

**Contract**: [src/Zappers/Modules/Exchanges/UniV3Exchange.sol/contract_UniV3Exchange.md]

## Metadata

- **Contract**: UniV3Exchange
- **Signature**: `constructor(contract IERC20,contract IBoldToken,uint24,contract ISwapRouter)`
- **Visibility**: public
- **Source Range**: 744:220:300

## Implementation

```solidity
constructor(IERC20 _collToken, IBoldToken _boldToken, uint24 _fee, ISwapRouter _uniV3Router) {
    collToken = _collToken;
    boldToken = _boldToken;
    fee = _fee;
    uniV3Router = _uniV3Router;
}
```

## State Variable Writes

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **fee** (`uint24`)
- **uniV3Router** (`contract ISwapRouter`) [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: UniV3Exchange.constructor(contract IERC20,contract IBoldToken,uint24,contract ISwapRouter) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: UniV3Exchange
```
