# Function: dynamicTextComponents(struct IMetadataNFT.TroveData)

**Contract**: [src/NFTMetadata/MetadataNFT.sol/contract_MetadataNFT.md]

## Metadata

- **Contract**: MetadataNFT
- **Signature**: `dynamicTextComponents(struct IMetadataNFT.TroveData)`
- **Visibility**: public
- **Source Range**: 2654:673:102

## Implementation

```solidity
function dynamicTextComponents(TroveData memory _troveData) public view returns (string memory) {
    string memory id = LibString.toHexString(_troveData._tokenId);
    id = string.concat(LibString.slice(id, 0, 6), "...", LibString.slice(id, 38, 42));
    return string.concat(baseSVG._formattedIdEl(id), baseSVG._formattedAddressEl(_troveData._owner), baseSVG._collLogo(IERC20Metadata(_troveData._collToken).symbol(), assetReader), baseSVG._statusEl(_status2Str(_troveData._status)), baseSVG._dynamicTextEls(_troveData._debtAmount, _troveData._collAmount, _troveData._interestRate));
}
```

## Related Implementations

### toHexString(uint256)

- **Kind**: internal
- **Source**: 9321:436:0
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:toHexString(uint256)`

```solidity
/// @dev Returns the hexadecimal representation of `value`.
///  The output is prefixed with "0x" and encoded using 2 hexadecimal digits per byte.
///  As address are 20 bytes long, the output will left-padded to have
///  a length of `20 * 2 + 2` bytes.
function toHexString(uint256 value) internal pure returns (string memory str) {
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

### toHexStringNoPrefix(uint256)

- **Kind**: internal
- **Source**: 11657:1411:0
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:toHexStringNoPrefix(uint256)`

```solidity
/// @dev Returns the hexadecimal representation of `value`.
///  The output is encoded using 2 hexadecimal digits per byte.
///  As address are 20 bytes long, the output will left-padded to have
///  a length of `20 * 2` bytes.
function toHexStringNoPrefix(uint256 value) internal pure returns (string memory str) {
    /// @solidity memory-safe-assembly
    assembly {
        str := add(mload(0x40), 0x80)
        mstore(0x40, add(str, 0x20))
        mstore(str, 0)
        let end := str
        mstore(0x0f, 0x30313233343536373839616263646566)
        let w := not(1)
        for {
            let temp := value
        } 1 {} {
            str := add(str, w)
            mstore8(add(str, 1), mload(and(temp, 15)))
            mstore8(str, mload(and(shr(4, temp), 15)))
            temp := shr(8, temp)
            if iszero(temp) {
                break
            }
        }
        let strLength := sub(end, str)
        str := sub(str, 0x20)
        mstore(str, strLength)
    }
}
```

### slice(string,uint256,uint256)

- **Kind**: internal
- **Source**: 33520:1207:0
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:slice(string,uint256,uint256)`

```solidity
/// @dev Returns a copy of `subject` sliced from `start` to `end` (exclusive).
///  `start` and `end` are byte offsets.
function slice(string memory subject, uint256 start, uint256 end) internal pure returns (string memory result) {
    /// @solidity memory-safe-assembly
    assembly {
        let subjectLength := mload(subject)
        if iszero(gt(subjectLength, end)) {
            end := subjectLength
        }
        if iszero(gt(subjectLength, start)) {
            start := subjectLength
        }
        if lt(start, end) {
            result := mload(0x40)
            let resultLength := sub(end, start)
            mstore(result, resultLength)
            subject := add(subject, start)
            let w := not(0x1f)
            for {
                let o := and(add(resultLength, 0x1f), w)
            } 1 {} {
                mstore(add(result, o), mload(add(subject, o)))
                o := add(o, w)
                if iszero(o) {
                    break
                }
            }
            mstore(add(add(result, 0x20), resultLength), 0)
            mstore(0x40, add(result, add(resultLength, 0x40)))
        }
    }
}
```

### _formattedIdEl(string)

- **Kind**: internal
- **Source**: 4870:415:107
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_formattedIdEl(string)`

```solidity
function _formattedIdEl(string memory _id) internal pure returns (string memory) {
    return svg.text(string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", "284"), svg.prop("y", "33"), svg.prop("font-size", "14"), svg.prop("fill", "white")), _id);
}
```

### text(string,string)

- **Kind**: internal
- **Source**: 1738:152:105
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:text(string,string)`

```solidity
function text(string memory _props, string memory _children) internal pure returns (string memory) {
    return el("text", _props, _children);
}
```

### prop(string,string)

- **Kind**: internal
- **Source**: 6496:157:105
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:prop(string,string)`

```solidity
function prop(string memory _key, string memory _val) internal pure returns (string memory) {
    return string.concat(_key, "=", "\"", _val, "\" ");
}
```

### el(string,string,string)

- **Kind**: internal
- **Source**: 5971:239:105
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:el(string,string,string)`

```solidity
function el(string memory _tag, string memory _props, string memory _children) internal pure returns (string memory) {
    return string.concat("<", _tag, " ", _props, ">", _children, "</", _tag, ">");
}
```

### _formattedAddressEl(address)

- **Kind**: internal
- **Source**: 5291:635:107
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_formattedAddressEl(address)`

```solidity
function _formattedAddressEl(address _address) internal pure returns (string memory) {
    return svg.text(string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", "284"), svg.prop("y", "462"), svg.prop("font-size", "14"), svg.prop("fill", "white")), string.concat(LibString.slice(LibString.toHexStringChecksummed(_address), 0, 6), "...", LibString.slice(LibString.toHexStringChecksummed(_address), 38, 42)));
}
```

### toHexStringChecksummed(address)

- **Kind**: internal
- **Source**: 13340:838:0
- **Link**: `lib/Solady/src/utils/LibString.sol:LibString:toHexStringChecksummed(address)`

```solidity
/// @dev Returns the hexadecimal representation of `value`.
///  The output is prefixed with "0x", encoded using 2 hexadecimal digits per byte,
///  and the alphabets are capitalized conditionally according to
///  https://eips.ethereum.org/EIPS/eip-55
function toHexStringChecksummed(address value) internal pure returns (string memory str) {
    str = toHexString(value);
    /// @solidity memory-safe-assembly
    assembly {
        let mask := shl(6, div(not(0), 255))
        let o := add(str, 0x22)
        let hashed := and(keccak256(o, 40), mul(34, mask))
        let t := shl(240, 136)
        for {
            let i := 0
        } 1 {} {
            mstore(add(i, i), mul(t, byte(i, hashed)))
            i := add(i, 1)
            if eq(i, 20) {
                break
            }
        }
        mstore(o, xor(mload(o), shr(1, and(mload(0x00), and(mload(o), mask)))))
        o := add(o, 0x20)
        mstore(o, xor(mload(o), shr(1, and(mload(0x20), and(mload(o), mask)))))
    }
}
```

### toHexString(address)

- **Kind**: internal
- **Source**: 14338:436:0
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
- **Source**: 14911:1330:0
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

### _collLogo(string,contract FixedAssetReader)

- **Kind**: internal
- **Source**: 5932:620:107
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_collLogo(string,contract FixedAssetReader)`

```solidity
function _collLogo(string memory _collName, FixedAssetReader _assetReader) internal view returns (string memory) {
    return svg.el("image", string.concat(svg.prop("x", "264"), svg.prop("y", "342.5"), svg.prop("width", "20"), svg.prop("height", "20"), svg.prop("href", string.concat("data:image/svg+xml;base64,", _assetReader.readAsset(bytes4(keccak256(bytes(_collName))))))));
}
```

### el(string,string)

- **Kind**: internal
- **Source**: 6307:159:105
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:el(string,string)`

```solidity
function el(string memory _tag, string memory _props) internal pure returns (string memory) {
    return string.concat("<", _tag, " ", _props, "/>");
}
```

### _statusEl(string)

- **Kind**: internal
- **Source**: 6558:305:107
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_statusEl(string)`

```solidity
function _statusEl(string memory _status) internal pure returns (string memory) {
    return svg.text(string.concat(GEIST, svg.prop("x", "40"), svg.prop("y", "33"), svg.prop("font-size", "14"), svg.prop("fill", "white")), _status);
}
```

### _status2Str(enum ITroveManager.Status)

- **Kind**: internal
- **Source**: 3333:418:102
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

### _dynamicTextEls(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 6869:457:107
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_dynamicTextEls(uint256,uint256,uint256)`

```solidity
function _dynamicTextEls(uint256 _debt, uint256 _coll, uint256 _annualInterestRate) internal pure returns (string memory) {
    return string.concat(_formattedDynamicEl(numUtils.toLocaleString(_coll, 18, 4), 256, 360), _formattedDynamicEl(numUtils.toLocaleString(_debt, 18, 2), 256, 391), _formattedDynamicEl(numUtils.toLocaleString(_annualInterestRate, 16, 2), 256, 422));
}
```

### _formattedDynamicEl(string,uint256,uint256)

- **Kind**: internal
- **Source**: 4379:485:107
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_formattedDynamicEl(string,uint256,uint256)`

```solidity
function _formattedDynamicEl(string memory _value, uint256 _x, uint256 _y) internal pure returns (string memory) {
    return svg.text(string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", LibString.toString(_x)), svg.prop("y", LibString.toString(_y)), svg.prop("font-size", "20"), svg.prop("fill", "white")), _value);
}
```

### toLocaleString(uint256,uint8,uint8)

- **Kind**: internal
- **Source**: 918:1824:106
- **Link**: `src/NFTMetadata/utils/Utils.sol:numUtils:toLocaleString(uint256,uint8,uint8)`

```solidity
function toLocaleString(uint256 _value, uint8 _divisor, uint8 _precision) internal pure returns (string memory) {
    uint256 whole;
    uint256 fraction;
    if (_divisor > 0) {
        whole = _value / (10 ** _divisor);
        if (_divisor <= _precision) {
            fraction = (_value % (10 ** _divisor));
            fraction = fraction * (10 ** (_precision - _divisor));
            fraction = ((whole == 0) && (_value != 1)) ? (fraction * 10) : fraction;
        } else {
            fraction = (_value % (10 ** _divisor)) / (10 ** ((_divisor - _precision) - 1));
        }
    } else {
        whole = _value;
    }
    string memory wholeStr = toLocale(LibString.toString(whole));
    if (fraction == 0) {
        if ((whole > 0) && (_precision > 0)) wholeStr = string.concat(wholeStr, ".");
        for (uint8 i = 0; i < _precision; i++) {
            wholeStr = string.concat(wholeStr, "0");
        }
        return wholeStr;
    }
    string memory fractionStr = LibString.slice(LibString.toString(fraction), 0, _precision);
    if (_precision > bytes(fractionStr).length) {
        uint256 len = _precision - bytes(fractionStr).length;
        string memory zeroStr = "";
        for (uint8 i = 0; i < len; i++) {
            zeroStr = string.concat(zeroStr, "0");
        }
        fractionStr = string.concat(zeroStr, fractionStr);
    }
    return string.concat(wholeStr, (_precision > 0) ? "." : "", fractionStr);
}
```

### toLocale(string)

- **Kind**: internal
- **Source**: 125:684:106
- **Link**: `src/NFTMetadata/utils/Utils.sol:numUtils:toLocale(string)`

```solidity
function toLocale(string memory _wholeNumber) internal pure returns (string memory) {
    bytes memory b = bytes(_wholeNumber);
    uint256 len = b.length;
    if (len < 4) return _wholeNumber;
    uint256 numCommas = (len - 1) / 3;
    bytes memory result = new bytes(len + numCommas);
    uint256 j = result.length - 1;
    uint256 k = len;
    for (uint256 i = 0; i < len; i++) {
        result[j] = b[k - 1];
        j = (j > 1) ? (j - 1) : 0;
        k--;
        if ((k > 0) && (((len - k) % 3) == 0)) {
            result[j] = ",";
            j = (j > 1) ? (j - 1) : 0;
        }
    }
    return string(result);
}
```

### toString(uint256)

- **Kind**: internal
- **Source**: 3513:1535:0
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

## External Calls

- **IERC20Metadata::symbol()**
- **FixedAssetReader::readAsset(bytes4)**

## State Variable Reads

- **assetReader** (`contract FixedAssetReader`) [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]
- **GEIST** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MetadataNFT.dynamicTextComponents(struct IMetadataNFT.TroveData) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: LibString.toHexString(uint256) (NodeID: 1)
  │   💬 Args: [_troveData._tokenId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibString.toHexStringNoPrefix(uint256) (NodeID: 2)
  │     💬 Args: [value]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 3)
  │   💬 Args: [id, 0, 6]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 4)
  │   💬 Args: [id, 38, 42]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: baseSVG._formattedIdEl(string) (NodeID: 5)
  │   💬 Args: [id]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 6)
  │     💬 Args: [string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", "284"), svg.prop("y", "33"), svg.prop("font-size", "14"), svg.prop("fill", "white")), _id]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 8)
  │   │   💬 Args: ["text-anchor", "end"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 9)
  │   │   💬 Args: ["x", "284"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 10)
  │   │   💬 Args: ["y", "33"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 11)
  │   │   💬 Args: ["font-size", "14"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 12)
  │   │   💬 Args: ["fill", "white"]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 7)
  │       💬 Args: ["text", _props, _children]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: baseSVG._formattedAddressEl(address) (NodeID: 13)
  │   💬 Args: [_troveData._owner]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 14)
  │     💬 Args: [string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", "284"), svg.prop("y", "462"), svg.prop("font-size", "14"), svg.prop("fill", "white")), string.concat(LibString.slice(LibString.toHexStringChecksummed(_address), 0, 6), "...", LibString.slice(LibString.toHexStringChecksummed(_address), 38, 42))]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 16)
  │   │   💬 Args: ["text-anchor", "end"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 17)
  │   │   💬 Args: ["x", "284"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 18)
  │   │   💬 Args: ["y", "462"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 19)
  │   │   💬 Args: ["font-size", "14"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 20)
  │   │   💬 Args: ["fill", "white"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 21)
  │   │   💬 Args: [LibString.toHexStringChecksummed(_address), 0, 6]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: LibString.toHexStringChecksummed(address) (NodeID: 22)
  │   │     💬 Args: [_address]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: LibString.toHexString(address) (NodeID: 23)
  │   │       💬 Args: [value]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: LibString.toHexStringNoPrefix(address) (NodeID: 24)
  │   │         💬 Args: [value]
  │   │         👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 25)
  │   │   💬 Args: [LibString.toHexStringChecksummed(_address), 38, 42]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: LibString.toHexStringChecksummed(address) (NodeID: 26)
  │   │     💬 Args: [_address]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: LibString.toHexString(address) (NodeID: 27)
  │   │       💬 Args: [value]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: LibString.toHexStringNoPrefix(address) (NodeID: 28)
  │   │         💬 Args: [value]
  │   │         👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 15)
  │       💬 Args: ["text", _props, _children]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: baseSVG._collLogo(string,contract FixedAssetReader) (NodeID: 29)
  │   💬 Args: [IERC20Metadata(_troveData._collToken).symbol(), assetReader]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 30)
  │     💬 Args: ["image", string.concat(svg.prop("x", "264"), svg.prop("y", "342.5"), svg.prop("width", "20"), svg.prop("height", "20"), svg.prop("href", string.concat("data:image/svg+xml;base64,", _assetReader.readAsset(bytes4(keccak256(bytes(_collName)))))))]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 31)
  │   │   💬 Args: ["x", "264"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 32)
  │   │   💬 Args: ["y", "342.5"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 33)
  │   │   💬 Args: ["width", "20"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 34)
  │   │   💬 Args: ["height", "20"]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 35)
  │       💬 Args: ["href", string.concat("data:image/svg+xml;base64,", _assetReader.readAsset(bytes4(keccak256(bytes(_collName)))))]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: baseSVG._statusEl(string) (NodeID: 36)
  │   💬 Args: [_status2Str(_troveData._status)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MetadataNFT._status2Str(enum ITroveManager.Status) (NodeID: 43)
  │ │   💬 Args: [_troveData._status]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 37)
  │     💬 Args: [string.concat(GEIST, svg.prop("x", "40"), svg.prop("y", "33"), svg.prop("font-size", "14"), svg.prop("fill", "white")), _status]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 39)
  │   │   💬 Args: ["x", "40"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 40)
  │   │   💬 Args: ["y", "33"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 41)
  │   │   💬 Args: ["font-size", "14"]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 42)
  │   │   💬 Args: ["fill", "white"]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 38)
  │       💬 Args: ["text", _props, _children]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: baseSVG._dynamicTextEls(uint256,uint256,uint256) (NodeID: 44)
      💬 Args: [_troveData._debtAmount, _troveData._collAmount, _troveData._interestRate]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: baseSVG._formattedDynamicEl(string,uint256,uint256) (NodeID: 45)
    │   💬 Args: [numUtils.toLocaleString(_coll, 18, 4), 256, 360]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 55)
    │ │   💬 Args: [_coll, 18, 4]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 56)
    │ │ │   💬 Args: [LibString.toString(whole)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 57)
    │ │ │     💬 Args: [whole]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 58)
    │ │     💬 Args: [LibString.toString(fraction), 0, _precision]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 59)
    │ │       💬 Args: [fraction]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 46)
    │     💬 Args: [string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", LibString.toString(_x)), svg.prop("y", LibString.toString(_y)), svg.prop("font-size", "20"), svg.prop("fill", "white")), _value]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 48)
    │   │   💬 Args: ["text-anchor", "end"]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 49)
    │   │   💬 Args: ["x", LibString.toString(_x)]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 50)
    │   │     💬 Args: [_x]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 51)
    │   │   💬 Args: ["y", LibString.toString(_y)]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 52)
    │   │     💬 Args: [_y]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 53)
    │   │   💬 Args: ["font-size", "20"]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 54)
    │   │   💬 Args: ["fill", "white"]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 47)
    │       💬 Args: ["text", _props, _children]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: baseSVG._formattedDynamicEl(string,uint256,uint256) (NodeID: 60)
    │   💬 Args: [numUtils.toLocaleString(_debt, 18, 2), 256, 391]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 70)
    │ │   💬 Args: [_debt, 18, 2]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 71)
    │ │ │   💬 Args: [LibString.toString(whole)]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 72)
    │ │ │     💬 Args: [whole]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 73)
    │ │     💬 Args: [LibString.toString(fraction), 0, _precision]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 74)
    │ │       💬 Args: [fraction]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 61)
    │     💬 Args: [string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", LibString.toString(_x)), svg.prop("y", LibString.toString(_y)), svg.prop("font-size", "20"), svg.prop("fill", "white")), _value]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 63)
    │   │   💬 Args: ["text-anchor", "end"]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 64)
    │   │   💬 Args: ["x", LibString.toString(_x)]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 65)
    │   │     💬 Args: [_x]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 66)
    │   │   💬 Args: ["y", LibString.toString(_y)]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 67)
    │   │     💬 Args: [_y]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 68)
    │   │   💬 Args: ["font-size", "20"]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 69)
    │   │   💬 Args: ["fill", "white"]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 62)
    │       💬 Args: ["text", _props, _children]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: baseSVG._formattedDynamicEl(string,uint256,uint256) (NodeID: 75)
        💬 Args: [numUtils.toLocaleString(_annualInterestRate, 16, 2), 256, 422]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 85)
      │   💬 Args: [_annualInterestRate, 16, 2]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 86)
      │ │   💬 Args: [LibString.toString(whole)]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 87)
      │ │     💬 Args: [whole]
      │ │     👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 88)
      │     💬 Args: [LibString.toString(fraction), 0, _precision]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 89)
      │       💬 Args: [fraction]
      │       👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 76)
          💬 Args: [string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", LibString.toString(_x)), svg.prop("y", LibString.toString(_y)), svg.prop("font-size", "20"), svg.prop("fill", "white")), _value]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 78)
        │   💬 Args: ["text-anchor", "end"]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 79)
        │   💬 Args: ["x", LibString.toString(_x)]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 80)
        │     💬 Args: [_x]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 81)
        │   💬 Args: ["y", LibString.toString(_y)]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 82)
        │     💬 Args: [_y]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 83)
        │   💬 Args: ["font-size", "20"]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 84)
        │   💬 Args: ["fill", "white"]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 77)
            💬 Args: ["text", _props, _children]
            👁️  Def: internal
```
