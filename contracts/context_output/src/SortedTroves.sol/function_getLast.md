# Function: getLast()

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `getLast()`
- **Visibility**: external
- **Source Range**: 12580:110:273

## Implementation

```solidity
function getLast() override external view returns (uint256) {
    return nodes[ROOT_NODE_ID].prevId;
}
```

## State Variable Reads

- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.getLast() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
