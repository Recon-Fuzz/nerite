# Function: getFlowDistributionFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

## Metadata

- **Contract**: GDAv1Forwarder
- **Signature**: `getFlowDistributionFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool)`
- **Visibility**: external
- **Source Range**: 6852:210:176

## Implementation

```solidity
///  @dev Gets the flow rate of tokens between the specified accounts.
///  @param token The Super Token address.
///  @param from The sender address.
///  @param to The receiver address (the pool address).
///  @return The flow distribution flow rate
function getFlowDistributionFlowRate(ISuperfluidToken token, address from, ISuperfluidPool to) external view returns (int96) {
    return _gda.getFlowRate(token, from, to);
}
```

## External Calls

- **IGeneralDistributionAgreementV1::getFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool)**

## State Variable Reads

- **_gda** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GDAv1Forwarder.getFlowDistributionFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @dev Gets the flow rate of tokens between the specified accounts.
 @param token The Super Token address.
 @param from The sender address.
 @param to The receiver address (the pool address).
 @return The flow distribution flow rate
