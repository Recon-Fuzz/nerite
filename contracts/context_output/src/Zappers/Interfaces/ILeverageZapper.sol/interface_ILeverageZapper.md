# Interface: ILeverageZapper

## Metadata

- **Name**: ILeverageZapper
- **Type**: Interface
- **Path**: src/Zappers/Interfaces/ILeverageZapper.sol

## Implements Interfaces

- **IZapper** [src/Zappers/Interfaces/IZapper.sol/interface_IZapper.md]

## Structs

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

### OpenLeveragedTroveParams

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

### LeverUpTroveParams

```solidity
struct LeverUpTroveParams {
    uint256 troveId;
    uint256 flashLoanAmount;
    uint256 boldAmount;
    uint256 maxUpfrontFee;
}
```

### LeverDownTroveParams

```solidity
struct LeverDownTroveParams {
    uint256 troveId;
    uint256 flashLoanAmount;
    uint256 minBoldAmount;
}
```

## Public/External Functions

### openLeveragedTroveWithRawETH(struct ILeverageZapper.OpenLeveragedTroveParams)

- **Signature**: `openLeveragedTroveWithRawETH(struct ILeverageZapper.OpenLeveragedTroveParams)`
- **Visibility**: external
- **Source Range**: 833:98:288

**Signature:**
```solidity
function openLeveragedTroveWithRawETH(OpenLeveragedTroveParams calldata _params) external payable;;
```

### leverUpTrove(struct ILeverageZapper.LeverUpTroveParams)

- **Signature**: `leverUpTrove(struct ILeverageZapper.LeverUpTroveParams)`
- **Visibility**: external
- **Source Range**: 937:68:288

**Signature:**
```solidity
function leverUpTrove(LeverUpTroveParams calldata _params) external;;
```

### leverDownTrove(struct ILeverageZapper.LeverDownTroveParams)

- **Signature**: `leverDownTrove(struct ILeverageZapper.LeverDownTroveParams)`
- **Visibility**: external
- **Source Range**: 1011:72:288

**Signature:**
```solidity
function leverDownTrove(LeverDownTroveParams calldata _params) external;;
```

### leverageRatioToCollateralRatio(uint256)

- **Signature**: `leverageRatioToCollateralRatio(uint256)`
- **Visibility**: external
- **Source Range**: 1089:93:288

**Signature:**
```solidity
function leverageRatioToCollateralRatio(uint256 _inputRatio) external pure returns (uint256);;
```

### flashLoanProvider() (inherited from IZapper)

- **Signature**: `flashLoanProvider()`
- **Visibility**: external
- **Source Range**: 644:72:289

**Signature:**
```solidity
function flashLoanProvider() external view returns (IFlashLoanProvider);;
```

### exchange() (inherited from IZapper)

- **Signature**: `exchange()`
- **Visibility**: external
- **Source Range**: 722:54:289

**Signature:**
```solidity
function exchange() external view returns (IExchange);;
```

### openTroveWithRawETH(struct IZapper.OpenTroveParams) (inherited from IZapper)

- **Signature**: `openTroveWithRawETH(struct IZapper.OpenTroveParams)`
- **Visibility**: external
- **Source Range**: 782:98:289

**Signature:**
```solidity
function openTroveWithRawETH(OpenTroveParams calldata _params) external payable returns (uint256);;
```

### closeTroveFromCollateral(uint256,uint256) (inherited from IZapper)

- **Signature**: `closeTroveFromCollateral(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 886:87:289

**Signature:**
```solidity
function closeTroveFromCollateral(uint256 _troveId, uint256 _flashLoanAmount) external;;
```
