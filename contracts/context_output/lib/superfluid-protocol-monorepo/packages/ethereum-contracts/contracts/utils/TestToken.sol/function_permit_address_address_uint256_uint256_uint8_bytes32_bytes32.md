# Function: permit(address,address,uint256,uint256,uint8,bytes32,bytes32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestToken.sol/contract_TestToken.md]

## Metadata

- **Contract**: TestToken
- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: public
- **Source Range**: 1923:626:90
- **Inherited From**: ERC20Permit

## Implementation

```solidity
///  @inheritdoc IERC20Permit
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) virtual override public {
    require(block.timestamp <= deadline, "ERC20Permit: expired deadline");
    bytes32 structHash = keccak256(abi.encode(_PERMIT_TYPEHASH, owner, spender, value, _useNonce(owner), deadline));
    bytes32 hash = _hashTypedDataV4(structHash);
    address signer = ECDSA.recover(hash, v, r, s);
    require(signer == owner, "ERC20Permit: invalid signature");
    _approve(owner, spender, value);
}
```

## Related Implementations

### _useNonce(address)

- **Kind**: internal
- **Source**: 3080:203:90
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol:ERC20Permit:_useNonce(address)`

```solidity
///  @dev "Consume a nonce": return the current value and increment.
///  _Available since v4.1._
function _useNonce(address owner) virtual internal returns (uint256 current) {
    Counters.Counter storage nonce = _nonces[owner];
    current = nonce.current();
    nonce.increment();
}
```

### current(struct Counters.Counter)

- **Kind**: internal
- **Source**: 827:112:105
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Counters.sol:Counters:current(struct Counters.Counter)`

```solidity
function current(Counter storage counter) internal view returns (uint256) {
    return counter._value;
}
```

### increment(struct Counters.Counter)

- **Kind**: internal
- **Source**: 945:123:105
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Counters.sol:Counters:increment(struct Counters.Counter)`

```solidity
function increment(Counter storage counter) internal {
    unchecked {
        counter._value += 1;
    }
}
```

### _hashTypedDataV4(bytes32)

- **Kind**: internal
- **Source**: 4768:165:110
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_hashTypedDataV4(bytes32)`

```solidity
///  @dev Given an already https://eips.ethereum.org/EIPS/eip-712#definition-of-hashstruct[hashed struct], this
///  function returns the hash of the fully encoded EIP712 message for this domain.
///  This hash can be used together with {ECDSA-recover} to obtain the signer of a message. For example:
///  ```solidity
///  bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(
///      keccak256("Mail(address to,string contents)"),
///      mailTo,
///      keccak256(bytes(mailContents))
///  )));
///  address signer = ECDSA.recover(digest, signature);
///  ```
function _hashTypedDataV4(bytes32 structHash) virtual internal view returns (bytes32) {
    return ECDSA.toTypedDataHash(_domainSeparatorV4(), structHash);
}
```

### toTypedDataHash(bytes32,bytes32)

- **Kind**: internal
- **Source**: 8336:397:109
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:toTypedDataHash(bytes32,bytes32)`

```solidity
///  @dev Returns an Ethereum Signed Typed Data, created from a
///  `domainSeparator` and a `structHash`. This produces hash corresponding
///  to the one signed with the
///  https://eips.ethereum.org/EIPS/eip-712[`eth_signTypedData`]
///  JSON-RPC method as part of EIP-712.
///  See {recover}.
function toTypedDataHash(bytes32 domainSeparator, bytes32 structHash) internal pure returns (bytes32 data) {
    /// @solidity memory-safe-assembly
    assembly {
        let ptr := mload(0x40)
        mstore(ptr, "\u0019\u0001")
        mstore(add(ptr, 0x02), domainSeparator)
        mstore(add(ptr, 0x22), structHash)
        data := keccak256(ptr, 0x42)
    }
}
```

### _domainSeparatorV4()

- **Kind**: internal
- **Source**: 3695:262:110
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_domainSeparatorV4()`

```solidity
///  @dev Returns the domain separator for the current chain.
function _domainSeparatorV4() internal view returns (bytes32) {
    if ((address(this) == _cachedThis) && (block.chainid == _cachedChainId)) {
        return _cachedDomainSeparator;
    } else {
        return _buildDomainSeparator();
    }
}
```

### _buildDomainSeparator()

- **Kind**: internal
- **Source**: 3963:180:110
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_buildDomainSeparator()`

```solidity
function _buildDomainSeparator() private view returns (bytes32) {
    return keccak256(abi.encode(_TYPE_HASH, _hashedName, _hashedVersion, block.chainid, address(this)));
}
```

### recover(bytes32,uint8,bytes32,bytes32)

- **Kind**: internal
- **Source**: 6598:232:109
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:recover(bytes32,uint8,bytes32,bytes32)`

```solidity
///  @dev Overload of {ECDSA-recover} that receives the `v`,
///  `r` and `s` signature fields separately.
function recover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) internal pure returns (address) {
    (address recovered, RecoverError error) = tryRecover(hash, v, r, s);
    _throwError(error);
    return recovered;
}
```

### tryRecover(bytes32,uint8,bytes32,bytes32)

- **Kind**: internal
- **Source**: 5009:1456:109
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:tryRecover(bytes32,uint8,bytes32,bytes32)`

```solidity
///  @dev Overload of {ECDSA-tryRecover} that receives the `v`,
///  `r` and `s` signature fields separately.
///  _Available since v4.3._
function tryRecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) internal pure returns (address, RecoverError) {
    if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
        return (address(0), RecoverError.InvalidSignatureS);
    }
    address signer = ecrecover(hash, v, r, s);
    if (signer == address(0)) {
        return (address(0), RecoverError.InvalidSignature);
    }
    return (signer, RecoverError.NoError);
}
```

### _throwError(enum ECDSA.RecoverError)

- **Kind**: internal
- **Source**: 570:511:109
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:_throwError(enum ECDSA.RecoverError)`

```solidity
function _throwError(RecoverError error) private pure {
    if (error == RecoverError.NoError) {
        return;
    } else if (error == RecoverError.InvalidSignature) {
        revert("ECDSA: invalid signature");
    } else if (error == RecoverError.InvalidSignatureLength) {
        revert("ECDSA: invalid signature length");
    } else if (error == RecoverError.InvalidSignatureS) {
        revert("ECDSA: invalid signature 's' value");
    }
}
```

### _approve(address,address,uint256)

- **Kind**: internal
- **Source**: 10457:340:86
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_approve(address,address,uint256)`

```solidity
///  @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
///  This internal function is equivalent to `approve`, and can be used to
///  e.g. set automatic allowances for certain subsystems, etc.
///  Emits an {Approval} event.
///  Requirements:
///  - `owner` cannot be the zero address.
///  - `spender` cannot be the zero address.
function _approve(address owner, address spender, uint256 amount) virtual internal {
    require(owner != address(0), "ERC20: approve from the zero address");
    require(spender != address(0), "ERC20: approve to the zero address");
    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
}
```

## State Variable Reads

- **_PERMIT_TYPEHASH** (`bytes32`)
- **_nonces** (`mapping(address => struct Counters.Counter)`)
- **_cachedThis** (`address`)
- **_cachedChainId** (`uint256`)
- **_cachedDomainSeparator** (`bytes32`)
- **_TYPE_HASH** (`bytes32`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Permit.permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC20Permit._useNonce(address) (NodeID: 1)
  │   💬 Args: [owner]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Counters.current(struct Counters.Counter) (NodeID: 2)
  │ │   💬 Args: [nonce]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Counters.increment(struct Counters.Counter) (NodeID: 3)
  │     💬 Args: [nonce]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EIP712._hashTypedDataV4(bytes32) (NodeID: 4)
  │   💬 Args: [structHash]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSA.toTypedDataHash(bytes32,bytes32) (NodeID: 5)
  │     💬 Args: [_domainSeparatorV4(), structHash]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EIP712._domainSeparatorV4() (NodeID: 6)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EIP712._buildDomainSeparator() (NodeID: 7)
  │         💬 Args: [no args]
  │         👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: ECDSA.recover(bytes32,uint8,bytes32,bytes32) (NodeID: 8)
  │   💬 Args: [hash, v, r, s]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,uint8,bytes32,bytes32) (NodeID: 9)
  │ │   💬 Args: [hash, v, r, s]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSA._throwError(enum ECDSA.RecoverError) (NodeID: 10)
  │     💬 Args: [error]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: ERC20._approve(address,address,uint256) (NodeID: 11)
      💬 Args: [owner, spender, value]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 @inheritdoc IERC20Permit

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
