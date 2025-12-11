# Contract: ERC721

## Metadata

- **Name**: ERC721
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol
- **Documentation**:  @dev Implementation of https://eips.ethereum.org/EIPS/eip-721[ERC721] Non-Fungible Token Standard, including
   the Metadata extension, but not including the Enumerable extension, which is available separately as
   {ERC721Enumerable}.

## Implements Interfaces

- **IERC721Metadata** [lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol/interface_IERC721Metadata.md]
- **IERC721** [lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol/interface_IERC721.md]
- **IERC165** [lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]

## State Variables

### _name

```solidity
string private _name
```

### _symbol

```solidity
string private _symbol
```

### _owners

```solidity
mapping(uint256 => address) private _owners
```

### _balances

```solidity
mapping(address => uint256) private _balances
```

### _tokenApprovals

```solidity
mapping(uint256 => address) private _tokenApprovals
```

### _operatorApprovals

```solidity
mapping(address => mapping(address => bool)) private _operatorApprovals
```

## Events

### Transfer (inherited from IERC721)

```solidity
///  @dev Emitted when `tokenId` token is transferred from `from` to `to`.
event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
```

### Approval (inherited from IERC721)

```solidity
///  @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
```

### ApprovalForAll (inherited from IERC721)

```solidity
///  @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
```

## Public/External Functions

### constructor(string,string)

- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 1390:113:96
- **Details**: [function_constructor_string_string.md](./function_constructor_string_string.md)

**Signature:**
```solidity
///  @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
constructor(string memory name_, string memory symbol_);
```

### supportsInterface(bytes4)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 1570:300:96
- **Details**: [function_supportsInterface_bytes4.md](./function_supportsInterface_bytes4.md)

**Signature:**
```solidity
///  @dev See {IERC165-supportsInterface}.
function supportsInterface(bytes4 interfaceId) virtual override(ERC165, IERC165) public view returns (bool);
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 1929:204:96
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
///  @dev See {IERC721-balanceOf}.
function balanceOf(address owner) virtual override public view returns (uint256);
```

### ownerOf(uint256)

- **Signature**: `ownerOf(uint256)`
- **Visibility**: public
- **Source Range**: 2190:219:96
- **Details**: [function_ownerOf_uint256.md](./function_ownerOf_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC721-ownerOf}.
function ownerOf(uint256 tokenId) virtual override public view returns (address);
```

### name()

- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 2471:98:96
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
///  @dev See {IERC721Metadata-name}.
function name() virtual override public view returns (string memory);
```

### symbol()

- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 2633:102:96
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
///  @dev See {IERC721Metadata-symbol}.
function symbol() virtual override public view returns (string memory);
```

### tokenURI(uint256)

- **Signature**: `tokenURI(uint256)`
- **Visibility**: public
- **Source Range**: 2801:276:96
- **Details**: [function_tokenURI_uint256.md](./function_tokenURI_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC721Metadata-tokenURI}.
function tokenURI(uint256 tokenId) virtual override public view returns (string memory);
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3468:406:96
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC721-approve}.
function approve(address to, uint256 tokenId) virtual override public;
```

### getApproved(uint256)

- **Signature**: `getApproved(uint256)`
- **Visibility**: public
- **Source Range**: 3935:167:96
- **Details**: [function_getApproved_uint256.md](./function_getApproved_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC721-getApproved}.
function getApproved(uint256 tokenId) virtual override public view returns (address);
```

### setApprovalForAll(address,bool)

- **Signature**: `setApprovalForAll(address,bool)`
- **Visibility**: public
- **Source Range**: 4169:153:96
- **Details**: [function_setApprovalForAll_address_bool.md](./function_setApprovalForAll_address_bool.md)

**Signature:**
```solidity
///  @dev See {IERC721-setApprovalForAll}.
function setApprovalForAll(address operator, bool approved) virtual override public;
```

### isApprovedForAll(address,address)

- **Signature**: `isApprovedForAll(address,address)`
- **Visibility**: public
- **Source Range**: 4388:162:96
- **Details**: [function_isApprovedForAll_address_address.md](./function_isApprovedForAll_address_address.md)

**Signature:**
```solidity
///  @dev See {IERC721-isApprovedForAll}.
function isApprovedForAll(address owner, address operator) virtual override public view returns (bool);
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 4612:296:96
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC721-transferFrom}.
function transferFrom(address from, address to, uint256 tokenId) virtual override public;
```

### safeTransferFrom(address,address,uint256)

- **Signature**: `safeTransferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 4974:149:96
- **Details**: [function_safeTransferFrom_address_address_uint256.md](./function_safeTransferFrom_address_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC721-safeTransferFrom}.
function safeTransferFrom(address from, address to, uint256 tokenId) virtual override public;
```

### safeTransferFrom(address,address,uint256,bytes)

- **Signature**: `safeTransferFrom(address,address,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 5189:276:96
- **Details**: [function_safeTransferFrom_address_address_uint256_bytes.md](./function_safeTransferFrom_address_address_uint256_bytes.md)

**Signature:**
```solidity
///  @dev See {IERC721-safeTransferFrom}.
function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) virtual override public;
```
