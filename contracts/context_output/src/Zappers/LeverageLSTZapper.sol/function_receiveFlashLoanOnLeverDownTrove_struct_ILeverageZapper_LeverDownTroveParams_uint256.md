# Function: receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256)

**Contract**: [src/Zappers/LeverageLSTZapper.sol/contract_LeverageLSTZapper.md]

## Metadata

- **Contract**: LeverageLSTZapper
- **Signature**: `receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 7345:1063:291

## Implementation

```solidity
function receiveFlashLoanOnLeverDownTrove(LeverDownTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) override external {
    require(msg.sender == address(flashLoanProvider), "LZ: Caller not FlashLoan provider");
    uint256 receivedBoldAmount = exchange.swapToBold(_effectiveFlashLoanAmount, _params.minBoldAmount);
    borrowerOperations.adjustTrove(_params.troveId, _params.flashLoanAmount, false, receivedBoldAmount, false, 0);
    collToken.safeTransfer(address(flashLoanProvider), _params.flashLoanAmount);
}
```

## External Calls

- **IExchange::swapToBold(uint256,uint256)**
- **IBorrowerOperations::adjustTrove(uint256,uint256,bool,uint256,bool,uint256)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LeverageLSTZapper.receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
