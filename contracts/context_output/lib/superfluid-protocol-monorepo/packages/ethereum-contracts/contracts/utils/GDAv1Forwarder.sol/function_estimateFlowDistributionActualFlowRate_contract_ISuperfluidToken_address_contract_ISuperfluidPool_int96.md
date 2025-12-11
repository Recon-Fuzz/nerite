# Function: estimateFlowDistributionActualFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool,int96)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

## Metadata

- **Contract**: GDAv1Forwarder
- **Signature**: `estimateFlowDistributionActualFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool,int96)`
- **Visibility**: external
- **Source Range**: 7742:350:176

## Implementation

```solidity
///  @dev Estimates the actual flow rate for flow distribution to the specified pool.
///  @param token The Super Token address.
///  @param from The sender address.
///  @param to The pool address.
///  @param requestedFlowRate The requested flow rate.
///  @return actualFlowRate
///  @return totalDistributionFlowRate
function estimateFlowDistributionActualFlowRate(ISuperfluidToken token, address from, ISuperfluidPool to, int96 requestedFlowRate) external view returns (int96 actualFlowRate, int96 totalDistributionFlowRate) {
    return _gda.estimateFlowDistributionActualFlowRate(token, from, to, requestedFlowRate);
}
```

## External Calls

- **IGeneralDistributionAgreementV1::estimateFlowDistributionActualFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool,int96)**

## State Variable Reads

- **_gda** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GDAv1Forwarder.estimateFlowDistributionActualFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool,int96) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @dev Estimates the actual flow rate for flow distribution to the specified pool.
 @param token The Super Token address.
 @param from The sender address.
 @param to The pool address.
 @param requestedFlowRate The requested flow rate.
 @return actualFlowRate
 @return totalDistributionFlowRate
