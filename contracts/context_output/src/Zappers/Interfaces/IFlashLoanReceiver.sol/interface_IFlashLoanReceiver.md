# Interface: IFlashLoanReceiver

## Metadata

- **Name**: IFlashLoanReceiver
- **Type**: Interface
- **Path**: src/Zappers/Interfaces/IFlashLoanReceiver.sol

## Public/External Functions

### receiveFlashLoanOnOpenLeveragedTrove(struct ILeverageZapper.OpenLeveragedTroveParams,uint256)

- **Signature**: `receiveFlashLoanOnOpenLeveragedTrove(struct ILeverageZapper.OpenLeveragedTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 150:171:136

**Signature:**
```solidity
function receiveFlashLoanOnOpenLeveragedTrove(ILeverageZapper.OpenLeveragedTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) external;;
```

### receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256)

- **Signature**: `receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 326:159:136

**Signature:**
```solidity
function receiveFlashLoanOnLeverUpTrove(ILeverageZapper.LeverUpTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) external;;
```

### receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256)

- **Signature**: `receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 490:163:136

**Signature:**
```solidity
function receiveFlashLoanOnLeverDownTrove(ILeverageZapper.LeverDownTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) external;;
```

### receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256)

- **Signature**: `receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 658:161:136

**Signature:**
```solidity
function receiveFlashLoanOnCloseTroveFromCollateral(IZapper.CloseTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) external;;
```
