# Function: receiveFlashLoan(contract IERC20[],uint256[],uint256[],bytes)

**Contract**: [src/Zappers/Modules/FlashLoans/BalancerFlashLoan.sol/contract_BalancerFlashLoan.md]

## Metadata

- **Contract**: BalancerFlashLoan
- **Signature**: `receiveFlashLoan(contract IERC20[],uint256[],uint256[],bytes)`
- **Visibility**: external
- **Source Range**: 2278:3705:159

## Implementation

```solidity
function receiveFlashLoan(IERC20[] calldata tokens, uint256[] calldata amounts, uint256[] calldata feeAmounts, bytes calldata userData) override external {
    require(msg.sender == address(vault), "Caller is not Vault");
    require(address(receiver) != address(0), "Flash loan not properly initiated");
    IFlashLoanReceiver receiverCached = receiver;
    receiver = IFlashLoanReceiver(address(0));
    Operation operation = abi.decode(userData[0:32], (Operation));
    if (operation == Operation.OpenTrove) {
        ILeverageZapper.OpenLeveragedTroveParams memory openTroveParams = abi.decode(userData[32:], (ILeverageZapper.OpenLeveragedTroveParams));
        uint256 effectiveFlashLoanAmount = amounts[0] - feeAmounts[0];
        tokens[0].safeTransfer(address(receiverCached), effectiveFlashLoanAmount);
        receiverCached.receiveFlashLoanOnOpenLeveragedTrove(openTroveParams, effectiveFlashLoanAmount);
    } else if (operation == Operation.LeverUpTrove) {
        ILeverageZapper.LeverUpTroveParams memory leverUpTroveParams = abi.decode(userData[32:], (ILeverageZapper.LeverUpTroveParams));
        uint256 effectiveFlashLoanAmount = amounts[0] - feeAmounts[0];
        tokens[0].safeTransfer(address(receiverCached), effectiveFlashLoanAmount);
        receiverCached.receiveFlashLoanOnLeverUpTrove(leverUpTroveParams, effectiveFlashLoanAmount);
    } else if (operation == Operation.LeverDownTrove) {
        ILeverageZapper.LeverDownTroveParams memory leverDownTroveParams = abi.decode(userData[32:], (ILeverageZapper.LeverDownTroveParams));
        uint256 effectiveFlashLoanAmount = amounts[0] - feeAmounts[0];
        tokens[0].safeTransfer(address(receiverCached), effectiveFlashLoanAmount);
        receiverCached.receiveFlashLoanOnLeverDownTrove(leverDownTroveParams, effectiveFlashLoanAmount);
    } else if (operation == Operation.CloseTrove) {
        IZapper.CloseTroveParams memory closeTroveParams = abi.decode(userData[32:], (IZapper.CloseTroveParams));
        uint256 effectiveFlashLoanAmount = amounts[0] - feeAmounts[0];
        tokens[0].safeTransfer(address(receiverCached), effectiveFlashLoanAmount);
        receiverCached.receiveFlashLoanOnCloseTroveFromCollateral(closeTroveParams, effectiveFlashLoanAmount);
    } else {
        revert("LZ: Wrong Operation");
    }
    tokens[0].safeTransfer(address(vault), amounts[0] + feeAmounts[0]);
}
```

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **IFlashLoanReceiver::receiveFlashLoanOnOpenLeveragedTrove(struct ILeverageZapper.OpenLeveragedTroveParams,uint256)**
- **IFlashLoanReceiver::receiveFlashLoanOnLeverUpTrove(struct ILeverageZapper.LeverUpTroveParams,uint256)**
- **IFlashLoanReceiver::receiveFlashLoanOnLeverDownTrove(struct ILeverageZapper.LeverDownTroveParams,uint256)**
- **IFlashLoanReceiver::receiveFlashLoanOnCloseTroveFromCollateral(struct IZapper.CloseTroveParams,uint256)**

## State Variable Reads

- **vault** (`contract IVault`) [src/Zappers/Modules/FlashLoans/Balancer/vault/IVault.sol/interface_IVault.md]
- **receiver** (`contract IFlashLoanReceiver`) [src/Zappers/Interfaces/IFlashLoanReceiver.sol/interface_IFlashLoanReceiver.md]

## State Variable Writes

- **receiver** (`contract IFlashLoanReceiver`) [src/Zappers/Interfaces/IFlashLoanReceiver.sol/interface_IFlashLoanReceiver.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BalancerFlashLoan.receiveFlashLoan(contract IERC20[],uint256[],uint256[],bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev When `flashLoan` is called on the Vault, it invokes the `receiveFlashLoan` hook on the recipient.
 At the time of the call, the Vault will have transferred `amounts` for `tokens` to the recipient. Before this
 call returns, the recipient must have transferred `amounts` plus `feeAmounts` for each token back to the
 Vault, or else the entire flash loan will revert.
 `userData` is the same value passed in the `IVault.flashLoan` call.
