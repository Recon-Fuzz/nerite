# Function: removePermissions(uint8,uint8)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `removePermissions(uint8,uint8)`
- **Visibility**: public
- **Source Range**: 31157:197:121

## Implementation

```solidity
function removePermissions(uint8 existingPermissions, uint8 permissionDelta) public pure returns (uint8) {
    return existingPermissions & (~permissionDelta);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.removePermissions(uint8,uint8) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
