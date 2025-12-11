# Function: receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256)

**Contract**: [src/Zappers/LeverageWETHZapper.sol/contract_LeverageWETHZapper.md]

## Metadata

- **Contract**: LeverageWETHZapper
- **Signature**: `receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 5332:1185:292

## Implementation

```solidity
function receiveFlashLoanOnLeverUpTrove(LeverUpTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) override external {
    require(msg.sender == address(flashLoanProvider), "LZ: Caller not FlashLoan provider");
    borrowerOperations.adjustTrove(_params.troveId, _effectiveFlashLoanAmount, true, _params.boldAmount, true, _params.maxUpfrontFee);
    exchange.swapFromBold(_params.boldAmount, _params.flashLoanAmount);
    WETH.transfer(address(flashLoanProvider), _params.flashLoanAmount);
}
```

## External Calls

- **IBorrowerOperations::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**
- **IExchange::swapFromBold(uint256,uint256)**
- **IWETH::transfer(address,uint256)**

## Native Transfers

- **WETH** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LeverageWETHZapper.receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
