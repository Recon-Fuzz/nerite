# Function: permit(address,address,uint256,uint256,uint8,bytes32,bytes32)

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 8263:1122:204

## Implementation

```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) override external {
    if (deadline < block.timestamp) revert("PERMIT_DEADLINE_EXPIRED");
    bytes32 structHash = keccak256(abi.encode(keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"), owner, spender, value, _nonces[owner]++, deadline));
    bytes32 digest = keccak256(abi.encodePacked("\u0019\u0001", DOMAIN_SEPARATOR(), structHash));
    address signer = ecrecover(digest, v, r, s);
    if (signer == address(0)) revert("INVALID_SIGNATURE");
    if (signer != owner) revert("INVALID_SIGNER");
    ISuperToken(address(this)).selfApproveFor(owner, spender, value);
}
```

## Related Implementations

### DOMAIN_SEPARATOR()

- **Kind**: internal
- **Source**: 7060:422:204
- **Link**: `src/BoldToken.sol:BoldToken:DOMAIN_SEPARATOR()`

```solidity
/// @dev Returns the EIP-712 domain separator for the EIP-2612 permit.
function DOMAIN_SEPARATOR() public view returns (bytes32) {
    return keccak256(abi.encode(keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"), keccak256(bytes(ISuperToken(address(this)).name())), keccak256(bytes("1")), block.chainid, address(this)));
}
```

## External Calls

- **ISuperToken::selfApproveFor(address,address,uint256)**
- **ISuperToken::name()**

## State Variable Writes

- **_nonces** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldToken.permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BoldToken.DOMAIN_SEPARATOR() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
 given ``owner``'s signed approval.
 IMPORTANT: The same issues {IERC20-approve} has related to transaction
 ordering also apply here.
 Emits an {Approval} event.
 Requirements:
 - `spender` cannot be the zero address.
 - `deadline` must be a timestamp in the future.
 - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
 over the EIP712-formatted function arguments.
 - the signature must use ``owner``'s current nonce (see {nonces}).
 For more information on the signature format, see the
 https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
 section].
 CAUTION: See Security Considerations above.
