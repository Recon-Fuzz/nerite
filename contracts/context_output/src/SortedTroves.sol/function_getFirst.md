# Function: getFirst()

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `getFirst()`
- **Visibility**: external
- **Source Range**: 12356:111:122

## Implementation

```solidity
function getFirst() override external view returns (uint256) {
    return nodes[ROOT_NODE_ID].nextId;
}
```

## State Variable Reads

- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.getFirst() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
