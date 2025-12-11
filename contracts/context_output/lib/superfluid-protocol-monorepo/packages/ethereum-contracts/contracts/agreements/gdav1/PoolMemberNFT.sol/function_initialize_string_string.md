# Function: initialize(string,string)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
- **Signature**: `initialize(string,string)`
- **Visibility**: external
- **Source Range**: 3171:217:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
function initialize(string memory nftName, string memory nftSymbol) override external initializer() {
    _name = nftName;
    _symbol = nftSymbol;
}
```

## Related Implementations

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

## State Variable Reads

- **_initializing** (`bool`)
- **_initialized** (`uint8`)

## State Variable Writes

- **_name** (`string`)
- **_symbol** (`string`)
- **_initialized** (`uint8`)
- **_initializing** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.initialize(string,string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Initializable.initializer() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Address.isContract(address) (NodeID: 2)
        💬 Args: [address(this)]
        👁️  Def: internal
```
