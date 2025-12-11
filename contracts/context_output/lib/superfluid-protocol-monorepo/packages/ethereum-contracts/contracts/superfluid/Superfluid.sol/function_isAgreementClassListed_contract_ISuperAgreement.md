# Function: isAgreementClassListed(contract ISuperAgreement)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `isAgreementClassListed(contract ISuperAgreement)`
- **Visibility**: public
- **Source Range**: 8208:394:163

## Implementation

```solidity
function isAgreementClassListed(ISuperAgreement agreementClass) override public view returns (bool yes) {
    bytes32 agreementType = agreementClass.agreementType();
    uint idx = _agreementClassIndices[agreementType];
    return (idx != 0) && (_agreementClasses[idx - 1] == agreementClass);
}
```

## External Calls

- **ISuperAgreement::agreementType()**

## State Variable Reads

- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)
- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.isAgreementClassListed(contract ISuperAgreement) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Check if the agreement class is whitelisted
