# Function: revokeSubscription(contract ISuperfluidToken,address,uint32,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `revokeSubscription(contract ISuperfluidToken,address,uint32,bytes)`
- **Visibility**: external
- **Source Range**: 16796:2655:122

## Implementation

```solidity
/// @dev IInstantDistributionAgreementV1.revokeSubscription implementation
function revokeSubscription(ISuperfluidToken token, address publisher, uint32 indexId, bytes calldata ctx) override external returns (bytes memory newCtx) {
    _SubscriptionOperationVars memory vars;
    AgreementLibrary.CallbackInputs memory cbStates;
    address subscriber;
    bytes memory userData;
    {
        ISuperfluid.Context memory context = AgreementLibrary.authorizeTokenAccess(token, ctx);
        subscriber = context.msgSender;
        userData = context.userData;
    }
    (vars.iId, vars.sId, vars.idata, , vars.sdata) = _loadAllData(token, publisher, subscriber, indexId, true);
    if (vars.sdata.subId == _UNALLOCATED_SUB_ID) {
        revert IDA_SUBSCRIPTION_IS_NOT_APPROVED();
    }
    cbStates = AgreementLibrary.createCallbackInputs(token, publisher, vars.sId, "");
    newCtx = ctx;
    cbStates.noopBit = SuperAppDefinitions.BEFORE_AGREEMENT_TERMINATED_NOOP;
    vars.cbdata = AgreementLibrary.callAppBeforeCallback(cbStates, newCtx);
    int256 balanceDelta = int256(uint256(vars.idata.indexValue - vars.sdata.indexValue)) * int256(uint256(vars.sdata.units));
    vars.idata.totalUnitsApproved = vars.idata.totalUnitsApproved - vars.sdata.units;
    vars.idata.totalUnitsPending = vars.idata.totalUnitsPending + vars.sdata.units;
    token.updateAgreementData(vars.iId, _encodeIndexData(vars.idata));
    _clearSubsBitmap(token, subscriber, vars.sdata.subId);
    vars.sdata.indexValue = vars.idata.indexValue;
    vars.sdata.subId = _UNALLOCATED_SUB_ID;
    token.updateAgreementData(vars.sId, _encodeSubscriptionData(vars.sdata));
    token.settleBalance(subscriber, balanceDelta);
    cbStates.noopBit = SuperAppDefinitions.AFTER_AGREEMENT_TERMINATED_NOOP;
    (, newCtx) = AgreementLibrary.callAppAfterCallback(cbStates, vars.cbdata, newCtx);
    emit IndexUnsubscribed(token, publisher, indexId, subscriber, userData);
    emit SubscriptionRevoked(token, subscriber, publisher, indexId, userData);
}
```

## Related Implementations

### authorizeTokenAccess(contract ISuperfluidToken,bytes)

- **Kind**: internal
- **Source**: 963:468:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:authorizeTokenAccess(contract ISuperfluidToken,bytes)`

```solidity
///  @dev Authorize the msg.sender to access token agreement storage
///  NOTE:
///  - msg.sender must be the expected host contract.
///  - it should revert on unauthorized access.
function authorizeTokenAccess(ISuperfluidToken token, bytes memory ctx) internal view returns (ISuperfluid.Context memory) {
    require(token.getHost() == msg.sender, "unauthorized host");
    require(ISuperfluid(msg.sender).isCtxValid(ctx), "invalid ctx");
    return ISuperfluid(msg.sender).decodeCtx(ctx);
}
```

### _loadAllData(contract ISuperfluidToken,address,address,uint32,bool)

- **Kind**: internal
- **Source**: 33085:1014:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_loadAllData(contract ISuperfluidToken,address,address,uint32,bool)`

```solidity
function _loadAllData(ISuperfluidToken token, address publisher, address subscriber, uint32 indexId, bool requireSubscriptionExisting) private view returns (bytes32 iId, bytes32 sId, IndexData memory idata, bool subscriptionExists, SubscriptionData memory sdata) {
    bool indexExists;
    iId = _getPublisherId(publisher, indexId);
    sId = _getSubscriptionId(subscriber, iId);
    (indexExists, idata) = _getIndexData(token, iId);
    if (!indexExists) revert IDA_INDEX_DOES_NOT_EXIST();
    (subscriptionExists, sdata) = _getSubscriptionData(token, sId);
    if (requireSubscriptionExisting) {
        if (!subscriptionExists) {
            revert IDA_SUBSCRIPTION_DOES_NOT_EXIST();
        }
        assert(sdata.publisher == publisher);
        assert(sdata.indexId == indexId);
    }
}
```

### _getPublisherId(address,uint32)

- **Kind**: internal
- **Source**: 34290:221:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_getPublisherId(address,uint32)`

```solidity
function _getPublisherId(address publisher, uint32 indexId) private pure returns (bytes32 iId) {
    return keccak256(abi.encodePacked("publisher", publisher, indexId));
}
```

### _getSubscriptionId(address,bytes32)

- **Kind**: internal
- **Source**: 34517:222:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_getSubscriptionId(address,bytes32)`

```solidity
function _getSubscriptionId(address subscriber, bytes32 iId) private pure returns (bytes32 sId) {
    return keccak256(abi.encodePacked("subscription", subscriber, iId));
}
```

### _getIndexData(contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 35754:731:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_getIndexData(contract ISuperfluidToken,bytes32)`

```solidity
function _getIndexData(ISuperfluidToken token, bytes32 iId) private view returns (bool exist, IndexData memory idata) {
    bytes32[] memory adata = token.getAgreementData(address(this), iId, 2);
    uint256 a = uint256(adata[0]);
    uint256 b = uint256(adata[1]);
    exist = a > 0;
    if (exist) {
        idata.indexValue = uint128(a);
        idata.totalUnitsApproved = uint128(b);
        idata.totalUnitsPending = uint128(b >> 128);
    }
}
```

### _getSubscriptionData(contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 38257:865:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_getSubscriptionData(contract ISuperfluidToken,bytes32)`

```solidity
function _getSubscriptionData(ISuperfluidToken token, bytes32 sId) private view returns (bool exist, SubscriptionData memory sdata) {
    bytes32[] memory adata = token.getAgreementData(address(this), sId, 2);
    uint256 a = uint256(adata[0]);
    uint256 b = uint256(adata[1]);
    exist = a > 0;
    if (exist) {
        sdata.publisher = address(uint160(a >> (12 * 8)));
        sdata.indexId = uint32((a >> 32) & type(uint32).max);
        sdata.subId = uint32(a & type(uint32).max);
        sdata.indexValue = uint128(b);
        sdata.units = uint128(b >> 128);
    }
}
```

### createCallbackInputs(contract ISuperfluidToken,address,bytes32,bytes)

- **Kind**: internal
- **Source**: 1871:388:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:createCallbackInputs(contract ISuperfluidToken,address,bytes32,bytes)`

```solidity
function createCallbackInputs(ISuperfluidToken token, address account, bytes32 agreementId, bytes memory agreementData) internal pure returns (CallbackInputs memory inputs) {
    inputs.token = token;
    inputs.account = account;
    inputs.agreementId = agreementId;
    inputs.agreementData = agreementData;
}
```

### callAppBeforeCallback(struct AgreementLibrary.CallbackInputs,bytes)

- **Kind**: internal
- **Source**: 2265:1318:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:callAppBeforeCallback(struct AgreementLibrary.CallbackInputs,bytes)`

```solidity
function callAppBeforeCallback(CallbackInputs memory inputs, bytes memory ctx) internal returns (bytes memory cbdata) {
    bool isSuperApp;
    bool isJailed;
    uint256 noopMask;
    (isSuperApp, isJailed, noopMask) = ISuperfluid(msg.sender).getAppManifest(ISuperApp(inputs.account));
    if (isSuperApp && (!isJailed)) {
        bytes memory appCtx = _pushCallbackStack(ctx, inputs);
        if ((noopMask & inputs.noopBit) == 0) {
            bytes memory callData = abi.encodeWithSelector(_selectorFromNoopBit(inputs.noopBit), inputs.token, address(this), inputs.agreementId, inputs.agreementData, new bytes(0));
            cbdata = ISuperfluid(msg.sender).callAppBeforeCallback(ISuperApp(inputs.account), callData, inputs.noopBit == SuperAppDefinitions.BEFORE_AGREEMENT_TERMINATED_NOOP, appCtx);
        }
        _popCallbackStack(ctx, 0);
    }
}
```

### _pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs)

- **Kind**: internal
- **Source**: 7449:478:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:_pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs)`

```solidity
function _pushCallbackStack(bytes memory ctx, CallbackInputs memory inputs) private returns (bytes memory appCtx) {
    appCtx = ISuperfluid(msg.sender).appCallbackPush(ctx, ISuperApp(inputs.account), inputs.appCreditGranted, inputs.appCreditUsed, inputs.token);
}
```

### _selectorFromNoopBit(uint256)

- **Kind**: internal
- **Source**: 6445:998:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:_selectorFromNoopBit(uint256)`

```solidity
function _selectorFromNoopBit(uint256 noopBit) private pure returns (bytes4 selector) {
    if (noopBit == SuperAppDefinitions.BEFORE_AGREEMENT_CREATED_NOOP) {
        return ISuperApp.beforeAgreementCreated.selector;
    } else if (noopBit == SuperAppDefinitions.BEFORE_AGREEMENT_UPDATED_NOOP) {
        return ISuperApp.beforeAgreementUpdated.selector;
    } else if (noopBit == SuperAppDefinitions.BEFORE_AGREEMENT_TERMINATED_NOOP) {
        return ISuperApp.beforeAgreementTerminated.selector;
    } else if (noopBit == SuperAppDefinitions.AFTER_AGREEMENT_CREATED_NOOP) {
        return ISuperApp.afterAgreementCreated.selector;
    } else if (noopBit == SuperAppDefinitions.AFTER_AGREEMENT_UPDATED_NOOP) {
        return ISuperApp.afterAgreementUpdated.selector;
    } else {
        return ISuperApp.afterAgreementTerminated.selector;
    }
}
```

### _popCallbackStack(bytes,int256)

- **Kind**: internal
- **Source**: 7933:278:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:_popCallbackStack(bytes,int256)`

```solidity
function _popCallbackStack(bytes memory ctx, int256 appCreditUsedDelta) private returns (bytes memory newCtx) {
    return ISuperfluid(msg.sender).appCallbackPop(ctx, appCreditUsedDelta);
}
```

### _encodeIndexData(struct InstantDistributionAgreementV1.IndexData)

- **Kind**: internal
- **Source**: 35022:435:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_encodeIndexData(struct InstantDistributionAgreementV1.IndexData)`

```solidity
function _encodeIndexData(IndexData memory idata) private pure returns (bytes32[] memory data) {
    data = new bytes32[](2);
    data[0] = bytes32(uint256(1 << 128) | uint256(idata.indexValue));
    data[1] = bytes32((uint256(idata.totalUnitsApproved)) | (uint256(idata.totalUnitsPending) << 128));
}
```

### _clearSubsBitmap(contract ISuperfluidToken,address,uint32)

- **Kind**: internal
- **Source**: 40099:293:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_clearSubsBitmap(contract ISuperfluidToken,address,uint32)`

```solidity
function _clearSubsBitmap(ISuperfluidToken token, address subscriber, uint32 subId) private {
    SlotsBitmapLibrary.clearSlot(token, subscriber, _SUBSCRIBER_SUBS_BITMAP_STATE_SLOT_ID, subId);
}
```

### clearSlot(contract ISuperfluidToken,address,uint256,uint32)

- **Kind**: internal
- **Source**: 2027:714:158
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SlotsBitmapLibrary.sol:SlotsBitmapLibrary:clearSlot(contract ISuperfluidToken,address,uint256,uint32)`

```solidity
function clearSlot(ISuperfluidToken token, address account, uint256 bitmapStateSlotId, uint32 slotId) public {
    uint256 subsBitmap = uint256(token.getAgreementStateSlot(address(this), account, bitmapStateSlotId, 1)[0]);
    bytes32[] memory slotData = new bytes32[](1);
    assert((subsBitmap & (1 << uint256(slotId))) != 0);
    slotData[0] = bytes32(subsBitmap & (~(1 << uint256(slotId))));
    token.updateAgreementStateSlot(account, bitmapStateSlotId, slotData);
}
```

### _encodeSubscriptionData(struct InstantDistributionAgreementV1.SubscriptionData)

- **Kind**: internal
- **Source**: 37772:479:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_encodeSubscriptionData(struct InstantDistributionAgreementV1.SubscriptionData)`

```solidity
function _encodeSubscriptionData(SubscriptionData memory sdata) private pure returns (bytes32[] memory data) {
    data = new bytes32[](2);
    data[0] = bytes32(((uint256(uint160(sdata.publisher)) << (12 * 8)) | (uint256(sdata.indexId) << 32)) | uint256(sdata.subId));
    data[1] = bytes32(uint256(sdata.indexValue) | (uint256(sdata.units) << 128));
}
```

### callAppAfterCallback(struct AgreementLibrary.CallbackInputs,bytes,bytes)

- **Kind**: internal
- **Source**: 3589:1805:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:callAppAfterCallback(struct AgreementLibrary.CallbackInputs,bytes,bytes)`

```solidity
function callAppAfterCallback(CallbackInputs memory inputs, bytes memory cbdata, bytes memory ctx) internal returns (ISuperfluid.Context memory appContext, bytes memory newCtx) {
    bool isSuperApp;
    bool isJailed;
    uint256 noopMask;
    (isSuperApp, isJailed, noopMask) = ISuperfluid(msg.sender).getAppManifest(ISuperApp(inputs.account));
    newCtx = ctx;
    if (isSuperApp && (!isJailed)) {
        newCtx = _pushCallbackStack(newCtx, inputs);
        if ((noopMask & inputs.noopBit) == 0) {
            bytes memory callData = abi.encodeWithSelector(_selectorFromNoopBit(inputs.noopBit), inputs.token, address(this), inputs.agreementId, inputs.agreementData, cbdata, new bytes(0));
            newCtx = ISuperfluid(msg.sender).callAppAfterCallback(ISuperApp(inputs.account), callData, inputs.noopBit == SuperAppDefinitions.AFTER_AGREEMENT_TERMINATED_NOOP, newCtx);
            appContext = ISuperfluid(msg.sender).decodeCtx(newCtx);
            appContext.appCreditUsed = _adjustNewAppCreditUsed(inputs.appCreditGranted, appContext.appCreditUsed);
        }
        newCtx = _popCallbackStack(ctx, appContext.appCreditUsed);
    }
}
```

### _adjustNewAppCreditUsed(uint256,int256)

- **Kind**: internal
- **Source**: 5695:744:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:_adjustNewAppCreditUsed(uint256,int256)`

```solidity
///  @dev Determines how much app credit the app will use.
///  @param appCreditGranted set prior to callback based on input flow
///  @param appCallbackDepositDelta set in callback - sum of deposit deltas of callback agreements and
///  current flow owed deposit amount
function _adjustNewAppCreditUsed(uint256 appCreditGranted, int256 appCallbackDepositDelta) internal pure returns (int256) {
    return max(0, min(appCreditGranted.toInt256(), appCallbackDepositDelta));
}
```

### max(int256,int256)

- **Kind**: internal
- **Source**: 8390:89:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:max(int256,int256)`

```solidity
function max(int256 a, int256 b) internal pure returns (int256) {
    return (a > b) ? a : b;
}
```

### min(int256,int256)

- **Kind**: internal
- **Source**: 8582:89:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:min(int256,int256)`

```solidity
function min(int256 a, int256 b) internal pure returns (int256) {
    return (a > b) ? b : a;
}
```

### toInt256(uint256)

- **Kind**: internal
- **Source**: 34781:297:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toInt256(uint256)`

```solidity
///  @dev Converts an unsigned uint256 into a signed int256.
///  Requirements:
///  - input must be less than or equal to maxInt256.
///  _Available since v3.0._
function toInt256(uint256 value) internal pure returns (int256) {
    require(value <= uint256(type(int256).max), "SafeCast: value doesn't fit in an int256");
    return int256(value);
}
```

## External Calls

- **ISuperfluidToken::updateAgreementData(bytes32,bytes32[])**
- **ISuperfluidToken::settleBalance(address,int256)**
- **ISuperfluidToken::getHost()**
- **ISuperfluid::isCtxValid(bytes)**
- **ISuperfluid::decodeCtx(bytes)**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**
- **ISuperfluid::getAppManifest(contract ISuperApp)**
- **ISuperfluid::callAppBeforeCallback(contract ISuperApp,bytes,bool,bytes)**
- **ISuperfluid::appCallbackPush(bytes,contract ISuperApp,uint256,int256,contract ISuperfluidToken)**
- **ISuperfluid::appCallbackPop(bytes,int256)**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**
- **ISuperfluid::callAppAfterCallback(contract ISuperApp,bytes,bool,bytes)**

## State Variable Reads

- **_UNALLOCATED_SUB_ID** (`uint32`)
- **_SUBSCRIBER_SUBS_BITMAP_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InstantDistributionAgreementV1.revokeSubscription(contract ISuperfluidToken,address,uint32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 1)
  │   💬 Args: [token, ctx]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._loadAllData(contract ISuperfluidToken,address,address,uint32,bool) (NodeID: 2)
  │   💬 Args: [token, publisher, subscriber, indexId, true]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getPublisherId(address,uint32) (NodeID: 3)
  │ │   💬 Args: [publisher, indexId]
  │ │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getSubscriptionId(address,bytes32) (NodeID: 4)
  │ │   💬 Args: [subscriber, iId]
  │ │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getIndexData(contract ISuperfluidToken,bytes32) (NodeID: 5)
  │ │   💬 Args: [token, iId]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getSubscriptionData(contract ISuperfluidToken,bytes32) (NodeID: 6)
  │     💬 Args: [token, sId]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.createCallbackInputs(contract ISuperfluidToken,address,bytes32,bytes) (NodeID: 7)
  │   💬 Args: [token, publisher, vars.sId, ""]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.callAppBeforeCallback(struct AgreementLibrary.CallbackInputs,bytes) (NodeID: 8)
  │   💬 Args: [cbStates, newCtx]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 9)
  │ │   💬 Args: [ctx, inputs]
  │ │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 10)
  │ │   💬 Args: [inputs.noopBit]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 11)
  │     💬 Args: [ctx, 0]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._encodeIndexData(struct InstantDistributionAgreementV1.IndexData) (NodeID: 12)
  │   💬 Args: [vars.idata]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._clearSubsBitmap(contract ISuperfluidToken,address,uint32) (NodeID: 13)
  │   💬 Args: [token, subscriber, vars.sdata.subId]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: SlotsBitmapLibrary.clearSlot(contract ISuperfluidToken,address,uint256,uint32) (NodeID: 14)
  │     💬 Args: [token, subscriber, _SUBSCRIBER_SUBS_BITMAP_STATE_SLOT_ID, subId]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._encodeSubscriptionData(struct InstantDistributionAgreementV1.SubscriptionData) (NodeID: 15)
  │   💬 Args: [vars.sdata]
  │   👁️  Def: private
  └─ [1] ⚙️ FUNCTION: AgreementLibrary.callAppAfterCallback(struct AgreementLibrary.CallbackInputs,bytes,bytes) (NodeID: 16)
      💬 Args: [cbStates, vars.cbdata, newCtx]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 17)
    │   💬 Args: [newCtx, inputs]
    │   👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 18)
    │   💬 Args: [inputs.noopBit]
    │   👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AgreementLibrary._adjustNewAppCreditUsed(uint256,int256) (NodeID: 19)
    │   💬 Args: [inputs.appCreditGranted, appContext.appCreditUsed]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AgreementLibrary.max(int256,int256) (NodeID: 20)
    │     💬 Args: [0, min(appCreditGranted.toInt256(), appCallbackDepositDelta)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 21)
    │       💬 Args: [appCreditGranted.toInt256(), appCallbackDepositDelta]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 22)
    │         💬 Args: [appCreditGranted]
    │         👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 23)
        💬 Args: [ctx, appContext.appCreditUsed]
        👁️  Def: private
```

## Documentation

### Function Documentation

@dev IInstantDistributionAgreementV1.revokeSubscription implementation
