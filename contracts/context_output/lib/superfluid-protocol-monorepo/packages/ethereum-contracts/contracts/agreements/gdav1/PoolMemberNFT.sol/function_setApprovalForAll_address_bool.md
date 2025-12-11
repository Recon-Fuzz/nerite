# Function: setApprovalForAll(address,bool)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
- **Signature**: `setApprovalForAll(address,bool)`
- **Visibility**: external
- **Source Range**: 6889:153:126
- **Inherited From**: PoolNFTBase

## Implementation

```solidity
/// @inheritdoc IERC721
function setApprovalForAll(address operator, bool approved) virtual override external {
    _setApprovalForAll(msg.sender, operator, approved);
}
```

## Related Implementations

### _setApprovalForAll(address,address,bool)

- **Kind**: internal
- **Source**: 9697:274:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:_setApprovalForAll(address,address,bool)`

```solidity
function _setApprovalForAll(address owner, address operator, bool approved) internal {
    if (owner == operator) revert POOL_NFT_APPROVE_TO_CALLER();
    _operatorApprovals[owner][operator] = approved;
    emit ApprovalForAll(owner, operator, approved);
}
```

## State Variable Writes

- **_operatorApprovals** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PoolNFTBase.setApprovalForAll(address,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: PoolNFTBase._setApprovalForAll(address,address,bool) (NodeID: 1)
      💬 Args: [msg.sender, operator, approved]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IERC721

### Interface Documentation

 @dev Approve or remove `operator` as an operator for the caller.
 Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
 Requirements:
 - The `operator` cannot be the caller.
 Emits an {ApprovalForAll} event.
