# Contract: UUPSUtils

## Metadata

- **Name**: UUPSUtils
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/UUPSUtils.sol
- **Documentation**:  @title UUPS (Universal Upgradeable Proxy Standard) Shared Library

## State Variables

### _IMPLEMENTATION_SLOT

```solidity
///  @dev Implementation slot constant.
///  Using https://eips.ethereum.org/EIPS/eip-1967 standard
///  Storage slot 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
///  (obtained as bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1)).
bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
```
