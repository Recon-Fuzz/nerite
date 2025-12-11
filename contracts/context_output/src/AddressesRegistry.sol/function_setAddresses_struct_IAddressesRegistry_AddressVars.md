# Function: setAddresses(struct IAddressesRegistry.AddressVars)

**Contract**: [src/AddressesRegistry.sol/contract_AddressesRegistry.md]

## Metadata

- **Contract**: AddressesRegistry
- **Signature**: `setAddresses(struct IAddressesRegistry.AddressVars)`
- **Visibility**: external
- **Source Range**: 4335:2116:203

## Implementation

```solidity
function setAddresses(AddressVars memory _vars) external onlyOwner() {
    collToken = _vars.collToken;
    borrowerOperations = _vars.borrowerOperations;
    troveManager = _vars.troveManager;
    troveNFT = _vars.troveNFT;
    metadataNFT = _vars.metadataNFT;
    stabilityPool = _vars.stabilityPool;
    priceFeed = _vars.priceFeed;
    activePool = _vars.activePool;
    defaultPool = _vars.defaultPool;
    gasPoolAddress = _vars.gasPoolAddress;
    collSurplusPool = _vars.collSurplusPool;
    sortedTroves = _vars.sortedTroves;
    interestRouter = _vars.interestRouter;
    hintHelpers = _vars.hintHelpers;
    multiTroveGetter = _vars.multiTroveGetter;
    collateralRegistry = _vars.collateralRegistry;
    boldToken = _vars.boldToken;
    WETH = _vars.WETH;
    emit CollTokenAddressChanged(address(_vars.collToken));
    emit BorrowerOperationsAddressChanged(address(_vars.borrowerOperations));
    emit TroveManagerAddressChanged(address(_vars.troveManager));
    emit TroveNFTAddressChanged(address(_vars.troveNFT));
    emit MetadataNFTAddressChanged(address(_vars.metadataNFT));
    emit StabilityPoolAddressChanged(address(_vars.stabilityPool));
    emit PriceFeedAddressChanged(address(_vars.priceFeed));
    emit ActivePoolAddressChanged(address(_vars.activePool));
    emit DefaultPoolAddressChanged(address(_vars.defaultPool));
    emit GasPoolAddressChanged(_vars.gasPoolAddress);
    emit CollSurplusPoolAddressChanged(address(_vars.collSurplusPool));
    emit SortedTrovesAddressChanged(address(_vars.sortedTroves));
    emit InterestRouterAddressChanged(address(_vars.interestRouter));
    emit HintHelpersAddressChanged(address(_vars.hintHelpers));
    emit MultiTroveGetterAddressChanged(address(_vars.multiTroveGetter));
    emit CollateralRegistryAddressChanged(address(_vars.collateralRegistry));
    emit BoldTokenAddressChanged(address(_vars.boldToken));
    emit WETHAddressChanged(address(_vars.WETH));
    _renounceOwnership();
}
```

## Related Implementations

### _renounceOwnership()

- **Kind**: internal
- **Source**: 1896:130:216
- **Link**: `src/Dependencies/Ownable.sol:Ownable:_renounceOwnership()`

```solidity
///  @dev Leaves the contract without owner. It will not be possible to call
///  `onlyOwner` functions anymore.
///  NOTE: Renouncing ownership will leave the contract without an owner,
///  thereby removing any functionality that is only available to the owner.
///  NOTE: This function is not safe, as it doesn’t check owner is calling it.
///  Make sure you check it before calling it.
function _renounceOwnership() internal {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
}
```

### onlyOwner()

- **Kind**: modifier
- **Source**: 1180:103:216
- **Link**: `src/Dependencies/Ownable.sol:Ownable:onlyOwner()`

```solidity
///  @dev Throws if called by any account other than the owner.
modifier onlyOwner() {
    require(isOwner(), "Ownable: caller is not the owner");
    _;
}
```

### isOwner()

- **Kind**: internal
- **Source**: 1366:90:216
- **Link**: `src/Dependencies/Ownable.sol:Ownable:isOwner()`

```solidity
///  @dev Returns true if the caller is the current owner.
function isOwner() public view returns (bool) {
    return msg.sender == _owner;
}
```

## State Variable Reads

- **_owner** (`address`)

## State Variable Writes

- **collToken** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]
- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveNFT** (`contract ITroveNFT`) [src/Interfaces/ITroveNFT.sol/interface_ITroveNFT.md]
- **metadataNFT** (`contract IMetadataNFT`) [src/NFTMetadata/MetadataNFT.sol/interface_IMetadataNFT.md]
- **stabilityPool** (`contract IStabilityPool`) [src/Interfaces/IStabilityPool.sol/interface_IStabilityPool.md]
- **priceFeed** (`contract IPriceFeed`) [src/Interfaces/IPriceFeed.sol/interface_IPriceFeed.md]
- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]
- **gasPoolAddress** (`address`)
- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]
- **sortedTroves** (`contract ISortedTroves`) [src/Interfaces/ISortedTroves.sol/interface_ISortedTroves.md]
- **interestRouter** (`contract IInterestRouter`) [src/Interfaces/IInterestRouter.sol/interface_IInterestRouter.md]
- **hintHelpers** (`contract IHintHelpers`) [src/Interfaces/IHintHelpers.sol/interface_IHintHelpers.md]
- **multiTroveGetter** (`contract IMultiTroveGetter`) [src/Interfaces/IMultiTroveGetter.sol/interface_IMultiTroveGetter.md]
- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **WETH** (`contract IWETH`) [src/Interfaces/IWETH.sol/interface_IWETH.md]
- **_owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AddressesRegistry.setAddresses(struct IAddressesRegistry.AddressVars) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Ownable._renounceOwnership() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Ownable.onlyOwner() (NodeID: 2)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Ownable.isOwner() (NodeID: 3)
        💬 Args: [no args]
        👁️  Def: public
```
