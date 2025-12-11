# Interface: IPoolNFTBase

## Metadata

- **Name**: IPoolNFTBase
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolNFTBase.sol

## Implements Interfaces

- **IERC721Metadata** [lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol/interface_IERC721Metadata.md]
- **IERC721** [lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol/interface_IERC721.md]
- **IERC165** [lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]

## Errors

### POOL_NFT_APPROVE_TO_CALLER

```solidity
error POOL_NFT_APPROVE_TO_CALLER();
```

### POOL_NFT_ONLY_SUPER_TOKEN_FACTORY

```solidity
error POOL_NFT_ONLY_SUPER_TOKEN_FACTORY();
```

### POOL_NFT_INVALID_TOKEN_ID

```solidity
error POOL_NFT_INVALID_TOKEN_ID();
```

### POOL_NFT_APPROVE_TO_CURRENT_OWNER

```solidity
error POOL_NFT_APPROVE_TO_CURRENT_OWNER();
```

### POOL_NFT_APPROVE_CALLER_NOT_OWNER_OR_APPROVED_FOR_ALL

```solidity
error POOL_NFT_APPROVE_CALLER_NOT_OWNER_OR_APPROVED_FOR_ALL();
```

### POOL_NFT_NOT_REGISTERED_POOL

```solidity
error POOL_NFT_NOT_REGISTERED_POOL();
```

### POOL_NFT_TRANSFER_NOT_ALLOWED

```solidity
error POOL_NFT_TRANSFER_NOT_ALLOWED();
```

### POOL_NFT_TRANSFER_CALLER_NOT_OWNER_OR_APPROVED_FOR_ALL

```solidity
error POOL_NFT_TRANSFER_CALLER_NOT_OWNER_OR_APPROVED_FOR_ALL();
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

### MetadataUpdate

```solidity
/// @notice Informs third-party platforms that NFT metadata should be updated
///  @dev This event comes from https://eips.ethereum.org/EIPS/eip-4906
///  @param tokenId the id of the token that should have its metadata updated
event MetadataUpdate(uint256 tokenId);
```

## Public/External Functions

### initialize(string,string)

- **Signature**: `initialize(string,string)`
- **Visibility**: external
- **Source Range**: 1152:77:136

**Signature:**
```solidity
function initialize(string memory nftName, string memory nftSymbol) external;;
```

### triggerMetadataUpdate(uint256)

- **Signature**: `triggerMetadataUpdate(uint256)`
- **Visibility**: external
- **Source Range**: 1251:57:136

**Signature:**
```solidity
function triggerMetadataUpdate(uint256 tokenId) external;;
```

### getTokenId(address,address)

- **Signature**: `getTokenId(address,address)`
- **Visibility**: external
- **Source Range**: 1441:91:136

**Signature:**
```solidity
/// @notice Gets the token id
///  @dev For PoolAdminNFT, `account` is admin and for PoolMemberNFT, `account` is member
function getTokenId(address pool, address account) external view returns (uint256 tokenId);;
```

### supportsInterface(bytes4) (inherited from IERC165)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 774:76:112

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
- **Source Range**: 954:74:97

**Signature:**
```solidity
///  @dev Returns the number of tokens in ``owner``'s account.
function balanceOf(address owner) external view returns (uint256 balance);;
```

### ownerOf(uint256) (inherited from IERC721)

- **Signature**: `ownerOf(uint256)`
- **Visibility**: external
- **Source Range**: 1170:72:97

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
- **Source Range**: 1809:99:97

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
- **Source Range**: 2606:78:97

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
- **Source Range**: 3427:74:97

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
- **Source Range**: 3964:55:97

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
- **Source Range**: 4339:69:97

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
- **Source Range**: 4558:79:97

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
- **Source Range**: 4786:88:97

**Signature:**
```solidity
///  @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
///  See {setApprovalForAll}
function isApprovedForAll(address owner, address operator) external view returns (bool);;
```

### name() (inherited from IERC721Metadata)

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 403:54:99

**Signature:**
```solidity
///  @dev Returns the token collection name.
function name() external view returns (string memory);;
```

### symbol() (inherited from IERC721Metadata)

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 528:56:99

**Signature:**
```solidity
///  @dev Returns the token collection symbol.
function symbol() external view returns (string memory);;
```

### tokenURI(uint256) (inherited from IERC721Metadata)

- **Signature**: `tokenURI(uint256)`
- **Visibility**: external
- **Source Range**: 685:73:99

**Signature:**
```solidity
///  @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
function tokenURI(uint256 tokenId) external view returns (string memory);;
```
