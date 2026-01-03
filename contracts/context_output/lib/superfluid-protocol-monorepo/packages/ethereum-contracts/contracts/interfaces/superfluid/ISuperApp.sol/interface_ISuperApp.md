# Interface: ISuperApp

## Metadata

- **Name**: ISuperApp
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperApp.sol
- **Documentation**:  @title SuperApp interface
   @author Superfluid
   @dev Be aware of the app being jailed, when the word permitted is used.

## Public/External Functions

### beforeAgreementCreated(contract ISuperToken,address,bytes32,bytes,bytes)

- **Signature**: `beforeAgreementCreated(contract ISuperToken,address,bytes32,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 906:265:42

**Signature:**
```solidity
///  @dev Callback before a new agreement is created.
///  @param superToken The super token used for the agreement.
///  @param agreementClass The agreement class address.
///  @param agreementId The agreementId
///  @param agreementData The agreement data (non-compressed)
///  @param ctx The context data.
///  @return cbdata A free format in memory data the app can use to pass
///           arbitary information to the after-hook callback.
///  @custom:note 
///  - It will be invoked with `staticcall`, no state changes are permitted.
///  - Only revert with a "reason" is permitted.
function beforeAgreementCreated(ISuperToken superToken, address agreementClass, bytes32 agreementId, bytes calldata agreementData, bytes calldata ctx) external view returns (bytes memory cbdata);;
```

### afterAgreementCreated(contract ISuperToken,address,bytes32,bytes,bytes,bytes)

- **Signature**: `afterAgreementCreated(contract ISuperToken,address,bytes32,bytes,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 1761:282:42

**Signature:**
```solidity
///  @dev Callback after a new agreement is created.
///  @param superToken The super token used for the agreement.
///  @param agreementClass The agreement class address.
///  @param agreementId The agreementId
///  @param agreementData The agreement data (non-compressed)
///  @param cbdata The data returned from the before-hook callback.
///  @param ctx The context data.
///  @return newCtx The current context of the transaction.
///  @custom:note 
///  - State changes is permitted.
///  - Only revert with a "reason" is permitted.
function afterAgreementCreated(ISuperToken superToken, address agreementClass, bytes32 agreementId, bytes calldata agreementData, bytes calldata cbdata, bytes calldata ctx) external returns (bytes memory newCtx);;
```

### beforeAgreementUpdated(contract ISuperToken,address,bytes32,bytes,bytes)

- **Signature**: `beforeAgreementUpdated(contract ISuperToken,address,bytes32,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 2684:265:42

**Signature:**
```solidity
///  @dev Callback before a new agreement is updated.
///  @param superToken The super token used for the agreement.
///  @param agreementClass The agreement class address.
///  @param agreementId The agreementId
///  @param agreementData The agreement data (non-compressed)
///  @param ctx The context data.
///  @return cbdata A free format in memory data the app can use to pass
///           arbitary information to the after-hook callback.
///  @custom:note 
///  - It will be invoked with `staticcall`, no state changes are permitted.
///  - Only revert with a "reason" is permitted.
function beforeAgreementUpdated(ISuperToken superToken, address agreementClass, bytes32 agreementId, bytes calldata agreementData, bytes calldata ctx) external view returns (bytes memory cbdata);;
```

### afterAgreementUpdated(contract ISuperToken,address,bytes32,bytes,bytes,bytes)

- **Signature**: `afterAgreementUpdated(contract ISuperToken,address,bytes32,bytes,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 3527:282:42

**Signature:**
```solidity
///  @dev Callback after a new agreement is updated.
///  @param superToken The super token used for the agreement.
///  @param agreementClass The agreement class address.
///  @param agreementId The agreementId
///  @param agreementData The agreement data (non-compressed)
///  @param cbdata The data returned from the before-hook callback.
///  @param ctx The context data.
///  @return newCtx The current context of the transaction.
///  @custom:note 
///  - State changes is permitted.
///  - Only revert with a "reason" is permitted.
function afterAgreementUpdated(ISuperToken superToken, address agreementClass, bytes32 agreementId, bytes calldata agreementData, bytes calldata cbdata, bytes calldata ctx) external returns (bytes memory newCtx);;
```

### beforeAgreementTerminated(contract ISuperToken,address,bytes32,bytes,bytes)

- **Signature**: `beforeAgreementTerminated(contract ISuperToken,address,bytes32,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 4422:268:42

**Signature:**
```solidity
///  @dev Callback before a new agreement is terminated.
///  @param superToken The super token used for the agreement.
///  @param agreementClass The agreement class address.
///  @param agreementId The agreementId
///  @param agreementData The agreement data (non-compressed)
///  @param ctx The context data.
///  @return cbdata A free format in memory data the app can use to pass arbitary information to
///          the after-hook callback.
///  @custom:note 
///  - It will be invoked with `staticcall`, no state changes are permitted.
///  - Revert is not permitted.
function beforeAgreementTerminated(ISuperToken superToken, address agreementClass, bytes32 agreementId, bytes calldata agreementData, bytes calldata ctx) external view returns (bytes memory cbdata);;
```

### afterAgreementTerminated(contract ISuperToken,address,bytes32,bytes,bytes,bytes)

- **Signature**: `afterAgreementTerminated(contract ISuperToken,address,bytes32,bytes,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 5253:285:42

**Signature:**
```solidity
///  @dev Callback after a new agreement is terminated.
///  @param superToken The super token used for the agreement.
///  @param agreementClass The agreement class address.
///  @param agreementId The agreementId
///  @param agreementData The agreement data (non-compressed)
///  @param cbdata The data returned from the before-hook callback.
///  @param ctx The context data.
///  @return newCtx The current context of the transaction.
///  @custom:note 
///  - State changes is permitted.
///  - Revert is not permitted.
function afterAgreementTerminated(ISuperToken superToken, address agreementClass, bytes32 agreementId, bytes calldata agreementData, bytes calldata cbdata, bytes calldata ctx) external returns (bytes memory newCtx);;
```
