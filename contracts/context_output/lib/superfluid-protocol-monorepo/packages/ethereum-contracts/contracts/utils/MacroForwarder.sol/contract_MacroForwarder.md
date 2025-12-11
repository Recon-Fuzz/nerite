# Contract: MacroForwarder

## Metadata

- **Name**: MacroForwarder
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/MacroForwarder.sol
- **Documentation**:  @dev This is a minimal version of a trusted forwarder with high degree of extensibility
   through permissionless and user-defined "macro contracts".

## State Variables

### _host (inherited from ForwarderBase)

```solidity
ISuperfluid internal immutable _host
```

**ISuperfluid**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Public/External Functions

### constructor(contract ISuperfluid)

- **Signature**: `constructor(contract ISuperfluid)`
- **Visibility**: public
- **Source Range**: 482:52:177
- **Details**: [function_constructor_contract_ISuperfluid.md](./function_constructor_contract_ISuperfluid.md)

**Signature:**
```solidity
constructor(ISuperfluid host) ForwarderBase(host);
```

### buildBatchOperations(contract IUserDefinedMacro,bytes)

- **Signature**: `buildBatchOperations(contract IUserDefinedMacro,bytes)`
- **Visibility**: public
- **Source Range**: 825:229:177
- **Details**: [function_buildBatchOperations_contract_IUserDefinedMacro_bytes.md](./function_buildBatchOperations_contract_IUserDefinedMacro_bytes.md)

**Signature:**
```solidity
///  @dev A convenience view wrapper for building the batch operations using a macro.
///  @param  m          Target macro.
///  @param  params     Parameters to simulate the macro.
///  @return operations Operations returned by the macro after the simulation.
function buildBatchOperations(IUserDefinedMacro m, bytes calldata params) public view returns (ISuperfluid.Operation[] memory operations);
```

### runMacro(contract IUserDefinedMacro,bytes)

- **Signature**: `runMacro(contract IUserDefinedMacro,bytes)`
- **Visibility**: external
- **Source Range**: 1301:334:177
- **Details**: [function_runMacro_contract_IUserDefinedMacro_bytes.md](./function_runMacro_contract_IUserDefinedMacro_bytes.md)

**Signature:**
```solidity
///  @dev Run the macro defined by the provided macro contract and params.
///  @param  m      Target macro.
///  @param  params Parameters to run the macro.
///  If value (native coins) is provided, it is forwarded.
function runMacro(IUserDefinedMacro m, bytes calldata params) external payable returns (bool);
```
