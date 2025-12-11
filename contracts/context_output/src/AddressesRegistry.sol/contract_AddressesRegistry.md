# Contract: AddressesRegistry

## Metadata

- **Name**: AddressesRegistry
- **Type**: Contract
- **Path**: src/AddressesRegistry.sol

## Implements Interfaces

- **IAddressesRegistry** [src/Interfaces/IAddressesRegistry.sol/interface_IAddressesRegistry.md]

## State Variables

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### collToken

```solidity
IERC20Metadata public collToken
```

**IERC20Metadata**: [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### borrowerOperations

```solidity
IBorrowerOperations public borrowerOperations
```

**IBorrowerOperations**: [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

### troveManager

```solidity
ITroveManager public troveManager
```

**ITroveManager**: [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

### troveNFT

```solidity
ITroveNFT public troveNFT
```

**ITroveNFT**: [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]

### metadataNFT

```solidity
IMetadataNFT public metadataNFT
```

**IMetadataNFT**: [src/NFTMetadata/MetadataNFT.sol/interface_IMetadataNFT.md]

### stabilityPool

```solidity
IStabilityPool public stabilityPool
```

**IStabilityPool**: [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]

### priceFeed

```solidity
IPriceFeed public priceFeed
```

**IPriceFeed**: [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]

### activePool

```solidity
IActivePool public activePool
```

**IActivePool**: [src/Interfaces/IActivePool.sol/interface_IActivePool.md]

### defaultPool

```solidity
IDefaultPool public defaultPool
```

**IDefaultPool**: [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

### gasPoolAddress

```solidity
address public gasPoolAddress
```

### collSurplusPool

```solidity
ICollSurplusPool public collSurplusPool
```

**ICollSurplusPool**: [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]

### sortedTroves

```solidity
ISortedTroves public sortedTroves
```

**ISortedTroves**: [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]

### interestRouter

```solidity
IInterestRouter public interestRouter
```

**IInterestRouter**: [src/Interfaces/IInterestRouter.sol/interface_IInterestRouter.md]

### hintHelpers

```solidity
IHintHelpers public hintHelpers
```

**IHintHelpers**: [src/Interfaces/IHintHelpers.sol/interface_IHintHelpers.md]

### multiTroveGetter

```solidity
IMultiTroveGetter public multiTroveGetter
```

**IMultiTroveGetter**: [src/Interfaces/IMultiTroveGetter.sol/interface_IMultiTroveGetter.md]

### collateralRegistry

```solidity
ICollateralRegistry public collateralRegistry
```

**ICollateralRegistry**: [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

### boldToken

```solidity
IBoldToken public boldToken
```

**IBoldToken**: [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

### WETH

```solidity
IWETH public WETH
```

**IWETH**: [src/Interfaces/IWETH.sol/interface_IWETH.md]

### CCR

```solidity
uint256 public immutable CCR
```

### SCR

```solidity
uint256 public immutable SCR
```

### MCR

```solidity
uint256 public immutable MCR
```

### debtLimit

```solidity
uint256 public debtLimit
```

### LIQUIDATION_PENALTY_SP

```solidity
uint256 public immutable LIQUIDATION_PENALTY_SP
```

### LIQUIDATION_PENALTY_REDISTRIBUTION

```solidity
uint256 public immutable LIQUIDATION_PENALTY_REDISTRIBUTION
```

## Structs

### AddressVars (inherited from IAddressesRegistry)

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

## Errors

### InvalidCCR

```solidity
error InvalidCCR();
```

### InvalidMCR

```solidity
error InvalidMCR();
```

### InvalidSCR

```solidity
error InvalidSCR();
```

### InvalidDebtLimit

```solidity
error InvalidDebtLimit();
```

### SPPenaltyTooLow

```solidity
error SPPenaltyTooLow();
```

### SPPenaltyGtRedist

```solidity
error SPPenaltyGtRedist();
```

### RedistPenaltyTooHigh

```solidity
error RedistPenaltyTooHigh();
```

## Events

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

### CollTokenAddressChanged

```solidity
event CollTokenAddressChanged(address _collTokenAddress);
```

### BorrowerOperationsAddressChanged

```solidity
event BorrowerOperationsAddressChanged(address _borrowerOperationsAddress);
```

### TroveManagerAddressChanged

```solidity
event TroveManagerAddressChanged(address _troveManagerAddress);
```

### TroveNFTAddressChanged

```solidity
event TroveNFTAddressChanged(address _troveNFTAddress);
```

### MetadataNFTAddressChanged

```solidity
event MetadataNFTAddressChanged(address _metadataNFTAddress);
```

### StabilityPoolAddressChanged

```solidity
event StabilityPoolAddressChanged(address _stabilityPoolAddress);
```

### PriceFeedAddressChanged

```solidity
event PriceFeedAddressChanged(address _priceFeedAddress);
```

### ActivePoolAddressChanged

```solidity
event ActivePoolAddressChanged(address _activePoolAddress);
```

### DefaultPoolAddressChanged

```solidity
event DefaultPoolAddressChanged(address _defaultPoolAddress);
```

### GasPoolAddressChanged

```solidity
event GasPoolAddressChanged(address _gasPoolAddress);
```

### CollSurplusPoolAddressChanged

```solidity
event CollSurplusPoolAddressChanged(address _collSurplusPoolAddress);
```

### SortedTrovesAddressChanged

```solidity
event SortedTrovesAddressChanged(address _sortedTrovesAddress);
```

### InterestRouterAddressChanged

```solidity
event InterestRouterAddressChanged(address _interestRouterAddress);
```

### HintHelpersAddressChanged

```solidity
event HintHelpersAddressChanged(address _hintHelpersAddress);
```

### MultiTroveGetterAddressChanged

```solidity
event MultiTroveGetterAddressChanged(address _multiTroveGetterAddress);
```

### CollateralRegistryAddressChanged

```solidity
event CollateralRegistryAddressChanged(address _collateralRegistryAddress);
```

### BoldTokenAddressChanged

```solidity
event BoldTokenAddressChanged(address _boldTokenAddress);
```

### WETHAddressChanged

```solidity
event WETHAddressChanged(address _wethAddress);
```

## Public/External Functions

### constructor(address,uint256,uint256,uint256,uint256,uint256,uint256)

- **Signature**: `constructor(address,uint256,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 3298:1031:203
- **Details**: [function_constructor_address_uint256_uint256_uint256_uint256_uint256_uint256.md](./function_constructor_address_uint256_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
constructor(address _owner, uint256 _ccr, uint256 _mcr, uint256 _scr, uint256 _debtLimit, uint256 _liquidationPenaltySP, uint256 _liquidationPenaltyRedistribution) Ownable(_owner);
```

### setAddresses(struct IAddressesRegistry.AddressVars)

- **Signature**: `setAddresses(struct IAddressesRegistry.AddressVars)`
- **Visibility**: external
- **Source Range**: 4335:2116:203
- **Details**: [function_setAddresses_struct_IAddressesRegistry_AddressVars.md](./function_setAddresses_struct_IAddressesRegistry_AddressVars.md)

**Signature:**
```solidity
function setAddresses(AddressVars memory _vars) external onlyOwner();
```

### constructor(address) (inherited from Ownable)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 806:133:216
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner);
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1015:77:216
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() public view returns (address);
```

### isOwner() (inherited from Ownable)

- **Signature**: `isOwner()`
- **Visibility**: public
- **Source Range**: 1366:90:216
- **Details**: [function_isOwner.md](./function_isOwner.md)

**Signature:**
```solidity
///  @dev Returns true if the caller is the current owner.
function isOwner() public view returns (bool);
```
