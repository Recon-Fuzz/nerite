# Function: setTroveStatusToActive(uint256)

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `setTroveStatusToActive(uint256)`
- **Visibility**: external
- **Source Range**: 60149:251:124

## Implementation

```solidity
function setTroveStatusToActive(uint256 _troveId) external {
    _requireCallerIsBorrowerOperations();
    Troves[_troveId].status = Status.active;
    if (lastZombieTroveId == _troveId) {
        lastZombieTroveId = 0;
    }
}
```

## Related Implementations

### _requireCallerIsBorrowerOperations()

- **Kind**: internal
- **Source**: 53483:184:124
- **Link**: `src/TroveManager.sol:TroveManager:_requireCallerIsBorrowerOperations()`

```solidity
function _requireCallerIsBorrowerOperations() internal view {
    if (msg.sender != address(borrowerOperations)) {
        revert CallerNotBorrowerOperations();
    }
}
```

## State Variable Reads

- **lastZombieTroveId** (`uint256`)
- **borrowerOperations** (`contract IBorrowerOperations`) [src/Interfaces/IBorrowerOperations.sol/interface_IBorrowerOperations.md]

## State Variable Writes

- **Troves** (`mapping(uint256 => struct TroveManager.Trove)`)
- **lastZombieTroveId** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveManager.setTroveStatusToActive(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TroveManager._requireCallerIsBorrowerOperations() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
