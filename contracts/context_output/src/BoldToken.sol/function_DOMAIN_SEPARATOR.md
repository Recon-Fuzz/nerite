# Function: DOMAIN_SEPARATOR()

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: public
- **Source Range**: 7060:422:53

## Implementation

```solidity
/// @dev Returns the EIP-712 domain separator for the EIP-2612 permit.
function DOMAIN_SEPARATOR() public view returns (bytes32) {
    return keccak256(abi.encode(keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"), keccak256(bytes(ISuperToken(address(this)).name())), keccak256(bytes("1")), block.chainid, address(this)));
}
```

## External Calls

- **ISuperToken::name()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldToken.DOMAIN_SEPARATOR() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev Returns the EIP-712 domain separator for the EIP-2612 permit.

### Interface Documentation

 @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
