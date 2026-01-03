# Interface: IBoldTokenCustom

## Metadata

- **Name**: IBoldTokenCustom
- **Type**: Interface
- **Path**: src/Interfaces/IBoldToken.sol

## Implements Interfaces

- **IERC5267** [lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol/interface_IERC5267.md]
- **IERC20Permit** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol/interface_IERC20Permit.md]

## Events

### EIP712DomainChanged (inherited from IERC5267)

```solidity
///  @dev MAY be emitted to signal that the domain could have changed.
event EIP712DomainChanged();
```

## Public/External Functions

### collateralRegistryAddress()

- **Signature**: `collateralRegistryAddress()`
- **Visibility**: external
- **Source Range**: 473:69:72

**Signature:**
```solidity
function collateralRegistryAddress() external view returns (address);;
```

### setBranchAddresses(address,address,address,address)

- **Signature**: `setBranchAddresses(address,address,address,address)`
- **Visibility**: external
- **Source Range**: 553:200:72

**Signature:**
```solidity
function setBranchAddresses(address _troveManagerAddress, address _stabilityPoolAddress, address _borrowerOperationsAddress, address _activePoolAddress) external;;
```

### setCollateralRegistry(address)

- **Signature**: `setCollateralRegistry(address)`
- **Visibility**: external
- **Source Range**: 759:76:72

**Signature:**
```solidity
function setCollateralRegistry(address _collateralRegistryAddress) external;;
```

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 841:58:72

**Signature:**
```solidity
function mint(address _account, uint256 _amount) external;;
```

### burn(address,uint256)

- **Signature**: `burn(address,uint256)`
- **Visibility**: external
- **Source Range**: 905:58:72

**Signature:**
```solidity
function burn(address _account, uint256 _amount) external;;
```

### sendToPool(address,address,uint256)

- **Signature**: `sendToPool(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 969:84:72

**Signature:**
```solidity
function sendToPool(address _sender, address poolAddress, uint256 _amount) external;;
```

### returnFromPool(address,address,uint256)

- **Signature**: `returnFromPool(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1059:85:72

**Signature:**
```solidity
function returnFromPool(address poolAddress, address user, uint256 _amount) external;;
```

### permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (inherited from IERC20Permit)

- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 2996:183:12

**Signature:**
```solidity
///  @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
///  given ``owner``'s signed approval.
///  IMPORTANT: The same issues {IERC20-approve} has related to transaction
///  ordering also apply here.
///  Emits an {Approval} event.
///  Requirements:
///  - `spender` cannot be the zero address.
///  - `deadline` must be a timestamp in the future.
///  - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
///  over the EIP712-formatted function arguments.
///  - the signature must use ``owner``'s current nonce (see {nonces}).
///  For more information on the signature format, see the
///  https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
///  section].
///  CAUTION: See Security Considerations above.
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;;
```

### nonces(address) (inherited from IERC20Permit)

- **Signature**: `nonces(address)`
- **Visibility**: external
- **Source Range**: 3484:63:12

**Signature:**
```solidity
///  @dev Returns the current nonce for `owner`. This value must be
///  included whenever a signature is generated for {permit}.
///  Every successful call to {permit} increases ``owner``'s nonce by one. This
///  prevents a signature from being used multiple times.
function nonces(address owner) external view returns (uint256);;
```

### DOMAIN_SEPARATOR() (inherited from IERC20Permit)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 3739:60:12

**Signature:**
```solidity
///  @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
function DOMAIN_SEPARATOR() external view returns (bytes32);;
```

### eip712Domain() (inherited from IERC5267)

- **Signature**: `eip712Domain()`
- **Visibility**: external
- **Source Range**: 425:310:3

**Signature:**
```solidity
///  @dev returns the fields and values that describe the domain separator used by this contract for EIP-712
///  signature.
function eip712Domain() external view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions);;
```
