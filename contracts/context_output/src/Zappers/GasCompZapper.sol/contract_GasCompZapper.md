# Contract: GasCompZapper

## Metadata

- **Name**: GasCompZapper
- **Type**: Contract
- **Path**: src/Zappers/GasCompZapper.sol

## Implements Interfaces

- **IZapper** [src/Zappers/Interfaces/IZapper.sol/interface_IZapper.md]
- **IFlashLoanReceiver** [src/Zappers/Interfaces/IFlashLoanReceiver.sol/interface_IFlashLoanReceiver.md]
- **IAddRemoveManagers** [src/Interfaces/IAddRemoveManagers.sol/interface_IAddRemoveManagers.md]

## State Variables

### troveNFT (inherited from AddRemoveManagers)

```solidity
ITroveNFT internal immutable troveNFT
```

**ITroveNFT**: [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

### addManagerOf (inherited from AddRemoveManagers)

```solidity
mapping(uint256 => address) public addManagerOf
```

### removeManagerReceiverOf (inherited from AddRemoveManagers)

```solidity
mapping(uint256 => RemoveManagerReceiver) public removeManagerReceiverOf
```

### borrowerOperations (inherited from BaseZapper)

```solidity
IBorrowerOperations public immutable borrowerOperations
```

**IBorrowerOperations**: [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

### troveManager (inherited from BaseZapper)

```solidity
ITroveManager public immutable troveManager
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### WETH (inherited from BaseZapper)

```solidity
IWETH public immutable WETH
```

**IWETH**: [src/Interfaces/IWETH.sol/interface_IWETH.md]

### boldToken (inherited from BaseZapper)

```solidity
IBoldToken public immutable boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### flashLoanProvider (inherited from BaseZapper)

```solidity
IFlashLoanProvider public immutable flashLoanProvider
```

**IFlashLoanProvider**: [src/Zappers/Interfaces/IFlashLoanProvider.sol/interface_IFlashLoanProvider.md]

### exchange (inherited from BaseZapper)

```solidity
IExchange public immutable exchange
```

**IExchange**: [src/Zappers/Interfaces/IExchange.sol/interface_IExchange.md]

### collToken

```solidity
IERC20 public immutable collToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Structs

### RemoveManagerReceiver (inherited from AddRemoveManagers)

```solidity
struct RemoveManagerReceiver {
    address manager;
    address receiver;
}
```

### InitialBalances (inherited from LeftoversSweep)

```solidity
struct InitialBalances {
    IERC20[4] tokens;
    uint256[4] balances;
    address receiver;
}
```

### OpenTroveParams (inherited from IZapper)

```solidity
struct OpenTroveParams {
    address owner;
    uint256 ownerIndex;
    uint256 collAmount;
    uint256 boldAmount;
    uint256 upperHint;
    uint256 lowerHint;
    uint256 annualInterestRate;
    address batchManager;
    uint256 maxUpfrontFee;
    address addManager;
    address removeManager;
    address receiver;
}
```

### CloseTroveParams (inherited from IZapper)

```solidity
struct CloseTroveParams {
    uint256 troveId;
    uint256 flashLoanAmount;
    address receiver;
}
```

## Errors

### EmptyManager (inherited from AddRemoveManagers)

```solidity
error EmptyManager();
```

### NotBorrower (inherited from AddRemoveManagers)

```solidity
error NotBorrower();
```

### NotOwnerNorAddManager (inherited from AddRemoveManagers)

```solidity
error NotOwnerNorAddManager();
```

### NotOwnerNorRemoveManager (inherited from AddRemoveManagers)

```solidity
error NotOwnerNorRemoveManager();
```

## Events

### TroveNFTAddressChanged (inherited from AddRemoveManagers)

```solidity
event TroveNFTAddressChanged(address _newTroveNFTAddress);
```

### AddManagerUpdated (inherited from AddRemoveManagers)

```solidity
event AddManagerUpdated(uint256 indexed _troveId, address _newAddManager);
```

### RemoveManagerAndReceiverUpdated (inherited from AddRemoveManagers)

```solidity
event RemoveManagerAndReceiverUpdated(uint256 indexed _troveId, address _newRemoveManager, address _newReceiver);
```

## Public/External Functions

### constructor(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange)

- **Signature**: `constructor(contract IAddressesRegistry,contract IFlashLoanProvider,contract IExchange)`
- **Visibility**: public
- **Source Range**: 318:702:283
- **Details**: [function_constructor_contract_IAddressesRegistry_contract_IFlashLoanProvider_contract_IExchange.md](./function_constructor_contract_IAddressesRegistry_contract_IFlashLoanProvider_contract_IExchange.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry, IFlashLoanProvider _flashLoanProvider, IExchange _exchange) BaseZapper(_addressesRegistry,_flashLoanProvider,_exchange);
```

### openTroveWithRawETH(struct IZapper.OpenTroveParams)

- **Signature**: `openTroveWithRawETH(struct IZapper.OpenTroveParams)`
- **Visibility**: external
- **Source Range**: 1026:2750:283
- **Details**: [function_openTroveWithRawETH_struct_IZapper_OpenTroveParams.md](./function_openTroveWithRawETH_struct_IZapper_OpenTroveParams.md)

**Signature:**
```solidity
function openTroveWithRawETH(OpenTroveParams calldata _params) external payable returns (uint256);
```

### addColl(uint256,uint256)

- **Signature**: `addColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3782:412:283
- **Details**: [function_addColl_uint256_uint256.md](./function_addColl_uint256_uint256.md)

**Signature:**
```solidity
function addColl(uint256 _troveId, uint256 _amount) external;
```

### withdrawColl(uint256,uint256)

- **Signature**: `withdrawColl(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4200:360:283
- **Details**: [function_withdrawColl_uint256_uint256.md](./function_withdrawColl_uint256_uint256.md)

**Signature:**
```solidity
function withdrawColl(uint256 _troveId, uint256 _amount) external;
```

### withdrawBold(uint256,uint256,uint256)

- **Signature**: `withdrawBold(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4566:403:283
- **Details**: [function_withdrawBold_uint256_uint256_uint256.md](./function_withdrawBold_uint256_uint256_uint256.md)

**Signature:**
```solidity
function withdrawBold(uint256 _troveId, uint256 _boldAmount, uint256 _maxUpfrontFee) external;
```

### repayBold(uint256,uint256)

- **Signature**: `repayBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4975:616:283
- **Details**: [function_repayBold_uint256_uint256.md](./function_repayBold_uint256_uint256.md)

**Signature:**
```solidity
function repayBold(uint256 _troveId, uint256 _boldAmount) external;
```

### adjustTrove(uint256,uint256,bool,uint256,bool,uint256)

- **Signature**: `adjustTrove(uint256,uint256,bool,uint256,bool,uint256)`
- **Visibility**: external
- **Source Range**: 5597:671:283
- **Details**: [function_adjustTrove_uint256_uint256_bool_uint256_bool_uint256.md](./function_adjustTrove_uint256_uint256_bool_uint256_bool_uint256.md)

**Signature:**
```solidity
function adjustTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) external;
```

### adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)

- **Signature**: `adjustZombieTrove(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 6274:763:283
- **Details**: [function_adjustZombieTrove_uint256_uint256_bool_uint256_bool_uint256_uint256_uint256.md](./function_adjustZombieTrove_uint256_uint256_bool_uint256_bool_uint256_uint256_uint256.md)

**Signature:**
```solidity
function adjustZombieTrove(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) external;
```

### closeTroveToRawETH(uint256)

- **Signature**: `closeTroveToRawETH(uint256)`
- **Visibility**: external
- **Source Range**: 8475:765:283
- **Details**: [function_closeTroveToRawETH_uint256.md](./function_closeTroveToRawETH_uint256.md)

**Signature:**
```solidity
function closeTroveToRawETH(uint256 _troveId) external;
```

### closeTroveFromCollateral(uint256,uint256)

- **Signature**: `closeTroveFromCollateral(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 9246:954:283
- **Details**: [function_closeTroveFromCollateral_uint256_uint256.md](./function_closeTroveFromCollateral_uint256_uint256.md)

**Signature:**
```solidity
function closeTroveFromCollateral(uint256 _troveId, uint256 _flashLoanAmount) override external;
```

### receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256)

- **Signature**: `receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 10206:1393:283
- **Details**: [function_receiveFlashLoanOnCloseTroveFromCollateral_struct_IZapper_CloseTroveParams_uint256.md](./function_receiveFlashLoanOnCloseTroveFromCollateral_struct_IZapper_CloseTroveParams_uint256.md)

**Signature:**
```solidity
function receiveFlashLoanOnCloseTroveFromCollateral(CloseTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) external;
```

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 11605:29:283
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
receive() external payable;
```

### receiveFlashLoanOnOpenLeveragedTrove(struct ILeverageZapper.OpenLeveragedTroveParams,uint256)

- **Signature**: `receiveFlashLoanOnOpenLeveragedTrove(struct ILeverageZapper.OpenLeveragedTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 11703:190:283
- **Details**: [function_receiveFlashLoanOnOpenLeveragedTrove_struct_ILeverageZapper_OpenLeveragedTroveParams_uint256.md](./function_receiveFlashLoanOnOpenLeveragedTrove_struct_ILeverageZapper_OpenLeveragedTroveParams_uint256.md)

**Signature:**
```solidity
function receiveFlashLoanOnOpenLeveragedTrove(ILeverageZapper.OpenLeveragedTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) virtual override external;
```

### receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256)

- **Signature**: `receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 11898:178:283
- **Details**: [function_receiveFlashLoanOnLeverUpTrove_struct_ILeverageZapper_LeverUpTroveParams_uint256.md](./function_receiveFlashLoanOnLeverUpTrove_struct_ILeverageZapper_LeverUpTroveParams_uint256.md)

**Signature:**
```solidity
function receiveFlashLoanOnLeverUpTrove(ILeverageZapper.LeverUpTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) virtual override external;
```

### receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256)

- **Signature**: `receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 12081:182:283
- **Details**: [function_receiveFlashLoanOnLeverDownTrove_struct_ILeverageZapper_LeverDownTroveParams_uint256.md](./function_receiveFlashLoanOnLeverDownTrove_struct_ILeverageZapper_LeverDownTroveParams_uint256.md)

**Signature:**
```solidity
function receiveFlashLoanOnLeverDownTrove(ILeverageZapper.LeverDownTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) virtual override external;
```

### constructor(contract IAddressesRegistry) (inherited from AddRemoveManagers)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 1932:164:209
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry);
```

### setAddManager(uint256,address) (inherited from AddRemoveManagers)

- **Signature**: `setAddManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2102:163:209
- **Details**: [function_setAddManager_uint256_address.md](./function_setAddManager_uint256_address.md)

**Signature:**
```solidity
function setAddManager(uint256 _troveId, address _manager) external;
```

### setRemoveManager(uint256,address) (inherited from AddRemoveManagers)

- **Signature**: `setRemoveManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2448:164:209
- **Details**: [function_setRemoveManager_uint256_address.md](./function_setRemoveManager_uint256_address.md)

**Signature:**
```solidity
function setRemoveManager(uint256 _troveId, address _manager) external;
```

### setRemoveManagerWithReceiver(uint256,address,address) (inherited from AddRemoveManagers)

- **Signature**: `setRemoveManagerWithReceiver(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 2618:220:209
- **Details**: [function_setRemoveManagerWithReceiver_uint256_address_address.md](./function_setRemoveManagerWithReceiver_uint256_address_address.md)

**Signature:**
```solidity
function setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) public;
```
