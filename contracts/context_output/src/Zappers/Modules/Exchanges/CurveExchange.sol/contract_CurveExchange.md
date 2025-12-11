# Contract: CurveExchange

## Metadata

- **Name**: CurveExchange
- **Type**: Contract
- **Path**: src/Zappers/Modules/Exchanges/CurveExchange.sol

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

### curvePool

```solidity
ICurvePool public immutable curvePool
```

**ICurvePool**: [src/Zappers/Modules/Exchanges/Curve/ICurvePool.sol/interface_ICurvePool.md]

### COLL_TOKEN_INDEX

```solidity
uint256 public immutable COLL_TOKEN_INDEX
```

### BOLD_TOKEN_INDEX

```solidity
uint256 public immutable BOLD_TOKEN_INDEX
```

## Public/External Functions

### constructor(contract IERC20,contract IBoldToken,contract ICurvePool,uint256,uint256)

- **Signature**: `constructor(contract IERC20,contract IBoldToken,contract ICurvePool,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 549:344:297
- **Details**: [function_constructor_contract_IERC20_contract_IBoldToken_contract_ICurvePool_uint256_uint256.md](./function_constructor_contract_IERC20_contract_IBoldToken_contract_ICurvePool_uint256_uint256.md)

**Signature:**
```solidity
constructor(IERC20 _collToken, IBoldToken _boldToken, ICurvePool _curvePool, uint256 _collIndex, uint256 _boldIndex);
```

### swapFromBold(uint256,uint256)

- **Signature**: `swapFromBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 899:735:297
- **Details**: [function_swapFromBold_uint256_uint256.md](./function_swapFromBold_uint256_uint256.md)

**Signature:**
```solidity
function swapFromBold(uint256 _boldAmount, uint256 _minCollAmount) external;
```

### swapToBold(uint256,uint256)

- **Signature**: `swapToBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1640:779:297
- **Details**: [function_swapToBold_uint256_uint256.md](./function_swapToBold_uint256_uint256.md)

**Signature:**
```solidity
function swapToBold(uint256 _collAmount, uint256 _minBoldAmount) external returns (uint256);
```
