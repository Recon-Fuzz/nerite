# Function: getInterestIndividualDelegateOf(uint256)

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `getInterestIndividualDelegateOf(uint256)`
- **Visibility**: external
- **Source Range**: 31488:207:205

## Implementation

```solidity
function getInterestIndividualDelegateOf(uint256 _troveId) external view returns (InterestIndividualDelegate memory) {
    return interestIndividualDelegateOf[_troveId];
}
```

## State Variable Reads

- **interestIndividualDelegateOf** (`mapping(uint256 => struct IBorrowerOperations.InterestIndividualDelegate)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.getInterestIndividualDelegateOf(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
