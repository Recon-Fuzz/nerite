# Function: getAccountFlowrate(contract ISuperToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]

## Metadata

- **Contract**: CFAv1Forwarder
- **Signature**: `getAccountFlowrate(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 5414:170:173

## Implementation

```solidity
///  @notice Get the net flowrate of an account.
///  @param token Super token address
///  @param account Account to query
///  @return flowrate The net flowrate (aggregate incoming minus aggregate outgoing flowrate), can be negative.
function getAccountFlowrate(ISuperToken token, address account) external view returns (int96 flowrate) {
    return _cfa.getNetFlow(token, account);
}
```

## External Calls

- **IConstantFlowAgreementV1::getNetFlow(contract ISuperfluidToken,address)**

## State Variable Reads

- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CFAv1Forwarder.getAccountFlowrate(contract ISuperToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @notice Get the net flowrate of an account.
 @param token Super token address
 @param account Account to query
 @return flowrate The net flowrate (aggregate incoming minus aggregate outgoing flowrate), can be negative.
