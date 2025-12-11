# Function: getFlowrate(contract ISuperToken,address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]

## Metadata

- **Contract**: CFAv1Forwarder
- **Signature**: `getFlowrate(contract ISuperToken,address,address)`
- **Visibility**: external
- **Source Range**: 3147:197:173

## Implementation

```solidity
///  @notice Get the flowrate of the flow between 2 accounts if exists.
///  @dev Currently, only 0 or 1 flows can exist between 2 accounts. This may change in the future.
///  @param token Super token address
///  @param sender The sender of the flow
///  @param receiver The receiver of the flow
///  @return flowrate The flowrate from the sender to the receiver account. Returns 0 if no flow exists.
function getFlowrate(ISuperToken token, address sender, address receiver) external view returns (int96 flowrate) {
    (, flowrate, , ) = _cfa.getFlow(token, sender, receiver);
}
```

## External Calls

- **IConstantFlowAgreementV1::getFlow(contract ISuperfluidToken,address,address)**

## State Variable Reads

- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CFAv1Forwarder.getFlowrate(contract ISuperToken,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @notice Get the flowrate of the flow between 2 accounts if exists.
 @dev Currently, only 0 or 1 flows can exist between 2 accounts. This may change in the future.
 @param token Super token address
 @param sender The sender of the flow
 @param receiver The receiver of the flow
 @return flowrate The flowrate from the sender to the receiver account. Returns 0 if no flow exists.
