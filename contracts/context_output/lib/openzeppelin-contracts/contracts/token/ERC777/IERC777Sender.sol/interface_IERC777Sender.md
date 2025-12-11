# Interface: IERC777Sender

## Metadata

- **Name**: IERC777Sender
- **Type**: Interface
- **Path**: lib/openzeppelin-contracts/contracts/token/ERC777/IERC777Sender.sol
- **Documentation**:  @dev Interface of the ERC777TokensSender standard as defined in the EIP.
   {IERC777} Token holders can be notified of operations performed on their
   tokens by having a contract implement this interface (contract holders can be
   their own implementer) and registering it on the
   https://eips.ethereum.org/EIPS/eip-1820[ERC1820 global registry].
   See {IERC1820Registry} and {ERC1820Implementer}.

## Public/External Functions

### tokensToSend(address,address,address,uint256,bytes,bytes)

- **Signature**: `tokensToSend(address,address,address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 1057:199:102

**Signature:**
```solidity
///  @dev Called by an {IERC777} token contract whenever a registered holder's
///  (`from`) tokens are about to be moved or destroyed. The type of operation
///  is conveyed by `to` being the zero address or not.
///  This call occurs _before_ the token contract's state is updated, so
///  {IERC777-balanceOf}, etc., can be used to query the pre-operation state.
///  This function may revert to prevent the operation from being executed.
function tokensToSend(address operator, address from, address to, uint256 amount, bytes calldata userData, bytes calldata operatorData) external;;
```
