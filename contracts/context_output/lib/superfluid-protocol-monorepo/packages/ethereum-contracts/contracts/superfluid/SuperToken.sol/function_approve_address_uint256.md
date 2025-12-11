# Function: approve(address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 17682:184:161

## Implementation

```solidity
function approve(address spender, uint256 amount) virtual override public returns (bool) {
    _approve(msg.sender, spender, amount);
    return true;
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

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.approve(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SuperToken._approve(address,address,uint256) (NodeID: 1)
      💬 Args: [msg.sender, spender, amount]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
 @return Returns Success a boolean value indicating whether the operation succeeded.
 @custom:note Beware that changing an allowance with this method brings the risk
 that someone may use both the old and the new allowance by unfortunate
 transaction ordering. One possible solution to mitigate this race
 condition is to first reduce the spender's allowance to 0 and set the
 desired value afterwards:
 https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
 @custom:emits an {Approval} event.

 @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
 Returns a boolean value indicating whether the operation succeeded.
 IMPORTANT: Beware that changing an allowance with this method brings the risk
 that someone may use both the old and the new allowance by unfortunate
 transaction ordering. One possible solution to mitigate this race
 condition is to first reduce the spender's allowance to 0 and set the
 desired value afterwards:
 https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
 Emits an {Approval} event.
