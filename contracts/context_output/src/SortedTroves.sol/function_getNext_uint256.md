# Function: getNext(uint256)

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `getNext(uint256)`
- **Visibility**: external
- **Source Range**: 12833:112:273

## Implementation

```solidity
function getNext(uint256 _id) override external view returns (uint256) {
    return nodes[_id].nextId;
}
```

## State Variable Reads

- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.getNext(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
