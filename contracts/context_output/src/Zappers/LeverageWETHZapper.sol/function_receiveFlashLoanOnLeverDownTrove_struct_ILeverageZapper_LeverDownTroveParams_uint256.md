# Function: receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256)

**Contract**: [src/Zappers/LeverageWETHZapper.sol/contract_LeverageWETHZapper.md]

## Metadata

- **Contract**: LeverageWETHZapper
- **Signature**: `receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 7290:1054:292

## Implementation

```solidity
function receiveFlashLoanOnLeverDownTrove(LeverDownTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) override external {
    require(msg.sender == address(flashLoanProvider), "LZ: Caller not FlashLoan provider");
    uint256 receivedBoldAmount = exchange.swapToBold(_effectiveFlashLoanAmount, _params.minBoldAmount);
    borrowerOperations.adjustTrove(_params.troveId, _params.flashLoanAmount, false, receivedBoldAmount, false, 0);
    WETH.transfer(address(flashLoanProvider), _params.flashLoanAmount);
}
```

## External Calls

- **IExchange::swapToBold(uint256,uint256)**
- **IBorrowerOperations::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**
- **IWETH::transfer(address,uint256)**

## Native Transfers

- **WETH** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LeverageWETHZapper.receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
