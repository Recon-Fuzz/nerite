# Function: clearSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperToken)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `clearSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperToken)`
- **Visibility**: external
- **Source Range**: 11977:305:130
- **Inherited From**: SuperfluidGovernanceBase

## Implementation

```solidity
function clearSuperTokenMinimumDeposit(ISuperfluid host, ISuperToken superToken) external {
    _clearConfig(host, superToken, SuperfluidGovernanceConfigs.SUPERTOKEN_MINIMUM_DEPOSIT_KEY);
    emit SuperTokenMinimumDepositChanged(host, superToken, false, 0);
}
```

## Related Implementations

### _clearConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 6440:307:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:_clearConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32)`

```solidity
function _clearConfig(ISuperfluid host, ISuperfluidToken superToken, bytes32 key) internal onlyAuthorized(host) {
    emit ConfigChanged(host, superToken, key, false, 0);
    _configs[address(host)][address(superToken)][key] = Value(false, 0);
}
```

### onlyAuthorized(contract ISuperfluid)

- **Kind**: modifier
- **Source**: 17371:94:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:onlyAuthorized(contract ISuperfluid)`

```solidity
modifier onlyAuthorized(ISuperfluid host) {
    _requireAuthorised(host);
    _;
}
```

### _requireAuthorised(contract ISuperfluid)

- **Kind**: internal
- **Source**: 1275:160:184
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol:TestGovernance:_requireAuthorised(contract ISuperfluid)`

```solidity
function _requireAuthorised(ISuperfluid host) override internal view {
    assert(host == _host);
    assert(owner() == _msgSender());
}
```

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:104
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### owner()

- **Kind**: internal
- **Source**: 1201:85:71
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:owner()`

```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address) {
    return _owner;
}
```

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_owner** (`address`)

## State Variable Writes

- **_configs** (`mapping(address => mapping(address => mapping(bytes32 => struct SuperfluidGovernanceBase.Value)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidGovernanceBase.clearSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperToken) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase._clearConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32) (NodeID: 1)
      💬 Args: [host, superToken, SuperfluidGovernanceConfigs.SUPERTOKEN_MINIMUM_DEPOSIT_KEY]
      👁️  Def: internal
    └─ [2] 🔒 MODIFIER: SuperfluidGovernanceBase.onlyAuthorized(contract ISuperfluid) (NodeID: 2)
        💬 Args: [host]
      └─ [3] ⚙️ FUNCTION: TestGovernance._requireAuthorised(contract ISuperfluid) (NodeID: 3)
          💬 Args: [host]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 4)
        │   💬 Args: [no args]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Ownable.owner() (NodeID: 5)
            💬 Args: [no args]
            👁️  Def: public
```
