# Contract: BoldToken

## Metadata

- **Name**: BoldToken
- **Type**: Contract
- **Path**: src/BoldToken.sol

## Implements Interfaces

- **IBoldTokenCustom** [src/Interfaces/IBoldToken.sol/interface_IBoldTokenCustom.md]
- **IERC5267** [lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol/interface_IERC5267.md]
- **IERC20Permit** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol/interface_IERC20Permit.md]

## State Variables

### _storagePaddings (inherited from CustomSuperTokenBase)

```solidity
uint256[32] internal _storagePaddings
```

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### _NAME

```solidity
string internal constant _NAME = "Nerite Stablecoin"
```

### _SYMBOL

```solidity
string internal constant _SYMBOL = "USDN"
```

### collateralRegistryAddress

```solidity
address public collateralRegistryAddress
```

### troveManagerAddresses

```solidity
mapping(address => bool) internal troveManagerAddresses
```

### stabilityPoolAddresses

```solidity
mapping(address => bool) internal stabilityPoolAddresses
```

### borrowerOperationsAddresses

```solidity
mapping(address => bool) internal borrowerOperationsAddresses
```

### activePoolAddresses

```solidity
mapping(address => bool) internal activePoolAddresses
```

### _nonces

```solidity
mapping(address => uint256) private _nonces
```

## Events

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

### EIP712DomainChanged (inherited from IERC5267)

```solidity
///  @dev MAY be emitted to signal that the domain could have changed.
event EIP712DomainChanged();
```

### CollateralRegistryAddressChanged

```solidity
event CollateralRegistryAddressChanged(address _newCollateralRegistryAddress);
```

### TroveManagerAddressAdded

```solidity
event TroveManagerAddressAdded(address _newTroveManagerAddress);
```

### StabilityPoolAddressAdded

```solidity
event StabilityPoolAddressAdded(address _newStabilityPoolAddress);
```

### BorrowerOperationsAddressAdded

```solidity
event BorrowerOperationsAddressAdded(address _newBorrowerOperationsAddress);
```

### ActivePoolAddressAdded

```solidity
event ActivePoolAddressAdded(address _newActivePoolAddress);
```

## Public/External Functions

### constructor(address,contract ISuperTokenFactory)

- **Signature**: `constructor(address,contract ISuperTokenFactory)`
- **Visibility**: public
- **Source Range**: 2925:74:53
- **Details**: [function_constructor_address_contract_ISuperTokenFactory.md](./function_constructor_address_contract_ISuperTokenFactory.md)

**Signature:**
```solidity
constructor(address _owner, ISuperTokenFactory factory) Ownable(_owner);
```

### initialize(contract ISuperTokenFactory)

- **Signature**: `initialize(contract ISuperTokenFactory)`
- **Visibility**: external
- **Source Range**: 3005:614:53
- **Details**: [function_initialize_contract_ISuperTokenFactory.md](./function_initialize_contract_ISuperTokenFactory.md)

**Signature:**
```solidity
function initialize(ISuperTokenFactory factory) external;
```

### setBranchAddresses(address,address,address,address)

- **Signature**: `setBranchAddresses(address,address,address,address)`
- **Visibility**: external
- **Source Range**: 3625:733:53
- **Details**: [function_setBranchAddresses_address_address_address_address.md](./function_setBranchAddresses_address_address_address_address.md)

**Signature:**
```solidity
function setBranchAddresses(address _troveManagerAddress, address _stabilityPoolAddress, address _borrowerOperationsAddress, address _activePoolAddress) override external onlyOwner();
```

### setCollateralRegistry(address)

- **Signature**: `setCollateralRegistry(address)`
- **Visibility**: external
- **Source Range**: 4364:272:53
- **Details**: [function_setCollateralRegistry_address.md](./function_setCollateralRegistry_address.md)

**Signature:**
```solidity
function setCollateralRegistry(address _collateralRegistryAddress) override external onlyOwner();
```

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 4692:176:53
- **Details**: [function_mint_address_uint256.md](./function_mint_address_uint256.md)

**Signature:**
```solidity
function mint(address _account, uint256 _amount) override external;
```

### burn(address,uint256)

- **Signature**: `burn(address,uint256)`
- **Visibility**: external
- **Source Range**: 4874:184:53
- **Details**: [function_burn_address_uint256.md](./function_burn_address_uint256.md)

**Signature:**
```solidity
function burn(address _account, uint256 _amount) override external;
```

### sendToPool(address,address,uint256)

- **Signature**: `sendToPool(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 5125:236:53
- **Details**: [function_sendToPool_address_address_uint256.md](./function_sendToPool_address_address_uint256.md)

**Signature:**
```solidity
function sendToPool(address _sender, address _poolAddress, uint256 _amount) override external;
```

### returnFromPool(address,address,uint256)

- **Signature**: `returnFromPool(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 5367:249:53
- **Details**: [function_returnFromPool_address_address_uint256.md](./function_returnFromPool_address_address_uint256.md)

**Signature:**
```solidity
function returnFromPool(address _poolAddress, address _receiver, uint256 _amount) override external;
```

### DOMAIN_SEPARATOR()

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: public
- **Source Range**: 7060:422:53
- **Details**: [function_DOMAIN_SEPARATOR.md](./function_DOMAIN_SEPARATOR.md)

**Signature:**
```solidity
/// @dev Returns the EIP-712 domain separator for the EIP-2612 permit.
function DOMAIN_SEPARATOR() public view returns (bytes32);
```

### eip712Domain()

- **Signature**: `eip712Domain()`
- **Visibility**: external
- **Source Range**: 7588:553:53
- **Details**: [function_eip712Domain.md](./function_eip712Domain.md)

**Signature:**
```solidity
function eip712Domain() override external view returns (bytes1 fields, string memory name712, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions);
```

### nonces(address)

- **Signature**: `nonces(address)`
- **Visibility**: external
- **Source Range**: 8147:110:53
- **Details**: [function_nonces_address.md](./function_nonces_address.md)

**Signature:**
```solidity
function nonces(address owner) override external view returns (uint256);
```

### permit(address,address,uint256,uint256,uint8,bytes32,bytes32)

- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 8263:1122:53
- **Details**: [function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md](./function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md)

**Signature:**
```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) override external;
```

### constructor(address) (inherited from Ownable)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 806:133:65
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner);
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1015:77:65
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() public view returns (address);
```

### isOwner() (inherited from Ownable)

- **Signature**: `isOwner()`
- **Visibility**: public
- **Source Range**: 1366:90:65
- **Details**: [function_isOwner.md](./function_isOwner.md)

**Signature:**
```solidity
///  @dev Returns true if the caller is the current owner.
function isOwner() public view returns (bool);
```

### fallback() (inherited from Proxy)

- **Signature**: `fallback()`
- **Visibility**: external
- **Source Range**: 2629:64:6
- **Details**: [function_fallback.md](./function_fallback.md)

**Signature:**
```solidity
///  @dev Fallback function that delegates calls to the address returned by `_implementation()`. Will run if no other
///  function in the contract matches the call data.
fallback() virtual external payable;
```

### receive() (inherited from Proxy)

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 2853:63:6
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
///  @dev Fallback function that delegates calls to the address returned by `_implementation()`. Will run if call data
///  is empty.
receive() virtual external payable;
```

### initializeProxy(address) (inherited from UUPSProxy)

- **Signature**: `initializeProxy(address)`
- **Visibility**: external
- **Source Range**: 898:285:49
- **Details**: [function_initializeProxy_address.md](./function_initializeProxy_address.md)

**Signature:**
```solidity
///  @dev Proxy initialization function.
///       This should only be called once and it is permission-less.
///  @param initialAddress Initial logic contract code address to be used.
function initializeProxy(address initialAddress) external;
```
