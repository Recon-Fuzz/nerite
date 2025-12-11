# Function: operationApprove(address,address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `operationApprove(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 27724:212:161

## Implementation

```solidity
function operationApprove(address account, address spender, uint256 amount) virtual override external onlyHost() {
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

### onlyHost()

- **Kind**: modifier
- **Source**: 13353:133:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:onlyHost()`

```solidity
modifier onlyHost() {
    if (address(_host) != msg.sender) {
        revert SF_TOKEN_ONLY_HOST();
    }
    _;
}
```

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.operationApprove(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperToken._approve(address,address,uint256) (NodeID: 1)
  │   💬 Args: [account, spender, amount]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: SuperfluidToken.onlyHost() (NodeID: 2)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @dev Perform ERC20 approve by host contract.
 @param account The account owner to be approved.
 @param spender The spender of account owner's funds.
 @param amount Number of tokens to be approved.
 @custom:modifiers
  - onlyHost
