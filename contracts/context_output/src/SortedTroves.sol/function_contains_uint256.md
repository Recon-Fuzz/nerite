# Function: contains(uint256)

**Contract**: [src/SortedTroves.sol/contract_SortedTroves.md]

## Metadata

- **Contract**: SortedTroves
- **Signature**: `contains(uint256)`
- **Visibility**: public
- **Source Range**: 11484:108:273

## Implementation

```solidity
function contains(uint256 _id) override public view returns (bool) {
    return nodes[_id].exists;
}
```

## State Variable Reads

- **nodes** (`mapping(uint256 => struct SortedTroves.Node)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SortedTroves.contains(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
