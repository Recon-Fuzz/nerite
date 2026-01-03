# Function: getTroveFromTroveIdsArray(uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `getTroveFromTroveIdsArray(uint256)`
- **Visibility**: external
- **Source Range**: 8517:132:124

## Implementation

```solidity
function getTroveFromTroveIdsArray(uint256 _index) override external view returns (uint256) {
    return TroveIds[_index];
}
```

## State Variable Reads

- **TroveIds** (`uint256[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.getTroveFromTroveIdsArray(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
