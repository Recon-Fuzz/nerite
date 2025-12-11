# Function: constructor(contract ISuperfluid)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/MacroForwarder.sol/contract_MacroForwarder.md]

## Metadata

- **Contract**: MacroForwarder
- **Signature**: `constructor(contract ISuperfluid)`
- **Visibility**: public
- **Source Range**: 482:52:177

## Implementation

```solidity
constructor(ISuperfluid host) ForwarderBase(host) {}
```

## Related Implementations

### (contract ISuperfluid)

- **Kind**: internal
- **Source**: 282:59:175
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/ForwarderBase.sol:ForwarderBase:constructor(contract ISuperfluid)`

```solidity
constructor(ISuperfluid host) {
    _host = host;
}
```

## State Variable Writes

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MacroForwarder.constructor(contract ISuperfluid) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MacroForwarder
  └─ [1] 🏗️ CONSTRUCTOR: ForwarderBase.constructor(contract ISuperfluid) (NodeID: 1)
      💬 Args: [host]
      🏗️  Contract: ForwarderBase
```
