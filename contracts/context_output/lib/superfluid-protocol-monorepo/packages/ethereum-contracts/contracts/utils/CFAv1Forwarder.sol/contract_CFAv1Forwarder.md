# Contract: CFAv1Forwarder

## Metadata

- **Name**: CFAv1Forwarder
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol
- **Documentation**:  @title CFAv1Forwarder
   @author Superfluid
   The CFAv1Forwarder contract provides an easy to use interface to
   ConstantFlowAgreementV1 specific functionality of Super Tokens.
   Instances of this contract can operate on the protocol only if configured as "trusted forwarder"
   by protocol governance.

## State Variables

### _host (inherited from ForwarderBase)

```solidity
ISuperfluid internal immutable _host
```

**ISuperfluid**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

### _cfa

```solidity
IConstantFlowAgreementV1 internal immutable _cfa
```

**IConstantFlowAgreementV1**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]

## Errors

### CFA_FWD_INVALID_FLOW_RATE

```solidity
error CFA_FWD_INVALID_FLOW_RATE();
```

## Public/External Functions

### constructor(contract ISuperfluid)

- **Signature**: `constructor(contract ISuperfluid)`
- **Visibility**: public
- **Source Range**: 812:227:173
- **Details**: [function_constructor_contract_ISuperfluid.md](./function_constructor_contract_ISuperfluid.md)

**Signature:**
```solidity
constructor(ISuperfluid host) ForwarderBase(host);
```

### setFlowrate(contract ISuperToken,address,int96)

- **Signature**: `setFlowrate(contract ISuperToken,address,int96)`
- **Visibility**: external
- **Source Range**: 1896:176:173
- **Details**: [function_setFlowrate_contract_ISuperToken_address_int96.md](./function_setFlowrate_contract_ISuperToken_address_int96.md)

**Signature:**
```solidity
///  @notice Sets the given flowrate between msg.sender and a given receiver.
///  If there's no pre-existing flow and `flowrate` non-zero, a new flow is created.
///  If there's an existing flow and `flowrate` non-zero, the flowrate of that flow is updated.
///  If there's an existing flow and `flowrate` zero, the flow is deleted.
///  If the existing and given flowrate are equal, no action is taken.
///  On creation of a flow, a "buffer" amount is automatically detracted from the sender account's available balance.
///  If the sender account is solvent when the flow is deleted, this buffer is redeemed to it.
///  @param token Super token address
///  @param receiver The receiver of the flow
///  @param flowrate The wanted flowrate in wad/second. Only positive values are valid here.
///  @return bool
function setFlowrate(ISuperToken token, address receiver, int96 flowrate) external returns (bool);
```

### setFlowrateFrom(contract ISuperToken,address,address,int96)

- **Signature**: `setFlowrateFrom(contract ISuperToken,address,address,int96)`
- **Visibility**: external
- **Source Range**: 2479:231:173
- **Details**: [function_setFlowrateFrom_contract_ISuperToken_address_address_int96.md](./function_setFlowrateFrom_contract_ISuperToken_address_address_int96.md)

**Signature:**
```solidity
///  @notice Like `setFlowrate`, but can be invoked by an account with flowOperator permissions
///  on behalf of the sender account.
///  @param token Super token address
///  @param sender The sender of the flow
///  @param receiver The receiver of the flow
///  @param flowrate The wanted flowrate in wad/second. Only positive values are valid here.
///  @return bool
function setFlowrateFrom(ISuperToken token, address sender, address receiver, int96 flowrate) external returns (bool);
```

### getFlowrate(contract ISuperToken,address,address)

- **Signature**: `getFlowrate(contract ISuperToken,address,address)`
- **Visibility**: external
- **Source Range**: 3147:197:173
- **Details**: [function_getFlowrate_contract_ISuperToken_address_address.md](./function_getFlowrate_contract_ISuperToken_address_address.md)

**Signature:**
```solidity
///  @notice Get the flowrate of the flow between 2 accounts if exists.
///  @dev Currently, only 0 or 1 flows can exist between 2 accounts. This may change in the future.
///  @param token Super token address
///  @param sender The sender of the flow
///  @param receiver The receiver of the flow
///  @return flowrate The flowrate from the sender to the receiver account. Returns 0 if no flow exists.
function getFlowrate(ISuperToken token, address sender, address receiver) external view returns (int96 flowrate);
```

### getFlowInfo(contract ISuperToken,address,address)

- **Signature**: `getFlowInfo(contract ISuperToken,address,address)`
- **Visibility**: external
- **Source Range**: 4016:285:173
- **Details**: [function_getFlowInfo_contract_ISuperToken_address_address.md](./function_getFlowInfo_contract_ISuperToken_address_address.md)

**Signature:**
```solidity
///  @notice Get all available information about a flow (if exists).
///  If only the flowrate is needed, consider using `getFlowrate` instead.
///  @param token Super token address
///  @param sender The sender of the flow
///  @param receiver The receiver of the flow
///  @return lastUpdated Timestamp of last update (flowrate change) or zero if no flow exists
///  @return flowrate Current flowrate of the flow or zero if no flow exists
///  @return deposit Deposit amount locked as security buffer during the lifetime of the flow
///  @return owedDeposit Extra deposit amount borrowed to a SuperApp receiver by the flow sender
function getFlowInfo(ISuperToken token, address sender, address receiver) external view returns (uint256 lastUpdated, int96 flowrate, uint256 deposit, uint256 owedDeposit);
```

### getBufferAmountByFlowrate(contract ISuperToken,int96)

- **Signature**: `getBufferAmountByFlowrate(contract ISuperToken,int96)`
- **Visibility**: external
- **Source Range**: 4946:202:173
- **Details**: [function_getBufferAmountByFlowrate_contract_ISuperToken_int96.md](./function_getBufferAmountByFlowrate_contract_ISuperToken_int96.md)

**Signature:**
```solidity
///  @notice Get the buffer amount required for the given token and flowrate.
///  This amount can vary based on the combination of token, flowrate and chain being queried.
///  The result for a given set of parameters can change over time,
///  because it depends on governance configurable protocol parameters.
///  Changes of the required buffer amount affect only flows created or updated after the change.
///  @param token Super token address
///  @param flowrate The flowrate for which the buffer amount is calculated
///  @return bufferAmount The buffer amount required for the given configuration.
function getBufferAmountByFlowrate(ISuperToken token, int96 flowrate) external view returns (uint256 bufferAmount);
```

### getAccountFlowrate(contract ISuperToken,address)

- **Signature**: `getAccountFlowrate(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 5414:170:173
- **Details**: [function_getAccountFlowrate_contract_ISuperToken_address.md](./function_getAccountFlowrate_contract_ISuperToken_address.md)

**Signature:**
```solidity
///  @notice Get the net flowrate of an account.
///  @param token Super token address
///  @param account Account to query
///  @return flowrate The net flowrate (aggregate incoming minus aggregate outgoing flowrate), can be negative.
function getAccountFlowrate(ISuperToken token, address account) external view returns (int96 flowrate);
```

### getAccountFlowInfo(contract ISuperToken,address)

- **Signature**: `getAccountFlowInfo(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 6229:237:173
- **Details**: [function_getAccountFlowInfo_contract_ISuperToken_address.md](./function_getAccountFlowInfo_contract_ISuperToken_address.md)

**Signature:**
```solidity
///  @notice Get aggregated flow information (if any exist) of an account.
///  If only the net flowrate is needed, consider using `getAccountFlowrate` instead.
///  @param token Super token address
///  @param account Account to query
///  @return lastUpdated Timestamp of last update of a flow to or from the account (flowrate change)
///  @return flowrate Current net aggregate flowrate
///  @return deposit Aggregate deposit amount currently locked as security buffer for outgoing flows
///  @return owedDeposit Aggregate extra deposit amount currently borrowed to SuperApps receiving from this account
function getAccountFlowInfo(ISuperToken token, address account) external view returns (uint256 lastUpdated, int96 flowrate, uint256 deposit, uint256 owedDeposit);
```

### createFlow(contract ISuperToken,address,address,int96,bytes)

- **Signature**: `createFlow(contract ISuperToken,address,address,int96,bytes)`
- **Visibility**: external
- **Source Range**: 7276:228:173
- **Details**: [function_createFlow_contract_ISuperToken_address_address_int96_bytes.md](./function_createFlow_contract_ISuperToken_address_address_int96_bytes.md)

**Signature:**
```solidity
///  @notice Low-level wrapper of createFlow/createFlowByOperator.
///  If the address of msg.sender is not the same as the address of the `sender` argument,
///  createFlowByOperator is used internally. In this case msg.sender needs to have permission to create flows
///  on behalf of the given sender account with sufficient flowRateAllowance.
///  Currently, only 1 flow can exist between 2 accounts, thus `createFlow` will fail if one already exists.
///  @param token Super token address
///  @param sender Sender address of the flow
///  @param receiver Receiver address of the flow
///  @param flowrate The flowrate in wad/second to be set initially
///  @param userData (optional) User data to be set. Should be set to zero if not needed.
///  @return bool
function createFlow(ISuperToken token, address sender, address receiver, int96 flowrate, bytes memory userData) external returns (bool);
```

### updateFlow(contract ISuperToken,address,address,int96,bytes)

- **Signature**: `updateFlow(contract ISuperToken,address,address,int96,bytes)`
- **Visibility**: external
- **Source Range**: 8200:228:173
- **Details**: [function_updateFlow_contract_ISuperToken_address_address_int96_bytes.md](./function_updateFlow_contract_ISuperToken_address_address_int96_bytes.md)

**Signature:**
```solidity
///  @notice Low-level wrapper if updateFlow/updateFlowByOperator.
///  If the address of msg.sender doesn't match the address of the `sender` argument,
///  updateFlowByOperator is invoked. In this case msg.sender needs to have permission to update flows
///  on behalf of the given sender account with sufficient flowRateAllowance.
///  @param token Super token address
///  @param sender Sender address of the flow
///  @param receiver Receiver address of the flow
///  @param flowrate The flowrate in wad/second the flow should be updated to
///  @param userData (optional) User data to be set. Should be set to zero if not needed.
///  @return bool
function updateFlow(ISuperToken token, address sender, address receiver, int96 flowrate, bytes memory userData) external returns (bool);
```

### deleteFlow(contract ISuperToken,address,address,bytes)

- **Signature**: `deleteFlow(contract ISuperToken,address,address,bytes)`
- **Visibility**: external
- **Source Range**: 8924:240:173
- **Details**: [function_deleteFlow_contract_ISuperToken_address_address_bytes.md](./function_deleteFlow_contract_ISuperToken_address_address_bytes.md)

**Signature:**
```solidity
///  @notice Low-level wrapper of deleteFlow/deleteFlowByOperator.
///  If msg.sender isn't the same as sender address, msg.sender needs to have permission
///  to delete flows on behalf of the given sender account.
///  @param token Super token address
///  @param sender Sender address of the flow
///  @param receiver Receiver address of the flow
///  @param userData (optional) User data to be set. Should be set to zero if not needed.
///  @return bool
function deleteFlow(ISuperToken token, address sender, address receiver, bytes memory userData) external returns (bool);
```

### grantPermissions(contract ISuperToken,address)

- **Signature**: `grantPermissions(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 9574:293:173
- **Details**: [function_grantPermissions_contract_ISuperToken_address.md](./function_grantPermissions_contract_ISuperToken_address.md)

**Signature:**
```solidity
///  @notice Grants a flowOperator permission to create/update/delete flows on behalf of msg.sender.
///  In order to restrict what a flowOperator can or can't do, the flowOperator account
///  should be a contract implementing the desired restrictions.
///  @param token Super token address
///  @param flowOperator Account to which permissions are granted
///  @return bool
function grantPermissions(ISuperToken token, address flowOperator) external returns (bool);
```

### revokePermissions(contract ISuperToken,address)

- **Signature**: `revokePermissions(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 10377:235:173
- **Details**: [function_revokePermissions_contract_ISuperToken_address.md](./function_revokePermissions_contract_ISuperToken_address.md)

**Signature:**
```solidity
///  @notice Revokes all permissions previously granted to a flowOperator by msg.sender.
///  Revocation doesn't undo or reset flows previously created/updated by the flowOperator.
///  In order to be sure about the state of flows at the time of revocation, you need to check that state
///  either in the same transaction or after this transaction.
///  @param token Super token address
///  @param flowOperator Account from which permissions are revoked
///  @return bool
function revokePermissions(ISuperToken token, address flowOperator) external returns (bool);
```

### updateFlowOperatorPermissions(contract ISuperToken,address,uint8,int96)

- **Signature**: `updateFlowOperatorPermissions(contract ISuperToken,address,uint8,int96)`
- **Visibility**: external
- **Source Range**: 11300:305:173
- **Details**: [function_updateFlowOperatorPermissions_contract_ISuperToken_address_uint8_int96.md](./function_updateFlowOperatorPermissions_contract_ISuperToken_address_uint8_int96.md)

**Signature:**
```solidity
///  @notice Low-level wrapper of `IConstantFlowAgreementV1.updateFlowOperatorPermissions`
///  @param token Super token address
///  @param flowOperator Account for which permissions are set on behalf of msg.sender
///  @param permissions Bitmask for create/update/delete permission flags. See library `FlowOperatorDefinitions`
///  @param flowrateAllowance Max. flowrate in wad/second the operator can set for individual flows.
///  @return bool
///  @notice flowrateAllowance does NOT restrict the net flowrate a flowOperator is able to set.
///  In order to restrict that, flowOperator needs to be a contract implementing the wanted limitations.
function updateFlowOperatorPermissions(ISuperToken token, address flowOperator, uint8 permissions, int96 flowrateAllowance) external returns (bool);
```

### getFlowOperatorPermissions(contract ISuperToken,address,address)

- **Signature**: `getFlowOperatorPermissions(contract ISuperToken,address,address)`
- **Visibility**: external
- **Source Range**: 12149:279:173
- **Details**: [function_getFlowOperatorPermissions_contract_ISuperToken_address_address.md](./function_getFlowOperatorPermissions_contract_ISuperToken_address_address.md)

**Signature:**
```solidity
///  @notice Get the currently set permissions granted to the given flowOperator by the given sender account.
///  @param token Super token address
///  @param sender The account which (possiby) granted permissions
///  @param flowOperator Account to which (possibly) permissions were granted
///  @return permissions A bitmask of the permissions currently granted (or not) by `sender` to `flowOperator`
///  @return flowrateAllowance Max. flowrate in wad/second the flowOperator can set for individual flows.
function getFlowOperatorPermissions(ISuperToken token, address sender, address flowOperator) external view returns (uint8 permissions, int96 flowrateAllowance);
```
