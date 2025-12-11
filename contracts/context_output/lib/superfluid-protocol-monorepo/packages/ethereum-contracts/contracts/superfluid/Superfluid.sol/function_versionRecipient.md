# Function: versionRecipient()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `versionRecipient()`
- **Visibility**: external
- **Source Range**: 36259:123:163

## Implementation

```solidity
/// @dev IRelayRecipient.versionRecipient implementation
function versionRecipient() override external pure returns (string memory) {
    return "v1";
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.versionRecipient() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@dev IRelayRecipient.versionRecipient implementation

### Interface Documentation

 @dev EIP 2771 version
 NOTE:
 - It is not clear if it is actually from the EIP 2771....
 - https://docs.biconomy.io/guides/enable-gasless-transactions/eip-2771
