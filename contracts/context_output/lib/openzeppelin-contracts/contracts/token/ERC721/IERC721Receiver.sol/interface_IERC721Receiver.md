# Interface: IERC721Receiver

## Metadata

- **Name**: IERC721Receiver
- **Type**: Interface
- **Path**: lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol
- **Documentation**:  @title ERC721 token receiver interface
   @dev Interface for any contract that wants to support safeTransfers
   from ERC721 asset contracts.

## Public/External Functions

### onERC721Received(address,address,uint256,bytes)

- **Signature**: `onERC721Received(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 824:160:16

**Signature:**
```solidity
///  @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
///  by `operator` from `from`, this function is called.
///  It must return its Solidity selector to confirm the token transfer.
///  If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
///  The selector can be obtained in Solidity with `IERC721Receiver.onERC721Received.selector`.
function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);;
```
