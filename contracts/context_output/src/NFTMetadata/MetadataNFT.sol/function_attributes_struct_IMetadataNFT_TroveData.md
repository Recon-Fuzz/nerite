# Function: attributes(struct IMetadataNFT.TroveData)

**Contract**: [src/NFTMetadata/MetadataNFT.sol/contract_MetadataNFT.md]

## Metadata

- **Contract**: MetadataNFT
- **Signature**: `attributes(struct IMetadataNFT.TroveData)`
- **Visibility**: public
- **Source Range**: 1682:966:253

## Implementation

```solidity
function attributes(TroveData memory _troveData) public pure returns (string memory) {
    return string.concat("[{\"trait_type\": \"Collateral Token\", \"value\": \"", LibString.toHexString(_troveData._collToken), "\"}, {\"trait_type\": \"Collateral Amount\", \"value\": \"", LibString.toString(_troveData._collAmount), "\"}, {\"trait_type\": \"Debt Token\", \"value\": \"", LibString.toHexString(_troveData._boldToken), "\"}, {\"trait_type\": \"Debt Amount\", \"value\": \"", LibString.toString(_troveData._debtAmount), "\"}, {\"trait_type\": \"Interest Rate\", \"value\": \"", LibString.toString(_troveData._interestRate), "\"}, {\"trait_type\": \"Status\", \"value\": \"", _status2Str(_troveData._status), "\"} ]");
}
```

## Related Implementations

### toHexString(address)

- **Kind**: internal
- **Source**: 14338:436:1
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:toHexString(address)`

```solidity
/// @dev Returns the hexadecimal representation of `value`.
///  The output is prefixed with "0x" and encoded using 2 hexadecimal digits per byte.
function toHexString(address value) internal pure returns (string memory str) {
    str = toHexStringNoPrefix(value);
    /// @solidity memory-safe-assembly
    assembly {
        let strLength := add(mload(str), 2)
        mstore(str, 0x3078)
        str := sub(str, 2)
        mstore(str, strLength)
    }
}
```

### toHexStringNoPrefix(address)

- **Kind**: internal
- **Source**: 14911:1330:1
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:toHexStringNoPrefix(address)`

```solidity
/// @dev Returns the hexadecimal representation of `value`.
///  The output is encoded using 2 hexadecimal digits per byte.
function toHexStringNoPrefix(address value) internal pure returns (string memory str) {
    /// @solidity memory-safe-assembly
    assembly {
        str := mload(0x40)
        mstore(0x40, add(str, 0x80))
        mstore(0x0f, 0x30313233343536373839616263646566)
        str := add(str, 2)
        mstore(str, 40)
        let o := add(str, 0x20)
        mstore(add(o, 40), 0)
        value := shl(96, value)
        for {
            let i := 0
        } 1 {} {
            let p := add(o, add(i, i))
            let temp := byte(i, value)
            mstore8(add(p, 1), mload(and(temp, 15)))
            mstore8(p, mload(shr(4, temp)))
            i := add(i, 1)
            if eq(i, 20) {
                break
            }
        }
    }
}
```

### toString(uint256)

- **Kind**: internal
- **Source**: 3513:1535:1
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:toString(uint256)`

```solidity
/// @dev Returns the base 10 decimal representation of `value`.
function toString(uint256 value) internal pure returns (string memory str) {
    /// @solidity memory-safe-assembly
    assembly {
        str := add(mload(0x40), 0x80)
        mstore(0x40, add(str, 0x20))
        mstore(str, 0)
        let end := str
        let w := not(0)
        for {
            let temp := value
        } 1 {} {
            str := add(str, w)
            mstore8(str, add(48, mod(temp, 10)))
            temp := div(temp, 10)
            if iszero(temp) {
                break
            }
        }
        let length := sub(end, str)
        str := sub(str, 0x20)
        mstore(str, length)
    }
}
```

### _status2Str(enum ITroveManager.Status)

- **Kind**: internal
- **Source**: 3333:418:253
- **Link**: `src/NFTMetadata/MetadataNFT.sol:MetadataNFT:_status2Str(enum ITroveManager.Status)`

```solidity
function _status2Str(ITroveManager.Status status) internal pure returns (string memory) {
    if (status == ITroveManager.Status.active) return "Active";
    if (status == ITroveManager.Status.closedByOwner) return "Closed";
    if (status == ITroveManager.Status.closedByLiquidation) return "Liquidated";
    if (status == ITroveManager.Status.zombie) return "Below Min Debt";
    return "";
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MetadataNFT.attributes(struct IMetadataNFT.TroveData) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: LibString.toHexString(address) (NodeID: 1)
  │   💬 Args: [_troveData._collToken]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.toHexStringNoPrefix(address) (NodeID: 2)
  │     💬 Args: [value]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 3)
  │   💬 Args: [_troveData._collAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LibString.toHexString(address) (NodeID: 4)
  │   💬 Args: [_troveData._boldToken]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.toHexStringNoPrefix(address) (NodeID: 5)
  │     💬 Args: [value]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 6)
  │   💬 Args: [_troveData._debtAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 7)
  │   💬 Args: [_troveData._interestRate]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: MetadataNFT._status2Str(enum ITroveManager.Status) (NodeID: 8)
      💬 Args: [_troveData._status]
      👁️  Def: internal
```
