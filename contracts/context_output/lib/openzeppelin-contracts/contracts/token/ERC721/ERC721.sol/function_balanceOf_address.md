# Function: balanceOf(address)

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol/contract_ERC721.md]

## Metadata

- **Contract**: ERC721
- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 1929:204:96

## Implementation

```solidity
///  @dev See {IERC721-balanceOf}.
function balanceOf(address owner) virtual override public view returns (uint256) {
    require(owner != address(0), "ERC721: address zero is not a valid owner");
    return _balances[owner];
}
```

## State Variable Reads

- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC721.balanceOf(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev See {IERC721-balanceOf}.

### Interface Documentation

 @dev Returns the number of tokens in ``owner``'s account.
