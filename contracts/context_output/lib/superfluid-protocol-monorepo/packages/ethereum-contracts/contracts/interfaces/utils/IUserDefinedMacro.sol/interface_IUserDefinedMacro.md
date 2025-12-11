# Interface: IUserDefinedMacro

## Metadata

- **Name**: IUserDefinedMacro
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/utils/IUserDefinedMacro.sol
- **Documentation**:  @dev User-defined macro used in implementations of TrustedMacros.

## Public/External Functions

### buildBatchOperations(contract ISuperfluid,bytes,address)

- **Signature**: `buildBatchOperations(contract ISuperfluid,bytes,address)`
- **Visibility**: external
- **Source Range**: 692:162:151

**Signature:**
```solidity
///  @dev Build batch operations according to the parameters provided.
///  It's up to the macro contract to map the provided params (can also be empty) to any
///  valid list of operations.
///  @param  host       The executing host contract.
///  @param  params     The encoded form of the parameters.
///  @param  msgSender  The msg.sender of the call to the MacroForwarder.
///  @return operations The batch operations built.
function buildBatchOperations(ISuperfluid host, bytes memory params, address msgSender) external view returns (ISuperfluid.Operation[] memory operations);;
```

### postCheck(contract ISuperfluid,bytes,address)

- **Signature**: `postCheck(contract ISuperfluid,bytes,address)`
- **Visibility**: external
- **Source Range**: 1385:91:151

**Signature:**
```solidity
///  @dev A post-check function which is called after execution.
///  It allows to do arbitrary checks based on the state after execution,
///  and to revert if the result is not as expected.
///  Can be an empty implementation if no check is needed.
///  @param  host       The host contract set for the executing MacroForwarder.
///  @param  params     The encoded parameters as provided to `MacroForwarder.runMacro()`
///  @param  msgSender  The msg.sender of the call to the MacroForwarder.
function postCheck(ISuperfluid host, bytes memory params, address msgSender) external view;;
```
