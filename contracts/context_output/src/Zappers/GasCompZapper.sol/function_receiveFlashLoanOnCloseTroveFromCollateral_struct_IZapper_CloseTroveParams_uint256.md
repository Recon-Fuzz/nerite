# Function: receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256)

**Contract**: [src/Zappers/GasCompZapper.sol/contract_GasCompZapper.md]

## Metadata

- **Contract**: GasCompZapper
- **Signature**: `receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256)`
- **Visibility**: external
- **Source Range**: 10206:1393:283

## Implementation

```solidity
function receiveFlashLoanOnCloseTroveFromCollateral(CloseTroveParams calldata _params, uint256 _effectiveFlashLoanAmount) external {
    require(msg.sender == address(flashLoanProvider), "GCZ: Caller not FlashLoan provider");
    LatestTroveData memory trove = troveManager.getLatestTroveData(_params.troveId);
    exchange.swapToBold(_effectiveFlashLoanAmount, trove.entireDebt);
    borrowerOperations.closeTrove(_params.troveId);
    collToken.safeTransfer(address(flashLoanProvider), _params.flashLoanAmount);
    collToken.safeTransfer(_params.receiver, trove.entireColl - _params.flashLoanAmount);
    WETH.withdraw(ETH_GAS_COMPENSATION);
    (bool success, ) = _params.receiver.call{value: ETH_GAS_COMPENSATION}("");
    require(success, "GCZ: Sending ETH failed");
}
```

## External Calls

- **ITroveManager::getLatestTroveData(uint256)**
- **IExchange::swapToBold(uint256,uint256)**
- **IBorrowerOperations::closeTrove(uint256)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **IWETH::withdraw(uint256)**
- **unknown::unknown**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GasCompZapper.receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
