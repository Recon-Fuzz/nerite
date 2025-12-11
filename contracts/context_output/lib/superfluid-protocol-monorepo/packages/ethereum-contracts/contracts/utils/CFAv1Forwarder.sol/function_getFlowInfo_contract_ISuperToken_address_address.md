# Function: getFlowInfo(contract ISuperToken,address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]

## Metadata

- **Contract**: CFAv1Forwarder
- **Signature**: `getFlowInfo(contract ISuperToken,address,address)`
- **Visibility**: external
- **Source Range**: 4016:285:173

## Implementation

```solidity
///  @notice Get all available information about a flow (if exists).
///  If only the flowrate is needed, consider using `getFlowrate` instead.
///  @param token Super token address
///  @param sender The sender of the flow
///  @param receiver The receiver of the flow
///  @return lastUpdated Timestamp of last update (flowrate change) or zero if no flow exists
///  @return flowrate Current flowrate of the flow or zero if no flow exists
///  @return deposit Deposit amount locked as security buffer during the lifetime of the flow
///  @return owedDeposit Extra deposit amount borrowed to a SuperApp receiver by the flow sender
function getFlowInfo(ISuperToken token, address sender, address receiver) external view returns (uint256 lastUpdated, int96 flowrate, uint256 deposit, uint256 owedDeposit) {
    (lastUpdated, flowrate, deposit, owedDeposit) = _cfa.getFlow(token, sender, receiver);
}
```

## External Calls

- **IConstantFlowAgreementV1::getFlow(contract ISuperfluidToken,address,address)**

## State Variable Reads

- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CFAv1Forwarder.getFlowInfo(contract ISuperToken,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @notice Get all available information about a flow (if exists).
 If only the flowrate is needed, consider using `getFlowrate` instead.
 @param token Super token address
 @param sender The sender of the flow
 @param receiver The receiver of the flow
 @return lastUpdated Timestamp of last update (flowrate change) or zero if no flow exists
 @return flowrate Current flowrate of the flow or zero if no flow exists
 @return deposit Deposit amount locked as security buffer during the lifetime of the flow
 @return owedDeposit Extra deposit amount borrowed to a SuperApp receiver by the flow sender
