# Function: updateSubscription(contract ISuperfluidToken,uint32,address,uint128,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `updateSubscription(contract ISuperfluidToken,uint32,address,uint128,bytes)`
- **Visibility**: external
- **Source Range**: 19536:4738:122

## Implementation

```solidity
/// @dev IInstantDistributionAgreementV1.updateSubscription implementation
function updateSubscription(ISuperfluidToken token, uint32 indexId, address subscriber, uint128 units, bytes calldata ctx) override external returns (bytes memory newCtx) {
    if (subscriber == address(0)) {
        revert IDA_ZERO_ADDRESS_SUBSCRIBER();
    }
    _SubscriptionOperationVars memory vars;
    AgreementLibrary.CallbackInputs memory cbStates;
    bytes memory userData;
    address publisher;
    {
        ISuperfluid.Context memory context = AgreementLibrary.authorizeTokenAccess(token, ctx);
        userData = context.userData;
        publisher = context.msgSender;
    }
    (vars.iId, vars.sId, vars.idata, vars.subscriptionExists, vars.sdata) = _loadAllData(token, publisher, subscriber, indexId, false);
    cbStates = AgreementLibrary.createCallbackInputs(token, subscriber, vars.sId, "");
    newCtx = ctx;
    if (vars.subscriptionExists) {
        cbStates.noopBit = SuperAppDefinitions.BEFORE_AGREEMENT_UPDATED_NOOP;
        vars.cbdata = AgreementLibrary.callAppBeforeCallback(cbStates, newCtx);
    } else {
        cbStates.noopBit = SuperAppDefinitions.BEFORE_AGREEMENT_CREATED_NOOP;
        vars.cbdata = AgreementLibrary.callAppBeforeCallback(cbStates, newCtx);
    }
    if (vars.subscriptionExists && (vars.sdata.subId != _UNALLOCATED_SUB_ID)) {
        vars.idata.totalUnitsApproved = ((uint256(vars.idata.totalUnitsApproved) + uint256(units)) - uint256(vars.sdata.units)).toUint128();
        token.updateAgreementData(vars.iId, _encodeIndexData(vars.idata));
    } else if (vars.subscriptionExists) {
        vars.idata.totalUnitsPending = ((uint256(vars.idata.totalUnitsPending) + uint256(units)) - uint256(vars.sdata.units)).toUint128();
        token.updateAgreementData(vars.iId, _encodeIndexData(vars.idata));
    } else {
        vars.sdata = SubscriptionData({publisher: publisher, indexId: indexId, subId: _UNALLOCATED_SUB_ID, units: units, indexValue: vars.idata.indexValue});
        token.createAgreement(vars.sId, _encodeSubscriptionData(vars.sdata));
        vars.idata.totalUnitsPending = vars.idata.totalUnitsPending + units;
        token.updateAgreementData(vars.iId, _encodeIndexData(vars.idata));
    }
    int256 balanceDelta = int256(uint256(vars.idata.indexValue - vars.sdata.indexValue)) * int256(uint256(vars.sdata.units));
    if (vars.sdata.subId == _UNALLOCATED_SUB_ID) {
        _adjustPublisherDeposit(token, publisher, -balanceDelta);
        token.settleBalance(publisher, -balanceDelta);
    }
    token.settleBalance(subscriber, balanceDelta);
    if (vars.subscriptionExists) {
        vars.sdata.indexValue = vars.idata.indexValue;
        vars.sdata.units = units;
        token.updateAgreementData(vars.sId, _encodeSubscriptionData(vars.sdata));
    }
    if (vars.subscriptionExists) {
        cbStates.noopBit = SuperAppDefinitions.AFTER_AGREEMENT_UPDATED_NOOP;
        (, newCtx) = AgreementLibrary.callAppAfterCallback(cbStates, vars.cbdata, newCtx);
    } else {
        cbStates.noopBit = SuperAppDefinitions.AFTER_AGREEMENT_CREATED_NOOP;
        (, newCtx) = AgreementLibrary.callAppAfterCallback(cbStates, vars.cbdata, newCtx);
    }
    emit IndexUnitsUpdated(token, publisher, indexId, subscriber, units, userData);
    emit SubscriptionUnitsUpdated(token, subscriber, publisher, indexId, units, userData);
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

### toUint128(uint256)

- **Kind**: internal
- **Source**: 9088:192:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint128(uint256)`

```solidity
///  @dev Returns the downcasted uint128 from uint256, reverting on
///  overflow (when the input is greater than largest uint128).
///  Counterpart to Solidity's `uint128` operator.
///  Requirements:
///  - input must fit into 128 bits
///  _Available since v2.5._
function toUint128(uint256 value) internal pure returns (uint128) {
    require(value <= type(uint128).max, "SafeCast: value doesn't fit in 128 bits");
    return uint128(value);
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

### _adjustPublisherDeposit(contract ISuperfluidToken,address,int256)

- **Kind**: internal
- **Source**: 36947:553:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_adjustPublisherDeposit(contract ISuperfluidToken,address,int256)`

```solidity
function _adjustPublisherDeposit(ISuperfluidToken token, address publisher, int256 delta) private {
    if (delta == 0) return;
    bytes32[] memory data = token.getAgreementStateSlot(address(this), publisher, _PUBLISHER_DEPOSIT_STATE_SLOT_ID, 1);
    data[0] = bytes32(uint256(uint256(data[0]).toInt256() + delta));
    token.updateAgreementStateSlot(publisher, _PUBLISHER_DEPOSIT_STATE_SLOT_ID, data);
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

## External Calls

- **ISuperfluidToken::updateAgreementData(bytes32,bytes32[])**
- **ISuperfluidToken::createAgreement(bytes32,bytes32[])**
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
- **_PUBLISHER_DEPOSIT_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InstantDistributionAgreementV1.updateSubscription(contract ISuperfluidToken,uint32,address,uint128,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 1)
  │   💬 Args: [token, ctx]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._loadAllData(contract ISuperfluidToken,address,address,uint32,bool) (NodeID: 2)
  │   💬 Args: [token, publisher, subscriber, indexId, false]
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
  │   💬 Args: [token, subscriber, vars.sId, ""]
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
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.callAppBeforeCallback(struct AgreementLibrary.CallbackInputs,bytes) (NodeID: 12)
  │   💬 Args: [cbStates, newCtx]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 13)
  │ │   💬 Args: [ctx, inputs]
  │ │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 14)
  │ │   💬 Args: [inputs.noopBit]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 15)
  │     💬 Args: [ctx, 0]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 16)
  │   💬 Args: [((uint256(vars.idata.totalUnitsApproved) + uint256(units)) - uint256(vars.sdata.units))]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._encodeIndexData(struct InstantDistributionAgreementV1.IndexData) (NodeID: 17)
  │   💬 Args: [vars.idata]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 18)
  │   💬 Args: [((uint256(vars.idata.totalUnitsPending) + uint256(units)) - uint256(vars.sdata.units))]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._encodeIndexData(struct InstantDistributionAgreementV1.IndexData) (NodeID: 19)
  │   💬 Args: [vars.idata]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._encodeSubscriptionData(struct InstantDistributionAgreementV1.SubscriptionData) (NodeID: 20)
  │   💬 Args: [vars.sdata]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._encodeIndexData(struct InstantDistributionAgreementV1.IndexData) (NodeID: 21)
  │   💬 Args: [vars.idata]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._adjustPublisherDeposit(contract ISuperfluidToken,address,int256) (NodeID: 22)
  │   💬 Args: [token, publisher, -balanceDelta]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 23)
  │     💬 Args: [uint256(data[0])]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._encodeSubscriptionData(struct InstantDistributionAgreementV1.SubscriptionData) (NodeID: 24)
  │   💬 Args: [vars.sdata]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.callAppAfterCallback(struct AgreementLibrary.CallbackInputs,bytes,bytes) (NodeID: 25)
  │   💬 Args: [cbStates, vars.cbdata, newCtx]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 26)
  │ │   💬 Args: [newCtx, inputs]
  │ │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 27)
  │ │   💬 Args: [inputs.noopBit]
  │ │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: AgreementLibrary._adjustNewAppCreditUsed(uint256,int256) (NodeID: 28)
  │ │   💬 Args: [inputs.appCreditGranted, appContext.appCreditUsed]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: AgreementLibrary.max(int256,int256) (NodeID: 29)
  │ │     💬 Args: [0, min(appCreditGranted.toInt256(), appCallbackDepositDelta)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 30)
  │ │       💬 Args: [appCreditGranted.toInt256(), appCallbackDepositDelta]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 31)
  │ │         💬 Args: [appCreditGranted]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 32)
  │     💬 Args: [ctx, appContext.appCreditUsed]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: AgreementLibrary.callAppAfterCallback(struct AgreementLibrary.CallbackInputs,bytes,bytes) (NodeID: 33)
      💬 Args: [cbStates, vars.cbdata, newCtx]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 34)
    │   💬 Args: [newCtx, inputs]
    │   👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 35)
    │   💬 Args: [inputs.noopBit]
    │   👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AgreementLibrary._adjustNewAppCreditUsed(uint256,int256) (NodeID: 36)
    │   💬 Args: [inputs.appCreditGranted, appContext.appCreditUsed]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AgreementLibrary.max(int256,int256) (NodeID: 37)
    │     💬 Args: [0, min(appCreditGranted.toInt256(), appCallbackDepositDelta)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 38)
    │       💬 Args: [appCreditGranted.toInt256(), appCallbackDepositDelta]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 39)
    │         💬 Args: [appCreditGranted]
    │         👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 40)
        💬 Args: [ctx, appContext.appCreditUsed]
        👁️  Def: private
```

## Documentation

### Function Documentation

@dev IInstantDistributionAgreementV1.updateSubscription implementation
