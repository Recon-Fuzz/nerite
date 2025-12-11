# Function: batchUpdateSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperToken[],uint256[])

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `batchUpdateSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperToken[],uint256[])`
- **Visibility**: external
- **Source Range**: 3906:443:130
- **Inherited From**: SuperfluidGovernanceBase

## Implementation

```solidity
function batchUpdateSuperTokenMinimumDeposit(ISuperfluid host, ISuperToken[] calldata tokens, uint256[] calldata minimumDeposits) external {
    assert(tokens.length == minimumDeposits.length);
    for (uint i = 0; i < minimumDeposits.length; ++i) {
        setSuperTokenMinimumDeposit(host, tokens[i], minimumDeposits[i]);
    }
}
```

## Related Implementations

### setSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperfluidToken,uint256)

- **Kind**: internal
- **Source**: 11634:337:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:setSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperfluidToken,uint256)`

```solidity
function setSuperTokenMinimumDeposit(ISuperfluid host, ISuperfluidToken superToken, uint256 value) public {
    _setConfig(host, superToken, SuperfluidGovernanceConfigs.SUPERTOKEN_MINIMUM_DEPOSIT_KEY, value);
    emit SuperTokenMinimumDepositChanged(host, superToken, true, value);
}
```

### _setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256)

- **Kind**: internal
- **Source**: 6100:334:130
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/gov/SuperfluidGovernanceBase.sol:SuperfluidGovernanceBase:_setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256)`

```solidity
function _setConfig(ISuperfluid host, ISuperfluidToken superToken, bytes32 key, uint256 value) internal onlyAuthorized(host) {
    emit ConfigChanged(host, superToken, key, true, value);
    _configs[address(host)][address(superToken)][key] = Value(true, value);
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
┌─ [0] ⚙️ FUNCTION: SuperfluidGovernanceBase.batchUpdateSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperToken[],uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidGovernanceBase.setSuperTokenMinimumDeposit(contract ISuperfluid,contract ISuperfluidToken,uint256) (NodeID: 1)
      💬 Args: [host, tokens[i], minimumDeposits[i]]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: SuperfluidGovernanceBase._setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256) (NodeID: 2)
        💬 Args: [host, superToken, SuperfluidGovernanceConfigs.SUPERTOKEN_MINIMUM_DEPOSIT_KEY, value]
        👁️  Def: internal
      └─ [3] 🔒 MODIFIER: SuperfluidGovernanceBase.onlyAuthorized(contract ISuperfluid) (NodeID: 3)
          💬 Args: [host]
        └─ [4] ⚙️ FUNCTION: TestGovernance._requireAuthorised(contract ISuperfluid) (NodeID: 4)
            💬 Args: [host]
            👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: Context._msgSender() (NodeID: 5)
          │   💬 Args: [no args]
          │   👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: Ownable.owner() (NodeID: 6)
              💬 Args: [no args]
              👁️  Def: public
```
