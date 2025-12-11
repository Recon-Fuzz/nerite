# Function: jailApp(bytes,contract ISuperApp,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `jailApp(bytes,contract ISuperApp,uint256)`
- **Visibility**: external
- **Source Range**: 23014:274:163

## Implementation

```solidity
function jailApp(bytes calldata ctx, ISuperApp app, uint256 reason) override external onlyAgreement() assertValidCtx(ctx) returns (bytes memory newCtx) {
    _jailApp(app, reason);
    return ctx;
}
```

## Related Implementations

### _jailApp(contract ISuperApp,uint256)

- **Kind**: internal
- **Source**: 36692:289:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_jailApp(contract ISuperApp,uint256)`

```solidity
function _jailApp(ISuperApp app, uint256 reason) internal {
    if ((_appManifests[app].configWord & SuperAppDefinitions.APP_JAIL_BIT) == 0) {
        _appManifests[app].configWord |= SuperAppDefinitions.APP_JAIL_BIT;
        emit Jail(app, reason);
    }
}
```

### assertValidCtx(bytes)

- **Kind**: modifier
- **Source**: 43756:94:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:assertValidCtx(bytes)`

```solidity
modifier assertValidCtx(bytes memory ctx) {
    assert(_isCtxValid(ctx));
    _;
}
```

### _isCtxValid(bytes)

- **Kind**: internal
- **Source**: 39285:137:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_isCtxValid(bytes)`

```solidity
function _isCtxValid(bytes memory ctx) private view returns (bool) {
    return (ctx.length != 0) && (keccak256(ctx) == _ctxStamp);
}
```

### onlyAgreement()

- **Kind**: modifier
- **Source**: 44305:170:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:onlyAgreement()`

```solidity
modifier onlyAgreement() {
    if (!isAgreementClassListed(ISuperAgreement(msg.sender))) {
        revert HOST_ONLY_LISTED_AGREEMENT();
    }
    _;
}
```

### isAgreementClassListed(contract ISuperAgreement)

- **Kind**: internal
- **Source**: 8208:394:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:isAgreementClassListed(contract ISuperAgreement)`

```solidity
function isAgreementClassListed(ISuperAgreement agreementClass) override public view returns (bool yes) {
    bytes32 agreementType = agreementClass.agreementType();
    uint idx = _agreementClassIndices[agreementType];
    return (idx != 0) && (_agreementClasses[idx - 1] == agreementClass);
}
```

## External Calls

- **ISuperAgreement::agreementType()**

## State Variable Reads

- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]
- **_ctxStamp** (`bytes32`)
- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)
- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]

## State Variable Writes

- **_appManifests** (`mapping(contract ISuperApp => struct Superfluid.AppManifest)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol/interface_ISuperApp.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.jailApp(bytes,contract ISuperApp,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Superfluid._jailApp(contract ISuperApp,uint256) (NodeID: 1)
  │   💬 Args: [app, reason]
  │   👁️  Def: internal
  ├─ [1] 🔒 MODIFIER: Superfluid.assertValidCtx(bytes) (NodeID: 2)
  │   💬 Args: [ctx]
  │ └─ [2] ⚙️ FUNCTION: Superfluid._isCtxValid(bytes) (NodeID: 3)
  │     💬 Args: [ctx]
  │     👁️  Def: private
  └─ [1] 🔒 MODIFIER: Superfluid.onlyAgreement() (NodeID: 4)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Superfluid.isAgreementClassListed(contract ISuperAgreement) (NodeID: 5)
        💬 Args: [ISuperAgreement(msg.sender)]
        👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev (For agreements) Jail the app.
 @param  app                     The super app.
 @param  reason                  Jail reason code.
 @return newCtx                  The current context of the transaction.
