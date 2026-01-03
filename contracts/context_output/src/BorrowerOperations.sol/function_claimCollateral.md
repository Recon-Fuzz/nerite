# Function: claimCollateral()

**Contract**: [src/BorrowerOperations.sol/contract_BorrowerOperations.md]

## Metadata

- **Contract**: BorrowerOperations
- **Signature**: `claimCollateral()`
- **Visibility**: external
- **Source Range**: 48139:151:54

## Implementation

```solidity
///  Claim remaining collateral from a liquidation with ICR exceeding the liquidation penalty
function claimCollateral() override external {
    collSurplusPool.claimColl(msg.sender);
}
```

## External Calls

- **ICollSurplusPool::claimColl(address)**

## State Variable Reads

- **collSurplusPool** (`contract ICollSurplusPool`) [src/Interfaces/ICollSurplusPool.sol/interface_ICollSurplusPool.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BorrowerOperations.claimCollateral() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 Claim remaining collateral from a liquidation with ICR exceeding the liquidation penalty
