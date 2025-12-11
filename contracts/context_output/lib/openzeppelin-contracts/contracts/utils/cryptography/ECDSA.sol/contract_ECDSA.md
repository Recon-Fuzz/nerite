# Contract: ECDSA

## Metadata

- **Name**: ECDSA
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol
- **Documentation**:  @dev Elliptic Curve Digital Signature Algorithm (ECDSA) operations.
   These functions can be used to verify that a message was signed by the holder
   of the private keys of a given address.

## Enums

### RecoverError

```solidity
enum RecoverError {
    NoError,
    InvalidSignature,
    InvalidSignatureLength,
    InvalidSignatureS,
    InvalidSignatureV
}
```
