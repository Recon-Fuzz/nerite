# Function: decreaseFlowRateAllowanceWithPermissions(contract ISuperfluidToken,address,uint8,int96,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `decreaseFlowRateAllowanceWithPermissions(contract ISuperfluidToken,address,uint8,int96,bytes)`
- **Visibility**: public
- **Source Range**: 29727:1227:121

## Implementation

```solidity
/// @dev IConstantFlowAgreementV1.decreaseFlowRateAllowanceWithPermissions implementation
function decreaseFlowRateAllowanceWithPermissions(ISuperfluidToken token, address flowOperator, uint8 permissionsToRemove, int96 subtractedFlowRateAllowance, bytes calldata ctx) override public returns (bytes memory newCtx) {
    newCtx = ctx;
    ISuperfluid.Context memory currentContext = _validateAndAuthorizeUpdateFlowOperatorDataInput(token, flowOperator, permissionsToRemove, subtractedFlowRateAllowance, ctx);
    (bytes32 flowOperatorId, uint8 oldPermissions, int96 oldFlowRateAllowance) = getFlowOperatorData(token, currentContext.msgSender, flowOperator);
    uint8 permissions = removePermissions(oldPermissions, permissionsToRemove);
    int96 newFlowRateAllowance = oldFlowRateAllowance - subtractedFlowRateAllowance;
    if (newFlowRateAllowance < 0) revert CFA_ACL_NO_NEGATIVE_ALLOWANCE();
    _updateFlowOperatorData(token, flowOperatorId, permissions, newFlowRateAllowance);
    emit FlowOperatorUpdated(token, currentContext.msgSender, flowOperator, permissions, newFlowRateAllowance);
}
```

## Related Implementations

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

### removePermissions(uint8,uint8)

- **Kind**: internal
- **Source**: 31157:197:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:removePermissions(uint8,uint8)`

```solidity
function removePermissions(uint8 existingPermissions, uint8 permissionDelta) public pure returns (uint8) {
    return existingPermissions & (~permissionDelta);
}
```

### _updateFlowOperatorData(contract ISuperfluidToken,bytes32,uint8,int96)

- **Kind**: internal
- **Source**: 35713:483:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_updateFlowOperatorData(contract ISuperfluidToken,bytes32,uint8,int96)`

```solidity
function _updateFlowOperatorData(ISuperfluidToken token, bytes32 flowOperatorId, uint8 updatedPermissions, int96 updatedFlowRateAllowance) private {
    FlowOperatorData memory flowOperatorData;
    flowOperatorData.permissions = updatedPermissions;
    flowOperatorData.flowRateAllowance = updatedFlowRateAllowance;
    token.updateAgreementData(flowOperatorId, _encodeFlowOperatorData(flowOperatorData));
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

- **ISuperfluidToken::getHost()**
- **ISuperfluid::isCtxValid(bytes)**
- **ISuperfluid::decodeCtx(bytes)**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**
- **ISuperfluidToken::updateAgreementData(bytes32,bytes32[])**

## State Variable Reads

- **AUTHORIZE_FLOW_OPERATOR_CREATE** (`uint8`)
- **AUTHORIZE_FLOW_OPERATOR_UPDATE** (`uint8`)
- **AUTHORIZE_FLOW_OPERATOR_DELETE** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.decreaseFlowRateAllowanceWithPermissions(contract ISuperfluidToken,address,uint8,int96,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._validateAndAuthorizeUpdateFlowOperatorDataInput(contract ISuperfluidToken,address,uint8,int96,bytes) (NodeID: 1)
  │   💬 Args: [token, flowOperator, permissionsToRemove, subtractedFlowRateAllowance, ctx]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: FlowOperatorDefinitions.isPermissionsClean(uint8) (NodeID: 2)
  │ │   💬 Args: [permissions]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 3)
  │     💬 Args: [token, ctx]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1.getFlowOperatorData(contract ISuperfluidToken,address,address) (NodeID: 4)
  │   💬 Args: [token, currentContext.msgSender, flowOperator]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._generateFlowOperatorId(address,address) (NodeID: 5)
  │ │   💬 Args: [sender, flowOperator]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._getFlowOperatorData(contract ISuperfluidToken,bytes32) (NodeID: 6)
  │     💬 Args: [token, flowOperatorId]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowOperatorData(uint256) (NodeID: 7)
  │       💬 Args: [uint256(data[0])]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1.removePermissions(uint8,uint8) (NodeID: 8)
  │   💬 Args: [oldPermissions, permissionsToRemove]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._updateFlowOperatorData(contract ISuperfluidToken,bytes32,uint8,int96) (NodeID: 9)
      💬 Args: [token, flowOperatorId, permissions, newFlowRateAllowance]
      👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._encodeFlowOperatorData(struct ConstantFlowAgreementV1.FlowOperatorData) (NodeID: 10)
        💬 Args: [flowOperatorData]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev IConstantFlowAgreementV1.decreaseFlowRateAllowanceWithPermissions implementation
