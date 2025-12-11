# Function: proxiableUUID()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 555:145:119
- **Inherited From**: AgreementBase

## Implementation

```solidity
function proxiableUUID() override public view returns (bytes32) {
    return ISuperAgreement(this).agreementType();
}
```

## External Calls

- **ISuperAgreement::agreementType()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AgreementBase.proxiableUUID() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
