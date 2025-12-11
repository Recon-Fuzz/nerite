# Function: approve(address,uint256)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol/contract_ERC20.md]

## Metadata

- **Contract**: ERC20
- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 4444:197:86

## Implementation

```solidity
///  @dev See {IERC20-approve}.
///  NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
///  `transferFrom`. This is semantically equivalent to an infinite approval.
///  Requirements:
///  - `spender` cannot be the zero address.
function approve(address spender, uint256 amount) virtual override public returns (bool) {
    address owner = _msgSender();
    _approve(owner, spender, amount);
    return true;
}
```

## Related Implementations

### _msgSender()

- **Kind**: internal
- **Source**: 655:96:104
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### _approve(address,address,uint256)

- **Kind**: internal
- **Source**: 10457:340:86
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_approve(address,address,uint256)`

```solidity
///  @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
///  This internal function is equivalent to `approve`, and can be used to
///  e.g. set automatic allowances for certain subsystems, etc.
///  Emits an {Approval} event.
///  Requirements:
///  - `owner` cannot be the zero address.
///  - `spender` cannot be the zero address.
function _approve(address owner, address spender, uint256 amount) virtual internal {
    require(owner != address(0), "ERC20: approve from the zero address");
    require(spender != address(0), "ERC20: approve to the zero address");
    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
}
```

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.approve(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Context._msgSender() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._approve(address,address,uint256) (NodeID: 2)
      💬 Args: [owner, spender, amount]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev See {IERC20-approve}.
 NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
 `transferFrom`. This is semantically equivalent to an infinite approval.
 Requirements:
 - `spender` cannot be the zero address.

### Interface Documentation

 @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
 Returns a boolean value indicating whether the operation succeeded.
 IMPORTANT: Beware that changing an allowance with this method brings the risk
 that someone may use both the old and the new allowance by unfortunate
 transaction ordering. One possible solution to mitigate this race
 condition is to first reduce the spender's allowance to 0 and set the
 desired value afterwards:
 https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
 Emits an {Approval} event.
