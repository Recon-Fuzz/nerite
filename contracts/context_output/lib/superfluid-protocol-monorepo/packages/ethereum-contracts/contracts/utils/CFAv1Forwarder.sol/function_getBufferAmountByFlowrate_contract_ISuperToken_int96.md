# Function: getBufferAmountByFlowrate(contract ISuperToken,int96)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]

## Metadata

- **Contract**: CFAv1Forwarder
- **Signature**: `getBufferAmountByFlowrate(contract ISuperToken,int96)`
- **Visibility**: external
- **Source Range**: 4946:202:173

## Implementation

```solidity
///  @notice Get the buffer amount required for the given token and flowrate.
///  This amount can vary based on the combination of token, flowrate and chain being queried.
///  The result for a given set of parameters can change over time,
///  because it depends on governance configurable protocol parameters.
///  Changes of the required buffer amount affect only flows created or updated after the change.
///  @param token Super token address
///  @param flowrate The flowrate for which the buffer amount is calculated
///  @return bufferAmount The buffer amount required for the given configuration.
function getBufferAmountByFlowrate(ISuperToken token, int96 flowrate) external view returns (uint256 bufferAmount) {
    return _cfa.getDepositRequiredForFlowRate(token, flowrate);
}
```

## External Calls

- **IConstantFlowAgreementV1::getDepositRequiredForFlowRate(contract ISuperfluidToken,int96)**

## State Variable Reads

- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CFAv1Forwarder.getBufferAmountByFlowrate(contract ISuperToken,int96) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @notice Get the buffer amount required for the given token and flowrate.
 This amount can vary based on the combination of token, flowrate and chain being queried.
 The result for a given set of parameters can change over time,
 because it depends on governance configurable protocol parameters.
 Changes of the required buffer amount affect only flows created or updated after the change.
 @param token Super token address
 @param flowrate The flowrate for which the buffer amount is calculated
 @return bufferAmount The buffer amount required for the given configuration.
