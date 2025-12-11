# Interface: IAddressesRegistry

## Metadata

- **Name**: IAddressesRegistry
- **Type**: Interface
- **Path**: src/Interfaces/IAddressesRegistry.sol

## Structs

### AddressVars

```solidity
struct AddressVars {
    IERC20Metadata collToken;
    IBorrowerOperations borrowerOperations;
    ITroveManager troveManager;
    ITroveNFT troveNFT;
    IMetadataNFT metadataNFT;
    IStabilityPool stabilityPool;
    IPriceFeed priceFeed;
    IActivePool activePool;
    IDefaultPool defaultPool;
    address gasPoolAddress;
    ICollSurplusPool collSurplusPool;
    ISortedTroves sortedTroves;
    IInterestRouter interestRouter;
    IHintHelpers hintHelpers;
    IMultiTroveGetter multiTroveGetter;
    ICollateralRegistry collateralRegistry;
    IBoldToken boldToken;
    IWETH WETH;
}
```

## Public/External Functions

### CCR()

- **Signature**: `CCR()`
- **Visibility**: external
- **Source Range**: 1255:42:221

**Signature:**
```solidity
function CCR() external returns (uint256);;
```

### SCR()

- **Signature**: `SCR()`
- **Visibility**: external
- **Source Range**: 1302:42:221

**Signature:**
```solidity
function SCR() external returns (uint256);;
```

### MCR()

- **Signature**: `MCR()`
- **Visibility**: external
- **Source Range**: 1349:42:221

**Signature:**
```solidity
function MCR() external returns (uint256);;
```

### debtLimit()

- **Signature**: `debtLimit()`
- **Visibility**: external
- **Source Range**: 1396:48:221

**Signature:**
```solidity
function debtLimit() external returns (uint256);;
```

### LIQUIDATION_PENALTY_SP()

- **Signature**: `LIQUIDATION_PENALTY_SP()`
- **Visibility**: external
- **Source Range**: 1449:61:221

**Signature:**
```solidity
function LIQUIDATION_PENALTY_SP() external returns (uint256);;
```

### LIQUIDATION_PENALTY_REDISTRIBUTION()

- **Signature**: `LIQUIDATION_PENALTY_REDISTRIBUTION()`
- **Visibility**: external
- **Source Range**: 1515:73:221

**Signature:**
```solidity
function LIQUIDATION_PENALTY_REDISTRIBUTION() external returns (uint256);;
```

### collToken()

- **Signature**: `collToken()`
- **Visibility**: external
- **Source Range**: 1594:60:221

**Signature:**
```solidity
function collToken() external view returns (IERC20Metadata);;
```

### borrowerOperations()

- **Signature**: `borrowerOperations()`
- **Visibility**: external
- **Source Range**: 1659:74:221

**Signature:**
```solidity
function borrowerOperations() external view returns (IBorrowerOperations);;
```

### troveManager()

- **Signature**: `troveManager()`
- **Visibility**: external
- **Source Range**: 1738:62:221

**Signature:**
```solidity
function troveManager() external view returns (ITroveManager);;
```

### troveNFT()

- **Signature**: `troveNFT()`
- **Visibility**: external
- **Source Range**: 1805:54:221

**Signature:**
```solidity
function troveNFT() external view returns (ITroveNFT);;
```

### metadataNFT()

- **Signature**: `metadataNFT()`
- **Visibility**: external
- **Source Range**: 1864:60:221

**Signature:**
```solidity
function metadataNFT() external view returns (IMetadataNFT);;
```

### stabilityPool()

- **Signature**: `stabilityPool()`
- **Visibility**: external
- **Source Range**: 1929:64:221

**Signature:**
```solidity
function stabilityPool() external view returns (IStabilityPool);;
```

### priceFeed()

- **Signature**: `priceFeed()`
- **Visibility**: external
- **Source Range**: 1998:56:221

**Signature:**
```solidity
function priceFeed() external view returns (IPriceFeed);;
```

### activePool()

- **Signature**: `activePool()`
- **Visibility**: external
- **Source Range**: 2059:58:221

**Signature:**
```solidity
function activePool() external view returns (IActivePool);;
```

### defaultPool()

- **Signature**: `defaultPool()`
- **Visibility**: external
- **Source Range**: 2122:60:221

**Signature:**
```solidity
function defaultPool() external view returns (IDefaultPool);;
```

### gasPoolAddress()

- **Signature**: `gasPoolAddress()`
- **Visibility**: external
- **Source Range**: 2187:58:221

**Signature:**
```solidity
function gasPoolAddress() external view returns (address);;
```

### collSurplusPool()

- **Signature**: `collSurplusPool()`
- **Visibility**: external
- **Source Range**: 2250:68:221

**Signature:**
```solidity
function collSurplusPool() external view returns (ICollSurplusPool);;
```

### sortedTroves()

- **Signature**: `sortedTroves()`
- **Visibility**: external
- **Source Range**: 2323:62:221

**Signature:**
```solidity
function sortedTroves() external view returns (ISortedTroves);;
```

### interestRouter()

- **Signature**: `interestRouter()`
- **Visibility**: external
- **Source Range**: 2390:66:221

**Signature:**
```solidity
function interestRouter() external view returns (IInterestRouter);;
```

### hintHelpers()

- **Signature**: `hintHelpers()`
- **Visibility**: external
- **Source Range**: 2461:60:221

**Signature:**
```solidity
function hintHelpers() external view returns (IHintHelpers);;
```

### multiTroveGetter()

- **Signature**: `multiTroveGetter()`
- **Visibility**: external
- **Source Range**: 2526:70:221

**Signature:**
```solidity
function multiTroveGetter() external view returns (IMultiTroveGetter);;
```

### collateralRegistry()

- **Signature**: `collateralRegistry()`
- **Visibility**: external
- **Source Range**: 2601:74:221

**Signature:**
```solidity
function collateralRegistry() external view returns (ICollateralRegistry);;
```

### boldToken()

- **Signature**: `boldToken()`
- **Visibility**: external
- **Source Range**: 2680:56:221

**Signature:**
```solidity
function boldToken() external view returns (IBoldToken);;
```

### WETH()

- **Signature**: `WETH()`
- **Visibility**: external
- **Source Range**: 2741:41:221

**Signature:**
```solidity
function WETH() external returns (IWETH);;
```

### setAddresses(struct IAddressesRegistry.AddressVars)

- **Signature**: `setAddresses(struct IAddressesRegistry.AddressVars)`
- **Visibility**: external
- **Source Range**: 2788:57:221

**Signature:**
```solidity
function setAddresses(AddressVars memory _vars) external;;
```
