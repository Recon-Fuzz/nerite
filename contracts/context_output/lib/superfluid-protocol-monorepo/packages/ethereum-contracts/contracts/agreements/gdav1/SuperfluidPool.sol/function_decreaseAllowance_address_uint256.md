# Function: decreaseAllowance(address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `decreaseAllowance(address,uint256)`
- **Visibility**: external
- **Source Range**: 5890:212:127

## Implementation

```solidity
/// @inheritdoc ISuperfluidPool
function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool) {
    _approve(msg.sender, spender, _allowances[msg.sender][spender] - subtractedValue);
    return true;
}
```

## Related Implementations

### _approve(address,address,uint256)

- **Kind**: internal
- **Source**: 6108:176:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_approve(address,address,uint256)`

```solidity
function _approve(address owner, address spender, uint256 amount) internal {
    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
}
```

## State Variable Reads

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.decreaseAllowance(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidPool._approve(address,address,uint256) (NodeID: 1)
      💬 Args: [msg.sender, spender, _allowances[msg.sender][spender] - subtractedValue]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluidPool

### Interface Documentation

@notice Decreases the allowance of `spender` by `subtractedValue`
 @param spender The address of the spender
 @param subtractedValue The amount to decrease the allowance by
 @return true if successful
