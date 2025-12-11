# Function: initialize(contract IERC20,uint8,string,string)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `initialize(contract IERC20,uint8,string,string)`
- **Visibility**: external
- **Source Range**: 4695:484:161

## Implementation

```solidity
/// @dev Initialize the Super Token proxy
function initialize(IERC20 underlyingToken, uint8 underlyingDecimals, string calldata n, string calldata s) virtual override external initializer() {
    _initialize(underlyingToken, underlyingDecimals, n, s, address(0));
}
```

## Related Implementations

### _initialize(contract IERC20,uint8,string,string,address)

- **Kind**: internal
- **Source**: 7648:674:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_initialize(contract IERC20,uint8,string,string,address)`

```solidity
function _initialize(IERC20 underlyingToken, uint8 underlyingDecimals, string calldata n, string calldata s, address admin) internal {
    _underlyingToken = underlyingToken;
    _underlyingDecimals = underlyingDecimals;
    _name = n;
    _symbol = s;
    _setAdmin(admin);
    ERC777Helper.register(address(this));
    emit Transfer(address(0), address(0), 0);
    emit AdminChanged(address(0), admin);
}
```

### _setAdmin(address)

- **Kind**: internal
- **Source**: 6775:159:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_setAdmin(address)`

```solidity
function _setAdmin(address newAdmin) internal {
    assembly {
        sstore(_ADMIN_SLOT, newAdmin)
    }
}
```

### register(address)

- **Kind**: internal
- **Source**: 898:246:156
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/ERC777Helper.sol:ERC777Helper:register(address)`

```solidity
function register(address token) internal {
    _ERC1820_REGISTRY.setInterfaceImplementer(token, keccak256("ERC777Token"), address(this));
    _ERC1820_REGISTRY.setInterfaceImplementer(token, keccak256("ERC20Token"), address(this));
}
```

### initializer()

- **Kind**: modifier
- **Source**: 3235:495:84
- **Link**: `lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol:Initializable:initializer()`

```solidity
///  @dev A modifier that defines a protected initializer function that can be invoked at most once. In its scope,
///  `onlyInitializing` functions can be used to initialize parent contracts.
///  Similar to `reinitializer(1)`, except that functions marked with `initializer` can be nested in the context of a
///  constructor.
///  Emits an {Initialized} event.
modifier initializer() {
    bool isTopLevelCall = !_initializing;
    require((isTopLevelCall && (_initialized < 1)) || ((!Address.isContract(address(this))) && (_initialized == 1)), "Initializable: contract is already initialized");
    _initialized = 1;
    if (isTopLevelCall) {
        _initializing = true;
    }
    _;
    if (isTopLevelCall) {
        _initializing = false;
        emit Initialized(1);
    }
}
```

### isContract(address)

- **Kind**: internal
- **Source**: 1412:320:103
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Address.sol:Address:isContract(address)`

```solidity
///  @dev Returns true if `account` is a contract.
///  [IMPORTANT]
///  ====
///  It is unsafe to assume that an address for which this function returns
///  false is an externally-owned account (EOA) and not a contract.
///  Among others, `isContract` will return false for the following
///  types of addresses:
///   - an externally-owned account
///   - a contract in construction
///   - an address where a contract will be created
///   - an address where a contract lived, but was destroyed
///  Furthermore, `isContract` will also return true if the target contract within
///  the same transaction is already scheduled for destruction by `SELFDESTRUCT`,
///  which only has an effect at the end of a transaction.
///  ====
///  [IMPORTANT]
///  ====
///  You shouldn't rely on `isContract` to protect against flash loan attacks!
///  Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
///  like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
///  constructor.
///  ====
function isContract(address account) internal view returns (bool) {
    return account.code.length > 0;
}
```

## External Calls

- **IERC1820Registry::setInterfaceImplementer(address,bytes32,address)**

## State Variable Reads

- **_ERC1820_REGISTRY** (`contract IERC1820Registry`) [lib/openzeppelin-contracts/contracts/utils/introspection/IERC1820Registry.sol/interface_IERC1820Registry.md]
- **_initializing** (`bool`)
- **_initialized** (`uint8`)

## State Variable Writes

- **_underlyingToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_underlyingDecimals** (`uint8`)
- **_name** (`string`)
- **_symbol** (`string`)
- **_initialized** (`uint8`)
- **_initializing** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.initialize(contract IERC20,uint8,string,string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperToken._initialize(contract IERC20,uint8,string,string,address) (NodeID: 1)
  │   💬 Args: [underlyingToken, underlyingDecimals, n, s, address(0)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperToken._setAdmin(address) (NodeID: 2)
  │ │   💬 Args: [admin]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ERC777Helper.register(address) (NodeID: 3)
  │     💬 Args: [address(this)]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Initializable.initializer() (NodeID: 4)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Address.isContract(address) (NodeID: 5)
        💬 Args: [address(this)]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Initialize the Super Token proxy

### Interface Documentation

 @dev Initialize the contract
