# Contract: UniV3Exchange

## Metadata

- **Name**: UniV3Exchange
- **Type**: Contract
- **Path**: src/Zappers/Modules/Exchanges/UniV3Exchange.sol

## Implements Interfaces

- **IExchange** [src/Zappers/Interfaces/IExchange.sol/interface_IExchange.md]

## State Variables

### collToken

```solidity
IERC20 public immutable collToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### boldToken

```solidity
IBoldToken public immutable boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### fee

```solidity
uint24 public immutable fee
```

### uniV3Router

```solidity
ISwapRouter public immutable uniV3Router
```

**ISwapRouter**: [src/Zappers/Modules/Exchanges/UniswapV3/ISwapRouter.sol/interface_ISwapRouter.md]

## Structs

### InitialBalances (inherited from LeftoversSweep)

```solidity
struct InitialBalances {
    IERC20[4] tokens;
    uint256[4] balances;
    address receiver;
}
```

## Public/External Functions

### constructor(contract IERC20,contract IBoldToken,uint24,contract ISwapRouter)

- **Signature**: `constructor(contract IERC20,contract IBoldToken,uint24,contract ISwapRouter)`
- **Visibility**: public
- **Source Range**: 744:220:300
- **Details**: [function_constructor_contract_IERC20_contract_IBoldToken_uint24_contract_ISwapRouter.md](./function_constructor_contract_IERC20_contract_IBoldToken_uint24_contract_ISwapRouter.md)

**Signature:**
```solidity
constructor(IERC20 _collToken, IBoldToken _boldToken, uint24 _fee, ISwapRouter _uniV3Router);
```

### swapFromBold(uint256,uint256)

- **Signature**: `swapFromBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 970:1066:300
- **Details**: [function_swapFromBold_uint256_uint256.md](./function_swapFromBold_uint256_uint256.md)

**Signature:**
```solidity
function swapFromBold(uint256 _boldAmount, uint256 _minCollAmount) external;
```

### swapToBold(uint256,uint256)

- **Signature**: `swapToBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2042:1130:300
- **Details**: [function_swapToBold_uint256_uint256.md](./function_swapToBold_uint256_uint256.md)

**Signature:**
```solidity
function swapToBold(uint256 _collAmount, uint256 _minBoldAmount) external returns (uint256);
```

### priceToSqrtPrice(contract IBoldToken,contract IERC20,uint256)

- **Signature**: `priceToSqrtPrice(contract IBoldToken,contract IERC20,uint256)`
- **Visibility**: public
- **Source Range**: 3178:327:300
- **Details**: [function_priceToSqrtPrice_contract_IBoldToken_contract_IERC20_uint256.md](./function_priceToSqrtPrice_contract_IBoldToken_contract_IERC20_uint256.md)

**Signature:**
```solidity
function priceToSqrtPrice(IBoldToken _boldToken, IERC20 _collToken, uint256 _price) public pure returns (uint160);
```

### priceToSqrtPriceX96(uint256) (inherited from UniPriceConverter)

- **Signature**: `priceToSqrtPriceX96(uint256)`
- **Visibility**: public
- **Source Range**: 230:378:307
- **Details**: [function_priceToSqrtPriceX96_uint256.md](./function_priceToSqrtPriceX96_uint256.md)

**Signature:**
```solidity
function priceToSqrtPriceX96(uint256 _price) public pure returns (uint160 sqrtPriceX96);
```

### sqrtPriceX96ToPrice(uint160) (inherited from UniPriceConverter)

- **Signature**: `sqrtPriceX96ToPrice(uint160)`
- **Visibility**: public
- **Source Range**: 614:539:307
- **Details**: [function_sqrtPriceX96ToPrice_uint160.md](./function_sqrtPriceX96ToPrice_uint160.md)

**Signature:**
```solidity
function sqrtPriceX96ToPrice(uint160 _sqrtPriceX96) public pure returns (uint256 price);
```
