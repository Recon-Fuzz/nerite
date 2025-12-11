# Function: addPermissions(uint8,uint8)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `addPermissions(uint8,uint8)`
- **Visibility**: public
- **Source Range**: 30960:191:121

## Implementation

```solidity
function addPermissions(uint8 existingPermissions, uint8 permissionDelta) public pure returns (uint8) {
    return existingPermissions | permissionDelta;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.addPermissions(uint8,uint8) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
