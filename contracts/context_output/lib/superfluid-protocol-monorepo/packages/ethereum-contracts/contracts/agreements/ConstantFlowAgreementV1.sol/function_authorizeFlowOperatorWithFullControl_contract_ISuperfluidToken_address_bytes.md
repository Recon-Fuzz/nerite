# Function: authorizeFlowOperatorWithFullControl(contract ISuperfluidToken,address,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `authorizeFlowOperatorWithFullControl(contract ISuperfluidToken,address,bytes)`
- **Visibility**: external
- **Source Range**: 32270:425:121

## Implementation

```solidity
/// @dev IConstantFlowAgreementV1.authorizeFlowOperatorWithFullControl implementation
function authorizeFlowOperatorWithFullControl(ISuperfluidToken token, address flowOperator, bytes calldata ctx) override external returns (bytes memory newCtx) {
    newCtx = updateFlowOperatorPermissions(token, flowOperator, FlowOperatorDefinitions.AUTHORIZE_FULL_CONTROL, type(int96).max, ctx);
}
```

## Related Implementations

### updateFlowOperatorPermissions(contract ISuperfluidToken,address,uint8,int96,bytes)

- **Kind**: internal
- **Source**: 27481:932:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:updateFlowOperatorPermissions(contract ISuperfluidToken,address,uint8,int96,bytes)`

```solidity
/// @dev IConstantFlowAgreementV1.updateFlowOperatorPermissions implementation
function updateFlowOperatorPermissions(ISuperfluidToken token, address flowOperator, uint8 permissions, int96 flowRateAllowance, bytes calldata ctx) override public returns (bytes memory newCtx) {
    newCtx = ctx;
    ISuperfluid.Context memory currentContext = _validateAndAuthorizeUpdateFlowOperatorDataInput(token, flowOperator, permissions, flowRateAllowance, ctx);
    FlowOperatorData memory flowOperatorData;
    flowOperatorData.permissions = permissions;
    flowOperatorData.flowRateAllowance = flowRateAllowance;
    bytes32 flowOperatorId = _generateFlowOperatorId(currentContext.msgSender, flowOperator);
    token.updateAgreementData(flowOperatorId, _encodeFlowOperatorData(flowOperatorData));
    emit FlowOperatorUpdated(token, currentContext.msgSender, flowOperator, permissions, flowRateAllowance);
}
```

### _validateAndAuthorizeUpdateFlowOperatorDataInput(contract ISuperfluidToken,address,uint8,int96,bytes)

- **Kind**: internal
- **Source**: 31540:634:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_validateAndAuthorizeUpdateFlowOperatorDataInput(contract ISuperfluidToken,address,uint8,int96,bytes)`

```solidity
/// @dev This function ensures:
///  - token access is authorized
///  - passed permissions are "clean"
///  - no sender flow operator
///  - no negative allowance
function _validateAndAuthorizeUpdateFlowOperatorDataInput(ISuperfluidToken token, address flowOperator, uint8 permissions, int96 flowAllowance, bytes calldata ctx) internal view returns (ISuperfluid.Context memory currentContext) {
    if (!FlowOperatorDefinitions.isPermissionsClean(permissions)) revert CFA_ACL_UNCLEAN_PERMISSIONS();
    currentContext = AgreementLibrary.authorizeTokenAccess(token, ctx);
    if (currentContext.msgSender == flowOperator) revert CFA_ACL_NO_SENDER_FLOW_OPERATOR();
    if (flowAllowance < 0) revert CFA_ACL_NO_NEGATIVE_ALLOWANCE();
}
```

### isPermissionsClean(uint8)

- **Kind**: internal
- **Source**: 5136:279:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:FlowOperatorDefinitions:isPermissionsClean(uint8)`

```solidity
function isPermissionsClean(uint8 permissions) internal pure returns (bool) {
    return (permissions & (~((AUTHORIZE_FLOW_OPERATOR_CREATE | AUTHORIZE_FLOW_OPERATOR_UPDATE) | AUTHORIZE_FLOW_OPERATOR_DELETE))) == uint8(0);
}
```

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

### _generateFlowOperatorId(address,address)

- **Kind**: internal
- **Source**: 59069:187:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_generateFlowOperatorId(address,address)`

```solidity
function _generateFlowOperatorId(address sender, address flowOperator) private pure returns (bytes32 id) {
    return keccak256(abi.encode("flowOperator", sender, flowOperator));
}
```

### _encodeFlowOperatorData(struct ConstantFlowAgreementV1.FlowOperatorData)

- **Kind**: internal
- **Source**: 59602:529:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_encodeFlowOperatorData(struct ConstantFlowAgreementV1.FlowOperatorData)`

```solidity
function _encodeFlowOperatorData(FlowOperatorData memory flowOperatorData) internal pure returns (bytes32[] memory data) {
    assert(flowOperatorData.flowRateAllowance >= 0);
    data = new bytes32[](1);
    data[0] = bytes32((uint256(flowOperatorData.permissions) << 128) | uint256(int256(flowOperatorData.flowRateAllowance)));
}
```

## External Calls

- **ISuperfluidToken::updateAgreementData(bytes32,bytes32[])**
- **ISuperfluidToken::getHost()**
- **ISuperfluid::isCtxValid(bytes)**
- **ISuperfluid::decodeCtx(bytes)**

## State Variable Reads

- **AUTHORIZE_FLOW_OPERATOR_CREATE** (`uint8`)
- **AUTHORIZE_FLOW_OPERATOR_UPDATE** (`uint8`)
- **AUTHORIZE_FLOW_OPERATOR_DELETE** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.authorizeFlowOperatorWithFullControl(contract ISuperfluidToken,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1.updateFlowOperatorPermissions(contract ISuperfluidToken,address,uint8,int96,bytes) (NodeID: 1)
      💬 Args: [token, flowOperator, FlowOperatorDefinitions.AUTHORIZE_FULL_CONTROL, type(int96).max, ctx]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._validateAndAuthorizeUpdateFlowOperatorDataInput(contract ISuperfluidToken,address,uint8,int96,bytes) (NodeID: 2)
    │   💬 Args: [token, flowOperator, permissions, flowRateAllowance, ctx]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: FlowOperatorDefinitions.isPermissionsClean(uint8) (NodeID: 3)
    │ │   💬 Args: [permissions]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 4)
    │     💬 Args: [token, ctx]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._generateFlowOperatorId(address,address) (NodeID: 5)
    │   💬 Args: [currentContext.msgSender, flowOperator]
    │   👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowOperatorData(struct ConstantFlowAgreementV1.FlowOperatorData) (NodeID: 6)
        💬 Args: [flowOperatorData]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev IConstantFlowAgreementV1.authorizeFlowOperatorWithFullControl implementation
