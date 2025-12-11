# Function: isAgreementTypeListed(bytes32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `isAgreementTypeListed(bytes32)`
- **Visibility**: external
- **Source Range**: 7996:206:163

## Implementation

```solidity
function isAgreementTypeListed(bytes32 agreementType) override external view returns (bool yes) {
    uint idx = _agreementClassIndices[agreementType];
    return idx != 0;
}
```

## State Variable Reads

- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.isAgreementTypeListed(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @notice Check if the agreement type is whitelisted
 @dev agreementType is the keccak256 hash of: "org.superfluid-finance.agreements.<AGREEMENT_NAME>.<VERSION>"
