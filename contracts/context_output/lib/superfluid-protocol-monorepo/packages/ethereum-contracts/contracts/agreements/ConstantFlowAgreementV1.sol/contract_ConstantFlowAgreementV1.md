# Contract: ConstantFlowAgreementV1

## Metadata

- **Name**: ConstantFlowAgreementV1
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol
- **Documentation**:  @title ConstantFlowAgreementV1 contract
   @author Superfluid
   @dev Please read IConstantFlowAgreementV1 for implementation notes.
   @dev For more technical notes, please visit protocol-monorepo wiki area.
   Storage Layout Notes
   Agreement State
   NOTE The Agreement State slot is computed with the following function:
   keccak256(abi.encode("AgreementState", msg.sender, account, slotId))
   slotId           = 0
   msg.sender       = address of CFAv1
   account          = context.msgSender
   Flow Agreement State stores the global FlowData state for an account.
   Agreement Data
   NOTE The Agreement Data slot is calculated with the following function:
   keccak256(abi.encode("AgreementData", agreementClass, agreementId))
   agreementClass   = address of CFAv1
   agreementId      = FlowId | FlowOperatorId
   FlowId           = keccak256(abi.encode(flowSender, flowReceiver))
   FlowId stores FlowData between a flowSender and flowReceiver.
   FlowOperatorId   = keccak256(abi.encode("flowOperator", flowSender, flowOperator))
   FlowOperatorId stores FlowOperatorData between a flowSender and flowOperator.

## Implements Interfaces

- **ISuperAgreement** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]

## State Variables

### _initialized (inherited from Initializable)

```solidity
///  @dev Indicates that the contract has been initialized.
///  @custom:oz-retyped-from bool
uint8 private _initialized
```

### _initializing (inherited from Initializable)

```solidity
///  @dev Indicates that the contract is in the process of being initialized.
bool private _initializing
```

### _host (inherited from AgreementBase)

```solidity
address internal immutable _host
```

### DEFAULT_MINIMUM_DEPOSIT

```solidity
///  @dev Default minimum deposit value
///  NOTE:
///  - It may come as a surprise that it is not 0, this is the minimum friction we have in the system for the
///    imperfect blockchain system we live in.
///  - It is related to deposit clipping, and it is always rounded-up when clipping.
uint256 public constant DEFAULT_MINIMUM_DEPOSIT = uint256(uint96(1 << 32))
```

### MAXIMUM_DEPOSIT

```solidity
/// @dev Maximum deposit value
uint256 public constant MAXIMUM_DEPOSIT = uint256(uint96(type(int96).max))
```

### MAXIMUM_FLOW_RATE

```solidity
/// @dev Maximum flow rate
uint256 public constant MAXIMUM_FLOW_RATE = uint256(uint96(type(int96).max))
```

### CFA_HOOK_GAS_LIMIT

```solidity
uint64 public constant CFA_HOOK_GAS_LIMIT = 250000
```

## Structs

### FlowData

```solidity
struct FlowData {
    uint256 timestamp;
    int96 flowRate;
    uint256 deposit;
    uint256 owedDeposit;
}
```

### FlowParams

```solidity
struct FlowParams {
    bytes32 flowId;
    address sender;
    address receiver;
    address flowOperator;
    int96 flowRate;
    bytes userData;
}
```

### FlowOperatorData

```solidity
struct FlowOperatorData {
    uint8 permissions;
    int96 flowRateAllowance;
}
```

### _StackVars_createOrUpdateFlow

```solidity
struct _StackVars_createOrUpdateFlow {
    ISuperfluidToken token;
    address sender;
    address receiver;
    int96 flowRate;
}
```

### _StackVars_changeFlowToApp

```solidity
///  @dev change a flow to a app receiver
struct _StackVars_changeFlowToApp {
    bytes cbdata;
    FlowData newFlowData;
    ISuperfluid.Context appContext;
}
```

### _StackVars_changeFlow

```solidity
struct _StackVars_changeFlow {
    int96 totalSenderFlowRate;
    int96 totalReceiverFlowRate;
}
```

## Errors

### AGREEMENT_BASE_ONLY_HOST (inherited from AgreementBase)

```solidity
error AGREEMENT_BASE_ONLY_HOST();
```

### CFA_ACL_NO_SENDER_CREATE (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_ACL_NO_SENDER_CREATE();
```

### CFA_ACL_NO_SENDER_UPDATE (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_ACL_NO_SENDER_UPDATE();
```

### CFA_ACL_OPERATOR_NO_CREATE_PERMISSIONS (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_ACL_OPERATOR_NO_CREATE_PERMISSIONS();
```

### CFA_ACL_OPERATOR_NO_UPDATE_PERMISSIONS (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_ACL_OPERATOR_NO_UPDATE_PERMISSIONS();
```

### CFA_ACL_OPERATOR_NO_DELETE_PERMISSIONS (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_ACL_OPERATOR_NO_DELETE_PERMISSIONS();
```

### CFA_ACL_FLOW_RATE_ALLOWANCE_EXCEEDED (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_ACL_FLOW_RATE_ALLOWANCE_EXCEEDED();
```

### CFA_ACL_UNCLEAN_PERMISSIONS (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_ACL_UNCLEAN_PERMISSIONS();
```

### CFA_ACL_NO_SENDER_FLOW_OPERATOR (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_ACL_NO_SENDER_FLOW_OPERATOR();
```

### CFA_ACL_NO_NEGATIVE_ALLOWANCE (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_ACL_NO_NEGATIVE_ALLOWANCE();
```

### CFA_FLOW_ALREADY_EXISTS (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_FLOW_ALREADY_EXISTS();
```

### CFA_FLOW_DOES_NOT_EXIST (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_FLOW_DOES_NOT_EXIST();
```

### CFA_INSUFFICIENT_BALANCE (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_INSUFFICIENT_BALANCE();
```

### CFA_ZERO_ADDRESS_SENDER (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_ZERO_ADDRESS_SENDER();
```

### CFA_ZERO_ADDRESS_RECEIVER (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_ZERO_ADDRESS_RECEIVER();
```

### CFA_HOOK_OUT_OF_GAS (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_HOOK_OUT_OF_GAS();
```

### CFA_DEPOSIT_TOO_BIG (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_DEPOSIT_TOO_BIG();
```

### CFA_FLOW_RATE_TOO_BIG (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_FLOW_RATE_TOO_BIG();
```

### CFA_NON_CRITICAL_SENDER (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_NON_CRITICAL_SENDER();
```

### CFA_INVALID_FLOW_RATE (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_INVALID_FLOW_RATE();
```

### CFA_NO_SELF_FLOW (inherited from IConstantFlowAgreementV1)

```solidity
error CFA_NO_SELF_FLOW();
```

## Events

### Initialized (inherited from Initializable)

```solidity
///  @dev Triggered when the contract has been initialized or reinitialized.
event Initialized(uint8 version);
```

### CodeUpdated (inherited from UUPSProxiable)

```solidity
event CodeUpdated(bytes32 uuid, address codeAddress);
```

### FlowOperatorUpdated (inherited from IConstantFlowAgreementV1)

```solidity
///  @dev Flow operator updated event
///  @param token Super token address
///  @param sender Flow sender address
///  @param flowOperator Flow operator address
///  @param permissions Octo bitmask representation of permissions
///  @param flowRateAllowance The flow rate allowance the `flowOperator` is granted (only goes down)
event FlowOperatorUpdated(ISuperfluidToken indexed token, address indexed sender, address indexed flowOperator, uint8 permissions, int96 flowRateAllowance);
```

### FlowUpdated (inherited from IConstantFlowAgreementV1)

```solidity
///  @dev Flow updated event
///  @param token Super token address
///  @param sender Flow sender address
///  @param receiver Flow recipient address
///  @param flowRate Flow rate in amount per second for this flow
///  @param totalSenderFlowRate Total flow rate in amount per second for the sender
///  @param totalReceiverFlowRate Total flow rate in amount per second for the receiver
///  @param userData The user provided data
event FlowUpdated(ISuperfluidToken indexed token, address indexed sender, address indexed receiver, int96 flowRate, int256 totalSenderFlowRate, int256 totalReceiverFlowRate, bytes userData);
```

### FlowUpdatedExtension (inherited from IConstantFlowAgreementV1)

```solidity
///  @dev Flow updated extension event
///  @param flowOperator Flow operator address - the Context.msgSender
///  @param deposit The deposit amount for the stream
event FlowUpdatedExtension(address indexed flowOperator, uint256 deposit);
```

## Enums

### FlowChangeType

```solidity
enum FlowChangeType {
    CREATE_FLOW,
    UPDATE_FLOW,
    DELETE_FLOW
}
```

## Public/External Functions

### constructor(contract ISuperfluid)

- **Signature**: `constructor(contract ISuperfluid)`
- **Visibility**: public
- **Source Range**: 3376:75:121
- **Details**: [function_constructor_contract_ISuperfluid.md](./function_constructor_contract_ISuperfluid.md)

**Signature:**
```solidity
constructor(ISuperfluid host) AgreementBase(address(host));
```

### realtimeBalanceOf(contract ISuperfluidToken,address,uint256)

- **Signature**: `realtimeBalanceOf(contract ISuperfluidToken,address,uint256)`
- **Visibility**: external
- **Source Range**: 3713:536:121
- **Details**: [function_realtimeBalanceOf_contract_ISuperfluidToken_address_uint256.md](./function_realtimeBalanceOf_contract_ISuperfluidToken_address_uint256.md)

**Signature:**
```solidity
/// @dev ISuperAgreement.realtimeBalanceOf implementation
function realtimeBalanceOf(ISuperfluidToken token, address account, uint256 time) override external view returns (int256 dynamicBalance, uint256 deposit, uint256 owedDeposit);
```

### getMaximumFlowRateFromDeposit(contract ISuperfluidToken,uint256)

- **Signature**: `getMaximumFlowRateFromDeposit(contract ISuperfluidToken,uint256)`
- **Visibility**: external
- **Source Range**: 5706:367:121
- **Details**: [function_getMaximumFlowRateFromDeposit_contract_ISuperfluidToken_uint256.md](./function_getMaximumFlowRateFromDeposit_contract_ISuperfluidToken_uint256.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.getMaximumFlowRateFromDeposit implementation
function getMaximumFlowRateFromDeposit(ISuperfluidToken token, uint256 deposit) override external view returns (int96 flowRate);
```

### getDepositRequiredForFlowRate(contract ISuperfluidToken,int96)

- **Signature**: `getDepositRequiredForFlowRate(contract ISuperfluidToken,int96)`
- **Visibility**: external
- **Source Range**: 6164:846:121
- **Details**: [function_getDepositRequiredForFlowRate_contract_ISuperfluidToken_int96.md](./function_getDepositRequiredForFlowRate_contract_ISuperfluidToken_int96.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.getDepositRequiredForFlowRate implementation
function getDepositRequiredForFlowRate(ISuperfluidToken token, int96 flowRate) override external view returns (uint256 deposit);
```

### isPatricianPeriodNow(contract ISuperfluidToken,address)

- **Signature**: `isPatricianPeriodNow(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 7016:331:121
- **Details**: [function_isPatricianPeriodNow_contract_ISuperfluidToken_address.md](./function_isPatricianPeriodNow_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
function isPatricianPeriodNow(ISuperfluidToken token, address account) override external view returns (bool isCurrentlyPatricianPeriod, uint256 timestamp);
```

### isPatricianPeriod(contract ISuperfluidToken,address,uint256)

- **Signature**: `isPatricianPeriod(contract ISuperfluidToken,address,uint256)`
- **Visibility**: public
- **Source Range**: 7353:827:121
- **Details**: [function_isPatricianPeriod_contract_ISuperfluidToken_address_uint256.md](./function_isPatricianPeriod_contract_ISuperfluidToken_address_uint256.md)

**Signature:**
```solidity
function isPatricianPeriod(ISuperfluidToken token, address account, uint256 timestamp) override public view returns (bool);
```

### createFlow(contract ISuperfluidToken,address,int96,bytes)

- **Signature**: `createFlow(contract ISuperfluidToken,address,int96,bytes)`
- **Visibility**: external
- **Source Range**: 8250:645:121
- **Details**: [function_createFlow_contract_ISuperfluidToken_address_int96_bytes.md](./function_createFlow_contract_ISuperfluidToken_address_int96_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.createFlow implementation
function createFlow(ISuperfluidToken token, address receiver, int96 flowRate, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### updateFlow(contract ISuperfluidToken,address,int96,bytes)

- **Signature**: `updateFlow(contract ISuperfluidToken,address,int96,bytes)`
- **Visibility**: external
- **Source Range**: 8965:863:121
- **Details**: [function_updateFlow_contract_ISuperfluidToken_address_int96_bytes.md](./function_updateFlow_contract_ISuperfluidToken_address_int96_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.updateFlow implementation
function updateFlow(ISuperfluidToken token, address receiver, int96 flowRate, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### deleteFlow(contract ISuperfluidToken,address,address,bytes)

- **Signature**: `deleteFlow(contract ISuperfluidToken,address,address,bytes)`
- **Visibility**: external
- **Source Range**: 9898:791:121
- **Details**: [function_deleteFlow_contract_ISuperfluidToken_address_address_bytes.md](./function_deleteFlow_contract_ISuperfluidToken_address_address_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.deleteFlow implementation
function deleteFlow(ISuperfluidToken token, address sender, address receiver, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### getFlow(contract ISuperfluidToken,address,address)

- **Signature**: `getFlow(contract ISuperfluidToken,address,address)`
- **Visibility**: external
- **Source Range**: 10756:570:121
- **Details**: [function_getFlow_contract_ISuperfluidToken_address_address.md](./function_getFlow_contract_ISuperfluidToken_address_address.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.getFlow implementation
function getFlow(ISuperfluidToken token, address sender, address receiver) override external view returns (uint256 timestamp, int96 flowRate, uint256 deposit, uint256 owedDeposit);
```

### getFlowByID(contract ISuperfluidToken,bytes32)

- **Signature**: `getFlowByID(contract ISuperfluidToken,bytes32)`
- **Visibility**: external
- **Source Range**: 11393:530:121
- **Details**: [function_getFlowByID_contract_ISuperfluidToken_bytes32.md](./function_getFlowByID_contract_ISuperfluidToken_bytes32.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.getFlow implementation
function getFlowByID(ISuperfluidToken token, bytes32 flowId) override external view returns (uint256 timestamp, int96 flowRate, uint256 deposit, uint256 owedDeposit);
```

### getAccountFlowInfo(contract ISuperfluidToken,address)

- **Signature**: `getAccountFlowInfo(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 12001:488:121
- **Details**: [function_getAccountFlowInfo_contract_ISuperfluidToken_address.md](./function_getAccountFlowInfo_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.getAccountFlowInfo implementation
function getAccountFlowInfo(ISuperfluidToken token, address account) override external view returns (uint256 timestamp, int96 flowRate, uint256 deposit, uint256 owedDeposit);
```

### getNetFlow(contract ISuperfluidToken,address)

- **Signature**: `getNetFlow(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 12559:263:121
- **Details**: [function_getNetFlow_contract_ISuperfluidToken_address.md](./function_getNetFlow_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.getNetFlow implementation
function getNetFlow(ISuperfluidToken token, address account) override external view returns (int96 flowRate);
```

### createFlowByOperator(contract ISuperfluidToken,address,address,int96,bytes)

- **Signature**: `createFlowByOperator(contract ISuperfluidToken,address,address,int96,bytes)`
- **Visibility**: external
- **Source Range**: 21815:1701:121
- **Details**: [function_createFlowByOperator_contract_ISuperfluidToken_address_address_int96_bytes.md](./function_createFlowByOperator_contract_ISuperfluidToken_address_address_int96_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.createFlowByOperator implementation
function createFlowByOperator(ISuperfluidToken token, address sender, address receiver, int96 flowRate, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### updateFlowByOperator(contract ISuperfluidToken,address,address,int96,bytes)

- **Signature**: `updateFlowByOperator(contract ISuperfluidToken,address,address,int96,bytes)`
- **Visibility**: external
- **Source Range**: 23596:1961:121
- **Details**: [function_updateFlowByOperator_contract_ISuperfluidToken_address_address_int96_bytes.md](./function_updateFlowByOperator_contract_ISuperfluidToken_address_address_int96_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.updateFlowByOperator implementation
function updateFlowByOperator(ISuperfluidToken token, address sender, address receiver, int96 flowRate, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### deleteFlowByOperator(contract ISuperfluidToken,address,address,bytes)

- **Signature**: `deleteFlowByOperator(contract ISuperfluidToken,address,address,bytes)`
- **Visibility**: external
- **Source Range**: 25637:871:121
- **Details**: [function_deleteFlowByOperator_contract_ISuperfluidToken_address_address_bytes.md](./function_deleteFlowByOperator_contract_ISuperfluidToken_address_address_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.deleteFlowByOperator implementation
function deleteFlowByOperator(ISuperfluidToken token, address sender, address receiver, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### increaseFlowRateAllowance(contract ISuperfluidToken,address,int96,bytes)

- **Signature**: `increaseFlowRateAllowance(contract ISuperfluidToken,address,int96,bytes)`
- **Visibility**: public
- **Source Range**: 26593:352:121
- **Details**: [function_increaseFlowRateAllowance_contract_ISuperfluidToken_address_int96_bytes.md](./function_increaseFlowRateAllowance_contract_ISuperfluidToken_address_int96_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.increaseFlowRateAllowance implementation
function increaseFlowRateAllowance(ISuperfluidToken token, address flowOperator, int96 addedFlowRateAllowance, bytes calldata ctx) override public returns (bytes memory newCtx);
```

### decreaseFlowRateAllowance(contract ISuperfluidToken,address,int96,bytes)

- **Signature**: `decreaseFlowRateAllowance(contract ISuperfluidToken,address,int96,bytes)`
- **Visibility**: public
- **Source Range**: 27030:362:121
- **Details**: [function_decreaseFlowRateAllowance_contract_ISuperfluidToken_address_int96_bytes.md](./function_decreaseFlowRateAllowance_contract_ISuperfluidToken_address_int96_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.decreaseFlowRateAllowance implementation
function decreaseFlowRateAllowance(ISuperfluidToken token, address flowOperator, int96 subtractedFlowRateAllowance, bytes calldata ctx) override public returns (bytes memory newCtx);
```

### updateFlowOperatorPermissions(contract ISuperfluidToken,address,uint8,int96,bytes)

- **Signature**: `updateFlowOperatorPermissions(contract ISuperfluidToken,address,uint8,int96,bytes)`
- **Visibility**: public
- **Source Range**: 27481:932:121
- **Details**: [function_updateFlowOperatorPermissions_contract_ISuperfluidToken_address_uint8_int96_bytes.md](./function_updateFlowOperatorPermissions_contract_ISuperfluidToken_address_uint8_int96_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.updateFlowOperatorPermissions implementation
function updateFlowOperatorPermissions(ISuperfluidToken token, address flowOperator, uint8 permissions, int96 flowRateAllowance, bytes calldata ctx) override public returns (bytes memory newCtx);
```

### increaseFlowRateAllowanceWithPermissions(contract ISuperfluidToken,address,uint8,int96,bytes)

- **Signature**: `increaseFlowRateAllowanceWithPermissions(contract ISuperfluidToken,address,uint8,int96,bytes)`
- **Visibility**: public
- **Source Range**: 28513:1114:121
- **Details**: [function_increaseFlowRateAllowanceWithPermissions_contract_ISuperfluidToken_address_uint8_int96_bytes.md](./function_increaseFlowRateAllowanceWithPermissions_contract_ISuperfluidToken_address_uint8_int96_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.increaseFlowRateAllowanceWithPermissions implementation
function increaseFlowRateAllowanceWithPermissions(ISuperfluidToken token, address flowOperator, uint8 permissionsToAdd, int96 addedFlowRateAllowance, bytes calldata ctx) override public returns (bytes memory newCtx);
```

### decreaseFlowRateAllowanceWithPermissions(contract ISuperfluidToken,address,uint8,int96,bytes)

- **Signature**: `decreaseFlowRateAllowanceWithPermissions(contract ISuperfluidToken,address,uint8,int96,bytes)`
- **Visibility**: public
- **Source Range**: 29727:1227:121
- **Details**: [function_decreaseFlowRateAllowanceWithPermissions_contract_ISuperfluidToken_address_uint8_int96_bytes.md](./function_decreaseFlowRateAllowanceWithPermissions_contract_ISuperfluidToken_address_uint8_int96_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.decreaseFlowRateAllowanceWithPermissions implementation
function decreaseFlowRateAllowanceWithPermissions(ISuperfluidToken token, address flowOperator, uint8 permissionsToRemove, int96 subtractedFlowRateAllowance, bytes calldata ctx) override public returns (bytes memory newCtx);
```

### addPermissions(uint8,uint8)

- **Signature**: `addPermissions(uint8,uint8)`
- **Visibility**: public
- **Source Range**: 30960:191:121
- **Details**: [function_addPermissions_uint8_uint8.md](./function_addPermissions_uint8_uint8.md)

**Signature:**
```solidity
function addPermissions(uint8 existingPermissions, uint8 permissionDelta) public pure returns (uint8);
```

### removePermissions(uint8,uint8)

- **Signature**: `removePermissions(uint8,uint8)`
- **Visibility**: public
- **Source Range**: 31157:197:121
- **Details**: [function_removePermissions_uint8_uint8.md](./function_removePermissions_uint8_uint8.md)

**Signature:**
```solidity
function removePermissions(uint8 existingPermissions, uint8 permissionDelta) public pure returns (uint8);
```

### authorizeFlowOperatorWithFullControl(contract ISuperfluidToken,address,bytes)

- **Signature**: `authorizeFlowOperatorWithFullControl(contract ISuperfluidToken,address,bytes)`
- **Visibility**: external
- **Source Range**: 32270:425:121
- **Details**: [function_authorizeFlowOperatorWithFullControl_contract_ISuperfluidToken_address_bytes.md](./function_authorizeFlowOperatorWithFullControl_contract_ISuperfluidToken_address_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.authorizeFlowOperatorWithFullControl implementation
function authorizeFlowOperatorWithFullControl(ISuperfluidToken token, address flowOperator, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### revokeFlowOperatorWithFullControl(contract ISuperfluidToken,address,bytes)

- **Signature**: `revokeFlowOperatorWithFullControl(contract ISuperfluidToken,address,bytes)`
- **Visibility**: external
- **Source Range**: 32788:334:121
- **Details**: [function_revokeFlowOperatorWithFullControl_contract_ISuperfluidToken_address_bytes.md](./function_revokeFlowOperatorWithFullControl_contract_ISuperfluidToken_address_bytes.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.revokeFlowOperatorWithFullControl implementation
function revokeFlowOperatorWithFullControl(ISuperfluidToken token, address flowOperator, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### getFlowOperatorData(contract ISuperfluidToken,address,address)

- **Signature**: `getFlowOperatorData(contract ISuperfluidToken,address,address)`
- **Visibility**: public
- **Source Range**: 33201:533:121
- **Details**: [function_getFlowOperatorData_contract_ISuperfluidToken_address_address.md](./function_getFlowOperatorData_contract_ISuperfluidToken_address_address.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.getFlowOperatorData implementation
function getFlowOperatorData(ISuperfluidToken token, address sender, address flowOperator) override public view returns (bytes32 flowOperatorId, uint8 permissions, int96 flowRateAllowance);
```

### getFlowOperatorDataByID(contract ISuperfluidToken,bytes32)

- **Signature**: `getFlowOperatorDataByID(contract ISuperfluidToken,bytes32)`
- **Visibility**: external
- **Source Range**: 33817:421:121
- **Details**: [function_getFlowOperatorDataByID_contract_ISuperfluidToken_bytes32.md](./function_getFlowOperatorDataByID_contract_ISuperfluidToken_bytes32.md)

**Signature:**
```solidity
/// @dev IConstantFlowAgreementV1.getFlowOperatorDataByID implementation
function getFlowOperatorDataByID(ISuperfluidToken token, bytes32 flowOperatorId) override external view returns (uint8 permissions, int96 flowRateAllowance);
```

### getCodeAddress() (inherited from UUPSProxiable)

- **Signature**: `getCodeAddress()`
- **Visibility**: public
- **Source Range**: 401:122:169
- **Details**: [function_getCodeAddress.md](./function_getCodeAddress.md)

**Signature:**
```solidity
///  @dev Get current implementation code address.
function getCodeAddress() public view returns (address codeAddress);
```

### castrate() (inherited from UUPSProxiable)

- **Signature**: `castrate()`
- **Visibility**: external
- **Source Range**: 694:44:169
- **Details**: [function_castrate.md](./function_castrate.md)

**Signature:**
```solidity
function castrate() external initializer();
```

### proxiableUUID() (inherited from AgreementBase)

- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 555:145:119
- **Details**: [function_proxiableUUID.md](./function_proxiableUUID.md)

**Signature:**
```solidity
function proxiableUUID() override public view returns (bytes32);
```

### updateCode(address) (inherited from AgreementBase)

- **Signature**: `updateCode(address)`
- **Visibility**: external
- **Source Range**: 706:192:119
- **Details**: [function_updateCode_address.md](./function_updateCode_address.md)

**Signature:**
```solidity
function updateCode(address newAddress) override external;
```

### agreementType() (inherited from IConstantFlowAgreementV1)

- **Signature**: `agreementType()`
- **Visibility**: external
- **Source Range**: 1897:161:131
- **Details**: [function_agreementType.md](./function_agreementType.md)

**Signature:**
```solidity
/// @dev ISuperAgreement.agreementType implementation
function agreementType() override external pure returns (bytes32);
```
