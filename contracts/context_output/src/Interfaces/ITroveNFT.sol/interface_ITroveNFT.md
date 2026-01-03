# Interface: ITroveNFT

## Metadata

- **Name**: ITroveNFT
- **Type**: Interface
- **Path**: src/Interfaces/ITroveNFT.sol

## Implements Interfaces

- **IERC721Metadata** [lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol/interface_IERC721Metadata.md]
- **IERC721** [lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol/interface_IERC721.md]
- **IERC165** [lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]

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

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 222:57:95

**Signature:**
```solidity
function mint(address _owner, uint256 _troveId) external;;
```

### burn(uint256)

- **Signature**: `burn(uint256)`
- **Visibility**: external
- **Source Range**: 284:41:95

**Signature:**
```solidity
function burn(uint256 _troveId) external;;
```

### supportsInterface(bytes4) (inherited from IERC165)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 774:76:28

**Signature:**
```solidity
///  @dev Returns true if this contract implements the interface defined by
///  `interfaceId`. See the corresponding
///  https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
///  to learn more about how these ids are created.
///  This function call must use less than 30 000 gas.
function supportsInterface(bytes4 interfaceId) external view returns (bool);;
```

### balanceOf(address) (inherited from IERC721)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 954:74:15

**Signature:**
```solidity
///  @dev Returns the number of tokens in ``owner``'s account.
function balanceOf(address owner) external view returns (uint256 balance);;
```

### ownerOf(uint256) (inherited from IERC721)

- **Signature**: `ownerOf(uint256)`
- **Visibility**: external
- **Source Range**: 1170:72:15

**Signature:**
```solidity
///  @dev Returns the owner of the `tokenId` token.
///  Requirements:
///  - `tokenId` must exist.
function ownerOf(uint256 tokenId) external view returns (address owner);;
```

### safeTransferFrom(address,address,uint256,bytes) (inherited from IERC721)

- **Signature**: `safeTransferFrom(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 1809:99:15

**Signature:**
```solidity
///  @dev Safely transfers `tokenId` token from `from` to `to`.
///  Requirements:
///  - `from` cannot be the zero address.
///  - `to` cannot be the zero address.
///  - `tokenId` token must exist and be owned by `from`.
///  - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
///  - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
///  Emits a {Transfer} event.
function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;;
```

### safeTransferFrom(address,address,uint256) (inherited from IERC721)

- **Signature**: `safeTransferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2606:78:15

**Signature:**
```solidity
///  @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
///  are aware of the ERC721 protocol to prevent tokens from being forever locked.
///  Requirements:
///  - `from` cannot be the zero address.
///  - `to` cannot be the zero address.
///  - `tokenId` token must exist and be owned by `from`.
///  - If the caller is not `from`, it must have been allowed to move this token by either {approve} or {setApprovalForAll}.
///  - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
///  Emits a {Transfer} event.
function safeTransferFrom(address from, address to, uint256 tokenId) external;;
```

### transferFrom(address,address,uint256) (inherited from IERC721)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 3427:74:15

**Signature:**
```solidity
///  @dev Transfers `tokenId` token from `from` to `to`.
///  WARNING: Note that the caller is responsible to confirm that the recipient is capable of receiving ERC721
///  or else they may be permanently lost. Usage of {safeTransferFrom} prevents loss, though the caller must
///  understand this adds an external call which potentially creates a reentrancy vulnerability.
///  Requirements:
///  - `from` cannot be the zero address.
///  - `to` cannot be the zero address.
///  - `tokenId` token must be owned by `from`.
///  - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
///  Emits a {Transfer} event.
function transferFrom(address from, address to, uint256 tokenId) external;;
```

### approve(address,uint256) (inherited from IERC721)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 3964:55:15

**Signature:**
```solidity
///  @dev Gives permission to `to` to transfer `tokenId` token to another account.
///  The approval is cleared when the token is transferred.
///  Only a single account can be approved at a time, so approving the zero address clears previous approvals.
///  Requirements:
///  - The caller must own the token or be an approved operator.
///  - `tokenId` must exist.
///  Emits an {Approval} event.
function approve(address to, uint256 tokenId) external;;
```

### setApprovalForAll(address,bool) (inherited from IERC721)

- **Signature**: `setApprovalForAll(address,bool)`
- **Visibility**: external
- **Source Range**: 4339:69:15

**Signature:**
```solidity
///  @dev Approve or remove `operator` as an operator for the caller.
///  Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
///  Requirements:
///  - The `operator` cannot be the caller.
///  Emits an {ApprovalForAll} event.
function setApprovalForAll(address operator, bool approved) external;;
```

### getApproved(uint256) (inherited from IERC721)

- **Signature**: `getApproved(uint256)`
- **Visibility**: external
- **Source Range**: 4558:79:15

**Signature:**
```solidity
///  @dev Returns the account approved for `tokenId` token.
///  Requirements:
///  - `tokenId` must exist.
function getApproved(uint256 tokenId) external view returns (address operator);;
```

### isApprovedForAll(address,address) (inherited from IERC721)

- **Signature**: `isApprovedForAll(address,address)`
- **Visibility**: external
- **Source Range**: 4786:88:15

**Signature:**
```solidity
///  @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
///  See {setApprovalForAll}
function isApprovedForAll(address owner, address operator) external view returns (bool);;
```

### name() (inherited from IERC721Metadata)

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 403:54:17

**Signature:**
```solidity
///  @dev Returns the token collection name.
function name() external view returns (string memory);;
```

### symbol() (inherited from IERC721Metadata)

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 528:56:17

**Signature:**
```solidity
///  @dev Returns the token collection symbol.
function symbol() external view returns (string memory);;
```

### tokenURI(uint256) (inherited from IERC721Metadata)

- **Signature**: `tokenURI(uint256)`
- **Visibility**: external
- **Source Range**: 685:73:17

**Signature:**
```solidity
///  @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
function tokenURI(uint256 tokenId) external view returns (string memory);;
```
