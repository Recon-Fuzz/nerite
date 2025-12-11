# Function: addToAgreementClassesBitmap(uint256,bytes32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `addToAgreementClassesBitmap(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 9584:343:163

## Implementation

```solidity
function addToAgreementClassesBitmap(uint256 bitmap, bytes32 agreementType) override external view returns (uint256 newBitmap) {
    uint idx = _agreementClassIndices[agreementType];
    if (idx == 0) {
        revert HOST_AGREEMENT_IS_NOT_REGISTERED();
    }
    return bitmap | (1 << (idx - 1));
}
```

## State Variable Reads

- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.addToAgreementClassesBitmap(uint256,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @notice Create a new bitmask by adding a agreement class to it
 @dev agreementType is the keccak256 hash of: "org.superfluid-finance.agreements.<AGREEMENT_NAME>.<VERSION>"
 @param bitmap Agreement class bitmap
