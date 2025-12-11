# Function: getPrev(uint256)

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `getPrev(uint256)`
- **Visibility**: external
- **Source Range**: 13091:112:273

## Implementation

```solidity
function getPrev(uint256 _id) override external view returns (uint256) {
    return nodes[_id].prevId;
}
```

## State Variable Reads

- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.getPrev(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
