# Function: eip712Domain()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestToken.sol/contract_TestToken.md]

## Metadata

- **Contract**: TestToken
- **Signature**: `eip712Domain()`
- **Visibility**: public
- **Source Range**: 5021:633:110
- **Inherited From**: EIP712

## Implementation

```solidity
///  @dev See {EIP-5267}.
///  _Available since v4.9._
function eip712Domain() virtual override public view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions) {
    return (hex"0f", _name.toStringWithFallback(_nameFallback), _version.toStringWithFallback(_versionFallback), block.chainid, address(this), bytes32(0), new uint256[](0));
}
```

## Related Implementations

### toStringWithFallback(ShortString,string)

- **Kind**: internal
- **Source**: 3367:268:106
- **Link**: `lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toStringWithFallback(ShortString,string)`

```solidity
///  @dev Decode a string that was encoded to `ShortString` or written to storage using {setWithFallback}.
function toStringWithFallback(ShortString value, string storage store) internal pure returns (string memory) {
    if (ShortString.unwrap(value) != _FALLBACK_SENTINEL) {
        return toString(value);
    } else {
        return store;
    }
}
```

### toString(ShortString)

- **Kind**: internal
- **Source**: 2059:405:106
- **Link**: `lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toString(ShortString)`

```solidity
///  @dev Decode a `ShortString` back to a "normal" string.
function toString(ShortString sstr) internal pure returns (string memory) {
    uint256 len = byteLength(sstr);
    string memory str = new string(32);
    /// @solidity memory-safe-assembly
    assembly {
        mstore(str, len)
        mstore(add(str, 0x20), sstr)
    }
    return str;
}
```

### byteLength(ShortString)

- **Kind**: internal
- **Source**: 2536:245:106
- **Link**: `lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:byteLength(ShortString)`

```solidity
///  @dev Return the length of a `ShortString`.
function byteLength(ShortString sstr) internal pure returns (uint256) {
    uint256 result = uint256(ShortString.unwrap(sstr)) & 0xFF;
    if (result > 31) {
        revert InvalidShortString();
    }
    return result;
}
```

## State Variable Reads

- **_name** (`ShortString`)
- **_nameFallback** (`string`)
- **_version** (`ShortString`)
- **_versionFallback** (`string`)
- **_FALLBACK_SENTINEL** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: EIP712.eip712Domain() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ShortStrings.toStringWithFallback(ShortString,string) (NodeID: 1)
  │   💬 Args: [_name, _nameFallback]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ShortStrings.toString(ShortString) (NodeID: 2)
  │     💬 Args: [value]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: ShortStrings.byteLength(ShortString) (NodeID: 3)
  │       💬 Args: [sstr]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ShortStrings.toStringWithFallback(ShortString,string) (NodeID: 4)
      💬 Args: [_version, _versionFallback]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ShortStrings.toString(ShortString) (NodeID: 5)
        💬 Args: [value]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ShortStrings.byteLength(ShortString) (NodeID: 6)
          💬 Args: [sstr]
          👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev See {EIP-5267}.
 _Available since v4.9._

### Interface Documentation

 @dev returns the fields and values that describe the domain separator used by this contract for EIP-712
 signature.
