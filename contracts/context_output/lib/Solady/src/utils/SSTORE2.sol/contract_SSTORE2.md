# Contract: SSTORE2

## Metadata

- **Name**: SSTORE2
- **Type**: Contract
- **Path**: lib/Solady/src/utils/SSTORE2.sol
- **Documentation**: @notice Read and write to persistent storage at a fraction of the cost.
   @author Solady (https://github.com/vectorized/solady/blob/main/src/utils/SSTORE2.sol)
   @author Saw-mon-and-Natalie (https://github.com/Saw-mon-and-Natalie)
   @author Modified from Solmate (https://github.com/transmissions11/solmate/blob/main/src/utils/SSTORE2.sol)
   @author Modified from 0xSequence (https://github.com/0xSequence/sstore2/blob/master/contracts/SSTORE2.sol)
   @author Modified from SSTORE3 (https://github.com/Philogy/sstore3)

## State Variables

### _CREATE3_PROXY_INITCODE

```solidity
/// @dev The proxy initialization code.
uint256 private constant _CREATE3_PROXY_INITCODE = 0x67363d3d37363d34f03d5260086018f3
```

### CREATE3_PROXY_INITCODE_HASH

```solidity
/// @dev Hash of the `_CREATE3_PROXY_INITCODE`.
///  Equivalent to `keccak256(abi.encodePacked(hex"67363d3d37363d34f03d5260086018f3"))`.
bytes32 internal constant CREATE3_PROXY_INITCODE_HASH = 0x21c35dbe1b344a2488cf3321d6ce542f8e9f305544ff09e4993a62319a497c1f
```

## Errors

### DeploymentFailed

```solidity
/// @dev Unable to deploy the storage contract.
error DeploymentFailed();
```
