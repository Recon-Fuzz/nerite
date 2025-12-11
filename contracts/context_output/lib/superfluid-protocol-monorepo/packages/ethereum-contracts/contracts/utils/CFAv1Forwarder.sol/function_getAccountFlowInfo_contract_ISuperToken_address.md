# Function: getAccountFlowInfo(contract ISuperToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]

## Metadata

- **Contract**: CFAv1Forwarder
- **Signature**: `getAccountFlowInfo(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 6229:237:173

## Implementation

```solidity
///  @notice Get aggregated flow information (if any exist) of an account.
///  If only the net flowrate is needed, consider using `getAccountFlowrate` instead.
///  @param token Super token address
///  @param account Account to query
///  @return lastUpdated Timestamp of last update of a flow to or from the account (flowrate change)
///  @return flowrate Current net aggregate flowrate
///  @return deposit Aggregate deposit amount currently locked as security buffer for outgoing flows
///  @return owedDeposit Aggregate extra deposit amount currently borrowed to SuperApps receiving from this account
function getAccountFlowInfo(ISuperToken token, address account) external view returns (uint256 lastUpdated, int96 flowrate, uint256 deposit, uint256 owedDeposit) {
    return _cfa.getAccountFlowInfo(token, account);
}
```

## External Calls

- **IConstantFlowAgreementV1::getAccountFlowInfo(contract ISuperfluidToken,address)**

## State Variable Reads

- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CFAv1Forwarder.getAccountFlowInfo(contract ISuperToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @notice Get aggregated flow information (if any exist) of an account.
 If only the net flowrate is needed, consider using `getAccountFlowrate` instead.
 @param token Super token address
 @param account Account to query
 @return lastUpdated Timestamp of last update of a flow to or from the account (flowrate change)
 @return flowrate Current net aggregate flowrate
 @return deposit Aggregate deposit amount currently locked as security buffer for outgoing flows
 @return owedDeposit Aggregate extra deposit amount currently borrowed to SuperApps receiving from this account
