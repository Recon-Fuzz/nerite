# Function: allowance(address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 5270:143:127

## Implementation

```solidity
/// @inheritdoc IERC20
function allowance(address owner, address spender) override external view returns (uint256) {
    return _allowances[owner][spender];
}
```

## State Variable Reads

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.allowance(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IERC20

### Interface Documentation

 @dev Returns the remaining number of tokens that `spender` will be
 allowed to spend on behalf of `owner` through {transferFrom}. This is
 zero by default.
 This value changes when {approve} or {transferFrom} are called.
