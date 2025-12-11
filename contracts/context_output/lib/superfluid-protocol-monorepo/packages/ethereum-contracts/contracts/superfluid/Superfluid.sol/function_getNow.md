# Function: getNow()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `getNow()`
- **Visibility**: public
- **Source Range**: 5438:142:163

## Implementation

```solidity
function getNow() public view returns (uint256) {
    return block.timestamp;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.getNow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
