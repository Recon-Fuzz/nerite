# Function: mapAgreementClasses(uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `mapAgreementClasses(uint256)`
- **Visibility**: external
- **Source Range**: 8961:617:163

## Implementation

```solidity
function mapAgreementClasses(uint256 bitmap) override external view returns (ISuperAgreement[] memory agreementClasses) {
    uint i;
    uint n;
    agreementClasses = new ISuperAgreement[](_agreementClasses.length);
    n = 0;
    for (i = 0; i < _agreementClasses.length; ++i) {
        if ((bitmap & (1 << i)) > 0) {
            agreementClasses[n++] = _agreementClasses[i];
        }
    }
    assembly {
        mstore(agreementClasses, n)
    }
}
```

## State Variable Reads

- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.mapAgreementClasses(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Map list of the agreement classes using a bitmap
 @param bitmap Agreement class bitmap
