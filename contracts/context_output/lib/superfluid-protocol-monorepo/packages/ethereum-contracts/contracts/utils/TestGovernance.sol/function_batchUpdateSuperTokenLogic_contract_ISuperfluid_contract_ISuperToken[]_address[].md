# Function: batchUpdateSuperTokenLogic(contract ISuperfluid,contract ISuperToken[],address[])

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]

## Metadata

- **Contract**: TestGovernance
- **Signature**: `batchUpdateSuperTokenLogic(contract ISuperfluid,contract ISuperToken[],address[])`
- **Visibility**: external
- **Source Range**: 3506:394:130
- **Inherited From**: SuperfluidGovernanceBase

## Implementation

```solidity
function batchUpdateSuperTokenLogic(ISuperfluid host, ISuperToken[] calldata tokens, address[] calldata tokenLogics) override external onlyAuthorized(host) {
    assert(tokens.length == tokenLogics.length);
    for (uint i = 0; i < tokens.length; ++i) {
        host.updateSuperTokenLogic(tokens[i], tokenLogics[i]);
    }
}
```

## Related Implementations

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

## External Calls

- **ISuperfluid::updateSuperTokenLogic(contract ISuperToken,address)**

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidGovernanceBase.batchUpdateSuperTokenLogic(contract ISuperfluid,contract ISuperToken[],address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: SuperfluidGovernanceBase.onlyAuthorized(contract ISuperfluid) (NodeID: 1)
      💬 Args: [host]
    └─ [2] ⚙️ FUNCTION: TestGovernance._requireAuthorised(contract ISuperfluid) (NodeID: 2)
        💬 Args: [host]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 3)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Ownable.owner() (NodeID: 4)
          💬 Args: [no args]
          👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Update supertoken logic contract to the provided logic contracts.
      Note that this is an overloaded version taking an additional argument `tokenLogics`
