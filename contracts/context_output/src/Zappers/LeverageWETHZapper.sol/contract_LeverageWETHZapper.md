# Contract: LeverageWETHZapper

## Metadata

- **Name**: LeverageWETHZapper
- **Type**: Contract
- **Path**: src/Zappers/LeverageWETHZapper.sol

## Implements Interfaces

- **ILeverageZapper** [src/Zappers/Interfaces/ILeverageZapper.sol/interface_ILeverageZapper.md]
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

### OpenLeveragedTroveParams (inherited from ILeverageZapper)

```solidity
struct OpenLeveragedTroveParams {
    address owner;
    uint256 ownerIndex;
    uint256 collAmount;
    uint256 flashLoanAmount;
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

### LeverUpTroveParams (inherited from ILeverageZapper)

```solidity
struct LeverUpTroveParams {
    uint256 troveId;
    uint256 flashLoanAmount;
    uint256 boldAmount;
    uint256 maxUpfrontFee;
}
```

### LeverDownTroveParams (inherited from ILeverageZapper)

```solidity
struct LeverDownTroveParams {
    uint256 troveId;
    uint256 flashLoanAmount;
    uint256 minBoldAmount;
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
- **Source Range**: 276:427:141
- **Details**: [function_constructor_contract_IAddressesRegistry_contract_IFlashLoanProvider_contract_IExchange.md](./function_constructor_contract_IAddressesRegistry_contract_IFlashLoanProvider_contract_IExchange.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry, IFlashLoanProvider _flashLoanProvider, IExchange _exchange) WETHZapper(_addressesRegistry,_flashLoanProvider,_exchange);
```

### openLeveragedTroveWithRawETH(struct ILeverageZapper.OpenLeveragedTroveParams)

- **Signature**: `openLeveragedTroveWithRawETH(struct ILeverageZapper.OpenLeveragedTroveParams)`
- **Visibility**: external
- **Source Range**: 709:902:141
- **Details**: [function_openLeveragedTroveWithRawETH_struct_ILeverageZapper_OpenLeveragedTroveParams.md](./function_openLeveragedTroveWithRawETH_struct_ILeverageZapper_OpenLeveragedTroveParams.md)

**Signature:**
```solidity
function openLeveragedTroveWithRawETH(OpenLeveragedTroveParams calldata _params) external payable;
```

### receiveFlashLoanOnOpenLeveragedTrove(struct ILeverageZapper.OpenLeveragedTroveParams,uint256)

- **Signature**: `receiveFlashLoanOnOpenLeveragedTrove(struct ILeverageZapper.OpenLeveragedTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 1662:2903:141
- **Details**: [function_receiveFlashLoanOnOpenLeveragedTrove_struct_ILeverageZapper_OpenLeveragedTroveParams_uint256.md](./function_receiveFlashLoanOnOpenLeveragedTrove_struct_ILeverageZapper_OpenLeveragedTroveParams_uint256.md)

**Signature:**
```solidity
function receiveFlashLoanOnOpenLeveragedTrove(OpenLeveragedTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) override external;
```

### leverUpTrove(struct ILeverageZapper.LeverUpTroveParams)

- **Signature**: `leverUpTrove(struct ILeverageZapper.LeverUpTroveParams)`
- **Visibility**: external
- **Source Range**: 4571:710:141
- **Details**: [function_leverUpTrove_struct_ILeverageZapper_LeverUpTroveParams.md](./function_leverUpTrove_struct_ILeverageZapper_LeverUpTroveParams.md)

**Signature:**
```solidity
function leverUpTrove(LeverUpTroveParams calldata _params) external;
```

### receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256)

- **Signature**: `receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 5332:1185:141
- **Details**: [function_receiveFlashLoanOnLeverUpTrove_struct_ILeverageZapper_LeverUpTroveParams_uint256.md](./function_receiveFlashLoanOnLeverUpTrove_struct_ILeverageZapper_LeverUpTroveParams_uint256.md)

**Signature:**
```solidity
function receiveFlashLoanOnLeverUpTrove(LeverUpTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) override external;
```

### leverDownTrove(struct ILeverageZapper.LeverDownTroveParams)

- **Signature**: `leverDownTrove(struct ILeverageZapper.LeverDownTroveParams)`
- **Visibility**: external
- **Source Range**: 6523:716:141
- **Details**: [function_leverDownTrove_struct_ILeverageZapper_LeverDownTroveParams.md](./function_leverDownTrove_struct_ILeverageZapper_LeverDownTroveParams.md)

**Signature:**
```solidity
function leverDownTrove(LeverDownTroveParams calldata _params) external;
```

### receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256)

- **Signature**: `receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 7290:1054:141
- **Details**: [function_receiveFlashLoanOnLeverDownTrove_struct_ILeverageZapper_LeverDownTroveParams_uint256.md](./function_receiveFlashLoanOnLeverDownTrove_struct_ILeverageZapper_LeverDownTroveParams_uint256.md)

**Signature:**
```solidity
function receiveFlashLoanOnLeverDownTrove(LeverDownTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) override external;
```

### leverageRatioToCollateralRatio(uint256)

- **Signature**: `leverageRatioToCollateralRatio(uint256)`
- **Visibility**: external
- **Source Range**: 8414:184:141
- **Details**: [function_leverageRatioToCollateralRatio_uint256.md](./function_leverageRatioToCollateralRatio_uint256.md)

**Signature:**
```solidity
function leverageRatioToCollateralRatio(uint256 _inputRatio) external pure returns (uint256);
```

### constructor(contract IAddressesRegistry) (inherited from AddRemoveManagers)

- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 1932:164:58
- **Details**: [function_constructor_contract_IAddressesRegistry.md](./function_constructor_contract_IAddressesRegistry.md)

**Signature:**
```solidity
constructor(IAddressesRegistry _addressesRegistry);
```

### setAddManager(uint256,address) (inherited from AddRemoveManagers)

- **Signature**: `setAddManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2102:163:58
- **Details**: [function_setAddManager_uint256_address.md](./function_setAddManager_uint256_address.md)

**Signature:**
```solidity
function setAddManager(uint256 _troveId, address _manager) external;
```

### setRemoveManager(uint256,address) (inherited from AddRemoveManagers)

- **Signature**: `setRemoveManager(uint256,address)`
- **Visibility**: external
- **Source Range**: 2448:164:58
- **Details**: [function_setRemoveManager_uint256_address.md](./function_setRemoveManager_uint256_address.md)

**Signature:**
```solidity
function setRemoveManager(uint256 _troveId, address _manager) external;
```

### setRemoveManagerWithReceiver(uint256,address,address) (inherited from AddRemoveManagers)

- **Signature**: `setRemoveManagerWithReceiver(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 2618:220:58
- **Details**: [function_setRemoveManagerWithReceiver_uint256_address_address.md](./function_setRemoveManagerWithReceiver_uint256_address_address.md)

**Signature:**
```solidity
function setRemoveManagerWithReceiver(uint256 _troveId, address _manager, address _receiver) public;
```

### openTroveWithRawETH(struct IZapper.OpenTroveParams) (inherited from WETHZapper)

- **Signature**: `openTroveWithRawETH(struct IZapper.OpenTroveParams)`
- **Visibility**: external
- **Source Range**: 716:2677:160
- **Details**: [function_openTroveWithRawETH_struct_IZapper_OpenTroveParams.md](./function_openTroveWithRawETH_struct_IZapper_OpenTroveParams.md)

**Signature:**
```solidity
function openTroveWithRawETH(OpenTroveParams calldata _params) external payable returns (uint256);
```

### addCollWithRawETH(uint256) (inherited from WETHZapper)

- **Signature**: `addCollWithRawETH(uint256)`
- **Visibility**: external
- **Source Range**: 3399:312:160
- **Details**: [function_addCollWithRawETH_uint256.md](./function_addCollWithRawETH_uint256.md)

**Signature:**
```solidity
function addCollWithRawETH(uint256 _troveId) external payable;
```

### withdrawCollToRawETH(uint256,uint256) (inherited from WETHZapper)

- **Signature**: `withdrawCollToRawETH(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3717:484:160
- **Details**: [function_withdrawCollToRawETH_uint256_uint256.md](./function_withdrawCollToRawETH_uint256_uint256.md)

**Signature:**
```solidity
function withdrawCollToRawETH(uint256 _troveId, uint256 _amount) external;
```

### withdrawBold(uint256,uint256,uint256) (inherited from WETHZapper)

- **Signature**: `withdrawBold(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4207:403:160
- **Details**: [function_withdrawBold_uint256_uint256_uint256.md](./function_withdrawBold_uint256_uint256_uint256.md)

**Signature:**
```solidity
function withdrawBold(uint256 _troveId, uint256 _boldAmount, uint256 _maxUpfrontFee) external;
```

### repayBold(uint256,uint256) (inherited from WETHZapper)

- **Signature**: `repayBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4616:611:160
- **Details**: [function_repayBold_uint256_uint256.md](./function_repayBold_uint256_uint256.md)

**Signature:**
```solidity
function repayBold(uint256 _troveId, uint256 _boldAmount) external;
```

### adjustTroveWithRawETH(uint256,uint256,bool,uint256,bool,uint256) (inherited from WETHZapper)

- **Signature**: `adjustTroveWithRawETH(uint256,uint256,bool,uint256,bool,uint256)`
- **Visibility**: external
- **Source Range**: 5233:697:160
- **Details**: [function_adjustTroveWithRawETH_uint256_uint256_bool_uint256_bool_uint256.md](./function_adjustTroveWithRawETH_uint256_uint256_bool_uint256_bool_uint256.md)

**Signature:**
```solidity
function adjustTroveWithRawETH(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _maxUpfrontFee) external payable;
```

### adjustZombieTroveWithRawETH(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256) (inherited from WETHZapper)

- **Signature**: `adjustZombieTroveWithRawETH(uint256,uint256,bool,uint256,bool,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 5936:789:160
- **Details**: [function_adjustZombieTroveWithRawETH_uint256_uint256_bool_uint256_bool_uint256_uint256_uint256.md](./function_adjustZombieTroveWithRawETH_uint256_uint256_bool_uint256_bool_uint256_uint256_uint256.md)

**Signature:**
```solidity
function adjustZombieTroveWithRawETH(uint256 _troveId, uint256 _collChange, bool _isCollIncrease, uint256 _boldChange, bool _isDebtIncrease, uint256 _upperHint, uint256 _lowerHint, uint256 _maxUpfrontFee) external payable;
```

### closeTroveToRawETH(uint256) (inherited from WETHZapper)

- **Signature**: `closeTroveToRawETH(uint256)`
- **Visibility**: external
- **Source Range**: 8994:682:160
- **Details**: [function_closeTroveToRawETH_uint256.md](./function_closeTroveToRawETH_uint256.md)

**Signature:**
```solidity
function closeTroveToRawETH(uint256 _troveId) external;
```

### closeTroveFromCollateral(uint256,uint256) (inherited from WETHZapper)

- **Signature**: `closeTroveFromCollateral(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 9682:944:160
- **Details**: [function_closeTroveFromCollateral_uint256_uint256.md](./function_closeTroveFromCollateral_uint256_uint256.md)

**Signature:**
```solidity
function closeTroveFromCollateral(uint256 _troveId, uint256 _flashLoanAmount) override external;
```

### receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256) (inherited from WETHZapper)

- **Signature**: `receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 10632:1345:160
- **Details**: [function_receiveFlashLoanOnCloseTroveFromCollateral_struct_IZapper_CloseTroveParams_uint256.md](./function_receiveFlashLoanOnCloseTroveFromCollateral_struct_IZapper_CloseTroveParams_uint256.md)

**Signature:**
```solidity
function receiveFlashLoanOnCloseTroveFromCollateral(CloseTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) external;
```

### receive() (inherited from WETHZapper)

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 11983:29:160
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
receive() external payable;
```
