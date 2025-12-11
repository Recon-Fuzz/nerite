# Function: allowance(address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `allowance(address,address)`
- **Visibility**: public
- **Source Range**: 17511:165:161

## Implementation

```solidity
function allowance(address account, address spender) virtual override public view returns (uint256) {
    return _allowances[account][spender];
}
```

## State Variable Reads

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.allowance(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the remaining number of tokens that `spender` will be
         allowed to spend on behalf of `owner` through {transferFrom}. This is
         zero by default.
 @notice This value changes when {approve} or {transferFrom} are called.

 @dev Returns the remaining number of tokens that `spender` will be
 allowed to spend on behalf of `owner` through {transferFrom}. This is
 zero by default.
 This value changes when {approve} or {transferFrom} are called.
