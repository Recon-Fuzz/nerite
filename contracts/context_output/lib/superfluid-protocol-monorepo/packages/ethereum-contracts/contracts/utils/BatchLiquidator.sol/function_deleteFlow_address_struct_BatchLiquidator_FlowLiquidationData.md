# Function: deleteFlow(address,struct BatchLiquidator.FlowLiquidationData)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/BatchLiquidator.sol/contract_BatchLiquidator.md]

## Metadata

- **Contract**: BatchLiquidator
- **Signature**: `deleteFlow(address,struct BatchLiquidator.FlowLiquidationData)`
- **Visibility**: external
- **Source Range**: 2622:925:172

## Implementation

```solidity
///  @dev Delete a single flow
///  @param superToken - The super token the flow belongs to.
///  @param data - The flow data to be deleted.
function deleteFlow(address superToken, FlowLiquidationData memory data) external {
    (bool success, bytes memory returndata) = _deleteFlow(superToken, data);
    if (!success) {
        if (returndata.length == 0) revert();
        assembly {
            revert(add(32, returndata), mload(returndata))
        }
    }
    {
        uint256 balance = ERC20(superToken).balanceOf(address(this));
        if (balance > 0) {
            try ERC20(superToken).transferFrom(address(this), msg.sender, balance) {} catch {}
        }
    }
}
```

## Related Implementations

### _deleteFlow(address,struct BatchLiquidator.FlowLiquidationData)

- **Kind**: internal
- **Source**: 3553:1491:172
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/BatchLiquidator.sol:BatchLiquidator:_deleteFlow(address,struct BatchLiquidator.FlowLiquidationData)`

```solidity
function _deleteFlow(address superToken, FlowLiquidationData memory data) internal returns (bool success, bytes memory returndata) {
    if (data.agreementOperation == FlowType.ConstantFlowAgreement) {
        (success, returndata) = address(host).call(abi.encodeCall(ISuperfluid(host).callAgreement, (ISuperAgreement(cfa), abi.encodeCall(IConstantFlowAgreementV1(cfa).deleteFlow, (ISuperToken(superToken), data.sender, data.receiver, new bytes(0))), new bytes(0))));
    } else {
        (success, returndata) = address(host).call(abi.encodeCall(ISuperfluid(host).callAgreement, (ISuperAgreement(gda), abi.encodeCall(IGeneralDistributionAgreementV1(gda).distributeFlow, (ISuperToken(superToken), data.sender, ISuperfluidPool(data.receiver), 0, new bytes(0))), new bytes(0))));
    }
}
```

## External Calls

- **ERC20::balanceOf(address)**
- **ERC20::transferFrom(address,address,uint256)**
- **address::call(bytes memory)**

## State Variable Reads

- **host** (`address`)
- **cfa** (`address`)
- **gda** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BatchLiquidator.deleteFlow(address,struct BatchLiquidator.FlowLiquidationData) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BatchLiquidator._deleteFlow(address,struct BatchLiquidator.FlowLiquidationData) (NodeID: 1)
      💬 Args: [superToken, data]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev Delete a single flow
 @param superToken - The super token the flow belongs to.
 @param data - The flow data to be deleted.
