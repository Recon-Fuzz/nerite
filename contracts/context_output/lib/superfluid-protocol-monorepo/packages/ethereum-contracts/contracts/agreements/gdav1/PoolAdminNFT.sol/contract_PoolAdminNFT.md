# Contract: PoolAdminNFT

## Metadata

- **Name**: PoolAdminNFT
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol

## Implements Interfaces

- **IPoolAdminNFT** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolAdminNFT.sol/interface_IPoolAdminNFT.md]
- **IPoolNFTBase** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolNFTBase.sol/interface_IPoolNFTBase.md]
- **IERC721Metadata** [lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol/interface_IERC721Metadata.md]
- **IERC721** [lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol/interface_IERC721.md]
- **IERC165** [lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]

## State Variables

### _initialized (inherited from Initializable)

```solidity
///  @dev Indicates that the contract has been initialized.
///  @custom:oz-retyped-from bool
uint8 private _initialized
```

### _initializing (inherited from Initializable)

```solidity
///  @dev Indicates that the contract is in the process of being initialized.
bool private _initializing
```

### DEFAULT_BASE_URI (inherited from PoolNFTBase)

```solidity
string public constant DEFAULT_BASE_URI = "https://nft.superfluid.finance/pool/v2/getmeta"
```

### HOST (inherited from PoolNFTBase)

```solidity
/// @notice Superfluid host contract address
ISuperfluid public immutable HOST
```

**ISuperfluid**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

### GENERAL_DISTRIBUTION_AGREEMENT_V1 (inherited from PoolNFTBase)

```solidity
/// @notice Superfluid GDAv1 contract address
IGeneralDistributionAgreementV1 public immutable GENERAL_DISTRIBUTION_AGREEMENT_V1
```

**IGeneralDistributionAgreementV1**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

### _name (inherited from PoolNFTBase)

```solidity
/// NOTE: The storage variables in this contract MUST NOT:
///  - change the ordering of the existing variables
///  - change any of the variable types
///  - rename any of the existing variables
///  - remove any of the existing variables
string internal _name
```

### _symbol (inherited from PoolNFTBase)

```solidity
string internal _symbol
```

### _tokenApprovals (inherited from PoolNFTBase)

```solidity
/// @notice Mapping for token approvals
///  @dev tokenID => approved address mapping
mapping(uint256 => address) internal _tokenApprovals
```

### _operatorApprovals (inherited from PoolNFTBase)

```solidity
/// @notice Mapping for operator approvals
mapping(address => mapping(address => bool)) internal _operatorApprovals
```

### _reserve5 (inherited from PoolNFTBase)

```solidity
/// @notice This allows us to add new storage variables in the base contract
///  without having to worry about messing up the storage layout that exists in COFNFT or CIFNFT.
///  @dev This empty reserved space is put in place to allow future versions to add new
///  variables without shifting down storage in the inheritance chain.
///  Slots 5-21 are reserved for future use.
///  We use this pattern in SuperToken.sol and favor this over the OpenZeppelin pattern
///  as this prevents silly footgunning.
///  See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
uint256 internal _reserve5
```

### _reserve6 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve6
```

### _reserve7 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve7
```

### _reserve8 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve8
```

### _reserve9 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve9
```

### _reserve10 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve10
```

### _reserve11 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve11
```

### _reserve12 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve12
```

### _reserve13 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve13
```

### _reserve14 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve14
```

### _reserve15 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve15
```

### _reserve16 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve16
```

### _reserve17 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve17
```

### _reserve18 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve18
```

### _reserve19 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve19
```

### _reserve20 (inherited from PoolNFTBase)

```solidity
uint256 private _reserve20
```

### _reserve21 (inherited from PoolNFTBase)

```solidity
uint256 internal _reserve21
```

### _poolAdminDataByTokenId

```solidity
/// @notice A mapping from token id to PoolAdminNFT data
///  PoolAdminNFTData: { address pool, address admin }
///  @dev The token id is uint256(keccak256(abi.encode(pool, admin)))
mapping(uint256 => PoolAdminNFTData) internal _poolAdminDataByTokenId
```

## Structs

### PoolAdminNFTData (inherited from IPoolAdminNFT)

```solidity
struct PoolAdminNFTData {
    address pool;
    address admin;
}
```

## Errors

### POOL_NFT_APPROVE_TO_CALLER (inherited from IPoolNFTBase)

```solidity
error POOL_NFT_APPROVE_TO_CALLER();
```

### POOL_NFT_ONLY_SUPER_TOKEN_FACTORY (inherited from IPoolNFTBase)

```solidity
error POOL_NFT_ONLY_SUPER_TOKEN_FACTORY();
```

### POOL_NFT_INVALID_TOKEN_ID (inherited from IPoolNFTBase)

```solidity
error POOL_NFT_INVALID_TOKEN_ID();
```

### POOL_NFT_APPROVE_TO_CURRENT_OWNER (inherited from IPoolNFTBase)

```solidity
error POOL_NFT_APPROVE_TO_CURRENT_OWNER();
```

### POOL_NFT_APPROVE_CALLER_NOT_OWNER_OR_APPROVED_FOR_ALL (inherited from IPoolNFTBase)

```solidity
error POOL_NFT_APPROVE_CALLER_NOT_OWNER_OR_APPROVED_FOR_ALL();
```

### POOL_NFT_NOT_REGISTERED_POOL (inherited from IPoolNFTBase)

```solidity
error POOL_NFT_NOT_REGISTERED_POOL();
```

### POOL_NFT_TRANSFER_NOT_ALLOWED (inherited from IPoolNFTBase)

```solidity
error POOL_NFT_TRANSFER_NOT_ALLOWED();
```

### POOL_NFT_TRANSFER_CALLER_NOT_OWNER_OR_APPROVED_FOR_ALL (inherited from IPoolNFTBase)

```solidity
error POOL_NFT_TRANSFER_CALLER_NOT_OWNER_OR_APPROVED_FOR_ALL();
```

## Events

### Initialized (inherited from Initializable)

```solidity
///  @dev Triggered when the contract has been initialized or reinitialized.
event Initialized(uint8 version);
```

### CodeUpdated (inherited from UUPSProxiable)

```solidity
event CodeUpdated(bytes32 uuid, address codeAddress);
```

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

### MetadataUpdate (inherited from IPoolNFTBase)

```solidity
/// @notice Informs third-party platforms that NFT metadata should be updated
///  @dev This event comes from https://eips.ethereum.org/EIPS/eip-4906
///  @param tokenId the id of the token that should have its metadata updated
event MetadataUpdate(uint256 tokenId);
```

## Public/External Functions

### constructor(contract ISuperfluid,contract IGeneralDistributionAgreementV1)

- **Signature**: `constructor(contract ISuperfluid,contract IGeneralDistributionAgreementV1)`
- **Visibility**: public
- **Source Range**: 1197:97:124
- **Details**: [function_constructor_contract_ISuperfluid_contract_IGeneralDistributionAgreementV1.md](./function_constructor_contract_ISuperfluid_contract_IGeneralDistributionAgreementV1.md)

**Signature:**
```solidity
constructor(ISuperfluid host, IGeneralDistributionAgreementV1 gdaV1) PoolNFTBase(host,gdaV1);
```

### proxiableUUID()

- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 1374:161:124
- **Details**: [function_proxiableUUID.md](./function_proxiableUUID.md)

**Signature:**
```solidity
function proxiableUUID() override public pure returns (bytes32);
```

### poolAdminDataByTokenId(uint256)

- **Signature**: `poolAdminDataByTokenId(uint256)`
- **Visibility**: external
- **Source Range**: 1685:167:124
- **Details**: [function_poolAdminDataByTokenId_uint256.md](./function_poolAdminDataByTokenId_uint256.md)

**Signature:**
```solidity
function poolAdminDataByTokenId(uint256 tokenId) override external view returns (PoolAdminNFTData memory data);
```

### getTokenId(address,address)

- **Signature**: `getTokenId(address,address)`
- **Visibility**: external
- **Source Range**: 2187:146:124
- **Details**: [function_getTokenId_address_address.md](./function_getTokenId_address_address.md)

**Signature:**
```solidity
function getTokenId(address pool, address admin) override external view returns (uint256 tokenId);
```

### tokenURI(uint256)

- **Signature**: `tokenURI(uint256)`
- **Visibility**: external
- **Source Range**: 2565:160:124
- **Details**: [function_tokenURI_uint256.md](./function_tokenURI_uint256.md)

**Signature:**
```solidity
/// @inheritdoc PoolNFTBase
function tokenURI(uint256 tokenId) override(IERC721Metadata, PoolNFTBase) external view returns (string memory);
```

### mint(address)

- **Signature**: `mint(address)`
- **Visibility**: external
- **Source Range**: 2731:65:124
- **Details**: [function_mint_address.md](./function_mint_address.md)

**Signature:**
```solidity
function mint(address pool) external;
```

### getCodeAddress() (inherited from UUPSProxiable)

- **Signature**: `getCodeAddress()`
- **Visibility**: public
- **Source Range**: 401:122:169
- **Details**: [function_getCodeAddress.md](./function_getCodeAddress.md)

**Signature:**
```solidity
///  @dev Get current implementation code address.
function getCodeAddress() public view returns (address codeAddress);
```

### castrate() (inherited from UUPSProxiable)

- **Signature**: `castrate()`
- **Visibility**: external
- **Source Range**: 694:44:169
- **Details**: [function_castrate.md](./function_castrate.md)

**Signature:**
```solidity
function castrate() external initializer();
```

### baseURI() (inherited from PoolNFTBase)

- **Signature**: `baseURI()`
- **Visibility**: public
- **Source Range**: 922:83:126
- **Details**: [function_baseURI.md](./function_baseURI.md)

**Signature:**
```solidity
function baseURI() public pure returns (string memory);
```

### initialize(string,string) (inherited from PoolNFTBase)

- **Signature**: `initialize(string,string)`
- **Visibility**: external
- **Source Range**: 3171:217:126
- **Details**: [function_initialize_string_string.md](./function_initialize_string_string.md)

**Signature:**
```solidity
function initialize(string memory nftName, string memory nftSymbol) override external initializer();
```

### updateCode(address) (inherited from PoolNFTBase)

- **Signature**: `updateCode(address)`
- **Visibility**: external
- **Source Range**: 3394:318:126
- **Details**: [function_updateCode_address.md](./function_updateCode_address.md)

**Signature:**
```solidity
function updateCode(address newAddress) override external;
```

### triggerMetadataUpdate(uint256) (inherited from PoolNFTBase)

- **Signature**: `triggerMetadataUpdate(uint256)`
- **Visibility**: external
- **Source Range**: 3894:105:126
- **Details**: [function_triggerMetadataUpdate_uint256.md](./function_triggerMetadataUpdate_uint256.md)

**Signature:**
```solidity
/// @notice Emits the MetadataUpdate event with `tokenId` as the argument.
///  @dev Callable by anyone.
///  @param tokenId the token id to trigger a metaupdate for
function triggerMetadataUpdate(uint256 tokenId) external;
```

### supportsInterface(bytes4) (inherited from PoolNFTBase)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 4352:334:126
- **Details**: [function_supportsInterface_bytes4.md](./function_supportsInterface_bytes4.md)

**Signature:**
```solidity
/// @notice This contract supports IERC165, IERC721 and IERC721Metadata
///  @dev This is part of the Standard Interface Detection EIP: https://eips.ethereum.org/EIPS/eip-165
///  @param interfaceId the XOR of all function selectors in the interface
///  @return boolean true if the interface is supported
///  @inheritdoc IERC165
function supportsInterface(bytes4 interfaceId) virtual override external pure returns (bool);
```

### ownerOf(uint256) (inherited from PoolNFTBase)

- **Signature**: `ownerOf(uint256)`
- **Visibility**: public
- **Source Range**: 4720:246:126
- **Details**: [function_ownerOf_uint256.md](./function_ownerOf_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC721
function ownerOf(uint256 tokenId) virtual override public view returns (address);
```

### balanceOf(address) (inherited from PoolNFTBase)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 5122:119:126
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
/// @notice Returns a hardcoded balance of 1
///  @dev We always return 1 to avoid the need for additional mapping
///  @return balance = 1
function balanceOf(address) external pure returns (uint256 balance);
```

### name() (inherited from PoolNFTBase)

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 5402:100:126
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
/// @notice Returns the name of the NFT
///  @dev Should follow the naming convention: (Pool Admin|Pool Member) NFT
///  @return name of the NFT
function name() virtual override external view returns (string memory);
```

### symbol() (inherited from PoolNFTBase)

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 5644:104:126
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
/// @notice Returns the symbol of the NFT
///  @dev Should follow the naming convention: PA|PM
///  @return symbol of the NFT
function symbol() virtual override external view returns (string memory);
```

### approve(address,uint256) (inherited from PoolNFTBase)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 6236:418:126
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC721
function approve(address to, uint256 tokenId) virtual override public;
```

### getApproved(uint256) (inherited from PoolNFTBase)

- **Signature**: `getApproved(uint256)`
- **Visibility**: public
- **Source Range**: 6688:167:126
- **Details**: [function_getApproved_uint256.md](./function_getApproved_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC721
function getApproved(uint256 tokenId) virtual override public view returns (address);
```

### setApprovalForAll(address,bool) (inherited from PoolNFTBase)

- **Signature**: `setApprovalForAll(address,bool)`
- **Visibility**: external
- **Source Range**: 6889:153:126
- **Details**: [function_setApprovalForAll_address_bool.md](./function_setApprovalForAll_address_bool.md)

**Signature:**
```solidity
/// @inheritdoc IERC721
function setApprovalForAll(address operator, bool approved) virtual override external;
```

### isApprovedForAll(address,address) (inherited from PoolNFTBase)

- **Signature**: `isApprovedForAll(address,address)`
- **Visibility**: public
- **Source Range**: 7076:162:126
- **Details**: [function_isApprovedForAll_address_address.md](./function_isApprovedForAll_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC721
function isApprovedForAll(address owner, address operator) virtual override public view returns (bool);
```

### transferFrom(address,address,uint256) (inherited from PoolNFTBase)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 7272:280:126
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC721
function transferFrom(address from, address to, uint256 tokenId) virtual override external;
```

### safeTransferFrom(address,address,uint256) (inherited from PoolNFTBase)

- **Signature**: `safeTransferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 7586:151:126
- **Details**: [function_safeTransferFrom_address_address_uint256.md](./function_safeTransferFrom_address_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC721
function safeTransferFrom(address from, address to, uint256 tokenId) virtual override external;
```

### safeTransferFrom(address,address,uint256,bytes) (inherited from PoolNFTBase)

- **Signature**: `safeTransferFrom(address,address,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 7771:311:126
- **Details**: [function_safeTransferFrom_address_address_uint256_bytes.md](./function_safeTransferFrom_address_address_uint256_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IERC721
function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) virtual override public;
```
