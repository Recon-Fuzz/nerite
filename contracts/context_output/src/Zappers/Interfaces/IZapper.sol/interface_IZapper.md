# Interface: IZapper

## Metadata

- **Name**: IZapper
- **Type**: Interface
- **Path**: src/Zappers/Interfaces/IZapper.sol

## Structs

### OpenTroveParams

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

### CloseTroveParams

```solidity
struct CloseTroveParams {
    uint256 troveId;
    uint256 flashLoanAmount;
    address receiver;
}
```

## Public/External Functions

### flashLoanProvider()

- **Signature**: `flashLoanProvider()`
- **Visibility**: external
- **Source Range**: 644:72:289

**Signature:**
```solidity
function flashLoanProvider() external view returns (IFlashLoanProvider);;
```

### exchange()

- **Signature**: `exchange()`
- **Visibility**: external
- **Source Range**: 722:54:289

**Signature:**
```solidity
function exchange() external view returns (IExchange);;
```

### openTroveWithRawETH(struct IZapper.OpenTroveParams)

- **Signature**: `openTroveWithRawETH(struct IZapper.OpenTroveParams)`
- **Visibility**: external
- **Source Range**: 782:98:289

**Signature:**
```solidity
function openTroveWithRawETH(OpenTroveParams calldata _params) external payable returns (uint256);;
```

### closeTroveFromCollateral(uint256,uint256)

- **Signature**: `closeTroveFromCollateral(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 886:87:289

**Signature:**
```solidity
function closeTroveFromCollateral(uint256 _troveId, uint256 _flashLoanAmount) external;;
```
