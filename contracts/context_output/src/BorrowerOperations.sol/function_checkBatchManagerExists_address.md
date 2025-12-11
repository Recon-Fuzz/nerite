# Function: checkBatchManagerExists(address)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `checkBatchManagerExists(address)`
- **Visibility**: external
- **Source Range**: 51739:165:205

## Implementation

```solidity
function checkBatchManagerExists(address _batchManager) external view returns (bool) {
    return interestBatchManagers[_batchManager].maxInterestRate > 0;
}
```

## State Variable Reads

- **interestBatchManagers** (`mapping(address => struct IBorrowerOperations.InterestBatchManager)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.checkBatchManagerExists(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
