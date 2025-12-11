# Function: getFlowOperatorPermissions(contract ISuperToken,address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]

## Metadata

- **Contract**: CFAv1Forwarder
- **Signature**: `getFlowOperatorPermissions(contract ISuperToken,address,address)`
- **Visibility**: external
- **Source Range**: 12149:279:173

## Implementation

```solidity
///  @notice Get the currently set permissions granted to the given flowOperator by the given sender account.
///  @param token Super token address
///  @param sender The account which (possiby) granted permissions
///  @param flowOperator Account to which (possibly) permissions were granted
///  @return permissions A bitmask of the permissions currently granted (or not) by `sender` to `flowOperator`
///  @return flowrateAllowance Max. flowrate in wad/second the flowOperator can set for individual flows.
function getFlowOperatorPermissions(ISuperToken token, address sender, address flowOperator) external view returns (uint8 permissions, int96 flowrateAllowance) {
    (, permissions, flowrateAllowance) = _cfa.getFlowOperatorData(token, sender, flowOperator);
}
```

## External Calls

- **IConstantFlowAgreementV1::getFlowOperatorData(contract ISuperfluidToken,address,address)**

## State Variable Reads

- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CFAv1Forwarder.getFlowOperatorPermissions(contract ISuperToken,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @notice Get the currently set permissions granted to the given flowOperator by the given sender account.
 @param token Super token address
 @param sender The account which (possiby) granted permissions
 @param flowOperator Account to which (possibly) permissions were granted
 @return permissions A bitmask of the permissions currently granted (or not) by `sender` to `flowOperator`
 @return flowrateAllowance Max. flowrate in wad/second the flowOperator can set for individual flows.
