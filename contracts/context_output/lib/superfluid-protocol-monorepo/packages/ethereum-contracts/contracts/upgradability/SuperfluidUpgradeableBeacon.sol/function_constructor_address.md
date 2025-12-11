# Function: constructor(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/SuperfluidUpgradeableBeacon.sol/contract_SuperfluidUpgradeableBeacon.md]

## Metadata

- **Contract**: SuperfluidUpgradeableBeacon
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 458:74:168

## Implementation

```solidity
constructor(address implementation_) UpgradeableBeacon(implementation_) {}
```

## Related Implementations

### (address)

- **Kind**: internal
- **Source**: 931:89:83
- **Link**: `lib/openzeppelin-contracts/contracts/proxy/beacon/UpgradeableBeacon.sol:UpgradeableBeacon:constructor(address)`

```solidity
///  @dev Sets the address of the initial implementation, and the deployer account as the owner who can upgrade the
///  beacon.
constructor(address implementation_) {
    _setImplementation(implementation_);
}
```

### _setImplementation(address)

- **Kind**: internal
- **Source**: 1811:226:83
- **Link**: `lib/openzeppelin-contracts/contracts/proxy/beacon/UpgradeableBeacon.sol:UpgradeableBeacon:_setImplementation(address)`

```solidity
///  @dev Sets the implementation contract address for this beacon
///  Requirements:
///  - `newImplementation` must be a contract.
function _setImplementation(address newImplementation) private {
    require(Address.isContract(newImplementation), "UpgradeableBeacon: implementation is not a contract");
    _implementation = newImplementation;
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

## State Variable Writes

- **_implementation** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperfluidUpgradeableBeacon.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperfluidUpgradeableBeacon
  └─ [1] 🏗️ CONSTRUCTOR: UpgradeableBeacon.constructor(address) (NodeID: 1)
      💬 Args: [implementation_]
      🏗️  Contract: UpgradeableBeacon
    └─ [2] ⚙️ FUNCTION: UpgradeableBeacon._setImplementation(address) (NodeID: 2)
        💬 Args: [implementation_]
        👁️  Def: private
      └─ [3] ⚙️ FUNCTION: Address.isContract(address) (NodeID: 3)
          💬 Args: [newImplementation]
          👁️  Def: internal
```
