# Function: getERC2771Forwarder()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `getERC2771Forwarder()`
- **Visibility**: external
- **Source Range**: 36388:122:163

## Implementation

```solidity
function getERC2771Forwarder() override external view returns (address) {
    return address(_ERC2771_FORWARDER);
}
```

## State Variable Reads

- **_ERC2771_FORWARDER** (`contract ERC2771Forwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/ERC2771Forwarder.sol/contract_ERC2771Forwarder.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.getERC2771Forwarder() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev returns the address of the forwarder contract used to route batch operations of type
 OPERATION_TYPE_ERC2771_FORWARD_CALL.
 Needs to be set as _trusted forwarder_ by the call targets of such operations.
