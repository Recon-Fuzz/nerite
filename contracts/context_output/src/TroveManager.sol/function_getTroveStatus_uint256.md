# Function: getTroveStatus(uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `getTroveStatus(uint256)`
- **Visibility**: external
- **Source Range**: 52500:129:124

## Implementation

```solidity
function getTroveStatus(uint256 _troveId) override external view returns (Status) {
    return Troves[_troveId].status;
}
```

## State Variable Reads

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.getTroveStatus(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
