# Function: getAgreementClass(bytes32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `getAgreementClass(bytes32)`
- **Visibility**: external
- **Source Range**: 8608:347:163

## Implementation

```solidity
function getAgreementClass(bytes32 agreementType) override external view returns (ISuperAgreement agreementClass) {
    uint idx = _agreementClassIndices[agreementType];
    if (idx == 0) {
        revert HOST_AGREEMENT_IS_NOT_REGISTERED();
    }
    return ISuperAgreement(_agreementClasses[idx - 1]);
}
```

## State Variable Reads

- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)
- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.getAgreementClass(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @notice Get agreement class
 @dev agreementType is the keccak256 hash of: "org.superfluid-finance.agreements.<AGREEMENT_NAME>.<VERSION>"
