# Function: constructor(contract IAddressesRegistry)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 5575:1200:54

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) AddRemoveManagers(_addressesRegistry) LiquityBase(_addressesRegistry) {
    assert(MIN_DEBT > 0);
    collToken = _addressesRegistry.collToken();
    WETH = _addressesRegistry.WETH();
    CCR = _addressesRegistry.CCR();
    SCR = _addressesRegistry.SCR();
    MCR = _addressesRegistry.MCR();
    troveManager = _addressesRegistry.troveManager();
    gasPoolAddress = _addressesRegistry.gasPoolAddress();
    collSurplusPool = _addressesRegistry.collSurplusPool();
    sortedTroves = _addressesRegistry.sortedTroves();
    boldToken = _addressesRegistry.boldToken();
    emit TroveManagerAddressChanged(address(troveManager));
    emit GasPoolAddressChanged(gasPoolAddress);
    emit CollSurplusPoolAddressChanged(address(collSurplusPool));
    emit SortedTrovesAddressChanged(address(sortedTroves));
    emit BoldTokenAddressChanged(address(boldToken));
    collToken.approve(address(activePool), type(uint256).max);
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

### (contract IAddressesRegistry)

- **Kind**: internal
- **Source**: 1932:164:58
- **Link**: `src/Dependencies/AddRemoveManagers.sol:AddRemoveManagers:constructor(contract IAddressesRegistry)`

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    troveNFT = _addressesRegistry.troveNFT();
    emit TroveNFTAddressChanged(address(troveNFT));
}
```

## External Calls

- **IAddressesRegistry::collToken()**
- **IAddressesRegistry::WETH()**
- **IAddressesRegistry::CCR()**
- **IAddressesRegistry::SCR()**
- **IAddressesRegistry::MCR()**
- **IAddressesRegistry::troveManager()**
- **IAddressesRegistry::gasPoolAddress()**
- **IAddressesRegistry::collSurplusPool()**
- **IAddressesRegistry::sortedTroves()**
- **IAddressesRegistry::boldToken()**
- **IERC20::approve(address,uint256)**
- **IAddressesRegistry::activePool()**
- **IAddressesRegistry::defaultPool()**
- **IAddressesRegistry::priceFeed()**
- **IAddressesRegistry::troveNFT()**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **gasPoolAddress** (`address`)
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **priceFeed** (`contract IPriceFeed`) [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## State Variable Writes

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **CCR** (`uint256`)
- **SCR** (`uint256`)
- **MCR** (`uint256`)
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **gasPoolAddress** (`address`)
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **priceFeed** (`contract IPriceFeed`) [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: BorrowerOperations.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: BorrowerOperations
  ├─ [1] 🏗️ CONSTRUCTOR: LiquityBase.constructor(contract IAddressesRegistry) (NodeID: 1)
  │   💬 Args: [_addressesRegistry]
  │   🏗️  Contract: LiquityBase
  └─ [1] 🏗️ CONSTRUCTOR: AddRemoveManagers.constructor(contract IAddressesRegistry) (NodeID: 2)
      💬 Args: [_addressesRegistry]
      🏗️  Contract: AddRemoveManagers
```
