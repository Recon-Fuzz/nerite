# Function: getInterestBatchManager(address)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `getInterestBatchManager(address)`
- **Visibility**: external
- **Source Range**: 33219:158:205

## Implementation

```solidity
function getInterestBatchManager(address _account) external view returns (InterestBatchManager memory) {
    return interestBatchManagers[_account];
}
```

## State Variable Reads

- **interestBatchManagers** (`mapping(address => struct IBorrowerOperations.InterestBatchManager)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.getInterestBatchManager(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
