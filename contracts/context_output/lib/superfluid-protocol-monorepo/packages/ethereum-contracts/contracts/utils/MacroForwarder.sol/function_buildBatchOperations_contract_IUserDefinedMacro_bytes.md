# Function: buildBatchOperations(contract IUserDefinedMacro,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/MacroForwarder.sol/contract_MacroForwarder.md]

## Metadata

- **Contract**: MacroForwarder
- **Signature**: `buildBatchOperations(contract IUserDefinedMacro,bytes)`
- **Visibility**: public
- **Source Range**: 825:229:177

## Implementation

```solidity
///  @dev A convenience view wrapper for building the batch operations using a macro.
///  @param  m          Target macro.
///  @param  params     Parameters to simulate the macro.
///  @return operations Operations returned by the macro after the simulation.
function buildBatchOperations(IUserDefinedMacro m, bytes calldata params) public view returns (ISuperfluid.Operation[] memory operations) {
    operations = m.buildBatchOperations(_host, params, msg.sender);
}
```

## External Calls

- **IUserDefinedMacro::buildBatchOperations(contract ISuperfluid,bytes,address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MacroForwarder.buildBatchOperations(contract IUserDefinedMacro,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev A convenience view wrapper for building the batch operations using a macro.
 @param  m          Target macro.
 @param  params     Parameters to simulate the macro.
 @return operations Operations returned by the macro after the simulation.
