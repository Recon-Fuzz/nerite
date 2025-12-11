# Function: receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256)

**Contract**: [src/Zappers/LeverageLSTZapper.sol/contract_LeverageLSTZapper.md]

## Metadata

- **Contract**: LeverageLSTZapper
- **Signature**: `receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 5368:1194:291

## Implementation

```solidity
function receiveFlashLoanOnLeverUpTrove(LeverUpTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) override external {
    require(msg.sender == address(flashLoanProvider), "LZ: Caller not FlashLoan provider");
    borrowerOperations.adjustTrove(_params.troveId, _effectiveFlashLoanAmount, true, _params.boldAmount, true, _params.maxUpfrontFee);
    exchange.swapFromBold(_params.boldAmount, _params.flashLoanAmount);
    collToken.safeTransfer(address(flashLoanProvider), _params.flashLoanAmount);
}
```

## External Calls

- **IBorrowerOperations::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**
- **IExchange::swapFromBold(uint256,uint256)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LeverageLSTZapper.receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
