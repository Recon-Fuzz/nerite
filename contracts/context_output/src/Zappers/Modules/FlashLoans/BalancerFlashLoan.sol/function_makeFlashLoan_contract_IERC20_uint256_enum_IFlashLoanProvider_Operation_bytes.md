# Function: makeFlashLoan(contract IERC20,uint256,enum IFlashLoanProvider.Operation,bytes)

**Contract**: [src/Zappers/Modules/FlashLoans/BalancerFlashLoan.sol/contract_BalancerFlashLoan.md]

## Metadata

- **Contract**: BalancerFlashLoan
- **Signature**: `makeFlashLoan(contract IERC20,uint256,enum IFlashLoanProvider.Operation,bytes)`
- **Visibility**: external
- **Source Range**: 609:1663:159

## Implementation

```solidity
function makeFlashLoan(IERC20 _token, uint256 _amount, Operation _operation, bytes calldata _params) external {
    IERC20[] memory tokens = new IERC20[](1);
    tokens[0] = _token;
    uint256[] memory amounts = new uint256[](1);
    amounts[0] = _amount;
    bytes memory userData;
    if (_operation == Operation.OpenTrove) {
        ILeverageZapper.OpenLeveragedTroveParams memory openTroveParams = abi.decode(_params, (ILeverageZapper.OpenLeveragedTroveParams));
        userData = abi.encode(_operation, openTroveParams);
    } else if (_operation == Operation.LeverUpTrove) {
        ILeverageZapper.LeverUpTroveParams memory leverUpTroveParams = abi.decode(_params, (ILeverageZapper.LeverUpTroveParams));
        userData = abi.encode(_operation, leverUpTroveParams);
    } else if (_operation == Operation.LeverDownTrove) {
        ILeverageZapper.LeverDownTroveParams memory leverDownTroveParams = abi.decode(_params, (ILeverageZapper.LeverDownTroveParams));
        userData = abi.encode(_operation, leverDownTroveParams);
    } else if (_operation == Operation.CloseTrove) {
        IZapper.CloseTroveParams memory closeTroveParams = abi.decode(_params, (IZapper.CloseTroveParams));
        userData = abi.encode(_operation, closeTroveParams);
    } else {
        revert("LZ: Wrong Operation");
    }
    receiver = IFlashLoanReceiver(msg.sender);
    vault.flashLoan(this, tokens, amounts, userData);
}
```

## External Calls

- **IVault::flashLoan(contract IFlashLoanRecipient,contract IERC20[],uint256[],bytes)**

## State Variable Reads

- **vault** (`contract IVault`) [src/Zappers/Modules/FlashLoans/Balancer/vault/IVault.sol/interface_IVault.md]

## State Variable Writes

- **receiver** (`contract IFlashLoanReceiver`) [src/Zappers/Interfaces/IFlashLoanReceiver.sol/interface_IFlashLoanReceiver.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BalancerFlashLoan.makeFlashLoan(contract IERC20,uint256,enum IFlashLoanProvider.Operation,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
