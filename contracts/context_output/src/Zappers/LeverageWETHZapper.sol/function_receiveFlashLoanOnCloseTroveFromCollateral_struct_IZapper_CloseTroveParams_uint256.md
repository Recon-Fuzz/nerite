# Function: receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256)

**Contract**: [src/Zappers/LeverageWETHZapper.sol/contract_LeverageWETHZapper.md]

## Metadata

- **Contract**: LeverageWETHZapper
- **Signature**: `receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 10632:1345:160
- **Inherited From**: WETHZapper

## Implementation

```solidity
function receiveFlashLoanOnCloseTroveFromCollateral(CloseTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) external {
    require(msg.sender == address(flashLoanProvider), "WZ: Caller not FlashLoan provider");
    LatestTroveData memory trove = troveManager.getLatestTroveData(_params.troveId);
    exchange.swapToBold(_effectiveFlashLoanAmount, trove.entireDebt);
    borrowerOperations.closeTrove(_params.troveId);
    WETH.transfer(address(flashLoanProvider), _params.flashLoanAmount);
    uint256 collLeft = (trove.entireColl + ETH_GAS_COMPENSATION) - _params.flashLoanAmount;
    WETH.withdraw(collLeft);
    (bool success, ) = _params.receiver.call{value: collLeft}("");
    require(success, "WZ: Sending ETH failed");
}
```

## External Calls

- **ITroveManager::getLatestTroveData(uint256)**
- **IExchange::swapToBold(uint256,uint256)**
- **IBorrowerOperations::closeTrove(uint256)**
- **IWETH::transfer(address,uint256)**
- **IWETH::withdraw(uint256)**
- **unknown::unknown**

## Native Transfers

- **WETH** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: WETHZapper.receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
