# Function: deleteFlow(contract ISuperfluidToken,address,address,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `deleteFlow(contract ISuperfluidToken,address,address,bytes)`
- **Visibility**: external
- **Source Range**: 9898:791:121

## Implementation

```solidity
/// @dev IConstantFlowAgreementV1.deleteFlow implementation
function deleteFlow(ISuperfluidToken token, address sender, address receiver, bytes calldata ctx) override external returns (bytes memory newCtx) {
    ISuperfluid.Context memory currentContext = AgreementLibrary.authorizeTokenAccess(token, ctx);
    (, uint8 permissions, ) = getFlowOperatorData(token, sender, currentContext.msgSender);
    bool hasPermissions = _getBooleanFlowOperatorPermissions(permissions, FlowChangeType.DELETE_FLOW);
    _StackVars_createOrUpdateFlow memory flowVars;
    flowVars.token = token;
    flowVars.sender = sender;
    flowVars.receiver = receiver;
    flowVars.flowRate = 0;
    newCtx = _deleteFlow(flowVars, hasPermissions, ctx, currentContext);
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

### getFlowOperatorData(contract ISuperfluidToken,address,address)

- **Kind**: internal
- **Source**: 33201:533:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:getFlowOperatorData(contract ISuperfluidToken,address,address)`

```solidity
/// @dev IConstantFlowAgreementV1.getFlowOperatorData implementation
function getFlowOperatorData(ISuperfluidToken token, address sender, address flowOperator) override public view returns (bytes32 flowOperatorId, uint8 permissions, int96 flowRateAllowance) {
    flowOperatorId = _generateFlowOperatorId(sender, flowOperator);
    (, FlowOperatorData memory flowOperatorData) = _getFlowOperatorData(token, flowOperatorId);
    permissions = flowOperatorData.permissions;
    flowRateAllowance = flowOperatorData.flowRateAllowance;
}
```

### _generateFlowOperatorId(address,address)

- **Kind**: internal
- **Source**: 59069:187:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_generateFlowOperatorId(address,address)`

```solidity
function _generateFlowOperatorId(address sender, address flowOperator) private pure returns (bytes32 id) {
    return keccak256(abi.encode("flowOperator", sender, flowOperator));
}
```

### _getFlowOperatorData(contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 35184:409:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_getFlowOperatorData(contract ISuperfluidToken,bytes32)`

```solidity
function _getFlowOperatorData(ISuperfluidToken token, bytes32 flowOperatorId) private view returns (bool exist, FlowOperatorData memory) {
    bytes32[] memory data = token.getAgreementData(address(this), flowOperatorId, 1);
    return _decodeFlowOperatorData(uint256(data[0]));
}
```

### _decodeFlowOperatorData(uint256)

- **Kind**: internal
- **Source**: 60137:527:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_decodeFlowOperatorData(uint256)`

```solidity
function _decodeFlowOperatorData(uint256 wordA) internal pure returns (bool exist, FlowOperatorData memory flowOperatorData) {
    exist = wordA > 0;
    if (exist) {
        flowOperatorData.flowRateAllowance = int96(int256(wordA & uint256(int256(type(int96).max))));
        flowOperatorData.permissions = uint8(wordA >> 128) & type(uint8).max;
    }
}
```

### _getBooleanFlowOperatorPermissions(uint8,enum ConstantFlowAgreementV1.FlowChangeType)

- **Kind**: internal
- **Source**: 60670:615:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_getBooleanFlowOperatorPermissions(uint8,enum ConstantFlowAgreementV1.FlowChangeType)`

```solidity
function _getBooleanFlowOperatorPermissions(uint8 permissions, FlowChangeType flowChangeType) internal pure returns (bool flowchangeTypeAllowed) {
    if (flowChangeType == FlowChangeType.CREATE_FLOW) {
        flowchangeTypeAllowed = (permissions & uint8(1)) == 1;
    } else if (flowChangeType == FlowChangeType.UPDATE_FLOW) {
        flowchangeTypeAllowed = ((permissions >> 1) & uint8(1)) == 1;
    } else {
        /// flowChangeType === FlowChangeType.DELETE_FLOW 
        flowchangeTypeAllowed = ((permissions >> 2) & uint8(1)) == 1;
    }
}
```

### _deleteFlow(struct ConstantFlowAgreementV1._StackVars_createOrUpdateFlow,bool,bytes,struct ISuperfluid.Context)

- **Kind**: internal
- **Source**: 16276:5277:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_deleteFlow(struct ConstantFlowAgreementV1._StackVars_createOrUpdateFlow,bool,bytes,struct ISuperfluid.Context)`

```solidity
function _deleteFlow(_StackVars_createOrUpdateFlow memory flowVars, bool hasPermissions, bytes calldata ctx, ISuperfluid.Context memory currentContext) internal returns (bytes memory newCtx) {
    FlowParams memory flowParams;
    if (flowVars.sender == address(0)) {
        revert CFA_ZERO_ADDRESS_SENDER();
    }
    if (flowVars.receiver == address(0)) {
        revert CFA_ZERO_ADDRESS_RECEIVER();
    }
    flowParams.flowId = _generateFlowId(flowVars.sender, flowVars.receiver);
    flowParams.sender = flowVars.sender;
    flowParams.receiver = flowVars.receiver;
    flowParams.flowOperator = currentContext.msgSender;
    flowParams.flowRate = 0;
    flowParams.userData = currentContext.userData;
    (bool exist, FlowData memory oldFlowData) = _getAgreementData(flowVars.token, flowParams.flowId);
    if (!exist) revert CFA_FLOW_DOES_NOT_EXIST();
    (int256 availableBalance, , ) = flowVars.token.realtimeBalanceOf(flowVars.sender, currentContext.timestamp);
    if (((currentContext.msgSender != flowVars.sender) && (currentContext.msgSender != flowVars.receiver)) && (!hasPermissions)) {
        if ((!ISuperfluid(msg.sender).isAppJailed(ISuperApp(flowVars.sender))) && (!ISuperfluid(msg.sender).isAppJailed(ISuperApp(flowVars.receiver)))) {
            if (availableBalance >= 0) revert CFA_NON_CRITICAL_SENDER();
        }
    }
    if (availableBalance < 0) {
        _makeLiquidationPayouts(flowVars.token, availableBalance, flowParams, oldFlowData, currentContext.msgSender);
    }
    newCtx = ctx;
    if (currentContext.msgSender == flowVars.sender) {
        if (ISuperfluid(msg.sender).isApp(ISuperApp(flowVars.receiver))) {
            newCtx = _changeFlowToApp(flowVars.receiver, flowVars.token, flowParams, oldFlowData, newCtx, currentContext, FlowChangeType.DELETE_FLOW);
        } else {
            newCtx = _changeFlowToNonApp(flowVars.token, flowParams, oldFlowData, newCtx, currentContext);
        }
    } else if (currentContext.msgSender == flowVars.receiver) {
        if (ISuperfluid(msg.sender).isApp(ISuperApp(flowVars.sender))) {
            newCtx = _changeFlowToApp(flowVars.sender, flowVars.token, flowParams, oldFlowData, newCtx, currentContext, FlowChangeType.DELETE_FLOW);
        } else if (ISuperfluid(msg.sender).isApp(ISuperApp(flowVars.receiver))) {
            newCtx = _changeFlowToApp(address(0), flowVars.token, flowParams, oldFlowData, newCtx, currentContext, FlowChangeType.DELETE_FLOW);
        } else {
            newCtx = _changeFlowToNonApp(flowVars.token, flowParams, oldFlowData, newCtx, currentContext);
        }
    } else {
        if (ISuperfluid(msg.sender).isApp(ISuperApp(flowVars.sender)) && (availableBalance < 0)) {
            newCtx = ISuperfluid(msg.sender).jailApp(newCtx, ISuperApp(flowVars.sender), SuperAppDefinitions.APP_RULE_NO_CRITICAL_SENDER_ACCOUNT);
        }
        if (ISuperfluid(msg.sender).isApp(ISuperApp(flowVars.receiver))) {
            newCtx = _changeFlowToApp(flowVars.receiver, flowVars.token, flowParams, oldFlowData, newCtx, currentContext, FlowChangeType.DELETE_FLOW);
        } else {
            newCtx = _changeFlowToNonApp(flowVars.token, flowParams, oldFlowData, newCtx, currentContext);
        }
    }
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

### _makeLiquidationPayouts(contract ISuperfluidToken,int256,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,address)

- **Kind**: internal
- **Source**: 52255:3558:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_makeLiquidationPayouts(contract ISuperfluidToken,int256,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,address)`

```solidity
function _makeLiquidationPayouts(ISuperfluidToken token, int256 availableBalance, FlowParams memory flowParams, FlowData memory flowData, address liquidator) private {
    (, FlowData memory senderAccountState) = _getAccountFlowState(token, flowParams.sender);
    int256 signedSingleDeposit = flowData.deposit.toInt256();
    int256 signedTotalCFADeposit = senderAccountState.deposit.toInt256();
    bytes memory liquidationTypeData;
    bool isCurrentlyPatricianPeriod;
    int256 totalRewardLeft = availableBalance + signedTotalCFADeposit;
    {
        (uint256 liquidationPeriod, uint256 patricianPeriod) = SolvencyHelperLibrary.decode3PsData(ISuperfluid(_host), token);
        isCurrentlyPatricianPeriod = SolvencyHelperLibrary.isPatricianPeriod(availableBalance, signedTotalCFADeposit, liquidationPeriod, patricianPeriod);
    }
    if (totalRewardLeft >= 0) {
        int256 rewardAmount = (signedSingleDeposit * totalRewardLeft) / signedTotalCFADeposit;
        liquidationTypeData = abi.encode(1, isCurrentlyPatricianPeriod ? 0 : 1);
        token.makeLiquidationPayoutsV2(flowParams.flowId, liquidationTypeData, liquidator, isCurrentlyPatricianPeriod, flowParams.sender, rewardAmount.toUint256(), rewardAmount * (-1));
    } else {
        int256 rewardAmount = signedSingleDeposit;
        liquidationTypeData = abi.encode(1, 2);
        token.makeLiquidationPayoutsV2(flowParams.flowId, liquidationTypeData, liquidator, false, flowParams.sender, rewardAmount.toUint256(), totalRewardLeft * (-1));
    }
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

### isPatricianPeriod(int256,int256,uint256,uint256)

- **Kind**: internal
- **Source**: 820:533:159
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SolvencyHelperLibrary.sol:SolvencyHelperLibrary:isPatricianPeriod(int256,int256,uint256,uint256)`

```solidity
function isPatricianPeriod(int256 availableBalance, int256 signedTotalDeposit, uint256 liquidationPeriod, uint256 patricianPeriod) internal pure returns (bool) {
    if (signedTotalDeposit == 0) {
        return false;
    }
    int256 totalRewardLeft = availableBalance + signedTotalDeposit;
    int256 totalOutflowRate = signedTotalDeposit / int256(liquidationPeriod);
    return (totalRewardLeft / totalOutflowRate) > int256(liquidationPeriod - patricianPeriod);
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

## External Calls

- **ISuperfluidToken::getHost()**
- **ISuperfluid::isCtxValid(bytes)**
- **ISuperfluid::decodeCtx(bytes)**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**
- **ISuperfluidToken::realtimeBalanceOf(address,uint256)**
- **ISuperfluid::isAppJailed(contract ISuperApp)**
- **ISuperfluid::isApp(contract ISuperApp)**
- **ISuperfluid::jailApp(bytes,contract ISuperApp,uint256)**
- **ISuperfluidToken::makeLiquidationPayoutsV2(bytes32,bytes,address,bool,address,uint256,int256)**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluid::getGovernance()**
- **ISuperfluidGovernance::getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)**
- **ISuperfluidToken::updateAgreementData(bytes32,bytes32[])**
- **ISuperfluid::ctxUseCredit(bytes,int256)**
- **ISuperfluidToken::settleBalance(address,int256)**
- **ISuperfluid::getAppManifest(contract ISuperApp)**
- **ISuperfluid::callAppBeforeCallback(contract ISuperApp,bytes,bool,bytes)**
- **ISuperfluid::appCallbackPush(bytes,contract ISuperApp,uint256,int256,contract ISuperfluidToken)**
- **ISuperfluid::appCallbackPop(bytes,int256)**
- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**
- **ISuperfluid::callAppAfterCallback(contract ISuperApp,bytes,bool,bytes)**

## State Variable Reads

- **DEFAULT_MINIMUM_DEPOSIT** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.deleteFlow(contract ISuperfluidToken,address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 1)
  │   💬 Args: [token, ctx]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1.getFlowOperatorData(contract ISuperfluidToken,address,address) (NodeID: 2)
  │   💬 Args: [token, sender, currentContext.msgSender]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._generateFlowOperatorId(address,address) (NodeID: 3)
  │ │   💬 Args: [sender, flowOperator]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._getFlowOperatorData(contract ISuperfluidToken,bytes32) (NodeID: 4)
  │     💬 Args: [token, flowOperatorId]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowOperatorData(uint256) (NodeID: 5)
  │       💬 Args: [uint256(data[0])]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._getBooleanFlowOperatorPermissions(uint8,enum ConstantFlowAgreementV1.FlowChangeType) (NodeID: 6)
  │   💬 Args: [permissions, FlowChangeType.DELETE_FLOW]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._deleteFlow(struct ConstantFlowAgreementV1._StackVars_createOrUpdateFlow,bool,bytes,struct ISuperfluid.Context) (NodeID: 7)
      💬 Args: [flowVars, hasPermissions, ctx, currentContext]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._generateFlowId(address,address) (NodeID: 8)
    │   💬 Args: [flowVars.sender, flowVars.receiver]
    │   👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAgreementData(contract ISuperfluidToken,bytes32) (NodeID: 9)
    │   💬 Args: [flowVars.token, flowParams.flowId]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 10)
    │     💬 Args: [uint256(data[0])]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._makeLiquidationPayouts(contract ISuperfluidToken,int256,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,address) (NodeID: 11)
    │   💬 Args: [flowVars.token, availableBalance, flowParams, oldFlowData, currentContext.msgSender]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 12)
    │ │   💬 Args: [token, flowParams.sender]
    │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 13)
    │ │     💬 Args: [uint256(data[0])]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 14)
    │ │   💬 Args: [flowData.deposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 15)
    │ │   💬 Args: [senderAccountState.deposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 16)
    │ │   💬 Args: [ISuperfluid(_host), token]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 17)
    │ │     💬 Args: [pppConfig]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SolvencyHelperLibrary.isPatricianPeriod(int256,int256,uint256,uint256) (NodeID: 18)
    │ │   💬 Args: [availableBalance, signedTotalCFADeposit, liquidationPeriod, patricianPeriod]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 19)
    │ │   💬 Args: [rewardAmount]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 20)
    │     💬 Args: [rewardAmount]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlowToApp(address,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context,enum ConstantFlowAgreementV1.FlowChangeType) (NodeID: 21)
    │   💬 Args: [flowVars.receiver, flowVars.token, flowParams, oldFlowData, newCtx, currentContext, FlowChangeType.DELETE_FLOW]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.createCallbackInputs(contract ISuperfluidToken,address,bytes32,bytes) (NodeID: 22)
    │ │   💬 Args: [token, appToCallback, flowParams.flowId, abi.encode(flowParams.sender, flowParams.receiver)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.callAppBeforeCallback(struct AgreementLibrary.CallbackInputs,bytes) (NodeID: 23)
    │ │   💬 Args: [cbStates, ctx]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 24)
    │ │ │   💬 Args: [ctx, inputs]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 25)
    │ │ │   💬 Args: [inputs.noopBit]
    │ │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 26)
    │ │     💬 Args: [ctx, 0]
    │ │     👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 27)
    │ │   💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 28)
    │ │ │   💬 Args: [ISuperfluid(_host), token]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 29)
    │ │ │     💬 Args: [pppConfig]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 30)
    │ │ │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 31)
    │ │ │     💬 Args: [deposit]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 32)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 33)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 34)
    │ │ │   💬 Args: [appCreditBase]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 35)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 36)
    │ │ │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 37)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 38)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 39)
    │ │ │   💬 Args: [minimumDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 40)
    │ │ │   💬 Args: [newFlowData]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 41)
    │ │ │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │ │ │   👁️  Def: private
    │ │ │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 42)
    │ │ │ │   💬 Args: [token, account]
    │ │ │ │   👁️  Def: private
    │ │ │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 43)
    │ │ │ │     💬 Args: [uint256(data[0])]
    │ │ │ │     👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 44)
    │ │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 45)
    │ │ │ │   💬 Args: [state.deposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 46)
    │ │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 47)
    │ │ │ │   💬 Args: [state.owedDeposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 48)
    │ │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 49)
    │ │ │     💬 Args: [state]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 50)
    │ │     💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │ │     👁️  Def: private
    │ │   ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 51)
    │ │   │   💬 Args: [token, account]
    │ │   │   👁️  Def: private
    │ │   │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 52)
    │ │   │     💬 Args: [uint256(data[0])]
    │ │   │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 53)
    │ │   │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 54)
    │ │   │   💬 Args: [state.deposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 55)
    │ │   │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 56)
    │ │   │   💬 Args: [state.owedDeposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 57)
    │ │   │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 58)
    │ │       💬 Args: [state]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.max(uint256,uint256) (NodeID: 59)
    │ │   💬 Args: [DEFAULT_MINIMUM_DEPOSIT, minimumDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 60)
    │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.callAppAfterCallback(struct AgreementLibrary.CallbackInputs,bytes,bytes) (NodeID: 61)
    │ │   💬 Args: [cbStates, vars.cbdata, newCtx]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 62)
    │ │ │   💬 Args: [newCtx, inputs]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 63)
    │ │ │   💬 Args: [inputs.noopBit]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._adjustNewAppCreditUsed(uint256,int256) (NodeID: 64)
    │ │ │   💬 Args: [inputs.appCreditGranted, appContext.appCreditUsed]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: AgreementLibrary.max(int256,int256) (NodeID: 65)
    │ │ │     💬 Args: [0, min(appCreditGranted.toInt256(), appCallbackDepositDelta)]
    │ │ │     👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 66)
    │ │ │       💬 Args: [appCreditGranted.toInt256(), appCallbackDepositDelta]
    │ │ │       👁️  Def: internal
    │ │ │     └─ [7] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 67)
    │ │ │         💬 Args: [appCreditGranted]
    │ │ │         👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 68)
    │ │     💬 Args: [ctx, appContext.appCreditUsed]
    │ │     👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAgreementData(contract ISuperfluidToken,bytes32) (NodeID: 69)
    │ │   💬 Args: [token, flowParams.flowId]
    │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 70)
    │ │     💬 Args: [uint256(data[0])]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 71)
    │ │   💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 72)
    │ │ │   💬 Args: [ISuperfluid(_host), token]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 73)
    │ │ │     💬 Args: [pppConfig]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 74)
    │ │ │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 75)
    │ │ │     💬 Args: [deposit]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 76)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 77)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 78)
    │ │ │   💬 Args: [appCreditBase]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 79)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 80)
    │ │ │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 81)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 82)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 83)
    │ │ │   💬 Args: [minimumDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 84)
    │ │ │   💬 Args: [newFlowData]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 85)
    │ │ │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │ │ │   👁️  Def: private
    │ │ │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 86)
    │ │ │ │   💬 Args: [token, account]
    │ │ │ │   👁️  Def: private
    │ │ │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 87)
    │ │ │ │     💬 Args: [uint256(data[0])]
    │ │ │ │     👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 88)
    │ │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 89)
    │ │ │ │   💬 Args: [state.deposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 90)
    │ │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 91)
    │ │ │ │   💬 Args: [state.owedDeposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 92)
    │ │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 93)
    │ │ │     💬 Args: [state]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 94)
    │ │     💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │ │     👁️  Def: private
    │ │   ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 95)
    │ │   │   💬 Args: [token, account]
    │ │   │   👁️  Def: private
    │ │   │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 96)
    │ │   │     💬 Args: [uint256(data[0])]
    │ │   │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 97)
    │ │   │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 98)
    │ │   │   💬 Args: [state.deposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 99)
    │ │   │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 100)
    │ │   │   💬 Args: [state.owedDeposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 101)
    │ │   │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 102)
    │ │       💬 Args: [state]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 103)
    │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 104)
    │ │   💬 Args: [vars.newFlowData.deposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 105)
    │ │   💬 Args: [(vars.newFlowData.deposit.toInt256() + appCreditDelta)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 106)
    │ │   💬 Args: [vars.newFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 107)
    │ │   💬 Args: [(vars.newFlowData.owedDeposit.toInt256() + appCreditDelta)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 108)
    │ │   💬 Args: [vars.newFlowData]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 109)
    │ │   💬 Args: [token, flowParams.sender, 0, appCreditDelta, 0, currentContext.timestamp]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 110)
    │ │ │   💬 Args: [token, account]
    │ │ │   👁️  Def: private
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 111)
    │ │ │     💬 Args: [uint256(data[0])]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 112)
    │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 113)
    │ │ │   💬 Args: [state.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 114)
    │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 115)
    │ │ │   💬 Args: [state.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 116)
    │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 117)
    │ │     💬 Args: [state]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 118)
    │ │   💬 Args: [token, flowParams.receiver, 0, 0, appCreditDelta, currentContext.timestamp]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 119)
    │ │ │   💬 Args: [token, account]
    │ │ │   👁️  Def: private
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 120)
    │ │ │     💬 Args: [uint256(data[0])]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 121)
    │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 122)
    │ │ │   💬 Args: [state.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 123)
    │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 124)
    │ │ │   💬 Args: [state.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 125)
    │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 126)
    │ │     💬 Args: [state]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 127)
    │     💬 Args: [-availableBalance, -appCreditDelta]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlowToNonApp(contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context) (NodeID: 128)
    │   💬 Args: [flowVars.token, flowParams, oldFlowData, newCtx, currentContext]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 129)
    │     💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │     👁️  Def: private
    │   ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 130)
    │   │   💬 Args: [ISuperfluid(_host), token]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 131)
    │   │     💬 Args: [pppConfig]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 132)
    │   │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 133)
    │   │     💬 Args: [deposit]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 134)
    │   │   💬 Args: [oldFlowData.owedDeposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 135)
    │   │   💬 Args: [oldFlowData.deposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 136)
    │   │   💬 Args: [appCreditBase]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 137)
    │   │   💬 Args: [oldFlowData.deposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 138)
    │   │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 139)
    │   │   💬 Args: [oldFlowData.owedDeposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 140)
    │   │   💬 Args: [oldFlowData.deposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 141)
    │   │   💬 Args: [minimumDeposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 142)
    │   │   💬 Args: [newFlowData]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 143)
    │   │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │   │   👁️  Def: private
    │   │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 144)
    │   │ │   💬 Args: [token, account]
    │   │ │   👁️  Def: private
    │   │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 145)
    │   │ │     💬 Args: [uint256(data[0])]
    │   │ │     👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 146)
    │   │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 147)
    │   │ │   💬 Args: [state.deposit]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 148)
    │   │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 149)
    │   │ │   💬 Args: [state.owedDeposit]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 150)
    │   │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │   │ │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 151)
    │   │     💬 Args: [state]
    │   │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 152)
    │       💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │       👁️  Def: private
    │     ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 153)
    │     │   💬 Args: [token, account]
    │     │   👁️  Def: private
    │     │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 154)
    │     │     💬 Args: [uint256(data[0])]
    │     │     👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 155)
    │     │   💬 Args: [(currentTimestamp - state.timestamp)]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 156)
    │     │   💬 Args: [state.deposit]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 157)
    │     │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 158)
    │     │   💬 Args: [state.owedDeposit]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 159)
    │     │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │     │   👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 160)
    │         💬 Args: [state]
    │         👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlowToApp(address,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context,enum ConstantFlowAgreementV1.FlowChangeType) (NodeID: 161)
    │   💬 Args: [flowVars.sender, flowVars.token, flowParams, oldFlowData, newCtx, currentContext, FlowChangeType.DELETE_FLOW]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.createCallbackInputs(contract ISuperfluidToken,address,bytes32,bytes) (NodeID: 162)
    │ │   💬 Args: [token, appToCallback, flowParams.flowId, abi.encode(flowParams.sender, flowParams.receiver)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.callAppBeforeCallback(struct AgreementLibrary.CallbackInputs,bytes) (NodeID: 163)
    │ │   💬 Args: [cbStates, ctx]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 164)
    │ │ │   💬 Args: [ctx, inputs]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 165)
    │ │ │   💬 Args: [inputs.noopBit]
    │ │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 166)
    │ │     💬 Args: [ctx, 0]
    │ │     👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 167)
    │ │   💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 168)
    │ │ │   💬 Args: [ISuperfluid(_host), token]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 169)
    │ │ │     💬 Args: [pppConfig]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 170)
    │ │ │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 171)
    │ │ │     💬 Args: [deposit]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 172)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 173)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 174)
    │ │ │   💬 Args: [appCreditBase]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 175)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 176)
    │ │ │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 177)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 178)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 179)
    │ │ │   💬 Args: [minimumDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 180)
    │ │ │   💬 Args: [newFlowData]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 181)
    │ │ │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │ │ │   👁️  Def: private
    │ │ │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 182)
    │ │ │ │   💬 Args: [token, account]
    │ │ │ │   👁️  Def: private
    │ │ │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 183)
    │ │ │ │     💬 Args: [uint256(data[0])]
    │ │ │ │     👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 184)
    │ │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 185)
    │ │ │ │   💬 Args: [state.deposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 186)
    │ │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 187)
    │ │ │ │   💬 Args: [state.owedDeposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 188)
    │ │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 189)
    │ │ │     💬 Args: [state]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 190)
    │ │     💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │ │     👁️  Def: private
    │ │   ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 191)
    │ │   │   💬 Args: [token, account]
    │ │   │   👁️  Def: private
    │ │   │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 192)
    │ │   │     💬 Args: [uint256(data[0])]
    │ │   │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 193)
    │ │   │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 194)
    │ │   │   💬 Args: [state.deposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 195)
    │ │   │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 196)
    │ │   │   💬 Args: [state.owedDeposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 197)
    │ │   │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 198)
    │ │       💬 Args: [state]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.max(uint256,uint256) (NodeID: 199)
    │ │   💬 Args: [DEFAULT_MINIMUM_DEPOSIT, minimumDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 200)
    │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.callAppAfterCallback(struct AgreementLibrary.CallbackInputs,bytes,bytes) (NodeID: 201)
    │ │   💬 Args: [cbStates, vars.cbdata, newCtx]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 202)
    │ │ │   💬 Args: [newCtx, inputs]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 203)
    │ │ │   💬 Args: [inputs.noopBit]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._adjustNewAppCreditUsed(uint256,int256) (NodeID: 204)
    │ │ │   💬 Args: [inputs.appCreditGranted, appContext.appCreditUsed]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: AgreementLibrary.max(int256,int256) (NodeID: 205)
    │ │ │     💬 Args: [0, min(appCreditGranted.toInt256(), appCallbackDepositDelta)]
    │ │ │     👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 206)
    │ │ │       💬 Args: [appCreditGranted.toInt256(), appCallbackDepositDelta]
    │ │ │       👁️  Def: internal
    │ │ │     └─ [7] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 207)
    │ │ │         💬 Args: [appCreditGranted]
    │ │ │         👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 208)
    │ │     💬 Args: [ctx, appContext.appCreditUsed]
    │ │     👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAgreementData(contract ISuperfluidToken,bytes32) (NodeID: 209)
    │ │   💬 Args: [token, flowParams.flowId]
    │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 210)
    │ │     💬 Args: [uint256(data[0])]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 211)
    │ │   💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 212)
    │ │ │   💬 Args: [ISuperfluid(_host), token]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 213)
    │ │ │     💬 Args: [pppConfig]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 214)
    │ │ │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 215)
    │ │ │     💬 Args: [deposit]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 216)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 217)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 218)
    │ │ │   💬 Args: [appCreditBase]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 219)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 220)
    │ │ │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 221)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 222)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 223)
    │ │ │   💬 Args: [minimumDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 224)
    │ │ │   💬 Args: [newFlowData]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 225)
    │ │ │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │ │ │   👁️  Def: private
    │ │ │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 226)
    │ │ │ │   💬 Args: [token, account]
    │ │ │ │   👁️  Def: private
    │ │ │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 227)
    │ │ │ │     💬 Args: [uint256(data[0])]
    │ │ │ │     👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 228)
    │ │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 229)
    │ │ │ │   💬 Args: [state.deposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 230)
    │ │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 231)
    │ │ │ │   💬 Args: [state.owedDeposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 232)
    │ │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 233)
    │ │ │     💬 Args: [state]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 234)
    │ │     💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │ │     👁️  Def: private
    │ │   ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 235)
    │ │   │   💬 Args: [token, account]
    │ │   │   👁️  Def: private
    │ │   │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 236)
    │ │   │     💬 Args: [uint256(data[0])]
    │ │   │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 237)
    │ │   │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 238)
    │ │   │   💬 Args: [state.deposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 239)
    │ │   │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 240)
    │ │   │   💬 Args: [state.owedDeposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 241)
    │ │   │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 242)
    │ │       💬 Args: [state]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 243)
    │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 244)
    │ │   💬 Args: [vars.newFlowData.deposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 245)
    │ │   💬 Args: [(vars.newFlowData.deposit.toInt256() + appCreditDelta)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 246)
    │ │   💬 Args: [vars.newFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 247)
    │ │   💬 Args: [(vars.newFlowData.owedDeposit.toInt256() + appCreditDelta)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 248)
    │ │   💬 Args: [vars.newFlowData]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 249)
    │ │   💬 Args: [token, flowParams.sender, 0, appCreditDelta, 0, currentContext.timestamp]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 250)
    │ │ │   💬 Args: [token, account]
    │ │ │   👁️  Def: private
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 251)
    │ │ │     💬 Args: [uint256(data[0])]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 252)
    │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 253)
    │ │ │   💬 Args: [state.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 254)
    │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 255)
    │ │ │   💬 Args: [state.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 256)
    │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 257)
    │ │     💬 Args: [state]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 258)
    │ │   💬 Args: [token, flowParams.receiver, 0, 0, appCreditDelta, currentContext.timestamp]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 259)
    │ │ │   💬 Args: [token, account]
    │ │ │   👁️  Def: private
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 260)
    │ │ │     💬 Args: [uint256(data[0])]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 261)
    │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 262)
    │ │ │   💬 Args: [state.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 263)
    │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 264)
    │ │ │   💬 Args: [state.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 265)
    │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 266)
    │ │     💬 Args: [state]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 267)
    │     💬 Args: [-availableBalance, -appCreditDelta]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlowToApp(address,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context,enum ConstantFlowAgreementV1.FlowChangeType) (NodeID: 268)
    │   💬 Args: [address(0), flowVars.token, flowParams, oldFlowData, newCtx, currentContext, FlowChangeType.DELETE_FLOW]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.createCallbackInputs(contract ISuperfluidToken,address,bytes32,bytes) (NodeID: 269)
    │ │   💬 Args: [token, appToCallback, flowParams.flowId, abi.encode(flowParams.sender, flowParams.receiver)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.callAppBeforeCallback(struct AgreementLibrary.CallbackInputs,bytes) (NodeID: 270)
    │ │   💬 Args: [cbStates, ctx]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 271)
    │ │ │   💬 Args: [ctx, inputs]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 272)
    │ │ │   💬 Args: [inputs.noopBit]
    │ │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 273)
    │ │     💬 Args: [ctx, 0]
    │ │     👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 274)
    │ │   💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 275)
    │ │ │   💬 Args: [ISuperfluid(_host), token]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 276)
    │ │ │     💬 Args: [pppConfig]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 277)
    │ │ │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 278)
    │ │ │     💬 Args: [deposit]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 279)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 280)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 281)
    │ │ │   💬 Args: [appCreditBase]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 282)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 283)
    │ │ │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 284)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 285)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 286)
    │ │ │   💬 Args: [minimumDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 287)
    │ │ │   💬 Args: [newFlowData]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 288)
    │ │ │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │ │ │   👁️  Def: private
    │ │ │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 289)
    │ │ │ │   💬 Args: [token, account]
    │ │ │ │   👁️  Def: private
    │ │ │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 290)
    │ │ │ │     💬 Args: [uint256(data[0])]
    │ │ │ │     👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 291)
    │ │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 292)
    │ │ │ │   💬 Args: [state.deposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 293)
    │ │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 294)
    │ │ │ │   💬 Args: [state.owedDeposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 295)
    │ │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 296)
    │ │ │     💬 Args: [state]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 297)
    │ │     💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │ │     👁️  Def: private
    │ │   ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 298)
    │ │   │   💬 Args: [token, account]
    │ │   │   👁️  Def: private
    │ │   │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 299)
    │ │   │     💬 Args: [uint256(data[0])]
    │ │   │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 300)
    │ │   │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 301)
    │ │   │   💬 Args: [state.deposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 302)
    │ │   │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 303)
    │ │   │   💬 Args: [state.owedDeposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 304)
    │ │   │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 305)
    │ │       💬 Args: [state]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.max(uint256,uint256) (NodeID: 306)
    │ │   💬 Args: [DEFAULT_MINIMUM_DEPOSIT, minimumDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 307)
    │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.callAppAfterCallback(struct AgreementLibrary.CallbackInputs,bytes,bytes) (NodeID: 308)
    │ │   💬 Args: [cbStates, vars.cbdata, newCtx]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 309)
    │ │ │   💬 Args: [newCtx, inputs]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 310)
    │ │ │   💬 Args: [inputs.noopBit]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._adjustNewAppCreditUsed(uint256,int256) (NodeID: 311)
    │ │ │   💬 Args: [inputs.appCreditGranted, appContext.appCreditUsed]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: AgreementLibrary.max(int256,int256) (NodeID: 312)
    │ │ │     💬 Args: [0, min(appCreditGranted.toInt256(), appCallbackDepositDelta)]
    │ │ │     👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 313)
    │ │ │       💬 Args: [appCreditGranted.toInt256(), appCallbackDepositDelta]
    │ │ │       👁️  Def: internal
    │ │ │     └─ [7] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 314)
    │ │ │         💬 Args: [appCreditGranted]
    │ │ │         👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 315)
    │ │     💬 Args: [ctx, appContext.appCreditUsed]
    │ │     👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAgreementData(contract ISuperfluidToken,bytes32) (NodeID: 316)
    │ │   💬 Args: [token, flowParams.flowId]
    │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 317)
    │ │     💬 Args: [uint256(data[0])]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 318)
    │ │   💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 319)
    │ │ │   💬 Args: [ISuperfluid(_host), token]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 320)
    │ │ │     💬 Args: [pppConfig]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 321)
    │ │ │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 322)
    │ │ │     💬 Args: [deposit]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 323)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 324)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 325)
    │ │ │   💬 Args: [appCreditBase]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 326)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 327)
    │ │ │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 328)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 329)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 330)
    │ │ │   💬 Args: [minimumDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 331)
    │ │ │   💬 Args: [newFlowData]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 332)
    │ │ │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │ │ │   👁️  Def: private
    │ │ │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 333)
    │ │ │ │   💬 Args: [token, account]
    │ │ │ │   👁️  Def: private
    │ │ │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 334)
    │ │ │ │     💬 Args: [uint256(data[0])]
    │ │ │ │     👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 335)
    │ │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 336)
    │ │ │ │   💬 Args: [state.deposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 337)
    │ │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 338)
    │ │ │ │   💬 Args: [state.owedDeposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 339)
    │ │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 340)
    │ │ │     💬 Args: [state]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 341)
    │ │     💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │ │     👁️  Def: private
    │ │   ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 342)
    │ │   │   💬 Args: [token, account]
    │ │   │   👁️  Def: private
    │ │   │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 343)
    │ │   │     💬 Args: [uint256(data[0])]
    │ │   │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 344)
    │ │   │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 345)
    │ │   │   💬 Args: [state.deposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 346)
    │ │   │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 347)
    │ │   │   💬 Args: [state.owedDeposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 348)
    │ │   │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 349)
    │ │       💬 Args: [state]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 350)
    │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 351)
    │ │   💬 Args: [vars.newFlowData.deposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 352)
    │ │   💬 Args: [(vars.newFlowData.deposit.toInt256() + appCreditDelta)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 353)
    │ │   💬 Args: [vars.newFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 354)
    │ │   💬 Args: [(vars.newFlowData.owedDeposit.toInt256() + appCreditDelta)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 355)
    │ │   💬 Args: [vars.newFlowData]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 356)
    │ │   💬 Args: [token, flowParams.sender, 0, appCreditDelta, 0, currentContext.timestamp]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 357)
    │ │ │   💬 Args: [token, account]
    │ │ │   👁️  Def: private
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 358)
    │ │ │     💬 Args: [uint256(data[0])]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 359)
    │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 360)
    │ │ │   💬 Args: [state.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 361)
    │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 362)
    │ │ │   💬 Args: [state.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 363)
    │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 364)
    │ │     💬 Args: [state]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 365)
    │ │   💬 Args: [token, flowParams.receiver, 0, 0, appCreditDelta, currentContext.timestamp]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 366)
    │ │ │   💬 Args: [token, account]
    │ │ │   👁️  Def: private
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 367)
    │ │ │     💬 Args: [uint256(data[0])]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 368)
    │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 369)
    │ │ │   💬 Args: [state.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 370)
    │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 371)
    │ │ │   💬 Args: [state.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 372)
    │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 373)
    │ │     💬 Args: [state]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 374)
    │     💬 Args: [-availableBalance, -appCreditDelta]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlowToNonApp(contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context) (NodeID: 375)
    │   💬 Args: [flowVars.token, flowParams, oldFlowData, newCtx, currentContext]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 376)
    │     💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │     👁️  Def: private
    │   ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 377)
    │   │   💬 Args: [ISuperfluid(_host), token]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 378)
    │   │     💬 Args: [pppConfig]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 379)
    │   │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 380)
    │   │     💬 Args: [deposit]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 381)
    │   │   💬 Args: [oldFlowData.owedDeposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 382)
    │   │   💬 Args: [oldFlowData.deposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 383)
    │   │   💬 Args: [appCreditBase]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 384)
    │   │   💬 Args: [oldFlowData.deposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 385)
    │   │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 386)
    │   │   💬 Args: [oldFlowData.owedDeposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 387)
    │   │   💬 Args: [oldFlowData.deposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 388)
    │   │   💬 Args: [minimumDeposit]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 389)
    │   │   💬 Args: [newFlowData]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 390)
    │   │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │   │   👁️  Def: private
    │   │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 391)
    │   │ │   💬 Args: [token, account]
    │   │ │   👁️  Def: private
    │   │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 392)
    │   │ │     💬 Args: [uint256(data[0])]
    │   │ │     👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 393)
    │   │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 394)
    │   │ │   💬 Args: [state.deposit]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 395)
    │   │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 396)
    │   │ │   💬 Args: [state.owedDeposit]
    │   │ │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 397)
    │   │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │   │ │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 398)
    │   │     💬 Args: [state]
    │   │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 399)
    │       💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │       👁️  Def: private
    │     ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 400)
    │     │   💬 Args: [token, account]
    │     │   👁️  Def: private
    │     │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 401)
    │     │     💬 Args: [uint256(data[0])]
    │     │     👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 402)
    │     │   💬 Args: [(currentTimestamp - state.timestamp)]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 403)
    │     │   💬 Args: [state.deposit]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 404)
    │     │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 405)
    │     │   💬 Args: [state.owedDeposit]
    │     │   👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 406)
    │     │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │     │   👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 407)
    │         💬 Args: [state]
    │         👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlowToApp(address,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context,enum ConstantFlowAgreementV1.FlowChangeType) (NodeID: 408)
    │   💬 Args: [flowVars.receiver, flowVars.token, flowParams, oldFlowData, newCtx, currentContext, FlowChangeType.DELETE_FLOW]
    │   👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.createCallbackInputs(contract ISuperfluidToken,address,bytes32,bytes) (NodeID: 409)
    │ │   💬 Args: [token, appToCallback, flowParams.flowId, abi.encode(flowParams.sender, flowParams.receiver)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.callAppBeforeCallback(struct AgreementLibrary.CallbackInputs,bytes) (NodeID: 410)
    │ │   💬 Args: [cbStates, ctx]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 411)
    │ │ │   💬 Args: [ctx, inputs]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 412)
    │ │ │   💬 Args: [inputs.noopBit]
    │ │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 413)
    │ │     💬 Args: [ctx, 0]
    │ │     👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 414)
    │ │   💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 415)
    │ │ │   💬 Args: [ISuperfluid(_host), token]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 416)
    │ │ │     💬 Args: [pppConfig]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 417)
    │ │ │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 418)
    │ │ │     💬 Args: [deposit]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 419)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 420)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 421)
    │ │ │   💬 Args: [appCreditBase]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 422)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 423)
    │ │ │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 424)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 425)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 426)
    │ │ │   💬 Args: [minimumDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 427)
    │ │ │   💬 Args: [newFlowData]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 428)
    │ │ │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │ │ │   👁️  Def: private
    │ │ │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 429)
    │ │ │ │   💬 Args: [token, account]
    │ │ │ │   👁️  Def: private
    │ │ │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 430)
    │ │ │ │     💬 Args: [uint256(data[0])]
    │ │ │ │     👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 431)
    │ │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 432)
    │ │ │ │   💬 Args: [state.deposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 433)
    │ │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 434)
    │ │ │ │   💬 Args: [state.owedDeposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 435)
    │ │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 436)
    │ │ │     💬 Args: [state]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 437)
    │ │     💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │ │     👁️  Def: private
    │ │   ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 438)
    │ │   │   💬 Args: [token, account]
    │ │   │   👁️  Def: private
    │ │   │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 439)
    │ │   │     💬 Args: [uint256(data[0])]
    │ │   │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 440)
    │ │   │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 441)
    │ │   │   💬 Args: [state.deposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 442)
    │ │   │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 443)
    │ │   │   💬 Args: [state.owedDeposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 444)
    │ │   │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 445)
    │ │       💬 Args: [state]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.max(uint256,uint256) (NodeID: 446)
    │ │   💬 Args: [DEFAULT_MINIMUM_DEPOSIT, minimumDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 447)
    │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AgreementLibrary.callAppAfterCallback(struct AgreementLibrary.CallbackInputs,bytes,bytes) (NodeID: 448)
    │ │   💬 Args: [cbStates, vars.cbdata, newCtx]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._pushCallbackStack(bytes,struct AgreementLibrary.CallbackInputs) (NodeID: 449)
    │ │ │   💬 Args: [newCtx, inputs]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._selectorFromNoopBit(uint256) (NodeID: 450)
    │ │ │   💬 Args: [inputs.noopBit]
    │ │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: AgreementLibrary._adjustNewAppCreditUsed(uint256,int256) (NodeID: 451)
    │ │ │   💬 Args: [inputs.appCreditGranted, appContext.appCreditUsed]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: AgreementLibrary.max(int256,int256) (NodeID: 452)
    │ │ │     💬 Args: [0, min(appCreditGranted.toInt256(), appCallbackDepositDelta)]
    │ │ │     👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 453)
    │ │ │       💬 Args: [appCreditGranted.toInt256(), appCallbackDepositDelta]
    │ │ │       👁️  Def: internal
    │ │ │     └─ [7] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 454)
    │ │ │         💬 Args: [appCreditGranted]
    │ │ │         👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: AgreementLibrary._popCallbackStack(bytes,int256) (NodeID: 455)
    │ │     💬 Args: [ctx, appContext.appCreditUsed]
    │ │     👁️  Def: private
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAgreementData(contract ISuperfluidToken,bytes32) (NodeID: 456)
    │ │   💬 Args: [token, flowParams.flowId]
    │ │   👁️  Def: private
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 457)
    │ │     💬 Args: [uint256(data[0])]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 458)
    │ │   💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 459)
    │ │ │   💬 Args: [ISuperfluid(_host), token]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 460)
    │ │ │     💬 Args: [pppConfig]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 461)
    │ │ │   💬 Args: [flowParams.flowRate, liquidationPeriod]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 462)
    │ │ │     💬 Args: [deposit]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 463)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 464)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 465)
    │ │ │   💬 Args: [appCreditBase]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 466)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 467)
    │ │ │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 468)
    │ │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 469)
    │ │ │   💬 Args: [oldFlowData.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 470)
    │ │ │   💬 Args: [minimumDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 471)
    │ │ │   💬 Args: [newFlowData]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 472)
    │ │ │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
    │ │ │   👁️  Def: private
    │ │ │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 473)
    │ │ │ │   💬 Args: [token, account]
    │ │ │ │   👁️  Def: private
    │ │ │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 474)
    │ │ │ │     💬 Args: [uint256(data[0])]
    │ │ │ │     👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 475)
    │ │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 476)
    │ │ │ │   💬 Args: [state.deposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 477)
    │ │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 478)
    │ │ │ │   💬 Args: [state.owedDeposit]
    │ │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 479)
    │ │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 480)
    │ │ │     💬 Args: [state]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 481)
    │ │     💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
    │ │     👁️  Def: private
    │ │   ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 482)
    │ │   │   💬 Args: [token, account]
    │ │   │   👁️  Def: private
    │ │   │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 483)
    │ │   │     💬 Args: [uint256(data[0])]
    │ │   │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 484)
    │ │   │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 485)
    │ │   │   💬 Args: [state.deposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 486)
    │ │   │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 487)
    │ │   │   💬 Args: [state.owedDeposit]
    │ │   │   👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 488)
    │ │   │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 489)
    │ │       💬 Args: [state]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 490)
    │ │   💬 Args: [oldFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 491)
    │ │   💬 Args: [vars.newFlowData.deposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 492)
    │ │   💬 Args: [(vars.newFlowData.deposit.toInt256() + appCreditDelta)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 493)
    │ │   💬 Args: [vars.newFlowData.owedDeposit]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 494)
    │ │   💬 Args: [(vars.newFlowData.owedDeposit.toInt256() + appCreditDelta)]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 495)
    │ │   💬 Args: [vars.newFlowData]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 496)
    │ │   💬 Args: [token, flowParams.sender, 0, appCreditDelta, 0, currentContext.timestamp]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 497)
    │ │ │   💬 Args: [token, account]
    │ │ │   👁️  Def: private
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 498)
    │ │ │     💬 Args: [uint256(data[0])]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 499)
    │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 500)
    │ │ │   💬 Args: [state.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 501)
    │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 502)
    │ │ │   💬 Args: [state.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 503)
    │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 504)
    │ │     💬 Args: [state]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 505)
    │ │   💬 Args: [token, flowParams.receiver, 0, 0, appCreditDelta, currentContext.timestamp]
    │ │   👁️  Def: private
    │ │ ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 506)
    │ │ │   💬 Args: [token, account]
    │ │ │   👁️  Def: private
    │ │ │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 507)
    │ │ │     💬 Args: [uint256(data[0])]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 508)
    │ │ │   💬 Args: [(currentTimestamp - state.timestamp)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 509)
    │ │ │   💬 Args: [state.deposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 510)
    │ │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 511)
    │ │ │   💬 Args: [state.owedDeposit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 512)
    │ │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 513)
    │ │     💬 Args: [state]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AgreementLibrary.min(int256,int256) (NodeID: 514)
    │     💬 Args: [-availableBalance, -appCreditDelta]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlowToNonApp(contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData,bytes,struct ISuperfluid.Context) (NodeID: 515)
        💬 Args: [flowVars.token, flowParams, oldFlowData, newCtx, currentContext]
        👁️  Def: private
      └─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._changeFlow(uint256,contract ISuperfluidToken,contract ISuperfluidToken,struct ConstantFlowAgreementV1.FlowParams,struct ConstantFlowAgreementV1.FlowData) (NodeID: 516)
          💬 Args: [currentContext.timestamp, currentContext.appCreditToken, token, flowParams, oldFlowData]
          👁️  Def: private
        ├─ [4] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 517)
        │   💬 Args: [ISuperfluid(_host), token]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 518)
        │     💬 Args: [pppConfig]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 519)
        │   💬 Args: [flowParams.flowRate, liquidationPeriod]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 520)
        │     💬 Args: [deposit]
        │     👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 521)
        │   💬 Args: [oldFlowData.owedDeposit]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 522)
        │   💬 Args: [oldFlowData.deposit]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 523)
        │   💬 Args: [appCreditBase]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 524)
        │   💬 Args: [oldFlowData.deposit]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 525)
        │   💬 Args: [(oldFlowData.deposit.toInt256() + depositDelta)]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 526)
        │   💬 Args: [oldFlowData.owedDeposit]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 527)
        │   💬 Args: [oldFlowData.deposit]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 528)
        │   💬 Args: [minimumDeposit]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 529)
        │   💬 Args: [newFlowData]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 530)
        │   💬 Args: [token, flowParams.sender, oldFlowData.flowRate - flowParams.flowRate, depositDelta, 0, currentTimestamp]
        │   👁️  Def: private
        │ ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 531)
        │ │   💬 Args: [token, account]
        │ │   👁️  Def: private
        │ │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 532)
        │ │     💬 Args: [uint256(data[0])]
        │ │     👁️  Def: internal
        │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 533)
        │ │   💬 Args: [(currentTimestamp - state.timestamp)]
        │ │   👁️  Def: internal
        │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 534)
        │ │   💬 Args: [state.deposit]
        │ │   👁️  Def: internal
        │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 535)
        │ │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
        │ │   👁️  Def: internal
        │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 536)
        │ │   💬 Args: [state.owedDeposit]
        │ │   👁️  Def: internal
        │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 537)
        │ │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
        │ │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 538)
        │     💬 Args: [state]
        │     👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateAccountFlowState(contract ISuperfluidToken,address,int96,int256,int256,uint256) (NodeID: 539)
            💬 Args: [token, flowParams.receiver, flowParams.flowRate - oldFlowData.flowRate, 0, 0, currentTimestamp]
            👁️  Def: private
          ├─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 540)
          │   💬 Args: [token, account]
          │   👁️  Def: private
          │ └─ [6] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 541)
          │     💬 Args: [uint256(data[0])]
          │     👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 542)
          │   💬 Args: [(currentTimestamp - state.timestamp)]
          │   👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 543)
          │   💬 Args: [state.deposit]
          │   👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 544)
          │   💬 Args: [(state.deposit.toInt256() + depositDelta)]
          │   👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 545)
          │   💬 Args: [state.owedDeposit]
          │   👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 546)
          │   💬 Args: [(state.owedDeposit.toInt256() + owedDepositDelta)]
          │   👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowData(struct ConstantFlowAgreementV1.FlowData) (NodeID: 547)
              💬 Args: [state]
              👁️  Def: internal
```

## Documentation

### Function Documentation

@dev IConstantFlowAgreementV1.deleteFlow implementation
