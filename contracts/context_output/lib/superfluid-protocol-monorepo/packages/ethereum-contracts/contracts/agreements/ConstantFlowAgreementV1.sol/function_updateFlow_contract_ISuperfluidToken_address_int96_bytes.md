# Function: updateFlow(contract ISuperfluidToken,address,int96,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `updateFlow(contract ISuperfluidToken,address,int96,bytes)`
- **Visibility**: external
- **Source Range**: 8965:863:121

## Implementation

```solidity
/// @dev IConstantFlowAgreementV1.updateFlow implementation
function updateFlow(ISuperfluidToken token, address receiver, int96 flowRate, bytes calldata ctx) override external returns (bytes memory newCtx) {
    ISuperfluid.Context memory currentContext = AgreementLibrary.authorizeTokenAccess(token, ctx);
    _StackVars_createOrUpdateFlow memory flowVars;
    flowVars.token = token;
    flowVars.sender = currentContext.msgSender;
    flowVars.receiver = receiver;
    flowVars.flowRate = flowRate;
    bytes32 flowId = _generateFlowId(flowVars.sender, flowVars.receiver);
    (bool exist, FlowData memory oldFlowData) = _getAgreementData(flowVars.token, flowId);
    newCtx = _updateFlow(flowVars, oldFlowData, exist, ctx, currentContext);
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

### _generateFlowId(address,address)

- **Kind**: internal
- **Source**: 57122:155:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_generateFlowId(address,address)`

```solidity
function _generateFlowId(address sender, address receiver) private pure returns (bytes32 id) {
    return keccak256(abi.encode(sender, receiver));
}
```

### _getAgreementData(contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 34880:298:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_getAgreementData(contract ISuperfluidToken,bytes32)`

```solidity
function _getAgreementData(ISuperfluidToken token, bytes32 dId) private view returns (bool exist, FlowData memory) {
    bytes32[] memory data = token.getAgreementData(address(this), dId, 1);
    return _decodeFlowData(uint256(data[0]));
}
```

### _decodeFlowData(uint256)

- **Kind**: internal
- **Source**: 58188:688:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_decodeFlowData(uint256)`

```solidity
function _decodeFlowData(uint256 wordA) internal pure returns (bool exist, FlowData memory flowData) {
    exist = wordA > 0;
    if (exist) {
        flowData.timestamp = uint32(wordA >> 224);
        flowData.flowRate = int96(int256(wordA >> 128) & int256(uint256(type(uint96).max)));
        flowData.deposit = ((wordA >> 64) & uint256(type(uint64).max)) << 32;
        flowData.owedDeposit = (wordA & uint256(type(uint64).max)) << 32;
    }
}
```

### _updateFlow(struct ConstantFlowAgreementV1._StackVars_createOrUpdateFlow,struct ConstantFlowAgreementV1.FlowData,bool,bytes,struct ISuperfluid.Context)

- **Kind**: internal
- **Source**: 15316:954:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_updateFlow(struct ConstantFlowAgreementV1._StackVars_createOrUpdateFlow,struct ConstantFlowAgreementV1.FlowData,bool,bytes,struct ISuperfluid.Context)`

```solidity
function _updateFlow(_StackVars_createOrUpdateFlow memory flowVars, FlowData memory oldFlowData, bool exist, bytes calldata ctx, ISuperfluid.Context memory currentContext) internal returns (bytes memory newCtx) {
    (, FlowParams memory flowParams) = _createOrUpdateFlowCheck(flowVars, currentContext);
    if (!exist) revert CFA_FLOW_DOES_NOT_EXIST();
    if (ISuperfluid(msg.sender).isApp(ISuperApp(flowVars.receiver))) {
        newCtx = _changeFlowToApp(flowVars.receiver, flowVars.token, flowParams, oldFlowData, ctx, currentContext, FlowChangeType.UPDATE_FLOW);
    } else {
        newCtx = _changeFlowToNonApp(flowVars.token, flowParams, oldFlowData, ctx, currentContext);
    }
    _requireAvailableBalance(flowVars.token, flowVars.sender, currentContext);
}
```

### _createOrUpdateFlowCheck(struct ConstantFlowAgreementV1._StackVars_createOrUpdateFlow,struct ISuperfluid.Context)

- **Kind**: internal
- **Source**: 13437:862:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_createOrUpdateFlowCheck(struct ConstantFlowAgreementV1._StackVars_createOrUpdateFlow,struct ISuperfluid.Context)`

```solidity
///  @dev Checks conditions for both create/update flow
///  returns the flowId and flowParams
function _createOrUpdateFlowCheck(_StackVars_createOrUpdateFlow memory flowVars, ISuperfluid.Context memory currentContext) internal pure returns (bytes32 flowId, FlowParams memory flowParams) {
    if (flowVars.receiver == address(0)) {
        revert CFA_ZERO_ADDRESS_RECEIVER();
    }
    flowId = _generateFlowId(flowVars.sender, flowVars.receiver);
    flowParams.flowId = flowId;
    flowParams.sender = flowVars.sender;
    flowParams.receiver = flowVars.receiver;
    flowParams.flowOperator = currentContext.msgSender;
    flowParams.flowRate = flowVars.flowRate;
    flowParams.userData = currentContext.userData;
    if (flowParams.sender == flowParams.receiver) revert CFA_NO_SELF_FLOW();
    if (flowParams.flowRate <= 0) revert CFA_INVALID_FLOW_RATE();
}
```

### _changeFlowToApp(address,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context,enum ConstantFlowAgreementV1.FlowChangeType)

- **Kind**: internal
- **Source**: 38574:7592:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_changeFlowToApp(address,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context,enum ConstantFlowAgreementV1.FlowChangeType)`

```solidity
function _changeFlowToApp(address appToCallback, ISuperfluidToken token, FlowParams memory flowParams, FlowData memory oldFlowData, bytes memory ctx, ISuperfluid.Context memory currentContext, FlowChangeType optype) private returns (bytes memory newCtx) {
    newCtx = ctx;
    _StackVars_changeFlowToApp memory vars;
    if (appToCallback != address(0)) {
        AgreementLibrary.CallbackInputs memory cbStates = AgreementLibrary.createCallbackInputs(token, appToCallback, flowParams.flowId, abi.encode(flowParams.sender, flowParams.receiver));
        if (optype == FlowChangeType.CREATE_FLOW) {
            cbStates.noopBit = SuperAppDefinitions.BEFORE_AGREEMENT_CREATED_NOOP;
        } else if (optype == FlowChangeType.UPDATE_FLOW) {
            cbStates.noopBit = SuperAppDefinitions.BEFORE_AGREEMENT_UPDATED_NOOP;
        } else {
            cbStates.noopBit = SuperAppDefinitions.BEFORE_AGREEMENT_TERMINATED_NOOP;
        }
        vars.cbdata = AgreementLibrary.callAppBeforeCallback(cbStates, ctx);
        ISuperfluidGovernance gov = ISuperfluidGovernance(ISuperfluid(msg.sender).getGovernance());
        (, cbStates.appCreditGranted, ) = _changeFlow(currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData);
        uint256 minimumDeposit = gov.getConfigAsUint256(ISuperfluid(msg.sender), token, SuperfluidGovernanceConfigs.SUPERTOKEN_MINIMUM_DEPOSIT_KEY);
        uint256 additionalAppCreditAmount = (cbStates.appCreditGranted == 0) ? 0 : AgreementLibrary.max(DEFAULT_MINIMUM_DEPOSIT, minimumDeposit);
        cbStates.appCreditGranted = cbStates.appCreditGranted + additionalAppCreditAmount;
        cbStates.appCreditUsed = oldFlowData.owedDeposit.toInt256();
        if (optype == FlowChangeType.CREATE_FLOW) {
            cbStates.noopBit = SuperAppDefinitions.AFTER_AGREEMENT_CREATED_NOOP;
        } else if (optype == FlowChangeType.UPDATE_FLOW) {
            cbStates.noopBit = SuperAppDefinitions.AFTER_AGREEMENT_UPDATED_NOOP;
        } else {
            cbStates.noopBit = SuperAppDefinitions.AFTER_AGREEMENT_TERMINATED_NOOP;
        }
        (vars.appContext, newCtx) = AgreementLibrary.callAppAfterCallback(cbStates, vars.cbdata, newCtx);
        (, vars.newFlowData) = _getAgreementData(token, flowParams.flowId);
    } else {
        (, , vars.newFlowData) = _changeFlow(currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData);
    }
    {
        int256 appCreditDelta = vars.appContext.appCreditUsed - oldFlowData.owedDeposit.toInt256();
        {
            vars.newFlowData.deposit = (vars.newFlowData.deposit.toInt256() + appCreditDelta).toUint256();
            vars.newFlowData.owedDeposit = (vars.newFlowData.owedDeposit.toInt256() + appCreditDelta).toUint256();
            token.updateAgreementData(flowParams.flowId, _encodeFlowData(vars.newFlowData));
            _updateAccountFlowState(token, flowParams.sender, 0, appCreditDelta, 0, currentContext.timestamp);
            _updateAccountFlowState(token, flowParams.receiver, 0, 0, appCreditDelta, currentContext.timestamp);
        }
        if ((address(currentContext.appCreditToken) == address(0)) || (currentContext.appCreditToken == token)) {
            newCtx = ISuperfluid(msg.sender).ctxUseCredit(newCtx, appCreditDelta);
        }
        if (ISuperfluid(msg.sender).isApp(ISuperApp(flowParams.receiver))) {
            int256 availableBalance;
            (availableBalance, , ) = token.realtimeBalanceOf(flowParams.receiver, currentContext.timestamp);
            if (availableBalance < 0) {
                if (optype == FlowChangeType.DELETE_FLOW) {
                    newCtx = ISuperfluid(msg.sender).jailApp(newCtx, ISuperApp(flowParams.receiver), SuperAppDefinitions.APP_RULE_NO_CRITICAL_RECEIVER_ACCOUNT);
                    int256 userDamageAmount = AgreementLibrary.min(-availableBalance, -appCreditDelta);
                    token.settleBalance(flowParams.sender, -userDamageAmount);
                    token.settleBalance(flowParams.receiver, userDamageAmount);
                } else {
                    revert ISuperfluid.APP_RULE(SuperAppDefinitions.APP_RULE_NO_CRITICAL_RECEIVER_ACCOUNT);
                }
            }
        }
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

### _changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData)

- **Kind**: internal
- **Source**: 46672:4940:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData)`

```solidity
///  @dev change flow between sender and receiver with new flow rate
///  NOTE:
///  - leaving owed deposit unchanged for later adjustment
///  - depositDelta output is always clipped (see _clipDepositNumberRoundingUp)
function _changeFlow(uint256 currentTimestamp, ISuperfluidToken appCreditToken, ISuperfluidToken token, FlowParams memory flowParams, FlowData memory oldFlowData) private returns (int256 depositDelta, uint256 appCreditBase, FlowData memory newFlowData) {
    uint256 newDeposit;
    {
        uint256 minimumDeposit;
        {
            (uint256 liquidationPeriod, ) = SolvencyHelperLibrary.decode3PsData(ISuperfluid(_host), token);
            ISuperfluidGovernance gov = ISuperfluidGovernance(ISuperfluid(msg.sender).getGovernance());
            minimumDeposit = gov.getConfigAsUint256(ISuperfluid(msg.sender), token, SuperfluidGovernanceConfigs.SUPERTOKEN_MINIMUM_DEPOSIT_KEY);
            appCreditBase = _calculateDeposit(flowParams.flowRate, liquidationPeriod);
        }
        depositDelta = (appCreditBase.toInt256() - oldFlowData.deposit.toInt256()) + oldFlowData.owedDeposit.toInt256();
        newDeposit = (oldFlowData.deposit.toInt256() + depositDelta).toUint256();
        if ((newDeposit < minimumDeposit) && (flowParams.flowRate > 0)) {
            depositDelta = (minimumDeposit.toInt256() - oldFlowData.deposit.toInt256()) + oldFlowData.owedDeposit.toInt256();
            newDeposit = minimumDeposit;
        }
        if ((address(appCreditToken) != address(0)) && (appCreditToken != token)) {
            appCreditBase = 0;
        }
        newFlowData = FlowData((flowParams.flowRate > 0) ? currentTimestamp : 0, flowParams.flowRate, newDeposit, oldFlowData.owedDeposit);
        token.updateAgreementData(flowParams.flowId, _encodeFlowData(newFlowData));
    }
    {
        _StackVars_changeFlow memory vars;
        vars.totalSenderFlowRate = _updateAccountFlowState(token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp);
        vars.totalReceiverFlowRate = _updateAccountFlowState(token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp);
        emit FlowUpdated(token, flowParams.sender, flowParams.receiver, flowParams.flowRate, vars.totalSenderFlowRate, vars.totalReceiverFlowRate, flowParams.userData);
        emit FlowUpdatedExtension(flowParams.flowOperator, newDeposit);
    }
}
```

### decode3PsData(contract ISuperfluid,contract ISuperfluidToken)

- **Kind**: internal
- **Source**: 257:557:159
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SolvencyHelperLibrary.sol:SolvencyHelperLibrary:decode3PsData(contract ISuperfluid,contract ISuperfluidToken)`

```solidity
function decode3PsData(ISuperfluid host, ISuperfluidToken token) internal view returns (uint256 liquidationPeriod, uint256 patricianPeriod) {
    ISuperfluidGovernance gov = ISuperfluidGovernance(host.getGovernance());
    uint256 pppConfig = gov.getConfigAsUint256(host, token, SuperfluidGovernanceConfigs.CFAV1_PPP_CONFIG_KEY);
    (liquidationPeriod, patricianPeriod) = SuperfluidGovernanceConfigs.decodePPPConfig(pppConfig);
}
```

### decodePPPConfig(uint256)

- **Kind**: internal
- **Source**: 11842:260:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperfluidGovernanceConfigs:decodePPPConfig(uint256)`

```solidity
function decodePPPConfig(uint256 pppConfig) internal pure returns (uint256 liquidationPeriod, uint256 patricianPeriod) {
    liquidationPeriod = (pppConfig >> 32) & type(uint32).max;
    patricianPeriod = pppConfig & type(uint32).max;
}
```

### _calculateDeposit(int96,uint256)

- **Kind**: internal
- **Source**: 56465:458:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_calculateDeposit(int96,uint256)`

```solidity
function _calculateDeposit(int96 flowRate, uint256 liquidationPeriod) internal pure returns (uint256 deposit) {
    if (flowRate == 0) return 0;
    assert(liquidationPeriod <= uint256(int256(type(int96).max)));
    deposit = uint256(int256(flowRate * int96(uint96(liquidationPeriod))));
    return _clipDepositNumberRoundingUp(deposit);
}
```

### _clipDepositNumberRoundingUp(uint256)

- **Kind**: internal
- **Source**: 56183:276:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_clipDepositNumberRoundingUp(uint256)`

```solidity
function _clipDepositNumberRoundingUp(uint256 deposit) internal pure returns (uint256) {
    uint256 rounding = ((deposit & type(uint32).max) > 0) ? 1 : 0;
    return ((deposit >> 32) + rounding) << 32;
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

### toUint256(int256)

- **Kind**: internal
- **Source**: 17187:168:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint256(int256)`

```solidity
///  @dev Converts a signed int256 into an unsigned uint256.
///  Requirements:
///  - input must be greater than or equal to 0.
///  _Available since v3.0._
function toUint256(int256 value) internal pure returns (uint256) {
    require(value >= 0, "SafeCast: value must be positive");
    return uint256(value);
}
```

### _encodeFlowData(struct ConstantFlowAgreementV1.FlowData)

- **Kind**: internal
- **Source**: 57588:594:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_encodeFlowData(struct ConstantFlowAgreementV1.FlowData)`

```solidity
function _encodeFlowData(FlowData memory flowData) internal pure returns (bytes32[] memory data) {
    data = new bytes32[](1);
    data[0] = bytes32(((((uint256(flowData.timestamp)) << 224) | ((uint256(uint96(flowData.flowRate)) << 128))) | ((uint256(flowData.deposit) >> 32) << 64)) | (uint256(flowData.owedDeposit) >> 32));
}
```

### _updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256)

- **Kind**: internal
- **Source**: 36202:976:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256)`

```solidity
function _updateAccountFlowState(ISuperfluidToken token, address account, int96 flowRateDelta, int256 depositDelta, int256 owedDepositDelta, uint256 currentTimestamp) private returns (int96 newNetFlowRate) {
    (, FlowData memory state) = _getAccountFlowState(token, account);
    int256 dynamicBalance = (currentTimestamp - state.timestamp).toInt256() * int256(state.flowRate);
    if (dynamicBalance != 0) {
        token.settleBalance(account, dynamicBalance);
    }
    state.flowRate = state.flowRate + flowRateDelta;
    state.timestamp = currentTimestamp;
    state.deposit = (state.deposit.toInt256() + depositDelta).toUint256();
    state.owedDeposit = (state.owedDeposit.toInt256() + owedDepositDelta).toUint256();
    token.updateAgreementStateSlot(account, 0, _encodeFlowData(state));
    return state.flowRate;
}
```

### _getAccountFlowState(contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 34532:342:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_getAccountFlowState(contract ISuperfluidToken,address)`

```solidity
function _getAccountFlowState(ISuperfluidToken token, address account) private view returns (bool exist, FlowData memory) {
    bytes32[] memory data = token.getAgreementStateSlot(address(this), account, 0, 1);
    return _decodeFlowData(uint256(data[0]));
}
```

### max(uint256,uint256)

- **Kind**: internal
- **Source**: 8484:92:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:max(uint256,uint256)`

```solidity
function max(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a > b) ? a : b;
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

### _changeFlowToNonApp(contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context)

- **Kind**: internal
- **Source**: 37248:980:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_changeFlowToNonApp(contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context)`

```solidity
///  @dev update a flow to a non-app receiver
function _changeFlowToNonApp(ISuperfluidToken token, FlowParams memory flowParams, FlowData memory oldFlowData, bytes memory ctx, ISuperfluid.Context memory currentContext) private returns (bytes memory newCtx) {
    assert(oldFlowData.owedDeposit == 0);
    int256 depositDelta;
    FlowData memory newFlowData;
    (depositDelta, , newFlowData) = _changeFlow(currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData);
    if (currentContext.appCreditToken == token) {
        newCtx = ISuperfluid(msg.sender).ctxUseCredit(ctx, depositDelta);
    } else {
        newCtx = ctx;
    }
}
```

### _requireAvailableBalance(contract ISuperfluidToken,address,struct ISuperfluid.Context)

- **Kind**: internal
- **Source**: 51617:632:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_requireAvailableBalance(contract ISuperfluidToken,address,struct ISuperfluid.Context)`

```solidity
function _requireAvailableBalance(ISuperfluidToken token, address flowSender, ISuperfluid.Context memory currentContext) private view {
    if ((currentContext.callType != ContextDefinitions.CALL_INFO_CALL_TYPE_APP_CALLBACK) || (currentContext.appCreditToken != token)) {
        (int256 availableBalance, , ) = token.realtimeBalanceOf(flowSender, currentContext.timestamp);
        if (availableBalance < 0) {
            revert CFA_INSUFFICIENT_BALANCE();
        }
    }
}
```

## External Calls

- **ISuperfluidToken::getHost()**
- **ISuperfluid::isCtxValid(bytes)**
- **ISuperfluid::decodeCtx(bytes)**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**
- **ISuperfluid::isApp(contract ISuperApp)**
- **ISuperfluid::getGovernance()**
- **ISuperfluidGovernance::getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)**
- **ISuperfluidToken::updateAgreementData(bytes32,bytes32[])**
- **ISuperfluid::ctxUseCredit(bytes,int256)**
- **ISuperfluidToken::realtimeBalanceOf(address,uint256)**
- **ISuperfluid::jailApp(bytes,contract ISuperApp,uint256)**
- **ISuperfluidToken::settleBalance(address,int256)**
- **ISuperfluid::getAppManifest(contract ISuperApp)**
- **ISuperfluid::callAppBeforeCallback(contract ISuperApp,bytes,bool,bytes)**
- **ISuperfluid::appCallbackPush(bytes,contract ISuperApp,uint256,int256,contract ISuperfluidToken)**
- **ISuperfluid::appCallbackPop(bytes,int256)**
- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluid::callAppAfterCallback(contract ISuperApp,bytes,bool,bytes)**

## State Variable Reads

- **DEFAULT_MINIMUM_DEPOSIT** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.updateFlow(contract ISuperfluidToken,address,int96,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 1)
  │   💬 Args: [token, ctx]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._generateFlowId(address,address) (NodeID: 2)
  │   💬 Args: [flowVars.sender, flowVars.receiver]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAgreementData(contract ISuperfluidToken,bytes32) (NodeID: 3)
  │   💬 Args: [flowVars.token, flowId]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 4)
  │     💬 Args: [uint256(data[0])]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateFlow(struct ConstantFlowAgreementV1._StackVars_createOrUpdateFlow,struct ConstantFlowAgreementV1.FlowData,bool,bytes,struct ISuperfluid.Context) (NodeID: 5)
      💬 Args: [flowVars, oldFlowData, exist, ctx, currentContext]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._createOrUpdateFlowCheck(struct ConstantFlowAgreementV1._StackVars_createOrUpdateFlow,struct ISuperfluid.Context) (NodeID: 6)
    │   💬 Args: [flowVars, currentContext]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._generateFlowId(address,address) (NodeID: 7)
    │     💬 Args: [flowVars.sender, flowVars.receiver]
    │     👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlowToApp(address,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context,enum ConstantFlowAgreementV1.FlowChangeType) (NodeID: 8)
    │   💬 Args: [flowVars.receiver, flowVars.token, flowParams, oldFlowData, ctx, currentContext, FlowChangeType.UPDATE_FLOW]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.createCallbackInputs(contract ISuperfluidToken,address,bytes32,bytes) (NodeID: 9)
    │ │   💬 Args: [token, appToCallback, flowParams.flowId, abi.encode(flowParams.sender, flowParams.receiver)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.callAppBeforeCallback(struct AgreementLibrary.CallbackInputs,bytes) (NodeID: 10)
    │ │   💬 Args: [cbStates, ctx]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 11)
    │ │ │   💬 Args: [ctx, inputs]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 12)
    │ │ │   💬 Args: [inputs.noopBit]
    │ │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 13)
    │ │     💬 Args: [ctx, 0]
    │ │     👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 14)
    │ │   💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 15)
    │ │ │   💬 Args: [ISuperfluid(_host), token]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 16)
    │ │ │     💬 Args: [pppConfig]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 17)
    │ │ │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 18)
    │ │ │     💬 Args: [deposit]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 19)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 20)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 21)
    │ │ │   💬 Args: [appCreditBase]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 22)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 23)
    │ │ │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 24)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 25)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 26)
    │ │ │   💬 Args: [minimumDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 27)
    │ │ │   💬 Args: [newFlowData]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 28)
    │ │ │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │ │ │   👁️  Def: private
    │ │ │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 29)
    │ │ │ │   💬 Args: [token, account]
    │ │ │ │   👁️  Def: private
    │ │ │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 30)
    │ │ │ │     💬 Args: [uint256(data[0])]
    │ │ │ │     👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 31)
    │ │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 32)
    │ │ │ │   💬 Args: [state.deposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 33)
    │ │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 34)
    │ │ │ │   💬 Args: [state.owedDeposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 35)
    │ │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 36)
    │ │ │     💬 Args: [state]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 37)
    │ │     💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │ │     👁️  Def: private
    │ │   ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 38)
    │ │   │   💬 Args: [token, account]
    │ │   │   👁️  Def: private
    │ │   │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 39)
    │ │   │     💬 Args: [uint256(data[0])]
    │ │   │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 40)
    │ │   │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 41)
    │ │   │   💬 Args: [state.deposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 42)
    │ │   │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 43)
    │ │   │   💬 Args: [state.owedDeposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 44)
    │ │   │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 45)
    │ │       💬 Args: [state]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.max(uint256,uint256) (NodeID: 46)
    │ │   💬 Args: [DEFAULT_MINIMUM_DEPOSIT, minimumDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 47)
    │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.callAppAfterCallback(struct AgreementLibrary.CallbackInputs,bytes,bytes) (NodeID: 48)
    │ │   💬 Args: [cbStates, vars.cbdata, newCtx]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 49)
    │ │ │   💬 Args: [newCtx, inputs]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 50)
    │ │ │   💬 Args: [inputs.noopBit]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._adjustNewAppCreditUsed(uint256,int256) (NodeID: 51)
    │ │ │   💬 Args: [inputs.appCreditGranted, appContext.appCreditUsed]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: AgreementLibrary.max(int256,int256) (NodeID: 52)
    │ │ │     💬 Args: [0, min(appCreditGranted.toInt256(), appCallbackDepositDelta)]
    │ │ │     👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 53)
    │ │ │       💬 Args: [appCreditGranted.toInt256(), appCallbackDepositDelta]
    │ │ │       👁️  Def: internal
    │ │ │     └─ [7] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 54)
    │ │ │         💬 Args: [appCreditGranted]
    │ │ │         👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 55)
    │ │     💬 Args: [ctx, appContext.appCreditUsed]
    │ │     👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAgreementData(contract ISuperfluidToken,bytes32) (NodeID: 56)
    │ │   💬 Args: [token, flowParams.flowId]
    │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 57)
    │ │     💬 Args: [uint256(data[0])]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 58)
    │ │   💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 59)
    │ │ │   💬 Args: [ISuperfluid(_host), token]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 60)
    │ │ │     💬 Args: [pppConfig]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 61)
    │ │ │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 62)
    │ │ │     💬 Args: [deposit]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 63)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 64)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 65)
    │ │ │   💬 Args: [appCreditBase]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 66)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 67)
    │ │ │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 68)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 69)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 70)
    │ │ │   💬 Args: [minimumDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 71)
    │ │ │   💬 Args: [newFlowData]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 72)
    │ │ │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │ │ │   👁️  Def: private
    │ │ │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 73)
    │ │ │ │   💬 Args: [token, account]
    │ │ │ │   👁️  Def: private
    │ │ │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 74)
    │ │ │ │     💬 Args: [uint256(data[0])]
    │ │ │ │     👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 75)
    │ │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 76)
    │ │ │ │   💬 Args: [state.deposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 77)
    │ │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 78)
    │ │ │ │   💬 Args: [state.owedDeposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 79)
    │ │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 80)
    │ │ │     💬 Args: [state]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 81)
    │ │     💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │ │     👁️  Def: private
    │ │   ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 82)
    │ │   │   💬 Args: [token, account]
    │ │   │   👁️  Def: private
    │ │   │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 83)
    │ │   │     💬 Args: [uint256(data[0])]
    │ │   │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 84)
    │ │   │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 85)
    │ │   │   💬 Args: [state.deposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 86)
    │ │   │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 87)
    │ │   │   💬 Args: [state.owedDeposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 88)
    │ │   │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 89)
    │ │       💬 Args: [state]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 90)
    │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 91)
    │ │   💬 Args: [vars.newFlowData.deposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 92)
    │ │   💬 Args: [(vars.newFlowData.deposit.toInt256() + appCreditDelta)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 93)
    │ │   💬 Args: [vars.newFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 94)
    │ │   💬 Args: [(vars.newFlowData.owedDeposit.toInt256() + appCreditDelta)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 95)
    │ │   💬 Args: [vars.newFlowData]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 96)
    │ │   💬 Args: [token, flowParams.sender, 0, appCreditDelta, 0, currentContext.timestamp]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 97)
    │ │ │   💬 Args: [token, account]
    │ │ │   👁️  Def: private
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 98)
    │ │ │     💬 Args: [uint256(data[0])]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 99)
    │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 100)
    │ │ │   💬 Args: [state.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 101)
    │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 102)
    │ │ │   💬 Args: [state.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 103)
    │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 104)
    │ │     💬 Args: [state]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 105)
    │ │   💬 Args: [token, flowParams.receiver, 0, 0, appCreditDelta, currentContext.timestamp]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 106)
    │ │ │   💬 Args: [token, account]
    │ │ │   👁️  Def: private
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 107)
    │ │ │     💬 Args: [uint256(data[0])]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 108)
    │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 109)
    │ │ │   💬 Args: [state.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 110)
    │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 111)
    │ │ │   💬 Args: [state.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 112)
    │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 113)
    │ │     💬 Args: [state]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 114)
    │     💬 Args: [-availableBalance, -appCreditDelta]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlowToNonApp(contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context) (NodeID: 115)
    │   💬 Args: [flowVars.token, flowParams, oldFlowData, ctx, currentContext]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 116)
    │     💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │     👁️  Def: private
    │   ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 117)
    │   │   💬 Args: [ISuperfluid(_host), token]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 118)
    │   │     💬 Args: [pppConfig]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 119)
    │   │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 120)
    │   │     💬 Args: [deposit]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 121)
    │   │   💬 Args: [oldFlowData.owedDeposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 122)
    │   │   💬 Args: [oldFlowData.deposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 123)
    │   │   💬 Args: [appCreditBase]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 124)
    │   │   💬 Args: [oldFlowData.deposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 125)
    │   │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 126)
    │   │   💬 Args: [oldFlowData.owedDeposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 127)
    │   │   💬 Args: [oldFlowData.deposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 128)
    │   │   💬 Args: [minimumDeposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 129)
    │   │   💬 Args: [newFlowData]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 130)
    │   │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │   │   👁️  Def: private
    │   │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 131)
    │   │ │   💬 Args: [token, account]
    │   │ │   👁️  Def: private
    │   │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 132)
    │   │ │     💬 Args: [uint256(data[0])]
    │   │ │     👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 133)
    │   │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 134)
    │   │ │   💬 Args: [state.deposit]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 135)
    │   │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 136)
    │   │ │   💬 Args: [state.owedDeposit]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 137)
    │   │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │   │ │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 138)
    │   │     💬 Args: [state]
    │   │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 139)
    │       💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │       👁️  Def: private
    │     ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 140)
    │     │   💬 Args: [token, account]
    │     │   👁️  Def: private
    │     │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 141)
    │     │     💬 Args: [uint256(data[0])]
    │     │     👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 142)
    │     │   💬 Args: [(currentTimestamp - state.timestamp)]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 143)
    │     │   💬 Args: [state.deposit]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 144)
    │     │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 145)
    │     │   💬 Args: [state.owedDeposit]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 146)
    │     │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │     │   👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 147)
    │         💬 Args: [state]
    │         👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._requireAvailableBalance(contract ISuperfluidToken,address,struct ISuperfluid.Context) (NodeID: 148)
        💬 Args: [flowVars.token, flowVars.sender, currentContext]
        👁️  Def: private
```

## Documentation

### Function Documentation

@dev IConstantFlowAgreementV1.updateFlow implementation
