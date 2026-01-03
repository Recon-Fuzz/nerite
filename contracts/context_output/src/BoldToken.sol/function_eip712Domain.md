# Function: eip712Domain()

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `eip712Domain()`
- **Visibility**: external
- **Source Range**: 7588:553:53

## Implementation

```solidity
function eip712Domain() override external view returns (bytes1 fields, string memory name712, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions) {
    return (hex"0f", ISuperToken(address(this)).name(), "1", block.chainid, address(this), bytes32(0), new uint256[](0));
}
```

## External Calls

- **ISuperToken::name()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldToken.eip712Domain() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev returns the fields and values that describe the domain separator used by this contract for EIP-712
 signature.
