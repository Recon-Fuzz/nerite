# Function: constructor(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange)

**Contract**: [src/Zappers/LeverageLSTZapper.sol/contract_LeverageLSTZapper.md]

## Metadata

- **Contract**: LeverageLSTZapper
- **Signature**: `constructor(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange)`
- **Visibility**: public
- **Source Range**: 305:438:140

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry, IFlashLoanProvider _flashLoanProvider, IExchange _exchange) GasCompZapper(_addressesRegistry,_flashLoanProvider,_exchange) {
    boldToken.approve(address(_exchange), type(uint256).max);
}
```

## Related Implementations

### (contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange)

- **Kind**: internal
- **Source**: 318:702:132
- **Link**: `src/Zappers/GasCompZapper.sol:GasCompZapper:constructor(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange)`

```solidity
constructor(IAddressesRegistry _addressesRegistry, IFlashLoanProvider _flashLoanProvider, IExchange _exchange) BaseZapper(_addressesRegistry,_flashLoanProvider,_exchange) {
    collToken = _addressesRegistry.collToken();
    require(address(WETH) != address(collToken), "GCZ: Wrong coll branch");
    WETH.approve(address(borrowerOperations), type(uint256).max);
    collToken.approve(address(borrowerOperations), type(uint256).max);
    collToken.approve(address(_exchange), type(uint256).max);
}
```

### (contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange)

- **Kind**: internal
- **Source**: 865:469:131
- **Link**: `src/Zappers/BaseZapper.sol:BaseZapper:constructor(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange)`

```solidity
constructor(IAddressesRegistry _addressesRegistry, IFlashLoanProvider _flashLoanProvider, IExchange _exchange) AddRemoveManagers(_addressesRegistry) {
    borrowerOperations = _addressesRegistry.borrowerOperations();
    troveManager = _addressesRegistry.troveManager();
    boldToken = _addressesRegistry.boldToken();
    WETH = _addressesRegistry.WETH();
    flashLoanProvider = _flashLoanProvider;
    exchange = _exchange;
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

- **IBoldToken::approve(address,uint256)**
- **IAddressesRegistry::collToken()**
- **IWETH::approve(address,uint256)**
- **IERC20::approve(address,uint256)**
- **IAddressesRegistry::borrowerOperations()**
- **IAddressesRegistry::troveManager()**
- **IAddressesRegistry::boldToken()**
- **IAddressesRegistry::WETH()**
- **IAddressesRegistry::troveNFT()**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## State Variable Writes

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **flashLoanProvider** (`contract IFlashLoanProvider`) [src/Zappers/Interfaces/IFlashLoanProvider.sol/interface_IFlashLoanProvider.md]
- **exchange** (`contract IExchange`) [src/Zappers/Interfaces/IExchange.sol/interface_IExchange.md]
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: LeverageLSTZapper.constructor(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: LeverageLSTZapper
  └─ [1] 🏗️ CONSTRUCTOR: GasCompZapper.constructor(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange) (NodeID: 1)
      💬 Args: [_addressesRegistry, _flashLoanProvider, _exchange]
      🏗️  Contract: GasCompZapper
    └─ [2] 🏗️ CONSTRUCTOR: BaseZapper.constructor(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange) (NodeID: 2)
        💬 Args: [_addressesRegistry, _flashLoanProvider, _exchange]
        🏗️  Contract: BaseZapper
      └─ [3] 🏗️ CONSTRUCTOR: AddRemoveManagers.constructor(contract IAddressesRegistry) (NodeID: 3)
          💬 Args: [_addressesRegistry]
          🏗️  Contract: AddRemoveManagers
```
