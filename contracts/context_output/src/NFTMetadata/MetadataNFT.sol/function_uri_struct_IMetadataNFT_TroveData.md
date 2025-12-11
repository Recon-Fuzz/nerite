# Function: uri(struct IMetadataNFT.TroveData)

**Contract**: [src/NFTMetadata/MetadataNFT.sol/contract_MetadataNFT.md]

## Metadata

- **Contract**: MetadataNFT
- **Signature**: `uri(struct IMetadataNFT.TroveData)`
- **Visibility**: public
- **Source Range**: 1027:230:253

## Implementation

```solidity
function uri(TroveData memory _troveData) public view returns (string memory) {
    string memory attr = attributes(_troveData);
    return json.formattedMetadata(name, description, renderSVGImage(_troveData), attr);
}
```

## Related Implementations

### attributes(struct IMetadataNFT.TroveData)

- **Kind**: internal
- **Source**: 1682:966:253
- **Link**: `src/NFTMetadata/MetadataNFT.sol:MetadataNFT:attributes(struct IMetadataNFT.TroveData)`

```solidity
function attributes(TroveData memory _troveData) public pure returns (string memory) {
    return string.concat("[{\"trait_type\": \"Collateral Token\", \"value\": \"", LibString.toHexString(_troveData._collToken), "\"}, {\"trait_type\": \"Collateral Amount\", \"value\": \"", LibString.toString(_troveData._collAmount), "\"}, {\"trait_type\": \"Debt Token\", \"value\": \"", LibString.toHexString(_troveData._boldToken), "\"}, {\"trait_type\": \"Debt Amount\", \"value\": \"", LibString.toString(_troveData._debtAmount), "\"}, {\"trait_type\": \"Interest Rate\", \"value\": \"", LibString.toString(_troveData._interestRate), "\"}, {\"trait_type\": \"Status\", \"value\": \"", _status2Str(_troveData._status), "\"} ]");
}
```

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

### formattedMetadata(string,string,string,string)

- **Kind**: internal
- **Source**: 613:705:255
- **Link**: `src/NFTMetadata/utils/JSON.sol:json:formattedMetadata(string,string,string,string)`

```solidity
function formattedMetadata(string memory name, string memory description, string memory svgImg, string memory attributes) internal pure returns (string memory) {
    return string.concat("data:application/json;base64,", encode(bytes(string.concat("{", _prop("name", name), _prop("description", description), _xmlImage(svgImg), ",\"attributes\":", attributes, "}"))));
}
```

### renderSVGImage(struct IMetadataNFT.TroveData)

- **Kind**: internal
- **Source**: 1263:413:253
- **Link**: `src/NFTMetadata/MetadataNFT.sol:MetadataNFT:renderSVGImage(struct IMetadataNFT.TroveData)`

```solidity
function renderSVGImage(TroveData memory _troveData) internal view returns (string memory) {
    return svg._svg(baseSVG._svgProps(), string.concat(baseSVG._baseElements(assetReader), bauhaus._bauhaus(IERC20Metadata(_troveData._collToken).symbol(), _troveData._tokenId), dynamicTextComponents(_troveData)));
}
```

### _svg(string,string)

- **Kind**: internal
- **Source**: 841:177:256
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:_svg(string,string)`

```solidity
function _svg(string memory _props, string memory _children) internal pure returns (string memory) {
    return el("svg", string.concat(_SVG, " ", _props), _children);
}
```

### _svgProps()

- **Kind**: internal
- **Source**: 342:281:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_svgProps()`

```solidity
function _svgProps() internal pure returns (string memory) {
    return string.concat(svg.prop("width", "300"), svg.prop("height", "484"), svg.prop("viewBox", "0 0 300 484"), svg.prop("style", "background:none"));
}
```

### prop(string,string)

- **Kind**: internal
- **Source**: 6496:157:256
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:prop(string,string)`

```solidity
function prop(string memory _key, string memory _val) internal pure returns (string memory) {
    return string.concat(_key, "=", "\"", _val, "\" ");
}
```

### _baseElements(contract FixedAssetReader)

- **Kind**: internal
- **Source**: 629:538:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_baseElements(contract FixedAssetReader)`

```solidity
function _baseElements(FixedAssetReader _assetReader) internal view returns (string memory) {
    return string.concat(svg.rect(string.concat(svg.prop("fill", DARK_BLUE), svg.prop("rx", "8"), svg.prop("width", "300"), svg.prop("height", "484"))), _styles(_assetReader), _leverageLogo(), _boldLogo(_assetReader), _staticTextEls());
}
```

### rect(string)

- **Kind**: internal
- **Source**: 4144:116:256
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:rect(string)`

```solidity
function rect(string memory _props) internal pure returns (string memory) {
    return el("rect", _props);
}
```

### el(string,string)

- **Kind**: internal
- **Source**: 6307:159:256
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:el(string,string)`

```solidity
function el(string memory _tag, string memory _props) internal pure returns (string memory) {
    return string.concat("<", _tag, " ", _props, "/>");
}
```

### _styles(contract FixedAssetReader)

- **Kind**: internal
- **Source**: 1173:398:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_styles(contract FixedAssetReader)`

```solidity
function _styles(FixedAssetReader _assetReader) private view returns (string memory) {
    return svg.el("style", utils.NULL, string.concat("@font-face { font-family: \"Geist\"; src: url(\"data:font/woff2;utf-8;base64,", _assetReader.readAsset(bytes4(keccak256("geist"))), "\"); }"));
}
```

### el(string,string,string)

- **Kind**: internal
- **Source**: 5971:239:256
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:el(string,string,string)`

```solidity
function el(string memory _tag, string memory _props, string memory _children) internal pure returns (string memory) {
    return string.concat("<", _tag, " ", _props, ">", _children, "</", _tag, ">");
}
```

### _leverageLogo()

- **Kind**: internal
- **Source**: 1577:545:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_leverageLogo()`

```solidity
function _leverageLogo() internal pure returns (string memory) {
    return string.concat(svg.path("M20.2 31.2C19.1 32.4 17.6 33 16 33L16 21C17.6 21 19.1 21.6 20.2 22.7C21.4 23.9 22 25.4 22 27C22 28.6 21.4 30.1 20.2 31.2Z", svg.prop("fill", STOIC_WHITE)), svg.path("M22 27C22 25.4 22.6 23.9 23.8 22.7C25 21.6 26.4 21 28 21V33C26.4 33 25 32.4 24 31.2C22.6 30.1 22 28.6 22 27Z", svg.prop("fill", STOIC_WHITE)));
}
```

### path(string,string)

- **Kind**: internal
- **Source**: 1334:164:256
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:path(string,string)`

```solidity
function path(string memory _d, string memory _props) internal pure returns (string memory) {
    return el("path", string.concat(prop("d", _d), _props));
}
```

### _boldLogo(contract FixedAssetReader)

- **Kind**: internal
- **Source**: 2128:539:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_boldLogo(contract FixedAssetReader)`

```solidity
function _boldLogo(FixedAssetReader _assetReader) internal view returns (string memory) {
    return svg.el("image", string.concat(svg.prop("x", "264"), svg.prop("y", "373.5"), svg.prop("width", "20"), svg.prop("height", "20"), svg.prop("href", string.concat("data:image/svg+xml;base64,", _assetReader.readAsset(bytes4(keccak256("BOLD")))))));
}
```

### _staticTextEls()

- **Kind**: internal
- **Source**: 2673:1700:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_staticTextEls()`

```solidity
function _staticTextEls() internal pure returns (string memory) {
    return string.concat(svg.text(string.concat(GEIST, svg.prop("x", "16"), svg.prop("y", "358"), svg.prop("font-size", "14"), svg.prop("fill", "white")), "Collateral"), svg.text(string.concat(GEIST, svg.prop("x", "16"), svg.prop("y", "389"), svg.prop("font-size", "14"), svg.prop("fill", "white")), "Debt"), svg.text(string.concat(GEIST, svg.prop("x", "16"), svg.prop("y", "420"), svg.prop("font-size", "14"), svg.prop("fill", "white")), "Interest Rate"), svg.text(string.concat(GEIST, svg.prop("x", "265"), svg.prop("y", "422"), svg.prop("font-size", "20"), svg.prop("fill", "white")), "%"), svg.text(string.concat(GEIST, svg.prop("x", "16"), svg.prop("y", "462"), svg.prop("font-size", "14"), svg.prop("fill", "white")), "Owner"));
}
```

### text(string,string)

- **Kind**: internal
- **Source**: 1738:152:256
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:text(string,string)`

```solidity
function text(string memory _props, string memory _children) internal pure returns (string memory) {
    return el("text", _props, _children);
}
```

### _bauhaus(string,uint256)

- **Kind**: internal
- **Source**: 511:458:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_bauhaus(string,uint256)`

```solidity
function _bauhaus(string memory _collName, uint256 _troveId) internal pure returns (string memory) {
    bytes32 collSig = keccak256(bytes(_collName));
    uint256 variant = _troveId % 4;
    if (collSig == keccak256("WETH")) {
        return _img1(variant);
    } else if (collSig == keccak256("wstETH")) {
        return _img2(variant);
    } else {
        return _img3(variant);
    }
}
```

### _img1(uint256)

- **Kind**: internal
- **Source**: 3743:215:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_img1(uint256)`

```solidity
function _img1(uint256 _variant) internal pure returns (string memory) {
    COLORS memory colors = _colors1(_variant);
    return string.concat(_rects1(colors), _polygons1(colors), _circles1(colors));
}
```

### _colors1(uint256)

- **Kind**: internal
- **Source**: 1820:1917:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_colors1(uint256)`

```solidity
function _colors1(uint256 _variant) internal pure returns (COLORS memory) {
    if (_variant == 0) {
        return COLORS(colorCode.BLUE, colorCode.GOLDEN, colorCode.GOLDEN, colorCode.BROWN, colorCode.CORAL, colorCode.CYAN, colorCode.GREEN, colorCode.DARK_BLUE, colorCode.GOLDEN);
    } else if (_variant == 1) {
        return COLORS(colorCode.GREEN, colorCode.BLUE, colorCode.GOLDEN, colorCode.BROWN, colorCode.GOLDEN, colorCode.CORAL, colorCode.BLUE, colorCode.DARK_BLUE, colorCode.BLUE);
    } else if (_variant == 2) {
        return COLORS(colorCode.BLUE, colorCode.GOLDEN, colorCode.CYAN, colorCode.GOLDEN, colorCode.BROWN, colorCode.GREEN, colorCode.CORAL, colorCode.DARK_BLUE, colorCode.BROWN);
    } else {
        return COLORS(colorCode.CYAN, colorCode.BLUE, colorCode.BLUE, colorCode.BROWN, colorCode.BLUE, colorCode.GREEN, colorCode.GOLDEN, colorCode.DARK_BLUE, colorCode.BLUE);
    }
}
```

### _rects1(struct bauhaus.COLORS)

- **Kind**: internal
- **Source**: 3964:2329:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_rects1(struct bauhaus.COLORS)`

```solidity
function _rects1(COLORS memory _colors) internal pure returns (string memory) {
    return string.concat(svg.rect(string.concat(svg.prop("x", "16"), svg.prop("y", "55"), svg.prop("width", "268"), svg.prop("height", "268"), svg.prop("fill", DARK_BLUE))), svg.rect(string.concat(svg.prop("x", "128"), svg.prop("y", "55"), svg.prop("width", "156"), svg.prop("height", "268"), svg.prop("fill", _colorCode2Hex(_colors.rect1)))), svg.rect(string.concat(svg.prop("x", "228"), svg.prop("y", "55"), svg.prop("width", "56"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect2)))), svg.rect(string.concat(svg.prop("x", "16"), svg.prop("y", "111"), svg.prop("width", "134"), svg.prop("height", "156"), svg.prop("fill", _colorCode2Hex(_colors.rect3)))), svg.rect(string.concat(svg.prop("x", "16"), svg.prop("y", "267"), svg.prop("width", "112"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect4)))), svg.rect(string.concat(svg.prop("x", "228"), svg.prop("y", "267"), svg.prop("width", "56"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect5)))));
}
```

### _colorCode2Hex(enum bauhaus.colorCode)

- **Kind**: internal
- **Source**: 975:582:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_colorCode2Hex(enum bauhaus.colorCode)`

```solidity
function _colorCode2Hex(colorCode _color) private pure returns (string memory) {
    if (_color == colorCode.GOLDEN) {
        return GOLDEN;
    } else if (_color == colorCode.CORAL) {
        return CORAL;
    } else if (_color == colorCode.GREEN) {
        return GREEN;
    } else if (_color == colorCode.CYAN) {
        return CYAN;
    } else if (_color == colorCode.BLUE) {
        return BLUE;
    } else if (_color == colorCode.DARK_BLUE) {
        return DARK_BLUE;
    } else {
        return BROWN;
    }
}
```

### _polygons1(struct bauhaus.COLORS)

- **Kind**: internal
- **Source**: 6299:524:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_polygons1(struct bauhaus.COLORS)`

```solidity
function _polygons1(COLORS memory _colors) internal pure returns (string memory) {
    return string.concat(svg.polygon(string.concat(svg.prop("points", "16,55 72,55 16,111"), svg.prop("fill", _colorCode2Hex(_colors.poly)))), svg.polygon(string.concat(svg.prop("points", "72,55 128,55 72,111"), svg.prop("fill", _colorCode2Hex(_colors.poly)))));
}
```

### polygon(string)

- **Kind**: internal
- **Source**: 3556:122:256
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:polygon(string)`

```solidity
function polygon(string memory _props) internal pure returns (string memory) {
    return el("polygon", _props);
}
```

### _circles1(struct bauhaus.COLORS)

- **Kind**: internal
- **Source**: 6829:1129:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_circles1(struct bauhaus.COLORS)`

```solidity
function _circles1(COLORS memory _colors) internal pure returns (string memory) {
    return string.concat(svg.circle(string.concat(svg.prop("cx", "150"), svg.prop("cy", "189"), svg.prop("r", "78"), svg.prop("fill", _colorCode2Hex(_colors.circle1)))), svg.circle(string.concat(svg.prop("cx", "228"), svg.prop("cy", "295"), svg.prop("r", "28"), svg.prop("fill", _colorCode2Hex(_colors.circle2)))), svg.path("M228 267C220.574 267 213.452 269.95 208.201 275.201C202.95 280.452 200 287.574 200 295C200 302.426 202.95 309.548 208.201 314.799C213.452 320.05 220.574 323 228 323L228 267Z", svg.prop("fill", _colorCode2Hex(_colors.circle3))));
}
```

### circle(string)

- **Kind**: internal
- **Source**: 2176:120:256
- **Link**: `src/NFTMetadata/utils/SVG.sol:svg:circle(string)`

```solidity
function circle(string memory _props) internal pure returns (string memory) {
    return el("circle", _props);
}
```

### _img2(uint256)

- **Kind**: internal
- **Source**: 9883:195:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_img2(uint256)`

```solidity
function _img2(uint256 _variant) internal pure returns (string memory) {
    COLORS memory colors = _colors2(_variant);
    return string.concat(_rects2(colors), _circles2(colors));
}
```

### _colors2(uint256)

- **Kind**: internal
- **Source**: 7964:1913:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_colors2(uint256)`

```solidity
function _colors2(uint256 _variant) internal pure returns (COLORS memory) {
    if (_variant == 0) {
        return COLORS(colorCode.BROWN, colorCode.GOLDEN, colorCode.BLUE, colorCode.GREEN, colorCode.CORAL, colorCode.GOLDEN, colorCode.GOLDEN, colorCode.CYAN, colorCode.GREEN);
    } else if (_variant == 1) {
        return COLORS(colorCode.GREEN, colorCode.BROWN, colorCode.GOLDEN, colorCode.BLUE, colorCode.CYAN, colorCode.GOLDEN, colorCode.GREEN, colorCode.CORAL, colorCode.BLUE);
    } else if (_variant == 2) {
        return COLORS(colorCode.BLUE, colorCode.GOLDEN, colorCode.GREEN, colorCode.BLUE, colorCode.CORAL, colorCode.GOLDEN, colorCode.CYAN, colorCode.BROWN, colorCode.BROWN);
    } else {
        return COLORS(colorCode.GOLDEN, colorCode.GREEN, colorCode.BLUE, colorCode.GOLDEN, colorCode.BROWN, colorCode.GOLDEN, colorCode.BROWN, colorCode.CYAN, colorCode.CORAL);
    }
}
```

### _rects2(struct bauhaus.COLORS)

- **Kind**: internal
- **Source**: 10084:2338:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_rects2(struct bauhaus.COLORS)`

```solidity
function _rects2(COLORS memory _colors) internal pure returns (string memory) {
    return string.concat(svg.rect(string.concat(svg.prop("x", "16"), svg.prop("y", "55"), svg.prop("width", "268"), svg.prop("height", "268"), svg.prop("fill", DARK_BLUE))), svg.rect(string.concat(svg.prop("x", "128"), svg.prop("y", "55"), svg.prop("width", "156"), svg.prop("height", "156"), svg.prop("fill", _colorCode2Hex(_colors.rect1)))), svg.rect(string.concat(svg.prop("x", "16"), svg.prop("y", "111"), svg.prop("width", "134"), svg.prop("height", "100"), svg.prop("fill", _colorCode2Hex(_colors.rect2)))), svg.rect(string.concat(svg.prop("x", "16"), svg.prop("y", "211"), svg.prop("width", "212"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect3)))), svg.rect(string.concat(svg.prop("x", "72"), svg.prop("y", "267"), svg.prop("width", "78"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect4)))), svg.rect(string.concat(svg.prop("x", "150"), svg.prop("y", "267"), svg.prop("width", "134"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect5)))));
}
```

### _circles2(struct bauhaus.COLORS)

- **Kind**: internal
- **Source**: 12428:1197:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_circles2(struct bauhaus.COLORS)`

```solidity
function _circles2(COLORS memory _colors) internal pure returns (string memory) {
    return string.concat(svg.circle(string.concat(svg.prop("cx", "44"), svg.prop("cy", "295"), svg.prop("r", "28"), svg.prop("fill", _colorCode2Hex(_colors.circle1)))), svg.path("M16 55C16 62.4 17.4 69.6 20.3 76.4C23.1 83.2 27.2 89.4 32.4 94.6C37.6 99.8 43.8 103.9 50.6 106.7C57.4 109.6 64.6 111 72 111C79.4 111 86.6 109.6 93.4 106.7C100.2 103.9 106.4 99.8 111.6 94.6C116.8 89.4 120.9 83.2 123.7 76.4C126.6 69.6 128 62.4 128 55L16 55Z", svg.prop("fill", _colorCode2Hex(_colors.circle2))), svg.path("M284 211C284 190.3 275.8 170.5 261.2 155.8C246.5 141.2 226.7 133 206 133C185.3 133 165.5 141.2 150.9 155.86C136.2 170.5 128 190.3 128 211L284 211Z", svg.prop("fill", _colorCode2Hex(_colors.circle3))));
}
```

### _img3(uint256)

- **Kind**: internal
- **Source**: 15557:195:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_img3(uint256)`

```solidity
function _img3(uint256 _variant) internal pure returns (string memory) {
    COLORS memory colors = _colors3(_variant);
    return string.concat(_rects3(colors), _circles3(colors));
}
```

### _colors3(uint256)

- **Kind**: internal
- **Source**: 13631:1920:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_colors3(uint256)`

```solidity
function _colors3(uint256 _variant) internal pure returns (COLORS memory) {
    if (_variant == 0) {
        return COLORS(colorCode.BLUE, colorCode.CORAL, colorCode.BLUE, colorCode.GREEN, colorCode.GOLDEN, colorCode.GOLDEN, colorCode.GOLDEN, colorCode.CYAN, colorCode.GOLDEN);
    } else if (_variant == 1) {
        return COLORS(colorCode.CORAL, colorCode.GREEN, colorCode.BROWN, colorCode.GOLDEN, colorCode.GOLDEN, colorCode.GOLDEN, colorCode.BLUE, colorCode.BLUE, colorCode.CYAN);
    } else if (_variant == 2) {
        return COLORS(colorCode.CORAL, colorCode.CYAN, colorCode.CORAL, colorCode.GOLDEN, colorCode.GOLDEN, colorCode.GOLDEN, colorCode.GREEN, colorCode.BLUE, colorCode.GREEN);
    } else {
        return COLORS(colorCode.GOLDEN, colorCode.CORAL, colorCode.GREEN, colorCode.BLUE, colorCode.GOLDEN, colorCode.GOLDEN, colorCode.BROWN, colorCode.BLUE, colorCode.GREEN);
    }
}
```

### _rects3(struct bauhaus.COLORS)

- **Kind**: internal
- **Source**: 15758:1934:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_rects3(struct bauhaus.COLORS)`

```solidity
function _rects3(COLORS memory _colors) internal pure returns (string memory) {
    return string.concat(svg.rect(string.concat(svg.prop("x", "16"), svg.prop("y", "55"), svg.prop("width", "268"), svg.prop("height", "268"), svg.prop("fill", DARK_BLUE))), svg.rect(string.concat(svg.prop("x", "16"), svg.prop("y", "205"), svg.prop("width", "75"), svg.prop("height", "118"), svg.prop("fill", _colorCode2Hex(_colors.rect1)))), svg.rect(string.concat(svg.prop("x", "91"), svg.prop("y", "205"), svg.prop("width", "136"), svg.prop("height", "59"), svg.prop("fill", _colorCode2Hex(_colors.rect2)))), svg.rect(string.concat(svg.prop("x", "166"), svg.prop("y", "180"), svg.prop("width", "118"), svg.prop("height", "25"), svg.prop("fill", _colorCode2Hex(_colors.rect3)))), svg.rect(string.concat(svg.prop("x", "166"), svg.prop("y", "55"), svg.prop("width", "118"), svg.prop("height", "126"), svg.prop("fill", _colorCode2Hex(_colors.rect4)))));
}
```

### _circles3(struct bauhaus.COLORS)

- **Kind**: internal
- **Source**: 17698:989:259
- **Link**: `src/NFTMetadata/utils/bauhaus.sol:bauhaus:_circles3(struct bauhaus.COLORS)`

```solidity
function _circles3(COLORS memory _colors) internal pure returns (string memory) {
    return string.concat(svg.circle(string.concat(svg.prop("cx", "91"), svg.prop("cy", "130"), svg.prop("r", "75"), svg.prop("fill", _colorCode2Hex(_colors.circle1)))), svg.path("M284 264 166 264 166 263C166 232 193 206 225 205C258 206 284 232 284 264C284 264 284 264 284 264Z", svg.prop("fill", _colorCode2Hex(_colors.circle2))), svg.path("M284 323 166 323 166 323C166 290 193 265 225 264C258 265 284 290 284 323C284 323 284 323 284 323Z", svg.prop("fill", _colorCode2Hex(_colors.circle3))));
}
```

### dynamicTextComponents(struct IMetadataNFT.TroveData)

- **Kind**: internal
- **Source**: 2654:673:253
- **Link**: `src/NFTMetadata/MetadataNFT.sol:MetadataNFT:dynamicTextComponents(struct IMetadataNFT.TroveData)`

```solidity
function dynamicTextComponents(TroveData memory _troveData) public view returns (string memory) {
    string memory id = LibString.toHexString(_troveData._tokenId);
    id = string.concat(LibString.slice(id, 0, 6), "...", LibString.slice(id, 38, 42));
    return string.concat(baseSVG._formattedIdEl(id), baseSVG._formattedAddressEl(_troveData._owner), baseSVG._collLogo(IERC20Metadata(_troveData._collToken).symbol(), assetReader), baseSVG._statusEl(_status2Str(_troveData._status)), baseSVG._dynamicTextEls(_troveData._debtAmount, _troveData._collAmount, _troveData._interestRate));
}
```

### toHexString(uint256)

- **Kind**: internal
- **Source**: 9321:436:1
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
- **Source**: 11657:1411:1
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
- **Source**: 33520:1207:1
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
- **Source**: 4870:415:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_formattedIdEl(string)`

```solidity
function _formattedIdEl(string memory _id) internal pure returns (string memory) {
    return svg.text(string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", "284"), svg.prop("y", "33"), svg.prop("font-size", "14"), svg.prop("fill", "white")), _id);
}
```

### _formattedAddressEl(address)

- **Kind**: internal
- **Source**: 5291:635:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_formattedAddressEl(address)`

```solidity
function _formattedAddressEl(address _address) internal pure returns (string memory) {
    return svg.text(string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", "284"), svg.prop("y", "462"), svg.prop("font-size", "14"), svg.prop("fill", "white")), string.concat(LibString.slice(LibString.toHexStringChecksummed(_address), 0, 6), "...", LibString.slice(LibString.toHexStringChecksummed(_address), 38, 42)));
}
```

### toHexStringChecksummed(address)

- **Kind**: internal
- **Source**: 13340:838:1
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

### _collLogo(string,contract FixedAssetReader)

- **Kind**: internal
- **Source**: 5932:620:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_collLogo(string,contract FixedAssetReader)`

```solidity
function _collLogo(string memory _collName, FixedAssetReader _assetReader) internal view returns (string memory) {
    return svg.el("image", string.concat(svg.prop("x", "264"), svg.prop("y", "342.5"), svg.prop("width", "20"), svg.prop("height", "20"), svg.prop("href", string.concat("data:image/svg+xml;base64,", _assetReader.readAsset(bytes4(keccak256(bytes(_collName))))))));
}
```

### _statusEl(string)

- **Kind**: internal
- **Source**: 6558:305:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_statusEl(string)`

```solidity
function _statusEl(string memory _status) internal pure returns (string memory) {
    return svg.text(string.concat(GEIST, svg.prop("x", "40"), svg.prop("y", "33"), svg.prop("font-size", "14"), svg.prop("fill", "white")), _status);
}
```

### _dynamicTextEls(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 6869:457:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_dynamicTextEls(uint256,uint256,uint256)`

```solidity
function _dynamicTextEls(uint256 _debt, uint256 _coll, uint256 _annualInterestRate) internal pure returns (string memory) {
    return string.concat(_formattedDynamicEl(numUtils.toLocaleString(_coll, 18, 4), 256, 360), _formattedDynamicEl(numUtils.toLocaleString(_debt, 18, 2), 256, 391), _formattedDynamicEl(numUtils.toLocaleString(_annualInterestRate, 16, 2), 256, 422));
}
```

### _formattedDynamicEl(string,uint256,uint256)

- **Kind**: internal
- **Source**: 4379:485:258
- **Link**: `src/NFTMetadata/utils/baseSVG.sol:baseSVG:_formattedDynamicEl(string,uint256,uint256)`

```solidity
function _formattedDynamicEl(string memory _value, uint256 _x, uint256 _y) internal pure returns (string memory) {
    return svg.text(string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", LibString.toString(_x)), svg.prop("y", LibString.toString(_y)), svg.prop("font-size", "20"), svg.prop("fill", "white")), _value);
}
```

### toLocaleString(uint256,uint8,uint8)

- **Kind**: internal
- **Source**: 918:1824:257
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
- **Source**: 125:684:257
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

### encode(bytes)

- **Kind**: internal
- **Source**: 2453:2941:255
- **Link**: `src/NFTMetadata/utils/JSON.sol:json:encode(bytes)`

```solidity
///  @dev Converts a `bytes` to its Bytes64 `string` representation.
function encode(bytes memory data) internal pure returns (string memory) {
    ///  Inspired by Brecht Devos (Brechtpd) implementation - MIT licence
    ///  https://github.com/Brechtpd/base64/blob/e78d9fd951e7b0977ddca77d92dc85183770daf4/base64.sol
    if (data.length == 0) return "";
    string memory table = _TABLE;
    string memory result = new string(4 * ((data.length + 2) / 3));
    assembly {
        let tablePtr := add(table, 1)
        let resultPtr := add(result, 32)
        for {
            let dataPtr := data
            let endPtr := add(data, mload(data))
        } lt(dataPtr, endPtr) {} {
            dataPtr := add(dataPtr, 3)
            let input := mload(dataPtr)
            mstore8(resultPtr, mload(add(tablePtr, and(shr(18, input), 0x3F))))
            resultPtr := add(resultPtr, 1)
            mstore8(resultPtr, mload(add(tablePtr, and(shr(12, input), 0x3F))))
            resultPtr := add(resultPtr, 1)
            mstore8(resultPtr, mload(add(tablePtr, and(shr(6, input), 0x3F))))
            resultPtr := add(resultPtr, 1)
            mstore8(resultPtr, mload(add(tablePtr, and(input, 0x3F))))
            resultPtr := add(resultPtr, 1)
        }
        switch mod(mload(data), 3)
        case 1 {
            mstore8(sub(resultPtr, 1), 0x3d)
            mstore8(sub(resultPtr, 2), 0x3d)
        }
        case 2 {
            mstore8(sub(resultPtr, 1), 0x3d)
        }
    }
    return result;
}
```

### _prop(string,string)

- **Kind**: internal
- **Source**: 1523:166:255
- **Link**: `src/NFTMetadata/utils/JSON.sol:json:_prop(string,string)`

```solidity
function _prop(string memory _key, string memory _val) internal pure returns (string memory) {
    return string.concat("\"", _key, "\": ", "\"", _val, "\", ");
}
```

### _xmlImage(string)

- **Kind**: internal
- **Source**: 1324:193:255
- **Link**: `src/NFTMetadata/utils/JSON.sol:json:_xmlImage(string)`

```solidity
function _xmlImage(string memory _svgImg) internal pure returns (string memory) {
    return _prop("image", string.concat("data:image/svg+xml;base64,", encode(bytes(_svgImg))), true);
}
```

### _prop(string,string,bool)

- **Kind**: internal
- **Source**: 1695:296:255
- **Link**: `src/NFTMetadata/utils/JSON.sol:json:_prop(string,string,bool)`

```solidity
function _prop(string memory _key, string memory _val, bool last) internal pure returns (string memory) {
    if (last) {
        return string.concat("\"", _key, "\": ", "\"", _val, "\"");
    } else {
        return string.concat("\"", _key, "\": ", "\"", _val, "\", ");
    }
}
```

## External Calls

- **IERC20Metadata::symbol()**
- **FixedAssetReader::readAsset(bytes4)**

## State Variable Reads

- **name** (`string`)
- **description** (`string`)
- **assetReader** (`contract FixedAssetReader`) [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]
- **_SVG** (`string`)
- **DARK_BLUE** (`string`)
- **STOIC_WHITE** (`string`)
- **GEIST** (`string`)
- **GOLDEN** (`string`)
- **CORAL** (`string`)
- **GREEN** (`string`)
- **CYAN** (`string`)
- **BLUE** (`string`)
- **BROWN** (`string`)
- **_TABLE** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MetadataNFT.uri(struct IMetadataNFT.TroveData) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MetadataNFT.attributes(struct IMetadataNFT.TroveData) (NodeID: 1)
  │   💬 Args: [_troveData]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: LibString.toHexString(address) (NodeID: 2)
  │ │   💬 Args: [_troveData._collToken]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toHexStringNoPrefix(address) (NodeID: 3)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 4)
  │ │   💬 Args: [_troveData._collAmount]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: LibString.toHexString(address) (NodeID: 5)
  │ │   💬 Args: [_troveData._boldToken]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: LibString.toHexStringNoPrefix(address) (NodeID: 6)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 7)
  │ │   💬 Args: [_troveData._debtAmount]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 8)
  │ │   💬 Args: [_troveData._interestRate]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MetadataNFT._status2Str(enum ITroveManager.Status) (NodeID: 9)
  │     💬 Args: [_troveData._status]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: json.formattedMetadata(string,string,string,string) (NodeID: 10)
      💬 Args: [name, description, renderSVGImage(_troveData), attr]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MetadataNFT.renderSVGImage(struct IMetadataNFT.TroveData) (NodeID: 17)
    │   💬 Args: [_troveData]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: svg._svg(string,string) (NodeID: 18)
    │     💬 Args: [baseSVG._svgProps(), string.concat(baseSVG._baseElements(assetReader), bauhaus._bauhaus(IERC20Metadata(_troveData._collToken).symbol(), _troveData._tokenId), dynamicTextComponents(_troveData))]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: baseSVG._svgProps() (NodeID: 20)
    │   │   💬 Args: [no args]
    │   │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 21)
    │   │ │   💬 Args: ["width", "300"]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 22)
    │   │ │   💬 Args: ["height", "484"]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 23)
    │   │ │   💬 Args: ["viewBox", "0 0 300 484"]
    │   │ │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 24)
    │   │     💬 Args: ["style", "background:none"]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: baseSVG._baseElements(contract FixedAssetReader) (NodeID: 25)
    │   │   💬 Args: [assetReader]
    │   │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: svg.rect(string) (NodeID: 26)
    │   │ │   💬 Args: [string.concat(svg.prop("fill", DARK_BLUE), svg.prop("rx", "8"), svg.prop("width", "300"), svg.prop("height", "484"))]
    │   │ │   👁️  Def: internal
    │   │ │ ├─ [6] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 28)
    │   │ │ │   💬 Args: ["fill", DARK_BLUE]
    │   │ │ │   👁️  Def: internal
    │   │ │ ├─ [6] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 29)
    │   │ │ │   💬 Args: ["rx", "8"]
    │   │ │ │   👁️  Def: internal
    │   │ │ ├─ [6] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 30)
    │   │ │ │   💬 Args: ["width", "300"]
    │   │ │ │   👁️  Def: internal
    │   │ │ ├─ [6] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 31)
    │   │ │ │   💬 Args: ["height", "484"]
    │   │ │ │   👁️  Def: internal
    │   │ │ └─ [6] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 27)
    │   │ │     💬 Args: ["rect", _props]
    │   │ │     👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: baseSVG._styles(contract FixedAssetReader) (NodeID: 32)
    │   │ │   💬 Args: [_assetReader]
    │   │ │   👁️  Def: private
    │   │ │ └─ [6] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 33)
    │   │ │     💬 Args: ["style", utils.NULL, string.concat("@font-face { font-family: \"Geist\"; src: url(\"data:font/woff2;utf-8;base64,", _assetReader.readAsset(bytes4(keccak256("geist"))), "\"); }")]
    │   │ │     👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: baseSVG._leverageLogo() (NodeID: 34)
    │   │ │   💬 Args: [no args]
    │   │ │   👁️  Def: internal
    │   │ │ ├─ [6] ⚙️ FUNCTION: svg.path(string,string) (NodeID: 35)
    │   │ │ │   💬 Args: ["M20.2 31.2C19.1 32.4 17.6 33 16 33L16 21C17.6 21 19.1 21.6 20.2 22.7C21.4 23.9 22 25.4 22 27C22 28.6 21.4 30.1 20.2 31.2Z", svg.prop("fill", STOIC_WHITE)]
    │   │ │ │   👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 38)
    │   │ │ │ │   💬 Args: ["fill", STOIC_WHITE]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ └─ [7] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 36)
    │   │ │ │     💬 Args: ["path", string.concat(prop("d", _d), _props)]
    │   │ │ │     👁️  Def: internal
    │   │ │ │   └─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 37)
    │   │ │ │       💬 Args: ["d", _d]
    │   │ │ │       👁️  Def: internal
    │   │ │ └─ [6] ⚙️ FUNCTION: svg.path(string,string) (NodeID: 39)
    │   │ │     💬 Args: ["M22 27C22 25.4 22.6 23.9 23.8 22.7C25 21.6 26.4 21 28 21V33C26.4 33 25 32.4 24 31.2C22.6 30.1 22 28.6 22 27Z", svg.prop("fill", STOIC_WHITE)]
    │   │ │     👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 42)
    │   │ │   │   💬 Args: ["fill", STOIC_WHITE]
    │   │ │   │   👁️  Def: internal
    │   │ │   └─ [7] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 40)
    │   │ │       💬 Args: ["path", string.concat(prop("d", _d), _props)]
    │   │ │       👁️  Def: internal
    │   │ │     └─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 41)
    │   │ │         💬 Args: ["d", _d]
    │   │ │         👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: baseSVG._boldLogo(contract FixedAssetReader) (NodeID: 43)
    │   │ │   💬 Args: [_assetReader]
    │   │ │   👁️  Def: internal
    │   │ │ └─ [6] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 44)
    │   │ │     💬 Args: ["image", string.concat(svg.prop("x", "264"), svg.prop("y", "373.5"), svg.prop("width", "20"), svg.prop("height", "20"), svg.prop("href", string.concat("data:image/svg+xml;base64,", _assetReader.readAsset(bytes4(keccak256("BOLD"))))))]
    │   │ │     👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 45)
    │   │ │   │   💬 Args: ["x", "264"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 46)
    │   │ │   │   💬 Args: ["y", "373.5"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 47)
    │   │ │   │   💬 Args: ["width", "20"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 48)
    │   │ │   │   💬 Args: ["height", "20"]
    │   │ │   │   👁️  Def: internal
    │   │ │   └─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 49)
    │   │ │       💬 Args: ["href", string.concat("data:image/svg+xml;base64,", _assetReader.readAsset(bytes4(keccak256("BOLD"))))]
    │   │ │       👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: baseSVG._staticTextEls() (NodeID: 50)
    │   │     💬 Args: [no args]
    │   │     👁️  Def: internal
    │   │   ├─ [6] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 51)
    │   │   │   💬 Args: [string.concat(GEIST, svg.prop("x", "16"), svg.prop("y", "358"), svg.prop("font-size", "14"), svg.prop("fill", "white")), "Collateral"]
    │   │   │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 53)
    │   │   │ │   💬 Args: ["x", "16"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 54)
    │   │   │ │   💬 Args: ["y", "358"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 55)
    │   │   │ │   💬 Args: ["font-size", "14"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 56)
    │   │   │ │   💬 Args: ["fill", "white"]
    │   │   │ │   👁️  Def: internal
    │   │   │ └─ [7] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 52)
    │   │   │     💬 Args: ["text", _props, _children]
    │   │   │     👁️  Def: internal
    │   │   ├─ [6] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 57)
    │   │   │   💬 Args: [string.concat(GEIST, svg.prop("x", "16"), svg.prop("y", "389"), svg.prop("font-size", "14"), svg.prop("fill", "white")), "Debt"]
    │   │   │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 59)
    │   │   │ │   💬 Args: ["x", "16"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 60)
    │   │   │ │   💬 Args: ["y", "389"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 61)
    │   │   │ │   💬 Args: ["font-size", "14"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 62)
    │   │   │ │   💬 Args: ["fill", "white"]
    │   │   │ │   👁️  Def: internal
    │   │   │ └─ [7] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 58)
    │   │   │     💬 Args: ["text", _props, _children]
    │   │   │     👁️  Def: internal
    │   │   ├─ [6] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 63)
    │   │   │   💬 Args: [string.concat(GEIST, svg.prop("x", "16"), svg.prop("y", "420"), svg.prop("font-size", "14"), svg.prop("fill", "white")), "Interest Rate"]
    │   │   │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 65)
    │   │   │ │   💬 Args: ["x", "16"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 66)
    │   │   │ │   💬 Args: ["y", "420"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 67)
    │   │   │ │   💬 Args: ["font-size", "14"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 68)
    │   │   │ │   💬 Args: ["fill", "white"]
    │   │   │ │   👁️  Def: internal
    │   │   │ └─ [7] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 64)
    │   │   │     💬 Args: ["text", _props, _children]
    │   │   │     👁️  Def: internal
    │   │   ├─ [6] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 69)
    │   │   │   💬 Args: [string.concat(GEIST, svg.prop("x", "265"), svg.prop("y", "422"), svg.prop("font-size", "20"), svg.prop("fill", "white")), "%"]
    │   │   │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 71)
    │   │   │ │   💬 Args: ["x", "265"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 72)
    │   │   │ │   💬 Args: ["y", "422"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 73)
    │   │   │ │   💬 Args: ["font-size", "20"]
    │   │   │ │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 74)
    │   │   │ │   💬 Args: ["fill", "white"]
    │   │   │ │   👁️  Def: internal
    │   │   │ └─ [7] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 70)
    │   │   │     💬 Args: ["text", _props, _children]
    │   │   │     👁️  Def: internal
    │   │   └─ [6] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 75)
    │   │       💬 Args: [string.concat(GEIST, svg.prop("x", "16"), svg.prop("y", "462"), svg.prop("font-size", "14"), svg.prop("fill", "white")), "Owner"]
    │   │       👁️  Def: internal
    │   │     ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 77)
    │   │     │   💬 Args: ["x", "16"]
    │   │     │   👁️  Def: internal
    │   │     ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 78)
    │   │     │   💬 Args: ["y", "462"]
    │   │     │   👁️  Def: internal
    │   │     ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 79)
    │   │     │   💬 Args: ["font-size", "14"]
    │   │     │   👁️  Def: internal
    │   │     ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 80)
    │   │     │   💬 Args: ["fill", "white"]
    │   │     │   👁️  Def: internal
    │   │     └─ [7] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 76)
    │   │         💬 Args: ["text", _props, _children]
    │   │         👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: bauhaus._bauhaus(string,uint256) (NodeID: 81)
    │   │   💬 Args: [IERC20Metadata(_troveData._collToken).symbol(), _troveData._tokenId]
    │   │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: bauhaus._img1(uint256) (NodeID: 82)
    │   │ │   💬 Args: [variant]
    │   │ │   👁️  Def: internal
    │   │ │ ├─ [6] ⚙️ FUNCTION: bauhaus._colors1(uint256) (NodeID: 83)
    │   │ │ │   💬 Args: [_variant]
    │   │ │ │   👁️  Def: internal
    │   │ │ ├─ [6] ⚙️ FUNCTION: bauhaus._rects1(struct bauhaus.COLORS) (NodeID: 84)
    │   │ │ │   💬 Args: [colors]
    │   │ │ │   👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 85)
    │   │ │ │ │   💬 Args: [string.concat(svg.prop("x", "16"), svg.prop("y", "55"), svg.prop("width", "268"), svg.prop("height", "268"), svg.prop("fill", DARK_BLUE))]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 87)
    │   │ │ │ │ │   💬 Args: ["x", "16"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 88)
    │   │ │ │ │ │   💬 Args: ["y", "55"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 89)
    │   │ │ │ │ │   💬 Args: ["width", "268"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 90)
    │   │ │ │ │ │   💬 Args: ["height", "268"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 91)
    │   │ │ │ │ │   💬 Args: ["fill", DARK_BLUE]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 86)
    │   │ │ │ │     💬 Args: ["rect", _props]
    │   │ │ │ │     👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 92)
    │   │ │ │ │   💬 Args: [string.concat(svg.prop("x", "128"), svg.prop("y", "55"), svg.prop("width", "156"), svg.prop("height", "268"), svg.prop("fill", _colorCode2Hex(_colors.rect1)))]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 94)
    │   │ │ │ │ │   💬 Args: ["x", "128"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 95)
    │   │ │ │ │ │   💬 Args: ["y", "55"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 96)
    │   │ │ │ │ │   💬 Args: ["width", "156"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 97)
    │   │ │ │ │ │   💬 Args: ["height", "268"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 98)
    │   │ │ │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.rect1)]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 99)
    │   │ │ │ │ │     💬 Args: [_colors.rect1]
    │   │ │ │ │ │     👁️  Def: private
    │   │ │ │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 93)
    │   │ │ │ │     💬 Args: ["rect", _props]
    │   │ │ │ │     👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 100)
    │   │ │ │ │   💬 Args: [string.concat(svg.prop("x", "228"), svg.prop("y", "55"), svg.prop("width", "56"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect2)))]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 102)
    │   │ │ │ │ │   💬 Args: ["x", "228"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 103)
    │   │ │ │ │ │   💬 Args: ["y", "55"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 104)
    │   │ │ │ │ │   💬 Args: ["width", "56"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 105)
    │   │ │ │ │ │   💬 Args: ["height", "56"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 106)
    │   │ │ │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.rect2)]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 107)
    │   │ │ │ │ │     💬 Args: [_colors.rect2]
    │   │ │ │ │ │     👁️  Def: private
    │   │ │ │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 101)
    │   │ │ │ │     💬 Args: ["rect", _props]
    │   │ │ │ │     👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 108)
    │   │ │ │ │   💬 Args: [string.concat(svg.prop("x", "16"), svg.prop("y", "111"), svg.prop("width", "134"), svg.prop("height", "156"), svg.prop("fill", _colorCode2Hex(_colors.rect3)))]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 110)
    │   │ │ │ │ │   💬 Args: ["x", "16"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 111)
    │   │ │ │ │ │   💬 Args: ["y", "111"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 112)
    │   │ │ │ │ │   💬 Args: ["width", "134"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 113)
    │   │ │ │ │ │   💬 Args: ["height", "156"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 114)
    │   │ │ │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.rect3)]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 115)
    │   │ │ │ │ │     💬 Args: [_colors.rect3]
    │   │ │ │ │ │     👁️  Def: private
    │   │ │ │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 109)
    │   │ │ │ │     💬 Args: ["rect", _props]
    │   │ │ │ │     👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 116)
    │   │ │ │ │   💬 Args: [string.concat(svg.prop("x", "16"), svg.prop("y", "267"), svg.prop("width", "112"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect4)))]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 118)
    │   │ │ │ │ │   💬 Args: ["x", "16"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 119)
    │   │ │ │ │ │   💬 Args: ["y", "267"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 120)
    │   │ │ │ │ │   💬 Args: ["width", "112"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 121)
    │   │ │ │ │ │   💬 Args: ["height", "56"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 122)
    │   │ │ │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.rect4)]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 123)
    │   │ │ │ │ │     💬 Args: [_colors.rect4]
    │   │ │ │ │ │     👁️  Def: private
    │   │ │ │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 117)
    │   │ │ │ │     💬 Args: ["rect", _props]
    │   │ │ │ │     👁️  Def: internal
    │   │ │ │ └─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 124)
    │   │ │ │     💬 Args: [string.concat(svg.prop("x", "228"), svg.prop("y", "267"), svg.prop("width", "56"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect5)))]
    │   │ │ │     👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 126)
    │   │ │ │   │   💬 Args: ["x", "228"]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 127)
    │   │ │ │   │   💬 Args: ["y", "267"]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 128)
    │   │ │ │   │   💬 Args: ["width", "56"]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 129)
    │   │ │ │   │   💬 Args: ["height", "56"]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 130)
    │   │ │ │   │   💬 Args: ["fill", _colorCode2Hex(_colors.rect5)]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 131)
    │   │ │ │   │     💬 Args: [_colors.rect5]
    │   │ │ │   │     👁️  Def: private
    │   │ │ │   └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 125)
    │   │ │ │       💬 Args: ["rect", _props]
    │   │ │ │       👁️  Def: internal
    │   │ │ ├─ [6] ⚙️ FUNCTION: bauhaus._polygons1(struct bauhaus.COLORS) (NodeID: 132)
    │   │ │ │   💬 Args: [colors]
    │   │ │ │   👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.polygon(string) (NodeID: 133)
    │   │ │ │ │   💬 Args: [string.concat(svg.prop("points", "16,55 72,55 16,111"), svg.prop("fill", _colorCode2Hex(_colors.poly)))]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 135)
    │   │ │ │ │ │   💬 Args: ["points", "16,55 72,55 16,111"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 136)
    │   │ │ │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.poly)]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 137)
    │   │ │ │ │ │     💬 Args: [_colors.poly]
    │   │ │ │ │ │     👁️  Def: private
    │   │ │ │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 134)
    │   │ │ │ │     💬 Args: ["polygon", _props]
    │   │ │ │ │     👁️  Def: internal
    │   │ │ │ └─ [7] ⚙️ FUNCTION: svg.polygon(string) (NodeID: 138)
    │   │ │ │     💬 Args: [string.concat(svg.prop("points", "72,55 128,55 72,111"), svg.prop("fill", _colorCode2Hex(_colors.poly)))]
    │   │ │ │     👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 140)
    │   │ │ │   │   💬 Args: ["points", "72,55 128,55 72,111"]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 141)
    │   │ │ │   │   💬 Args: ["fill", _colorCode2Hex(_colors.poly)]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 142)
    │   │ │ │   │     💬 Args: [_colors.poly]
    │   │ │ │   │     👁️  Def: private
    │   │ │ │   └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 139)
    │   │ │ │       💬 Args: ["polygon", _props]
    │   │ │ │       👁️  Def: internal
    │   │ │ └─ [6] ⚙️ FUNCTION: bauhaus._circles1(struct bauhaus.COLORS) (NodeID: 143)
    │   │ │     💬 Args: [colors]
    │   │ │     👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.circle(string) (NodeID: 144)
    │   │ │   │   💬 Args: [string.concat(svg.prop("cx", "150"), svg.prop("cy", "189"), svg.prop("r", "78"), svg.prop("fill", _colorCode2Hex(_colors.circle1)))]
    │   │ │   │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 146)
    │   │ │   │ │   💬 Args: ["cx", "150"]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 147)
    │   │ │   │ │   💬 Args: ["cy", "189"]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 148)
    │   │ │   │ │   💬 Args: ["r", "78"]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 149)
    │   │ │   │ │   💬 Args: ["fill", _colorCode2Hex(_colors.circle1)]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 150)
    │   │ │   │ │     💬 Args: [_colors.circle1]
    │   │ │   │ │     👁️  Def: private
    │   │ │   │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 145)
    │   │ │   │     💬 Args: ["circle", _props]
    │   │ │   │     👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.circle(string) (NodeID: 151)
    │   │ │   │   💬 Args: [string.concat(svg.prop("cx", "228"), svg.prop("cy", "295"), svg.prop("r", "28"), svg.prop("fill", _colorCode2Hex(_colors.circle2)))]
    │   │ │   │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 153)
    │   │ │   │ │   💬 Args: ["cx", "228"]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 154)
    │   │ │   │ │   💬 Args: ["cy", "295"]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 155)
    │   │ │   │ │   💬 Args: ["r", "28"]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 156)
    │   │ │   │ │   💬 Args: ["fill", _colorCode2Hex(_colors.circle2)]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 157)
    │   │ │   │ │     💬 Args: [_colors.circle2]
    │   │ │   │ │     👁️  Def: private
    │   │ │   │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 152)
    │   │ │   │     💬 Args: ["circle", _props]
    │   │ │   │     👁️  Def: internal
    │   │ │   └─ [7] ⚙️ FUNCTION: svg.path(string,string) (NodeID: 158)
    │   │ │       💬 Args: ["M228 267C220.574 267 213.452 269.95 208.201 275.201C202.95 280.452 200 287.574 200 295C200 302.426 202.95 309.548 208.201 314.799C213.452 320.05 220.574 323 228 323L228 267Z", svg.prop("fill", _colorCode2Hex(_colors.circle3))]
    │   │ │       👁️  Def: internal
    │   │ │     ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 161)
    │   │ │     │   💬 Args: ["fill", _colorCode2Hex(_colors.circle3)]
    │   │ │     │   👁️  Def: internal
    │   │ │     │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 162)
    │   │ │     │     💬 Args: [_colors.circle3]
    │   │ │     │     👁️  Def: private
    │   │ │     └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 159)
    │   │ │         💬 Args: ["path", string.concat(prop("d", _d), _props)]
    │   │ │         👁️  Def: internal
    │   │ │       └─ [9] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 160)
    │   │ │           💬 Args: ["d", _d]
    │   │ │           👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: bauhaus._img2(uint256) (NodeID: 163)
    │   │ │   💬 Args: [variant]
    │   │ │   👁️  Def: internal
    │   │ │ ├─ [6] ⚙️ FUNCTION: bauhaus._colors2(uint256) (NodeID: 164)
    │   │ │ │   💬 Args: [_variant]
    │   │ │ │   👁️  Def: internal
    │   │ │ ├─ [6] ⚙️ FUNCTION: bauhaus._rects2(struct bauhaus.COLORS) (NodeID: 165)
    │   │ │ │   💬 Args: [colors]
    │   │ │ │   👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 166)
    │   │ │ │ │   💬 Args: [string.concat(svg.prop("x", "16"), svg.prop("y", "55"), svg.prop("width", "268"), svg.prop("height", "268"), svg.prop("fill", DARK_BLUE))]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 168)
    │   │ │ │ │ │   💬 Args: ["x", "16"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 169)
    │   │ │ │ │ │   💬 Args: ["y", "55"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 170)
    │   │ │ │ │ │   💬 Args: ["width", "268"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 171)
    │   │ │ │ │ │   💬 Args: ["height", "268"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 172)
    │   │ │ │ │ │   💬 Args: ["fill", DARK_BLUE]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 167)
    │   │ │ │ │     💬 Args: ["rect", _props]
    │   │ │ │ │     👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 173)
    │   │ │ │ │   💬 Args: [string.concat(svg.prop("x", "128"), svg.prop("y", "55"), svg.prop("width", "156"), svg.prop("height", "156"), svg.prop("fill", _colorCode2Hex(_colors.rect1)))]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 175)
    │   │ │ │ │ │   💬 Args: ["x", "128"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 176)
    │   │ │ │ │ │   💬 Args: ["y", "55"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 177)
    │   │ │ │ │ │   💬 Args: ["width", "156"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 178)
    │   │ │ │ │ │   💬 Args: ["height", "156"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 179)
    │   │ │ │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.rect1)]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 180)
    │   │ │ │ │ │     💬 Args: [_colors.rect1]
    │   │ │ │ │ │     👁️  Def: private
    │   │ │ │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 174)
    │   │ │ │ │     💬 Args: ["rect", _props]
    │   │ │ │ │     👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 181)
    │   │ │ │ │   💬 Args: [string.concat(svg.prop("x", "16"), svg.prop("y", "111"), svg.prop("width", "134"), svg.prop("height", "100"), svg.prop("fill", _colorCode2Hex(_colors.rect2)))]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 183)
    │   │ │ │ │ │   💬 Args: ["x", "16"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 184)
    │   │ │ │ │ │   💬 Args: ["y", "111"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 185)
    │   │ │ │ │ │   💬 Args: ["width", "134"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 186)
    │   │ │ │ │ │   💬 Args: ["height", "100"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 187)
    │   │ │ │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.rect2)]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 188)
    │   │ │ │ │ │     💬 Args: [_colors.rect2]
    │   │ │ │ │ │     👁️  Def: private
    │   │ │ │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 182)
    │   │ │ │ │     💬 Args: ["rect", _props]
    │   │ │ │ │     👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 189)
    │   │ │ │ │   💬 Args: [string.concat(svg.prop("x", "16"), svg.prop("y", "211"), svg.prop("width", "212"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect3)))]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 191)
    │   │ │ │ │ │   💬 Args: ["x", "16"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 192)
    │   │ │ │ │ │   💬 Args: ["y", "211"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 193)
    │   │ │ │ │ │   💬 Args: ["width", "212"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 194)
    │   │ │ │ │ │   💬 Args: ["height", "56"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 195)
    │   │ │ │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.rect3)]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 196)
    │   │ │ │ │ │     💬 Args: [_colors.rect3]
    │   │ │ │ │ │     👁️  Def: private
    │   │ │ │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 190)
    │   │ │ │ │     💬 Args: ["rect", _props]
    │   │ │ │ │     👁️  Def: internal
    │   │ │ │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 197)
    │   │ │ │ │   💬 Args: [string.concat(svg.prop("x", "72"), svg.prop("y", "267"), svg.prop("width", "78"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect4)))]
    │   │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 199)
    │   │ │ │ │ │   💬 Args: ["x", "72"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 200)
    │   │ │ │ │ │   💬 Args: ["y", "267"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 201)
    │   │ │ │ │ │   💬 Args: ["width", "78"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 202)
    │   │ │ │ │ │   💬 Args: ["height", "56"]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 203)
    │   │ │ │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.rect4)]
    │   │ │ │ │ │   👁️  Def: internal
    │   │ │ │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 204)
    │   │ │ │ │ │     💬 Args: [_colors.rect4]
    │   │ │ │ │ │     👁️  Def: private
    │   │ │ │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 198)
    │   │ │ │ │     💬 Args: ["rect", _props]
    │   │ │ │ │     👁️  Def: internal
    │   │ │ │ └─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 205)
    │   │ │ │     💬 Args: [string.concat(svg.prop("x", "150"), svg.prop("y", "267"), svg.prop("width", "134"), svg.prop("height", "56"), svg.prop("fill", _colorCode2Hex(_colors.rect5)))]
    │   │ │ │     👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 207)
    │   │ │ │   │   💬 Args: ["x", "150"]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 208)
    │   │ │ │   │   💬 Args: ["y", "267"]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 209)
    │   │ │ │   │   💬 Args: ["width", "134"]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 210)
    │   │ │ │   │   💬 Args: ["height", "56"]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 211)
    │   │ │ │   │   💬 Args: ["fill", _colorCode2Hex(_colors.rect5)]
    │   │ │ │   │   👁️  Def: internal
    │   │ │ │   │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 212)
    │   │ │ │   │     💬 Args: [_colors.rect5]
    │   │ │ │   │     👁️  Def: private
    │   │ │ │   └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 206)
    │   │ │ │       💬 Args: ["rect", _props]
    │   │ │ │       👁️  Def: internal
    │   │ │ └─ [6] ⚙️ FUNCTION: bauhaus._circles2(struct bauhaus.COLORS) (NodeID: 213)
    │   │ │     💬 Args: [colors]
    │   │ │     👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.circle(string) (NodeID: 214)
    │   │ │   │   💬 Args: [string.concat(svg.prop("cx", "44"), svg.prop("cy", "295"), svg.prop("r", "28"), svg.prop("fill", _colorCode2Hex(_colors.circle1)))]
    │   │ │   │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 216)
    │   │ │   │ │   💬 Args: ["cx", "44"]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 217)
    │   │ │   │ │   💬 Args: ["cy", "295"]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 218)
    │   │ │   │ │   💬 Args: ["r", "28"]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 219)
    │   │ │   │ │   💬 Args: ["fill", _colorCode2Hex(_colors.circle1)]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 220)
    │   │ │   │ │     💬 Args: [_colors.circle1]
    │   │ │   │ │     👁️  Def: private
    │   │ │   │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 215)
    │   │ │   │     💬 Args: ["circle", _props]
    │   │ │   │     👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.path(string,string) (NodeID: 221)
    │   │ │   │   💬 Args: ["M16 55C16 62.4 17.4 69.6 20.3 76.4C23.1 83.2 27.2 89.4 32.4 94.6C37.6 99.8 43.8 103.9 50.6 106.7C57.4 109.6 64.6 111 72 111C79.4 111 86.6 109.6 93.4 106.7C100.2 103.9 106.4 99.8 111.6 94.6C116.8 89.4 120.9 83.2 123.7 76.4C126.6 69.6 128 62.4 128 55L16 55Z", svg.prop("fill", _colorCode2Hex(_colors.circle2))]
    │   │ │   │   👁️  Def: internal
    │   │ │   │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 224)
    │   │ │   │ │   💬 Args: ["fill", _colorCode2Hex(_colors.circle2)]
    │   │ │   │ │   👁️  Def: internal
    │   │ │   │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 225)
    │   │ │   │ │     💬 Args: [_colors.circle2]
    │   │ │   │ │     👁️  Def: private
    │   │ │   │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 222)
    │   │ │   │     💬 Args: ["path", string.concat(prop("d", _d), _props)]
    │   │ │   │     👁️  Def: internal
    │   │ │   │   └─ [9] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 223)
    │   │ │   │       💬 Args: ["d", _d]
    │   │ │   │       👁️  Def: internal
    │   │ │   └─ [7] ⚙️ FUNCTION: svg.path(string,string) (NodeID: 226)
    │   │ │       💬 Args: ["M284 211C284 190.3 275.8 170.5 261.2 155.8C246.5 141.2 226.7 133 206 133C185.3 133 165.5 141.2 150.9 155.86C136.2 170.5 128 190.3 128 211L284 211Z", svg.prop("fill", _colorCode2Hex(_colors.circle3))]
    │   │ │       👁️  Def: internal
    │   │ │     ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 229)
    │   │ │     │   💬 Args: ["fill", _colorCode2Hex(_colors.circle3)]
    │   │ │     │   👁️  Def: internal
    │   │ │     │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 230)
    │   │ │     │     💬 Args: [_colors.circle3]
    │   │ │     │     👁️  Def: private
    │   │ │     └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 227)
    │   │ │         💬 Args: ["path", string.concat(prop("d", _d), _props)]
    │   │ │         👁️  Def: internal
    │   │ │       └─ [9] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 228)
    │   │ │           💬 Args: ["d", _d]
    │   │ │           👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: bauhaus._img3(uint256) (NodeID: 231)
    │   │     💬 Args: [variant]
    │   │     👁️  Def: internal
    │   │   ├─ [6] ⚙️ FUNCTION: bauhaus._colors3(uint256) (NodeID: 232)
    │   │   │   💬 Args: [_variant]
    │   │   │   👁️  Def: internal
    │   │   ├─ [6] ⚙️ FUNCTION: bauhaus._rects3(struct bauhaus.COLORS) (NodeID: 233)
    │   │   │   💬 Args: [colors]
    │   │   │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 234)
    │   │   │ │   💬 Args: [string.concat(svg.prop("x", "16"), svg.prop("y", "55"), svg.prop("width", "268"), svg.prop("height", "268"), svg.prop("fill", DARK_BLUE))]
    │   │   │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 236)
    │   │   │ │ │   💬 Args: ["x", "16"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 237)
    │   │   │ │ │   💬 Args: ["y", "55"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 238)
    │   │   │ │ │   💬 Args: ["width", "268"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 239)
    │   │   │ │ │   💬 Args: ["height", "268"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 240)
    │   │   │ │ │   💬 Args: ["fill", DARK_BLUE]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 235)
    │   │   │ │     💬 Args: ["rect", _props]
    │   │   │ │     👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 241)
    │   │   │ │   💬 Args: [string.concat(svg.prop("x", "16"), svg.prop("y", "205"), svg.prop("width", "75"), svg.prop("height", "118"), svg.prop("fill", _colorCode2Hex(_colors.rect1)))]
    │   │   │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 243)
    │   │   │ │ │   💬 Args: ["x", "16"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 244)
    │   │   │ │ │   💬 Args: ["y", "205"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 245)
    │   │   │ │ │   💬 Args: ["width", "75"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 246)
    │   │   │ │ │   💬 Args: ["height", "118"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 247)
    │   │   │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.rect1)]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 248)
    │   │   │ │ │     💬 Args: [_colors.rect1]
    │   │   │ │ │     👁️  Def: private
    │   │   │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 242)
    │   │   │ │     💬 Args: ["rect", _props]
    │   │   │ │     👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 249)
    │   │   │ │   💬 Args: [string.concat(svg.prop("x", "91"), svg.prop("y", "205"), svg.prop("width", "136"), svg.prop("height", "59"), svg.prop("fill", _colorCode2Hex(_colors.rect2)))]
    │   │   │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 251)
    │   │   │ │ │   💬 Args: ["x", "91"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 252)
    │   │   │ │ │   💬 Args: ["y", "205"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 253)
    │   │   │ │ │   💬 Args: ["width", "136"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 254)
    │   │   │ │ │   💬 Args: ["height", "59"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 255)
    │   │   │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.rect2)]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 256)
    │   │   │ │ │     💬 Args: [_colors.rect2]
    │   │   │ │ │     👁️  Def: private
    │   │   │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 250)
    │   │   │ │     💬 Args: ["rect", _props]
    │   │   │ │     👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 257)
    │   │   │ │   💬 Args: [string.concat(svg.prop("x", "166"), svg.prop("y", "180"), svg.prop("width", "118"), svg.prop("height", "25"), svg.prop("fill", _colorCode2Hex(_colors.rect3)))]
    │   │   │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 259)
    │   │   │ │ │   💬 Args: ["x", "166"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 260)
    │   │   │ │ │   💬 Args: ["y", "180"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 261)
    │   │   │ │ │   💬 Args: ["width", "118"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 262)
    │   │   │ │ │   💬 Args: ["height", "25"]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 263)
    │   │   │ │ │   💬 Args: ["fill", _colorCode2Hex(_colors.rect3)]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 264)
    │   │   │ │ │     💬 Args: [_colors.rect3]
    │   │   │ │ │     👁️  Def: private
    │   │   │ │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 258)
    │   │   │ │     💬 Args: ["rect", _props]
    │   │   │ │     👁️  Def: internal
    │   │   │ └─ [7] ⚙️ FUNCTION: svg.rect(string) (NodeID: 265)
    │   │   │     💬 Args: [string.concat(svg.prop("x", "166"), svg.prop("y", "55"), svg.prop("width", "118"), svg.prop("height", "126"), svg.prop("fill", _colorCode2Hex(_colors.rect4)))]
    │   │   │     👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 267)
    │   │   │   │   💬 Args: ["x", "166"]
    │   │   │   │   👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 268)
    │   │   │   │   💬 Args: ["y", "55"]
    │   │   │   │   👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 269)
    │   │   │   │   💬 Args: ["width", "118"]
    │   │   │   │   👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 270)
    │   │   │   │   💬 Args: ["height", "126"]
    │   │   │   │   👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 271)
    │   │   │   │   💬 Args: ["fill", _colorCode2Hex(_colors.rect4)]
    │   │   │   │   👁️  Def: internal
    │   │   │   │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 272)
    │   │   │   │     💬 Args: [_colors.rect4]
    │   │   │   │     👁️  Def: private
    │   │   │   └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 266)
    │   │   │       💬 Args: ["rect", _props]
    │   │   │       👁️  Def: internal
    │   │   └─ [6] ⚙️ FUNCTION: bauhaus._circles3(struct bauhaus.COLORS) (NodeID: 273)
    │   │       💬 Args: [colors]
    │   │       👁️  Def: internal
    │   │     ├─ [7] ⚙️ FUNCTION: svg.circle(string) (NodeID: 274)
    │   │     │   💬 Args: [string.concat(svg.prop("cx", "91"), svg.prop("cy", "130"), svg.prop("r", "75"), svg.prop("fill", _colorCode2Hex(_colors.circle1)))]
    │   │     │   👁️  Def: internal
    │   │     │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 276)
    │   │     │ │   💬 Args: ["cx", "91"]
    │   │     │ │   👁️  Def: internal
    │   │     │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 277)
    │   │     │ │   💬 Args: ["cy", "130"]
    │   │     │ │   👁️  Def: internal
    │   │     │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 278)
    │   │     │ │   💬 Args: ["r", "75"]
    │   │     │ │   👁️  Def: internal
    │   │     │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 279)
    │   │     │ │   💬 Args: ["fill", _colorCode2Hex(_colors.circle1)]
    │   │     │ │   👁️  Def: internal
    │   │     │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 280)
    │   │     │ │     💬 Args: [_colors.circle1]
    │   │     │ │     👁️  Def: private
    │   │     │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 275)
    │   │     │     💬 Args: ["circle", _props]
    │   │     │     👁️  Def: internal
    │   │     ├─ [7] ⚙️ FUNCTION: svg.path(string,string) (NodeID: 281)
    │   │     │   💬 Args: ["M284 264 166 264 166 263C166 232 193 206 225 205C258 206 284 232 284 264C284 264 284 264 284 264Z", svg.prop("fill", _colorCode2Hex(_colors.circle2))]
    │   │     │   👁️  Def: internal
    │   │     │ ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 284)
    │   │     │ │   💬 Args: ["fill", _colorCode2Hex(_colors.circle2)]
    │   │     │ │   👁️  Def: internal
    │   │     │ │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 285)
    │   │     │ │     💬 Args: [_colors.circle2]
    │   │     │ │     👁️  Def: private
    │   │     │ └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 282)
    │   │     │     💬 Args: ["path", string.concat(prop("d", _d), _props)]
    │   │     │     👁️  Def: internal
    │   │     │   └─ [9] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 283)
    │   │     │       💬 Args: ["d", _d]
    │   │     │       👁️  Def: internal
    │   │     └─ [7] ⚙️ FUNCTION: svg.path(string,string) (NodeID: 286)
    │   │         💬 Args: ["M284 323 166 323 166 323C166 290 193 265 225 264C258 265 284 290 284 323C284 323 284 323 284 323Z", svg.prop("fill", _colorCode2Hex(_colors.circle3))]
    │   │         👁️  Def: internal
    │   │       ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 289)
    │   │       │   💬 Args: ["fill", _colorCode2Hex(_colors.circle3)]
    │   │       │   👁️  Def: internal
    │   │       │ └─ [9] ⚙️ FUNCTION: bauhaus._colorCode2Hex(enum bauhaus.colorCode) (NodeID: 290)
    │   │       │     💬 Args: [_colors.circle3]
    │   │       │     👁️  Def: private
    │   │       └─ [8] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 287)
    │   │           💬 Args: ["path", string.concat(prop("d", _d), _props)]
    │   │           👁️  Def: internal
    │   │         └─ [9] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 288)
    │   │             💬 Args: ["d", _d]
    │   │             👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: MetadataNFT.dynamicTextComponents(struct IMetadataNFT.TroveData) (NodeID: 291)
    │   │   💬 Args: [_troveData]
    │   │   👁️  Def: public
    │   │ ├─ [5] ⚙️ FUNCTION: LibString.toHexString(uint256) (NodeID: 292)
    │   │ │   💬 Args: [_troveData._tokenId]
    │   │ │   👁️  Def: internal
    │   │ │ └─ [6] ⚙️ FUNCTION: LibString.toHexStringNoPrefix(uint256) (NodeID: 293)
    │   │ │     💬 Args: [value]
    │   │ │     👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 294)
    │   │ │   💬 Args: [id, 0, 6]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 295)
    │   │ │   💬 Args: [id, 38, 42]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: baseSVG._formattedIdEl(string) (NodeID: 296)
    │   │ │   💬 Args: [id]
    │   │ │   👁️  Def: internal
    │   │ │ └─ [6] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 297)
    │   │ │     💬 Args: [string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", "284"), svg.prop("y", "33"), svg.prop("font-size", "14"), svg.prop("fill", "white")), _id]
    │   │ │     👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 299)
    │   │ │   │   💬 Args: ["text-anchor", "end"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 300)
    │   │ │   │   💬 Args: ["x", "284"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 301)
    │   │ │   │   💬 Args: ["y", "33"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 302)
    │   │ │   │   💬 Args: ["font-size", "14"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 303)
    │   │ │   │   💬 Args: ["fill", "white"]
    │   │ │   │   👁️  Def: internal
    │   │ │   └─ [7] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 298)
    │   │ │       💬 Args: ["text", _props, _children]
    │   │ │       👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: baseSVG._formattedAddressEl(address) (NodeID: 304)
    │   │ │   💬 Args: [_troveData._owner]
    │   │ │   👁️  Def: internal
    │   │ │ └─ [6] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 305)
    │   │ │     💬 Args: [string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", "284"), svg.prop("y", "462"), svg.prop("font-size", "14"), svg.prop("fill", "white")), string.concat(LibString.slice(LibString.toHexStringChecksummed(_address), 0, 6), "...", LibString.slice(LibString.toHexStringChecksummed(_address), 38, 42))]
    │   │ │     👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 307)
    │   │ │   │   💬 Args: ["text-anchor", "end"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 308)
    │   │ │   │   💬 Args: ["x", "284"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 309)
    │   │ │   │   💬 Args: ["y", "462"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 310)
    │   │ │   │   💬 Args: ["font-size", "14"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 311)
    │   │ │   │   💬 Args: ["fill", "white"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 312)
    │   │ │   │   💬 Args: [LibString.toHexStringChecksummed(_address), 0, 6]
    │   │ │   │   👁️  Def: internal
    │   │ │   │ └─ [8] ⚙️ FUNCTION: LibString.toHexStringChecksummed(address) (NodeID: 313)
    │   │ │   │     💬 Args: [_address]
    │   │ │   │     👁️  Def: internal
    │   │ │   │   └─ [9] ⚙️ FUNCTION: LibString.toHexString(address) (NodeID: 314)
    │   │ │   │       💬 Args: [value]
    │   │ │   │       👁️  Def: internal
    │   │ │   │     └─ [10] ⚙️ FUNCTION: LibString.toHexStringNoPrefix(address) (NodeID: 315)
    │   │ │   │         💬 Args: [value]
    │   │ │   │         👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 316)
    │   │ │   │   💬 Args: [LibString.toHexStringChecksummed(_address), 38, 42]
    │   │ │   │   👁️  Def: internal
    │   │ │   │ └─ [8] ⚙️ FUNCTION: LibString.toHexStringChecksummed(address) (NodeID: 317)
    │   │ │   │     💬 Args: [_address]
    │   │ │   │     👁️  Def: internal
    │   │ │   │   └─ [9] ⚙️ FUNCTION: LibString.toHexString(address) (NodeID: 318)
    │   │ │   │       💬 Args: [value]
    │   │ │   │       👁️  Def: internal
    │   │ │   │     └─ [10] ⚙️ FUNCTION: LibString.toHexStringNoPrefix(address) (NodeID: 319)
    │   │ │   │         💬 Args: [value]
    │   │ │   │         👁️  Def: internal
    │   │ │   └─ [7] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 306)
    │   │ │       💬 Args: ["text", _props, _children]
    │   │ │       👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: baseSVG._collLogo(string,contract FixedAssetReader) (NodeID: 320)
    │   │ │   💬 Args: [IERC20Metadata(_troveData._collToken).symbol(), assetReader]
    │   │ │   👁️  Def: internal
    │   │ │ └─ [6] ⚙️ FUNCTION: svg.el(string,string) (NodeID: 321)
    │   │ │     💬 Args: ["image", string.concat(svg.prop("x", "264"), svg.prop("y", "342.5"), svg.prop("width", "20"), svg.prop("height", "20"), svg.prop("href", string.concat("data:image/svg+xml;base64,", _assetReader.readAsset(bytes4(keccak256(bytes(_collName)))))))]
    │   │ │     👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 322)
    │   │ │   │   💬 Args: ["x", "264"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 323)
    │   │ │   │   💬 Args: ["y", "342.5"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 324)
    │   │ │   │   💬 Args: ["width", "20"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 325)
    │   │ │   │   💬 Args: ["height", "20"]
    │   │ │   │   👁️  Def: internal
    │   │ │   └─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 326)
    │   │ │       💬 Args: ["href", string.concat("data:image/svg+xml;base64,", _assetReader.readAsset(bytes4(keccak256(bytes(_collName)))))]
    │   │ │       👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: baseSVG._statusEl(string) (NodeID: 327)
    │   │ │   💬 Args: [_status2Str(_troveData._status)]
    │   │ │   👁️  Def: internal
    │   │ │ ├─ [6] ⚙️ FUNCTION: MetadataNFT._status2Str(enum ITroveManager.Status) (NodeID: 334)
    │   │ │ │   💬 Args: [_troveData._status]
    │   │ │ │   👁️  Def: internal
    │   │ │ └─ [6] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 328)
    │   │ │     💬 Args: [string.concat(GEIST, svg.prop("x", "40"), svg.prop("y", "33"), svg.prop("font-size", "14"), svg.prop("fill", "white")), _status]
    │   │ │     👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 330)
    │   │ │   │   💬 Args: ["x", "40"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 331)
    │   │ │   │   💬 Args: ["y", "33"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 332)
    │   │ │   │   💬 Args: ["font-size", "14"]
    │   │ │   │   👁️  Def: internal
    │   │ │   ├─ [7] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 333)
    │   │ │   │   💬 Args: ["fill", "white"]
    │   │ │   │   👁️  Def: internal
    │   │ │   └─ [7] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 329)
    │   │ │       💬 Args: ["text", _props, _children]
    │   │ │       👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: baseSVG._dynamicTextEls(uint256,uint256,uint256) (NodeID: 335)
    │   │     💬 Args: [_troveData._debtAmount, _troveData._collAmount, _troveData._interestRate]
    │   │     👁️  Def: internal
    │   │   ├─ [6] ⚙️ FUNCTION: baseSVG._formattedDynamicEl(string,uint256,uint256) (NodeID: 336)
    │   │   │   💬 Args: [numUtils.toLocaleString(_coll, 18, 4), 256, 360]
    │   │   │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 346)
    │   │   │ │   💬 Args: [_coll, 18, 4]
    │   │   │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 347)
    │   │   │ │ │   💬 Args: [LibString.toString(whole)]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ │ └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 348)
    │   │   │ │ │     💬 Args: [whole]
    │   │   │ │ │     👁️  Def: internal
    │   │   │ │ └─ [8] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 349)
    │   │   │ │     💬 Args: [LibString.toString(fraction), 0, _precision]
    │   │   │ │     👁️  Def: internal
    │   │   │ │   └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 350)
    │   │   │ │       💬 Args: [fraction]
    │   │   │ │       👁️  Def: internal
    │   │   │ └─ [7] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 337)
    │   │   │     💬 Args: [string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", LibString.toString(_x)), svg.prop("y", LibString.toString(_y)), svg.prop("font-size", "20"), svg.prop("fill", "white")), _value]
    │   │   │     👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 339)
    │   │   │   │   💬 Args: ["text-anchor", "end"]
    │   │   │   │   👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 340)
    │   │   │   │   💬 Args: ["x", LibString.toString(_x)]
    │   │   │   │   👁️  Def: internal
    │   │   │   │ └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 341)
    │   │   │   │     💬 Args: [_x]
    │   │   │   │     👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 342)
    │   │   │   │   💬 Args: ["y", LibString.toString(_y)]
    │   │   │   │   👁️  Def: internal
    │   │   │   │ └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 343)
    │   │   │   │     💬 Args: [_y]
    │   │   │   │     👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 344)
    │   │   │   │   💬 Args: ["font-size", "20"]
    │   │   │   │   👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 345)
    │   │   │   │   💬 Args: ["fill", "white"]
    │   │   │   │   👁️  Def: internal
    │   │   │   └─ [8] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 338)
    │   │   │       💬 Args: ["text", _props, _children]
    │   │   │       👁️  Def: internal
    │   │   ├─ [6] ⚙️ FUNCTION: baseSVG._formattedDynamicEl(string,uint256,uint256) (NodeID: 351)
    │   │   │   💬 Args: [numUtils.toLocaleString(_debt, 18, 2), 256, 391]
    │   │   │   👁️  Def: internal
    │   │   │ ├─ [7] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 361)
    │   │   │ │   💬 Args: [_debt, 18, 2]
    │   │   │ │   👁️  Def: internal
    │   │   │ │ ├─ [8] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 362)
    │   │   │ │ │   💬 Args: [LibString.toString(whole)]
    │   │   │ │ │   👁️  Def: internal
    │   │   │ │ │ └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 363)
    │   │   │ │ │     💬 Args: [whole]
    │   │   │ │ │     👁️  Def: internal
    │   │   │ │ └─ [8] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 364)
    │   │   │ │     💬 Args: [LibString.toString(fraction), 0, _precision]
    │   │   │ │     👁️  Def: internal
    │   │   │ │   └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 365)
    │   │   │ │       💬 Args: [fraction]
    │   │   │ │       👁️  Def: internal
    │   │   │ └─ [7] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 352)
    │   │   │     💬 Args: [string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", LibString.toString(_x)), svg.prop("y", LibString.toString(_y)), svg.prop("font-size", "20"), svg.prop("fill", "white")), _value]
    │   │   │     👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 354)
    │   │   │   │   💬 Args: ["text-anchor", "end"]
    │   │   │   │   👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 355)
    │   │   │   │   💬 Args: ["x", LibString.toString(_x)]
    │   │   │   │   👁️  Def: internal
    │   │   │   │ └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 356)
    │   │   │   │     💬 Args: [_x]
    │   │   │   │     👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 357)
    │   │   │   │   💬 Args: ["y", LibString.toString(_y)]
    │   │   │   │   👁️  Def: internal
    │   │   │   │ └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 358)
    │   │   │   │     💬 Args: [_y]
    │   │   │   │     👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 359)
    │   │   │   │   💬 Args: ["font-size", "20"]
    │   │   │   │   👁️  Def: internal
    │   │   │   ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 360)
    │   │   │   │   💬 Args: ["fill", "white"]
    │   │   │   │   👁️  Def: internal
    │   │   │   └─ [8] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 353)
    │   │   │       💬 Args: ["text", _props, _children]
    │   │   │       👁️  Def: internal
    │   │   └─ [6] ⚙️ FUNCTION: baseSVG._formattedDynamicEl(string,uint256,uint256) (NodeID: 366)
    │   │       💬 Args: [numUtils.toLocaleString(_annualInterestRate, 16, 2), 256, 422]
    │   │       👁️  Def: internal
    │   │     ├─ [7] ⚙️ FUNCTION: numUtils.toLocaleString(uint256,uint8,uint8) (NodeID: 376)
    │   │     │   💬 Args: [_annualInterestRate, 16, 2]
    │   │     │   👁️  Def: internal
    │   │     │ ├─ [8] ⚙️ FUNCTION: numUtils.toLocale(string) (NodeID: 377)
    │   │     │ │   💬 Args: [LibString.toString(whole)]
    │   │     │ │   👁️  Def: internal
    │   │     │ │ └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 378)
    │   │     │ │     💬 Args: [whole]
    │   │     │ │     👁️  Def: internal
    │   │     │ └─ [8] ⚙️ FUNCTION: LibString.slice(string,uint256,uint256) (NodeID: 379)
    │   │     │     💬 Args: [LibString.toString(fraction), 0, _precision]
    │   │     │     👁️  Def: internal
    │   │     │   └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 380)
    │   │     │       💬 Args: [fraction]
    │   │     │       👁️  Def: internal
    │   │     └─ [7] ⚙️ FUNCTION: svg.text(string,string) (NodeID: 367)
    │   │         💬 Args: [string.concat(GEIST, svg.prop("text-anchor", "end"), svg.prop("x", LibString.toString(_x)), svg.prop("y", LibString.toString(_y)), svg.prop("font-size", "20"), svg.prop("fill", "white")), _value]
    │   │         👁️  Def: internal
    │   │       ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 369)
    │   │       │   💬 Args: ["text-anchor", "end"]
    │   │       │   👁️  Def: internal
    │   │       ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 370)
    │   │       │   💬 Args: ["x", LibString.toString(_x)]
    │   │       │   👁️  Def: internal
    │   │       │ └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 371)
    │   │       │     💬 Args: [_x]
    │   │       │     👁️  Def: internal
    │   │       ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 372)
    │   │       │   💬 Args: ["y", LibString.toString(_y)]
    │   │       │   👁️  Def: internal
    │   │       │ └─ [9] ⚙️ FUNCTION: LibString.toString(uint256) (NodeID: 373)
    │   │       │     💬 Args: [_y]
    │   │       │     👁️  Def: internal
    │   │       ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 374)
    │   │       │   💬 Args: ["font-size", "20"]
    │   │       │   👁️  Def: internal
    │   │       ├─ [8] ⚙️ FUNCTION: svg.prop(string,string) (NodeID: 375)
    │   │       │   💬 Args: ["fill", "white"]
    │   │       │   👁️  Def: internal
    │   │       └─ [8] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 368)
    │   │           💬 Args: ["text", _props, _children]
    │   │           👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: svg.el(string,string,string) (NodeID: 19)
    │       💬 Args: ["svg", string.concat(_SVG, " ", _props), _children]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: json.encode(bytes) (NodeID: 11)
        💬 Args: [bytes(string.concat("{", _prop("name", name), _prop("description", description), _xmlImage(svgImg), ",\"attributes\":", attributes, "}"))]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: json._prop(string,string) (NodeID: 12)
      │   💬 Args: ["name", name]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: json._prop(string,string) (NodeID: 13)
      │   💬 Args: ["description", description]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: json._xmlImage(string) (NodeID: 14)
          💬 Args: [svgImg]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: json._prop(string,string,bool) (NodeID: 15)
            💬 Args: ["image", string.concat("data:image/svg+xml;base64,", encode(bytes(_svgImg))), true]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: json.encode(bytes) (NodeID: 16)
              💬 Args: [bytes(_svgImg)]
              👁️  Def: internal
```
