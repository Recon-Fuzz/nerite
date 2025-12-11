# Function: selfApproveFor(address,address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `selfApproveFor(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 21854:210:161

## Implementation

```solidity
function selfApproveFor(address account, address spender, uint256 amount) virtual override external onlySelf() {
    _approve(account, spender, amount);
}
```

## Related Implementations

### _approve(address,address,uint256)

- **Kind**: internal
- **Source**: 13858:406:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_approve(address,address,uint256)`

```solidity
///  @notice Sets `amount` as the allowance of `spender` over the `account`s tokens.
///  This is internal function is equivalent to `approve`, and can be used to
///  e.g. set automatic allowances for certain subsystems, etc.
///  Emits an {Approval} event.
///  Requirements:
///  - `account` cannot be the zero address.
///  - `spender` cannot be the zero address.
function _approve(address account, address spender, uint256 amount) internal {
    if (account == address(0)) {
        revert SUPER_TOKEN_APPROVE_FROM_ZERO_ADDRESS();
    }
    if (spender == address(0)) {
        revert SUPER_TOKEN_APPROVE_TO_ZERO_ADDRESS();
    }
    _allowances[account][spender] = amount;
    emit Approval(account, spender, amount);
}
```

### onlySelf()

- **Kind**: modifier
- **Source**: 30060:111:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:onlySelf()`

```solidity
modifier onlySelf() {
    if (msg.sender != address(this)) revert SUPER_TOKEN_ONLY_SELF();
    _;
}
```

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.selfApproveFor(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperToken._approve(address,address,uint256) (NodeID: 1)
  │   💬 Args: [account, spender, amount]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: SuperToken.onlySelf() (NodeID: 2)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @dev Give `spender`, `amount` allowance to spend the tokens of
 `account`.
 @custom:modifiers
  - onlySelf
