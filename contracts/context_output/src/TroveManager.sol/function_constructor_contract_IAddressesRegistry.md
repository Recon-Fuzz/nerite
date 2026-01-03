# Function: constructor(contract IAddressesRegistry)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 6883:1490:124

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) LiquityBase(_addressesRegistry) {
    CCR = _addressesRegistry.CCR();
    MCR = _addressesRegistry.MCR();
    SCR = _addressesRegistry.SCR();
    debtLimit = _addressesRegistry.debtLimit();
    LIQUIDATION_PENALTY_SP = _addressesRegistry.LIQUIDATION_PENALTY_SP();
    LIQUIDATION_PENALTY_REDISTRIBUTION = _addressesRegistry.LIQUIDATION_PENALTY_REDISTRIBUTION();
    troveNFT = _addressesRegistry.troveNFT();
    borrowerOperations = _addressesRegistry.borrowerOperations();
    stabilityPool = _addressesRegistry.stabilityPool();
    gasPoolAddress = _addressesRegistry.gasPoolAddress();
    collSurplusPool = _addressesRegistry.collSurplusPool();
    boldToken = _addressesRegistry.boldToken();
    sortedTroves = _addressesRegistry.sortedTroves();
    WETH = _addressesRegistry.WETH();
    collateralRegistry = _addressesRegistry.collateralRegistry();
    emit TroveNFTAddressChanged(address(troveNFT));
    emit BorrowerOperationsAddressChanged(address(borrowerOperations));
    emit StabilityPoolAddressChanged(address(stabilityPool));
    emit GasPoolAddressChanged(gasPoolAddress);
    emit CollSurplusPoolAddressChanged(address(collSurplusPool));
    emit BoldTokenAddressChanged(address(boldToken));
    emit SortedTrovesAddressChanged(address(sortedTroves));
    emit CollateralRegistryAddressChanged(address(collateralRegistry));
}
```

## Related Implementations

### (contract IAddressesRegistry)

- **Kind**: internal
- **Source**: 816:401:63
- **Link**: `src/Dependencies/LiquityBase.sol:LiquityBase:constructor(contract IAddressesRegistry)`

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    activePool = _addressesRegistry.activePool();
    defaultPool = _addressesRegistry.defaultPool();
    priceFeed = _addressesRegistry.priceFeed();
    emit ActivePoolAddressChanged(address(activePool));
    emit DefaultPoolAddressChanged(address(defaultPool));
    emit PriceFeedAddressChanged(address(priceFeed));
}
```

## External Calls

- **IAddressesRegistry::CCR()**
- **IAddressesRegistry::MCR()**
- **IAddressesRegistry::SCR()**
- **IAddressesRegistry::debtLimit()**
- **IAddressesRegistry::LIQUIDATION_PENALTY_SP()**
- **IAddressesRegistry::LIQUIDATION_PENALTY_REDISTRIBUTION()**
- **IAddressesRegistry::troveNFT()**
- **IAddressesRegistry::borrowerOperations()**
- **IAddressesRegistry::stabilityPool()**
- **IAddressesRegistry::gasPoolAddress()**
- **IAddressesRegistry::collSurplusPool()**
- **IAddressesRegistry::boldToken()**
- **IAddressesRegistry::sortedTroves()**
- **IAddressesRegistry::WETH()**
- **IAddressesRegistry::collateralRegistry()**
- **IAddressesRegistry::activePool()**
- **IAddressesRegistry::defaultPool()**
- **IAddressesRegistry::priceFeed()**

## State Variable Reads

- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **gasPoolAddress** (`address`)
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **priceFeed** (`contract IPriceFeed`) [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## State Variable Writes

- **CCR** (`uint256`)
- **MCR** (`uint256`)
- **SCR** (`uint256`)
- **debtLimit** (`uint256`)
- **LIQUIDATION_PENALTY_SP** (`uint256`)
- **LIQUIDATION_PENALTY_REDISTRIBUTION** (`uint256`)
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **gasPoolAddress** (`address`)
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **priceFeed** (`contract IPriceFeed`) [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: TroveManager.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: TroveManager
  └─ [1] 🏗️ CONSTRUCTOR: LiquityBase.constructor(contract IAddressesRegistry) (NodeID: 1)
      💬 Args: [_addressesRegistry]
      🏗️  Contract: LiquityBase
```
