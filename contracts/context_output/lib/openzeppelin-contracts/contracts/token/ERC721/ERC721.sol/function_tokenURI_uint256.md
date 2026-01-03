# Function: tokenURI(uint256)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol/contract_ERC721.md]

## Metadata

- **Contract**: ERC721
- **Signature**: `tokenURI(uint256)`
- **Visibility**: public
- **Source Range**: 2801:276:14

## Implementation

```solidity
///  @dev See {IERC721Metadata-tokenURI}.
function tokenURI(uint256 tokenId) virtual override public view returns (string memory) {
    _requireMinted(tokenId);
    string memory baseURI = _baseURI();
    return (bytes(baseURI).length > 0) ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
}
```

## Related Implementations

### _requireMinted(uint256)

- **Kind**: internal
- **Source**: 13240:133:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_requireMinted(uint256)`

```solidity
///  @dev Reverts if the `tokenId` has not been minted yet.
function _requireMinted(uint256 tokenId) virtual internal view {
    require(_exists(tokenId), "ERC721: invalid token ID");
}
```

### _exists(uint256)

- **Kind**: internal
- **Source**: 7120:126:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_exists(uint256)`

```solidity
///  @dev Returns whether `tokenId` exists.
///  Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
///  Tokens start existing when they are minted (`_mint`),
///  and stop existing when they are burned (`_burn`).
function _exists(uint256 tokenId) virtual internal view returns (bool) {
    return _ownerOf(tokenId) != address(0);
}
```

### _ownerOf(uint256)

- **Kind**: internal
- **Source**: 6702:115:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_ownerOf(uint256)`

```solidity
///  @dev Returns the owner of the `tokenId`. Does NOT revert if token doesn't exist
function _ownerOf(uint256 tokenId) virtual internal view returns (address) {
    return _owners[tokenId];
}
```

### _baseURI()

- **Kind**: internal
- **Source**: 3319:92:14
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_baseURI()`

```solidity
///  @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
///  token will be the concatenation of the `baseURI` and the `tokenId`. Empty
///  by default, can be overridden in child contracts.
function _baseURI() virtual internal view returns (string memory) {
    return "";
}
```

### toString(uint256)

- **Kind**: internal
- **Source**: 447:696:24
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toString(uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` decimal representation.
function toString(uint256 value) internal pure returns (string memory) {
    unchecked {
        uint256 length = Math.log10(value) + 1;
        string memory buffer = new string(length);
        uint256 ptr;
        /// @solidity memory-safe-assembly
        assembly {
            ptr := add(buffer, add(32, length))
        }
        while (true) {
            ptr--;
            /// @solidity memory-safe-assembly
            assembly {
                mstore8(ptr, byte(mod(value, 10), _SYMBOLS))
            }
            value /= 10;
            if (value == 0) break;
        }
        return buffer;
    }
}
```

### log10(uint256)

- **Kind**: internal
- **Source**: 10139:916:29
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log10(uint256)`

```solidity
///  @dev Return the log in base 10, rounded down, of a positive value.
///  Returns 0 if given 0.
function log10(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if (value >= (10 ** 64)) {
            value /= 10 ** 64;
            result += 64;
        }
        if (value >= (10 ** 32)) {
            value /= 10 ** 32;
            result += 32;
        }
        if (value >= (10 ** 16)) {
            value /= 10 ** 16;
            result += 16;
        }
        if (value >= (10 ** 8)) {
            value /= 10 ** 8;
            result += 8;
        }
        if (value >= (10 ** 4)) {
            value /= 10 ** 4;
            result += 4;
        }
        if (value >= (10 ** 2)) {
            value /= 10 ** 2;
            result += 2;
        }
        if (value >= (10 ** 1)) {
            result += 1;
        }
    }
    return result;
}
```

## State Variable Reads

- **_owners** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC721.tokenURI(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC721._requireMinted(uint256) (NodeID: 1)
  │   💬 Args: [tokenId]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ERC721._exists(uint256) (NodeID: 2)
  │     💬 Args: [tokenId]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 3)
  │       💬 Args: [tokenId]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ERC721._baseURI() (NodeID: 4)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 5)
      💬 Args: [tokenId]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 6)
        💬 Args: [value]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev See {IERC721Metadata-tokenURI}.

### Interface Documentation

 @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
